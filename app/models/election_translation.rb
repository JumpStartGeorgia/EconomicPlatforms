class ElectionTranslation < ActiveRecord::Base

  belongs_to :election
  has_one :report_file, :dependent => :destroy
  accepts_nested_attributes_for :report_file

  attr_accessible :election_id, :name, :locale, :report_file_attributes

  validates :name, :presence => true


  def required_data_provided?
    provided = false
    
    provided = self.name.present?
    
    return provided
  end
  
  def add_required_data(obj)
    self.name = obj.name
  end


  ##############################
  ## shortcut methods to get to
  ## report file in report object
  ##############################
  def report_record
    self.report_file
  end
  def report
    report_record.file if report_record
  end
  def report_file_name
    report_record.file_file_name if report_record
  end

end
