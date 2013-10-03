class PlatformTranslation < ActiveRecord::Base
  has_paper_trail
  attr_accessible :platform_id, :description, :locale
  belongs_to :platform

  validates :description, :locale, :presence => true

  def required_data_provided?
    provided = false
    
    provided = self.description.present?
    
    return provided
  end
  
  def add_required_data(obj)
    self.description = obj.description
  end
end
