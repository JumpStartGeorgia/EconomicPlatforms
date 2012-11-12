class ActivityTranslation < ActiveRecord::Base

  attr_accessible :activity_id, :title, :body, :locale
  belongs_to :activity

  validates :title, :body, :presence => true

end
