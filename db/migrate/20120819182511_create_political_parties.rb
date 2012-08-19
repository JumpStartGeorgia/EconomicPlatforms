class CreatePoliticalParties < ActiveRecord::Migration
  def up
    create_table :political_parties do |t|
      t.timestamps
    end
    PoliticalParty.create_translation_table! :name => :string
    add_index :political_party_translations, :name
  end
  def down
    drop_table :political_parties
    remove_index :political_party_translations, :name
    PoliticalParty.drop_translation_table!    
  end
end
