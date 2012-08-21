class Statement < ActiveRecord::Base
  has_paper_trail
  translates :statement_made, :source, :author, :analysis
  belongs_to :political_party
  belongs_to :economic_category
  has_many :statement_scores, :dependent => :destroy
  has_many :statement_translations, :dependent => :destroy
  accepts_nested_attributes_for :statement_translations
  accepts_nested_attributes_for :statement_scores
  attr_accessible :date_made, :political_party_id, :economic_category_id,
		:statement_translations_attributes, :statement_scores_attributes

  validates :date_made, :political_party_id, :economic_category_id, :presence => true

	default_scope lambda {with_translations(I18n.locale).order("statements.date_made desc")}

  before_save :translate_to_english
  
  # if there is a ka translation, get the english from google translate
  def translate_to_english
    if !self.statement_translations.empty? && !self.statement_translations.index{|x| x.locale == "ka"}.nil?
      # found ka record
      # get english
    end
  end
end
