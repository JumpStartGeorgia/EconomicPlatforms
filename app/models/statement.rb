class Statement < ActiveRecord::Base
  has_paper_trail
  translates :statement_made, :source, :author, :analysis
  belongs_to :political_party
  belongs_to :economic_category
  has_many :statement_scores, :dependent => :destroy
  has_many :statement_translations, :dependent => :destroy
  accepts_nested_attributes_for :statement_translations
  accepts_nested_attributes_for :statement_scores
  attr_accessible :date_made, :political_party_id, :economic_category_id, :is_public,
		:statement_translations_attributes, :statement_scores_attributes

  acts_as_commentable
  require 'split_votes'
  include SplitVotes

  validates :date_made, :political_party_id, :economic_category_id, :presence => true

	default_scope lambda {with_translations(I18n.locale).order("statements.date_made desc")}
  scope :published, where("is_public = '1'")

  TYPE = %w[political_party, economic_indicator]

	attr_accessible :political_party_name, :economic_category_name, :indicator_category_name, :daily_avg_score

	# number of items per page for pagination
	self.per_page = 4

	def self.latest
		limit(4)
	end

	def self.by_political_party(political_party_id)
		where(:political_party_id => political_party_id) if political_party_id
	end

	def self.by_economic_category(economic_category_id)
		where(:economic_category_id => economic_category_id) if economic_category_id
	end

  #########################
  ## avg scores
  #########################
  def self.daily_average(political_party_id, economic_category_id, indicator_category_id)
    if political_party_id && economic_category_id && indicator_category_id
      sql = "select ppt.name as political_party_name,ect.name as economic_category_name, "
      sql << "ict.name as indicator_category_name, s.date_made, avg(ss.value) as daily_avg_score "
      sql << "from  "
      sql << "statements as s "
      sql << "inner join statement_scores as ss on ss.statement_id = s.id "
      sql << "inner join political_party_translations as ppt on ppt.political_party_id = s.political_party_id "
      sql << "inner join economic_category_translations as ect on ect.economic_category_id = s.economic_category_id "
      sql << "inner join indicator_category_translations as ict on ict.indicator_category_id = ss.indicator_category_id "
      sql << "where "
      sql << "s.political_party_id = :pp_id "
      sql << "and s.economic_category_id = :ec_id "
      sql << "and ss.indicator_category_id = :ind_id "
      sql << "and ss.value != 0 "
      sql << "and ppt.locale = :locale and ect.locale = :locale and ict.locale = :locale "
      sql << "group by ppt.name,ect.name, ict.name,s.date_made "
      sql << "order by s.date_made "
      
		  find_by_sql([sql, :pp_id => political_party_id, :ec_id => economic_category_id, 
		    :ind_id => indicator_category_id, :locale => I18n.locale])

    end
  end


end
