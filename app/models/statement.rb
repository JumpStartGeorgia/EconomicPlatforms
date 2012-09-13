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

  before_save :translate_to_english

  TYPE = %w[political_party, economic_indicator]

	attr_accessible :count_name, :count_permalink, :count_total

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

  def self.count_by_political_party
    sql = "select ppt.name as count_name, ppt.permalink as count_permalink, if(isnull(s.total),0,s.total) as count_total "
    sql << "from political_party_translations as ppt "
    sql << "left join ( "
    sql << "select political_party_id, count(*) as total "
    sql << "from statements group by political_party_id) as s on s.political_party_id = ppt.political_party_id  "
    sql << "where ppt.locale = :locale "
    sql << "order by ppt.name"

		find_by_sql([sql, :locale => I18n.locale])
  end

  def self.count_by_economic_category
    sql = "select ect.name as count_name, ect.permalink as count_permalink, if(isnull(s.total),0,s.total) as count_total "
    sql << "from economic_category_translations as ect "
    sql << "left join ( "
    sql << "select economic_category_id, count(*) as total "
    sql << "from statements group by economic_category_id) as s on s.economic_category_id = ect.economic_category_id  "
    sql << "where ect.locale = :locale "
    sql << "order by ect.name"

		find_by_sql([sql, :locale => I18n.locale])
  end


	protected

  # if there is a ka translation, get the english from google translate
  def translate_to_english
    if !self.statement_translations.empty? && !self.statement_translations.index{|x| x.locale == "ka"}.nil?
      # found ka record
      # get english
    end
  end


end
