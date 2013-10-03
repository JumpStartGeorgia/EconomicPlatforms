class PolicyBriefTranslation < ActiveRecord::Base
  has_paper_trail
  attr_accessible :policy_brief_id, :analysis, :locale
  belongs_to :policy_brief

  validates :analysis, :locale, :presence => true

  def required_data_provided?
    provided = false
    
    provided = self.analysis.present?
    
    return provided
  end
  
  def add_required_data(obj)
    self.analysis = obj.analysis
  end
end
