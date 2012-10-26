class Activity < ActiveRecord::Base

  translates :title, :body
  has_many :activity_images, :dependent => :destroy
  has_many :activity_translations, :dependent => :destroy
  accepts_nested_attributes_for :activity_translations
  accepts_nested_attributes_for :activity_images, :reject_if => lambda { |a| a[:file].blank? }, :allow_destroy => true
  attr_accessible :image, :video, :date, :activity_images_attributes, :activity_translations_attributes

  validates :date, :presence => true

	default_scope order("date desc")

  def images
    self.activity_images
  end

end
