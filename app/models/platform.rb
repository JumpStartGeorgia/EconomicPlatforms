class Platform < ActiveRecord::Base
  has_paper_trail
  translates :description
  belongs_to :political_party
  belongs_to :economic_category
  has_many :platform_files, :dependent => :destroy
  has_many :platform_scores, :dependent => :destroy
  has_many :platform_translations, :dependent => :destroy
  accepts_nested_attributes_for :platform_translations
  accepts_nested_attributes_for :platform_scores
  accepts_nested_attributes_for :platform_files, :reject_if => lambda { |a| a[:file].blank? }, :allow_destroy => true
  attr_accessible :political_party_id, :economic_category_id,
		:platform_translations_attributes, :platform_scores_attributes, :platform_files_attributes

  validates :political_party_id, :economic_category_id, :presence => true
	validates :economic_category_id, :uniqueness => {:scope => :political_party_id,
			:message => I18n.t('app.msgs.platform_already_exists')}

	def self.by_party_category(political_party_id, economic_category_id)
		if political_party_id && economic_category_id
			x = with_translations(I18n.locale)
			.where(:political_party_id => political_party_id, :economic_category_id => economic_category_id)

			return x.first if x && !x.empty?
		end
	end

	def self.by_political_party(political_party_id)
		if political_party_id
			includes(:economic_category => :economic_category_translations)
			.where(:platforms => {:political_party_id => political_party_id},
						:economic_category_translations => {:locale => I18n.locale})
			.order("economic_category_translations.name asc")
		end
	end

	def self.by_economic_category(economic_category_id)
		if economic_category_id
			includes(:political_party => :political_party_translations)
			.where(:platforms => {:economic_category_id => economic_category_id},
						:political_party_translations => {:locale => I18n.locale})
			.order("political_party_translations.name asc")
		end
	end

	def political_party_name
		return self.political_party.political_party_translations[0].name
	end

	def economic_category_name
		return self.economic_category.economic_category_translations[0].name
	end

	def political_party_permalink
		return self.political_party.political_party_translations[0].permalink
	end

	def economic_category_permalink
		return self.economic_category.economic_category_translations[0].permalink
	end


end
