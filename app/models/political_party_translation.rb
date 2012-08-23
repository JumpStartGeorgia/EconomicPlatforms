class PoliticalPartyTranslation < ActiveRecord::Base
  has_paper_trail
  has_permalink :create_permalink
  attr_accessible :political_party_id, :name, :locale, :permalink
  belongs_to :political_party

  validates :name, :locale, :presence => true
	validates :permalink, :uniqueness => {:scope => :locale, :case_sensitive => false,
			:message => I18n.t('app.msgs.permalink_exists')}

  def create_permalink
    "#{Utf8Converter.convert(name.clone)}"
  end

end
