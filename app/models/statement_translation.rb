class StatementTranslation < ActiveRecord::Base
  attr_accessible :statement_id, :statement, :source, :author, :locale
  belongs_to :statement

  validates :statement, :source, :locale, :presence => true

end
