class IndicatorCategoryTranslation < ActiveRecord::Base
  attr_accessible :indicator_category_id, :name, :locale
  belongs_to :indicator_category

  validates :name, :locale, :presence => true

end
