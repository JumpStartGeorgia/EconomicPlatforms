class RemovePartyTransCandidate < ActiveRecord::Migration
  def up
		remove_column :political_party_translations, :candidate
  end

  def down
		add_column :political_party_translations, :candidate, :string
  end
end
