class PlatformFile < ActiveRecord::Base
  has_paper_trail
	has_attached_file :file,
    :url => "/system/platform_files/:attachment/:platform_id/:style/:filename",
    :path => ":rails_root/public/system/platform_files/:attachment/:platform_id/:style/:filename"

	belongs_to :platform
  attr_accessible :platform_id, :file
end
