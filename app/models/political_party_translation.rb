class PoliticalPartyTranslation < ActiveRecord::Base
	require 'utf8_converter'
  has_paper_trail
  has_permalink :create_permalink
  belongs_to :political_party

  attr_accessible :political_party_id, :name, :locale, :permalink

  validates :name, :locale, :presence => true
  validates :permalink, :uniqueness => {:scope => :locale, :case_sensitive => false, :message => I18n.t('app.msgs.permalink_exists')}

  def create_permalink
    "#{Utf8Converter.convert_ka_to_en(name.clone.to_ascii.gsub(/[^0-9A-Za-z|_\- ]/,''))}"
  end

  def required_data_provided?
    provided = false
    
    provided = self.name.present?
    
    return provided
  end
  
  def add_required_data(obj)
    self.name = obj.name
  end
end
