class PoliticalParty < ActiveRecord::Base
  has_paper_trail
  translates :name, :permalink
  has_many :political_party_translations, :dependent => :destroy
  accepts_nested_attributes_for :political_party_translations
  attr_accessible :id, :color, :political_party_translations_attributes

  validates :color, :presence => true

  has_many :statements
  has_many :policy_briefs

	default_scope lambda {with_translations(I18n.locale).order("political_party_translations.name")}

end
