class IndicatorTranslation < ActiveRecord::Base
  attr_accessible :indicator_id, :name, :locale
  belongs_to :indicator

  validates :name, :locale, :presence => true

end
