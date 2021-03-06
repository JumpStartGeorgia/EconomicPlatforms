class Platform < ActiveRecord::Base
  has_paper_trail
  translates :description
  belongs_to :political_party
  belongs_to :economic_category
  belongs_to :election
  has_many :platform_files, :dependent => :destroy
  has_many :platform_scores, :dependent => :destroy
  has_many :platform_translations, :dependent => :destroy
  accepts_nested_attributes_for :platform_translations
  accepts_nested_attributes_for :platform_scores
  accepts_nested_attributes_for :platform_files, :reject_if => lambda { |a| a[:file].blank? }, :allow_destroy => true
  attr_accessible :political_party_id, :economic_category_id, :is_public, :election_id,
		:platform_translations_attributes, :platform_scores_attributes, :platform_files_attributes

  validates :political_party_id, :economic_category_id, :election_id, :presence => true
	validates :economic_category_id, :uniqueness => {:scope => [:political_party_id, :election_id],
			:message => I18n.t('app.msgs.platform_already_exists')}

  scope :published, where("is_public = '1'")

  acts_as_commentable

	attr_accessible :score_economic_category, :score_political_party, :score_indicator_category, :score_value,
		:score_value_centered, :score_value_explaination,


  def self.by_election(election_id)
    where(:election_id => election_id)
  end

  # normal process of Election.destroy does not work because paper trail is throwing error
  # - so have to do normal deletes
  def self.delete_hack(id)
    if id.present?
      PlatformTranslation.where(:platform_id => id).delete_all
      PlatformFile.where(:platform_id => id).delete_all
      PlatformScore.where(:platform_id => id).delete_all
      Platform.delete(id)
    end
  end

	def self.by_party_category(political_party_id, economic_category_id)
		if political_party_id && economic_category_id
			x = with_translations(I18n.locale)
			.where(:political_party_id => political_party_id, :economic_category_id => economic_category_id)

			return x.first if x && !x.empty?
		end
	end

	def self.by_political_party(political_party_id)
		if political_party_id
			includes(:economic_category => :economic_category_translations)
			.where(:platforms => {:political_party_id => political_party_id},
						:economic_category_translations => {:locale => I18n.locale})
			.order("economic_category_translations.name asc")
		end
	end

	def self.by_economic_category(economic_category_id)
		if economic_category_id
			includes(:political_party => :political_party_translations)
			.where(:platforms => {:economic_category_id => economic_category_id},
						:political_party_translations => {:locale => I18n.locale})
			.order("political_party_translations.name asc")
		end
	end

	def political_party_name
		return self.political_party.political_party_translations[0].name
	end
	
	def political_party_name_with_candidate
		return self.political_party.name_with_candidate(self.election_id)
	end

	def economic_category_name
		return self.economic_category.economic_category_translations[0].name
	end

	def political_party_permalink
		return self.political_party.political_party_translations[0].permalink
	end

	def economic_category_permalink
		return self.economic_category.economic_category_translations[0].permalink
	end

  #########################
  ## scores
  #########################
  def self.score(election_id, political_party_id, economic_category_id, indicator_category_id)
    if election_id && political_party_id && economic_category_id && indicator_category_id
      x = select("platform_scores.value as score_value")
          .joins(:platform_scores)
          .where(['platforms.election_id = :e_id and platforms.political_party_id = :pp_id and platforms.economic_category_id = :ec_id and platform_scores.indicator_category_id = :ind_id and platform_scores.value != 0',
            :e_id => election_id, :pp_id => political_party_id, :ec_id => economic_category_id, :ind_id => indicator_category_id])

      # if x exists, center the value and flip the sign
      if x && x.length > 0
logger.debug "@@@@@@@@@@@@@ original score = #{x.first.score_value}"
        return y = (x.first.score_value - 4)
#        return y == 0 ? y : y*-1
      end
    end
  end

  def self.all_party_average(election_id, economic_category_id, indicator_category_id)
    if election_id && economic_category_id && indicator_category_id
      x = joins(:platform_scores)
          .where(['platforms.election_id = :e_id and platforms.economic_category_id = :ec_id and platform_scores.indicator_category_id = :ind_id and platform_scores.value != 0',
            :e_id => election_id, :ec_id => economic_category_id, :ind_id => indicator_category_id])
          .average('platform_scores.value')

      # if x exists, center the value and flip the sign
      if x
logger.debug "@@@@@@@@@@@@@ original score = #{x.to_f}"
        return y = (x.to_f - 4)
#        return y == 0 ? y : y*-1
      end
    end
  end

  def scores_to_hash
    {
      :economic_category => self.score_economic_category,
      :indicator_category => self.score_indicator_category,
      :political_party => self.score_political_party,
      :color => self.score_color,
      :value => self.score_value,
      :value_centered => self.score_value_centered,
      :value_explaination => self.score_value_explaination
    }
  end

	def self.scores_for_ec_cat_and_ind_cat(election_id, economic_category_id, indicator_category_id)
		if economic_category_id && indicator_category_id && election_id
			sql = "select ect.name as score_economic_category, ict.name as score_indicator_category, "
			sql << "ppt.name as score_political_party, pp.color as score_color, "
			sql << "if(ps.value=0, null, ps.value) as score_value, "
			sql << "if(ps.value=0, null, ((ps.value-4)*(-1))) as score_value_centered, "
			sql << "if(ps.value=0, null, it.name ) as score_value_explaination "
			sql << "from "
			sql << "platforms as p "
			sql << "inner join platform_scores as ps on ps.platform_id = p.id "
			sql << "inner join economic_category_translations as ect on ect.economic_category_id = p.economic_category_id "
			sql << "inner join political_parties as pp on pp.id = p.political_party_id "
			sql << "inner join political_party_translations as ppt on ppt.political_party_id = p.political_party_id "
			sql << "inner join indicator_category_translations as ict on ict.indicator_category_id = ps.indicator_category_id "
			sql << "inner join indicator_translations as it on it.indicator_id = ps.indicator_id "
			sql << "where "
			sql << "p.economic_category_id = :economic_category_id "
      sql << "and p.election_id = :e_id "
			sql << "and ps.indicator_category_id = :indicator_category_id "
			sql << "and ect.locale = :locale "
			sql << "and ppt.locale = :locale "
			sql << "and ict.locale = :locale "
			sql << "and it.locale = :locale "
			sql << "order by ppt.name "

			find_by_sql([sql, :economic_category_id => economic_category_id,
				:indicator_category_id => indicator_category_id, 
				:e_id => election_id,
				:locale => I18n.locale])
		end
	end


end
