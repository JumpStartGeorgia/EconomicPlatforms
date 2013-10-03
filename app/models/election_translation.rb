class ElectionTranslation < ActiveRecord::Base

  attr_accessible :election_id, :name, :locale
  belongs_to :election

  validates :name, :presence => true


  def required_data_provided?
    provided = false
    
    provided = self.name.present?
    
    return provided
  end
  
  def add_required_data(obj)
    self.name = obj.name
  end
end
