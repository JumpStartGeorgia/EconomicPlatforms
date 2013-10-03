class IndicatorTranslation < ActiveRecord::Base
  has_paper_trail
  attr_accessible :indicator_id, :name, :locale
  belongs_to :indicator

  validates :name, :locale, :presence => true

  def required_data_provided?
    provided = false
    
    provided = self.name.present?
    
    return provided
  end
  
  def add_required_data(obj)
    self.name = obj.name
  end
end
