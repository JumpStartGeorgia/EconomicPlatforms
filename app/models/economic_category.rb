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


  # normal process of Election.destroy does not work because paper trail is throwing error
  # - so have to do normal deletes
  def self.delete_hack(id)
    if id.present?
      EconomicCategoryTranslation.where(:economic_category_id => id).delete_all
      EconomicCategory.delete(id)
    end
  end

end
