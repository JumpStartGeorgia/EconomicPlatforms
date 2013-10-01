class Election < ActiveRecord::Base

  translates :name
  accepts_nested_attributes_for :election_translations
  attr_accessible :date, :election_translations_attributes

 #validates :date, :presence => true

	default_scope order("date desc")

end
