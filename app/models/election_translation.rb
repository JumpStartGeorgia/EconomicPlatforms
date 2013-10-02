class ElectionTranslation < ActiveRecord::Base

  attr_accessible :election_id, :name, :locale
  belongs_to :election

  validates :name, :presence => true

end
