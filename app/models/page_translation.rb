class PageTranslation < ActiveRecord::Base
  has_paper_trail
  attr_accessible :page_id, :title, :description, :locale
  belongs_to :page

  validates :title, :description, :locale, :presence => true

end
