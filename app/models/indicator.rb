class Indicator < ActiveRecord::Base
  has_paper_trail
  translates :name
  has_many :indicator_translations, :dependent => :destroy
  accepts_nested_attributes_for :indicator_translations
  attr_accessible :id, :indicator_category_id, :value, :indicator_translations_attributes

  belongs_to :indicator_category

  validates :indicator_category_id, :value, :presence => true

	default_scope lambda {with_translations(I18n.locale).order("indicators.indicator_category_id, indicators.value, indicator_translations.name")}

  def self.by_indicator_category(indicator_category_id)
    if indicator_category_id
      where(:indicator_category_id => indicator_category_id)
    end
  end

end
