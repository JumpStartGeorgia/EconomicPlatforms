class Activity < ActiveRecord::Base

  attr_accessible :title, :body, :image, :video, :published_at

end
