class IndicatorTranslation < ActiveRecord::Base
  has_paper_trail
  attr_accessible :indicator_id, :name, :locale
  belongs_to :indicator

  validates :name, :locale, :presence => true

end
