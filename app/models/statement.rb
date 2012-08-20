class Statement < ActiveRecord::Base
  translates :statement, :source, :author
  has_many :statement_translations, :dependent => :destroy
  accepts_nested_attributes_for :statement_translations
  attr_accessible :date_maade, :political_party_id, :economic_category_id, :statement_translations_attributes
  
  belongs_to :political_party
  belongs_to :economic_category
  has_many :statement_scores
  
  validates :date_made, :political_party_id, :economic_category_id, :presence => true
  
end
