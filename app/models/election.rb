class Election < ActiveRecord::Base

  translates :name
  has_many :election_translations, :dependent => :destroy
  accepts_nested_attributes_for :election_translations
  attr_accessible :date, :election_translations_attributes

  has_many :activities
  has_many :platforms
  has_many :policy_briefs
  has_many :political_parties
  has_many :statements

  validates :date, :presence => true

	default_scope order("date desc")

end
