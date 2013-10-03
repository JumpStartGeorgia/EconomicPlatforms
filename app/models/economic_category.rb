class EconomicCategory < ActiveRecord::Base
  has_paper_trail
  translates :name, :permalink

  has_many :statements
  has_many :policy_briefs
	has_many :platforms

  has_many :economic_category_translations, :dependent => :destroy
  accepts_nested_attributes_for :economic_category_translations
  attr_accessible :id, :economic_category_translations_attributes, :ec_cat_name

  def self.sorted
    with_translations(I18n.locale).order("economic_category_translations.name")  
  end
end
