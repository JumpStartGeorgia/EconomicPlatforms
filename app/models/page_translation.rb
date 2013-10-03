class PageTranslation < ActiveRecord::Base
  has_paper_trail
  attr_accessible :page_id, :title, :description, :locale
  belongs_to :page

  validates :title, :description, :locale, :presence => true

  def required_data_provided?
    provided = false
    
    provided = self.title.present? && self.description.present?
    
    return provided
  end
  
  def add_required_data(obj)
    self.title = obj.title
    self.description = obj.description
  end
end
