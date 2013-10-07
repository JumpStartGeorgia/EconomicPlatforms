class PoliticalParty < ActiveRecord::Base
  has_paper_trail
#  belongs_to :election
  translates :name, :permalink

  
	has_attached_file :logo,
    :url => "/system/political_parties/:attachment/:id/:style/:filename",
    :path => ":rails_root/public/system/political_parties/:attachment/:id/:style/:filename"


  has_and_belongs_to_many :elections
  accepts_nested_attributes_for :elections
  has_many :political_party_translations, :dependent => :destroy
  accepts_nested_attributes_for :political_party_translations
  attr_accessible :id, :color, :political_party_translations_attributes, :logo, :election_id_old, :elections_attributes, :election_ids

#  validates :color, :election_id, :presence => true
  validates :color, :presence => true
  validate :required_elections

  has_many :statements
  has_many :policy_briefs
	has_many :platforms
	
  def required_elections
    errors.add :election, I18n.t('formtastic.required') if self.election_ids.length == 0
  end

  def name_with_candidate(election_id)
    cand = Candidate.name_for_election_party(election_id, self.id)
    name = self.name.clone
    name << " (#{cand})" if cand.present? && name.present?
    return name
  end

  def self.sorted
    with_translations(I18n.locale).order("political_party_translations.name")
  end

  def self.by_election(election_id)
    joins(:elections).where('elections.id = ?', election_id)
  end
  
	# get parties that have data
	# data is defined as having at least one record that is public in: platform, policy brief, or statement
	def self.with_data
    x = nil
	  ids = []
	  p = Platform.select('distinct political_party_id').published
	  pb = PolicyBrief.select('distinct political_party_id').published
	  s = Statement.select('distinct political_party_id').published
	  
	  ids << p.map{|x| x.political_party_id} if p.present?
	  ids << pb.map{|x| x.political_party_id} if pb.present?
	  ids << s.map{|x| x.political_party_id} if s.present?

    ids.flatten!.uniq!
    
    if ids.present?
      x = where(:id => ids)
    end
    
    return x
	end
  
  def elections_sorted
    sql = "select distinct election_id from elections_political_parties where political_party_id = ?"
    q = PoliticalParty.find_by_sql([sql, self.id.to_s])
    ids = []
    x = nil
    
    if q.present?
      ids << q.map{|x| x["election_id"]} 

      if ids.present?
        x = Election.where(:id => ids).sorted
      end
    end
    
    return x
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
