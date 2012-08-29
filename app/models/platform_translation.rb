class PlatformTranslation < ActiveRecord::Base
  has_paper_trail
  attr_accessible :platform_id, :description, :locale
  belongs_to :platform

  validates :description, :locale, :presence => true

end
