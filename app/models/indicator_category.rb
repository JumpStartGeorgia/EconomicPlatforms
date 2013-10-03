class IndicatorCategory < ActiveRecord::Base
  has_paper_trail
  translates :name
  has_many :indicator_category_translations, :dependent => :destroy
  accepts_nested_attributes_for :indicator_category_translations
  attr_accessible :id, :indicator_category_translations_attributes

  has_many :indicators
  has_many :statement_scores

  def self.sorted
    with_translations(I18n.locale).order("indicator_category_translations.name")
  end

  def self.with_indicators
    joins(:indicators)
    .where("indicators.id is not null")
  end


  # normal process of Election.destroy does not work because paper trail is throwing error
  # - so have to do normal deletes
  def self.delete_hack(id)
    if id.present?
      IndicatorCategoryTranslation.where(:indicator_category_id => id).delete_all
      IndicatorCategory.delete(id)
    end
  end
end
