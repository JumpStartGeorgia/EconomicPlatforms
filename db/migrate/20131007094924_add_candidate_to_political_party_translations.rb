class AddCandidateToPoliticalPartyTranslations < ActiveRecord::Migration
  def change
		add_column :political_party_translations, :candidate, :string
  end
end
