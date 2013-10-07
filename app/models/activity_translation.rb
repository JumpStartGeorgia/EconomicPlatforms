class ActivityTranslation < ActiveRecord::Base
  has_paper_trail
  attr_accessible :activity_id, :title, :body, :locale
  belongs_to :activity

  validates :title, :body, :presence => true

  def required_data_provided?
    provided = false
    
    provided = self.title.present? && self.body.present?
    
    return provided
  end
  
  def add_required_data(obj)
    self.title = obj.title
    self.body = obj.body
  end
end
