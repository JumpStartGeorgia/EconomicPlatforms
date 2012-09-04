class PageFile < ActiveRecord::Base
  has_paper_trail
	has_attached_file :file,
    :url => "/system/page_files/:attachment/:page_id/:style/:filename",
    :path => ":rails_root/public/system/page_files/:attachment/:page_id/:style/:filename"

	belongs_to :page
  attr_accessible :page_id, :file
end
