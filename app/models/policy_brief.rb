class PolicyBrief < ActiveRecord::Base
  has_paper_trail
  translates :analysis
  belongs_to :political_party
  belongs_to :economic_category
  has_many :policy_brief_scores, :dependent => :destroy
  has_many :policy_brief_translations, :dependent => :destroy
  accepts_nested_attributes_for :policy_brief_translations
  accepts_nested_attributes_for :policy_brief_scores
  attr_accessible :political_party_id, :economic_category_id,
		:policy_brief_translations_attributes, :policy_brief_scores_attributes

  validates :political_party_id, :economic_category_id, :presence => true
	validates :economic_category_id, :uniqueness => {:scope => :political_party_id,
			:message => I18n.t('app.msgs.policy_already_exists')}

	def self.by_political_party(political_party_id)
		where(:political_party_id => political_party_id) if political_party_id
	end

	def self.by_economic_category(economic_category_id)
		where(:economic_category_id => economic_category_id) if economic_category_id
	end

end
