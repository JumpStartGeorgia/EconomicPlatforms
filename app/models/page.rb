class Page < ActiveRecord::Base
  has_paper_trail
  translates :title, :description
  has_many :page_files, :dependent => :destroy
  has_many :page_translations, :dependent => :destroy
  accepts_nested_attributes_for :page_translations
  accepts_nested_attributes_for :page_files, :reject_if => lambda { |a| a[:file].blank? }, :allow_destroy => true
  attr_accessible :name, :page_translations_attributes, :page_files_attributes

  validates :name, :presence => true
end
