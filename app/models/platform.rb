class Platform < ActiveRecord::Base
  has_paper_trail
  translates :description
  belongs_to :political_party
  belongs_to :economic_category
  has_many :platform_scores, :dependent => :destroy
  has_many :platform_translations, :dependent => :destroy
  accepts_nested_attributes_for :platform_translations
  accepts_nested_attributes_for :platform_scores
  attr_accessible :political_party_id, :economic_category_id,
		:platform_translations_attributes, :platform_scores_attributes

  validates :political_party_id, :economic_category_id, :presence => true
	validates :economic_category_id, :uniqueness => {:scope => :political_party_id,
			:message => I18n.t('app.msgs.platform_already_exists')}

	def self.by_political_party(political_party_id)
		where(:political_party_id => political_party_id) if political_party_id
	end

	def self.by_economic_category(economic_category_id)
		where(:economic_category_id => economic_category_id) if economic_category_id
	end

end
