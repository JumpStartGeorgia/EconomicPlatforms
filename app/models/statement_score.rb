class StatementScore < ActiveRecord::Base
  belongs_to :statement
  belongs_to :indicator_category
  
  attr_accessible :statement_id, :indicator_category_id, :value
  validates :statement_id, :indicator_category_id, :value, :presence => true
  
end
