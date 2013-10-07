class Candidate < ActiveRecord::Base
  has_paper_trail
  translates :name
  has_many :candidate_translations, :dependent => :destroy
  belongs_to :election
  belongs_to :political_party
  accepts_nested_attributes_for :candidate_translations
  attr_accessible :election_id, :political_party_id, :candidate_translations_attributes

  validates :election_id, :political_party_id, :presence => true
  validates :political_party_id, :uniqueness => {:scope => :election_id, :message => I18n.t('app.msgs.candidate_exists')}

  def images
    self.activity_images
  end

  def self.by_election(election_id)
    where(:election_id => election_id)
  end

  # normal process of Election.destroy does not work because paper trail is throwing error
  # - so have to do normal deletes
  def self.delete_hack(id)
    if id.present?
      CandidateTranslation.where(:candidate_id => id).delete_all
      CandidateImage.where(:candidate_id => id).delete_all
      Candidate.delete(id)
    end
  end


end