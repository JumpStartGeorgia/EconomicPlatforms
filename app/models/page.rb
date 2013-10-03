class Page < ActiveRecord::Base
  has_paper_trail
  translates :title, :description
  has_many :page_files, :dependent => :destroy
  has_many :page_translations, :dependent => :destroy
  accepts_nested_attributes_for :page_translations
  accepts_nested_attributes_for :page_files, :reject_if => lambda { |a| a[:file].blank? }, :allow_destroy => true
  attr_accessible :name, :page_translations_attributes, :page_files_attributes

  validates :name, :presence => true


  # normal process of Election.destroy does not work because paper trail is throwing error
  # - so have to do normal deletes
  def self.delete_hack(id)
    if id.present?
      PageTranslation.where(:page_id => id).delete_all
      PageFile.where(:page_id => id).delete_all
      Page.delete(id)
    end
  end
end
