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

	scope :sorted, order("date desc")
	
  # normal process of Election.destroy does not work because paper trail is throwing error
  # - so have to do normal deletes
  def self.delete_hack(id)
    if id.present?
      ElectionTranslation.where(:election_id => id).delete_all
      Election.delete(id)
    end
  end

  # get elections that have political parties
  def self.with_political_parties
    x = nil
    ids = []
    pp = PoliticalParty.select('distinct election_id')
    ids << pp.map{|x| x.election_id} if pp.present?
    
    ids.flatten!

    if ids.present?
      x = where(:id => ids)
    end
    
    return x
  end

	# get elections that have data
	# data is defined as having at least one record that is public in: platform, policy brief, or statement
	def self.with_data
    x = nil
	  ids = []
	  p = Platform.select('distinct election_id').published
	  pb = PolicyBrief.select('distinct election_id').published
	  s = Statement.select('distinct election_id').published
	  
	  ids << p.map{|x| x.election_id} if p.present?
	  ids << pb.map{|x| x.election_id} if pb.present?
	  ids << s.map{|x| x.election_id} if s.present?

    ids.flatten!.uniq!
    
    if ids.present?
      x = where(:id => ids)
    end
    
    return x
	end

end
