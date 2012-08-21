class EconomicCategoryTranslation < ActiveRecord::Base
  has_paper_trail
  attr_accessible :economic_category_id, :name, :locale
  belongs_to :economic_category

  validates :name, :locale, :presence => true

end
