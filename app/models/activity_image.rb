class ActivityImage < ActiveRecord::Base
	has_attached_file :file,
    :url => "/system/activity_images/:attachment/:activity_id/:style/:filename",
    :path => ":rails_root/public/system/activity_images/:attachment/:activity_id/:style/:filename",
		:styles => {
      :thumb => "122x122>",
      :medium => "300x300>" }

	belongs_to :activity
  attr_accessible :activity_id, :file
end
