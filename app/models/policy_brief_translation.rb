class PolicyBriefTranslation < ActiveRecord::Base
  has_paper_trail
  attr_accessible :policy_brief_id, :analysis, :locale
  belongs_to :policy_brief

  validates :analysis, :locale, :presence => true

end
