class ReportFile < ActiveRecord::Base
	belongs_to :election_translation
	attr_accessible :election_translation_id,
		:file, :file_file_name, :file_content_type, :file_updated_at
	has_attached_file :file,
		:url => "/system/reports/:election_id/:locale/:filename"
	  
	validates_attachment :file, presence: true,
	  content_type: { content_type: "application/pdf" }
end
