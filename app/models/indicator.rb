class Indicator < ActiveRecord::Base
  has_paper_trail
  translates :name
  has_many :indicator_translations, :dependent => :destroy
  accepts_nested_attributes_for :indicator_translations
  attr_accessible :id, :indicator_category_id, :value, :indicator_translations_attributes

  belongs_to :indicator_category

  validates :indicator_category_id, :value, :presence => true

  def self.sorted
    with_translations(I18n.locale).order("indicators.indicator_category_id, indicators.value, indicator_translations.name")  
  end

  def self.by_indicator_category(indicator_category_id)
    if indicator_category_id
      where(:indicator_category_id => indicator_category_id)
    end
  end


  # normal process of Election.destroy does not work because paper trail is throwing error
  # - so have to do normal deletes
  def self.delete_hack(id)
    if id.present?
      IndicatorTranslation.where(:indicator_id => id).delete_all
      Indicator.delete(id)
    end
  end

end
