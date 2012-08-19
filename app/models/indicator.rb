class Indicator < ActiveRecord::Base
  translates :name
  has_many :indicator_translations, :dependent => :destroy
  accepts_nested_attributes_for :indicator_translations
  attr_accessible :indicator_category_id, :value, :indicator_translations_attributes

  belongs_to :indicator_category
  
  validates :indicator_category_id, :value, :presence => true
  
end
