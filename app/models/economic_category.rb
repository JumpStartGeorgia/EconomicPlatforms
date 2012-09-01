class EconomicCategory < ActiveRecord::Base
  has_paper_trail
  translates :name, :permalink
  has_many :economic_category_translations, :dependent => :destroy
  accepts_nested_attributes_for :economic_category_translations
  attr_accessible :id, :economic_category_translations_attributes

  has_many :statements
  has_many :policy_briefs

	default_scope lambda {with_translations(I18n.locale).order("economic_category_translations.name")}

  attr_accessible :ec_cat_name

  def self.id_and_name
    unscoped.select("economic_categories.id, economic_category_translations.name as ec_cat_name")
    .joins(:economic_category_translations)
    .where(:economic_category_translations => {:locale => I18n.locale})
    .order("economic_category_translations.name")
  end

end
