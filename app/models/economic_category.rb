class EconomicCategory < ActiveRecord::Base
  translates :name
  has_many :economic_category_translations, :dependent => :destroy
  accepts_nested_attributes_for :economic_category_translations
  attr_accessible :economic_category_translations_attributes

  has_many :statements
end
