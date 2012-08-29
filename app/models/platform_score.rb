class PlatformScore < ActiveRecord::Base
  has_paper_trail
  belongs_to :platform
  belongs_to :indicator_category
  belongs_to :indicator

  attr_accessible :platform_id, :indicator_category_id, :indicator_id, :value
  validates :indicator_category_id, :indicator_id, :value, :presence => true

  # in the platform form, the indicator_id and value are combined into one value
	def combined
		"#{self.indicator_id}||#{self.value}"
	end

  def self.ordered
	  includes(:indicator_category => :indicator_category_translations)
	  .where(:indicator_category_translations => {:locale => I18n.locale})
	  .order("indicator_category_translations.name asc")
  end

end
