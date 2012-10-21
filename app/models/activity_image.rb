class ActivityImage < ActiveRecord::Base
	has_attached_file :file,
    :url => "/system/activity_images/:attachment/:activity_id/:style/:filename",
    :path => ":rails_root/public/system/activity_images/:attachment/:activity_id/:style/:filename"

	belongs_to :activity
  attr_accessible :activity_id, :file
end
