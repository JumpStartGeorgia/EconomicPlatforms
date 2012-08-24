class EconomicCategoryTranslation < ActiveRecord::Base
	require 'utf8_converter'
  has_paper_trail
  has_permalink :create_permalink
  attr_accessible :economic_category_id, :name, :locale, :permalink
  belongs_to :economic_category

  validates :name, :locale, :presence => true
	validates :permalink, :uniqueness => {:scope => :locale, :case_sensitive => false,
			:message => I18n.t('app.msgs.permalink_exists')}

  def create_permalink
    "#{Utf8Converter.convert_ka_to_en(name.clone)}"
  end

end
