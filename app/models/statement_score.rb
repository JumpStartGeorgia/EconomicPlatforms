class StatementScore < ActiveRecord::Base
  has_paper_trail
  belongs_to :statement
  belongs_to :indicator_category
  belongs_to :indicator

  attr_accessible :statement_id, :indicator_category_id, :indicator_id, :value
  validates :indicator_category_id, :indicator_id, :value, :presence => true

  # in the statement form, the indicator_id and value are combined into one value
	def combined
		"#{self.indicator_id}||#{self.value}"
	end

  def self.ordered
	  includes(:indicator_category => :indicator_category_translations)
	  .where(:indicator_category_translations => {:locale => I18n.locale})
	  .order("indicator_category_translations.name asc")
  end



end
