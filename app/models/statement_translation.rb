class StatementTranslation < ActiveRecord::Base
  attr_accessible :statement_id, :statement_made, :source, :author, :locale
  belongs_to :statement

  validates :statement_made, :source, :locale, :presence => true

end
