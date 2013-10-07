class PolicyBrief < ActiveRecord::Base
  has_paper_trail
  translates :analysis
  belongs_to :political_party
  belongs_to :economic_category
  belongs_to :election
  has_many :policy_brief_translations, :dependent => :destroy
  accepts_nested_attributes_for :policy_brief_translations
  attr_accessible :political_party_id, :economic_category_id, :is_public,
		:policy_brief_translations_attributes, :election_id

  validates :political_party_id, :economic_category_id, :election_id, :presence => true
	validates :economic_category_id, :uniqueness => {:scope => [:political_party_id, :election_id],
			:message => I18n.t('app.msgs.policy_already_exists')}

  scope :published, where("is_public = '1'")

  acts_as_commentable


  # normal process of Election.destroy does not work because paper trail is throwing error
  # - so have to do normal deletes
  def self.delete_hack(id)
    if id.present?
      PolicyBriefTranslation.where(:policy_brief_id => id).delete_all
      PolicyBrief.delete(id)
    end
  end

  def self.by_election(election_id)
    where(:election_id => election_id)
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
			.where(:policy_briefs => {:political_party_id => political_party_id},
						:economic_category_translations => {:locale => I18n.locale})
			.order("economic_category_translations.name asc")
		end
	end

	def self.by_economic_category(economic_category_id)
		if economic_category_id
			includes(:political_party => :political_party_translations)
			.where(:policy_briefs => {:economic_category_id => economic_category_id},
						:political_party_translations => {:locale => I18n.locale})
			.order("political_party_translations.name asc")
		end
	end

	def political_party_name
		return self.political_party.political_party_translations[0].name
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

end
