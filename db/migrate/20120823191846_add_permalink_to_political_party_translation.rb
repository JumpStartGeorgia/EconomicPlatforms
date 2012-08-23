class AddPermalinkToPoliticalPartyTranslation < ActiveRecord::Migration
  def self.up
    add_column :political_party_translations, :permalink, :string
    add_index :political_party_translations, :permalink
  end
  def self.down
    remove_column :political_party_translations, :permalink
  end
end