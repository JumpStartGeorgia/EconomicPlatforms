class PoliticalPartyTranslation < ActiveRecord::Base
  has_paper_trail
  attr_accessible :political_party_id, :name, :locale
  belongs_to :political_party

  validates :name, :locale, :presence => true

end
