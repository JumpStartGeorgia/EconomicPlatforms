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

  def self.by_election(election_id)
    where(:election_id => election_id)
  end

  # normal process of Election.destroy does not work because paper trail is throwing error
  # - so have to do normal deletes
  def self.delete_hack(id)
    if id.present?
      PoliticalPartyTranslation.where(:political_party_id => id).delete_all
      PoliticalParty.delete(id)
    end
  end


end
