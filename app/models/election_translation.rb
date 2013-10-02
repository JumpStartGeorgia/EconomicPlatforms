class ElectionTranslation < ActiveRecord::Base

  attr_accessible :election_id, :name, :locale
  belongs_to :election

  validates :name, :presence => true


  def required_data_provided?
    provided = false
    
    provided = self.name.present?

Rails.logger.debug "***************************************"
Rails.logger.debug "******* - required data provided = #{provided}"
    
    return provided
  end
  
  def add_required_data(obj)
Rails.logger.debug "***************************************"
Rails.logger.debug "******* - setting name to #{obj.name}"
    self.name = obj.name
  end
end
