class IndicatorCategory < ActiveRecord::Base
  has_paper_trail
  translates :name
  has_many :indicator_category_translations, :dependent => :destroy
  accepts_nested_attributes_for :indicator_category_translations
  attr_accessible :id, :indicator_category_translations_attributes

  has_many :indicators
  has_many :statement_scores
  
	default_scope lambda {with_translations(I18n.locale).order("indicator_category_translations.name")}
  
  def self.with_indicators
    joins(:indicators)
    .where("indicators.id is not null")
  end
end
