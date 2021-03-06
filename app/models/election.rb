class Election < ActiveRecord::Base
  has_paper_trail

  translates :name
  has_many :election_translations, :dependent => :destroy
  accepts_nested_attributes_for :election_translations
  attr_accessible :date, :election_translations_attributes

  has_and_belongs_to_many :political_parites

  has_many :activities
  has_many :platforms
  has_many :policy_briefs
#  has_many :political_parties
  has_many :statements

  validates :date, :presence => true

	scope :sorted, with_translations(I18n.locale).order("date desc")
	
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
    sql = "select distinct election_id from elections_political_parties"
    q = find_by_sql(sql)
    ids = []
    x = nil
        
    if q.present?
      ids << q.map{|x| x["election_id"]} 

      if ids.present?
        x = where(:id => ids)
      end
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


  ##############################
  ## shortcut methods to get to
  ## report file in report_file object
  ##############################
  def report_record
    x = self.election_translations.select{|x| x.locale == I18n.locale.to_s}.first
    if x.present?
      return x.report_record
    end
    return nil
  end
  def report_file_name
    report_record.file_file_name if !report_record.blank?
  end
  def report
    report_record.file if !report_record.blank?
  end

end
