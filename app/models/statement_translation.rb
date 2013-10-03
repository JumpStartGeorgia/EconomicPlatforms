class StatementTranslation < ActiveRecord::Base
  has_paper_trail
  attr_accessible :statement_id, :statement_made, :source, :author, :analysis, :locale
  belongs_to :statement

  validates :statement_made, :author, :source, :locale, :presence => true

  def required_data_provided?
    provided = false
    
    provided = self.statement_made.present? && self.author.present? && self.source.present?
    
    return provided
  end
  
  def add_required_data(obj)
    self.statement_made = obj.statement_made
    self.author = obj.author
    self.source = obj.source
  end
end
