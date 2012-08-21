class StatementTranslation < ActiveRecord::Base
  has_paper_trail
  attr_accessible :statement_id, :statement_made, :source, :author, :analysis, :locale
  belongs_to :statement

  validates :statement_made, :author, :source, :locale, :presence => true

end
