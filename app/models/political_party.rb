class PoliticalParty < ActiveRecord::Base
  has_paper_trail
  belongs_to :election
  translates :name, :permalink
	has_attached_file :logo,
    :url => "/system/political_parties/:attachment/:id/:style/:filename",
    :path => ":rails_root/public/system/political_parties/:attachment/:id/:style/:filename"


  has_many :political_party_translations, :dependent => :destroy
  accepts_nested_attributes_for :political_party_translations
  attr_accessible :id, :color, :political_party_translations_attributes, :logo, :election_id

  validates :color, :election_id, :presence => true

  has_many :statements
  has_many :policy_briefs
	has_many :platforms

  def self.sorted
    with_translations(I18n.locale).order("political_party_translations.name")
  end

end
