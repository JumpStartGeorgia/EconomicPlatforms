class AddPartyPlatform < ActiveRecord::Migration
  def up
		add_column :political_party_translations, :platform, :text
  end

  def down
		remove_column :political_party_translations, :platform
  end
end
