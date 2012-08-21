class IndicatorCategoryTranslation < ActiveRecord::Base
  has_paper_trail
  attr_accessible :indicator_category_id, :name, :locale
  belongs_to :indicator_category

  validates :name, :locale, :presence => true

end
