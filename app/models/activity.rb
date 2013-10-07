class Activity < ActiveRecord::Base
  has_paper_trail
  translates :title, :body
  has_many :activity_images, :dependent => :destroy
  has_many :activity_translations, :dependent => :destroy
  belongs_to :election
  accepts_nested_attributes_for :activity_translations
  accepts_nested_attributes_for :activity_images, :reject_if => lambda { |a| a[:file].blank? }, :allow_destroy => true
  attr_accessible :video, :date, :activity_images_attributes, :activity_translations_attributes, :election_id

  validates :date, :election_id, :presence => true

	scope :sorted, order("date desc")

  def images
    self.activity_images
  end

  def self.by_election(election_id)
    where(:election_id => election_id)
  end

  # normal process of Election.destroy does not work because paper trail is throwing error
  # - so have to do normal deletes
  def self.delete_hack(id)
    if id.present?
      ActivityTranslation.where(:activity_id => id).delete_all
      ActivityImage.where(:activity_id => id).delete_all
      Activity.delete(id)
    end
  end


end
