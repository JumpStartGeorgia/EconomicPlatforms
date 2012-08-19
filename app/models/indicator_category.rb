class IndicatorCategory < ActiveRecord::Base
  translates :name
  has_many :indicator_category_translations, :dependent => :destroy
  accepts_nested_attributes_for :indicator_category_translations
  attr_accessible :indicator_category_translations_attributes

  has_many :indicators
  has_many :statement_scores
  
end
