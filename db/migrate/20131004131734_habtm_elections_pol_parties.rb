class HabtmElectionsPolParties < ActiveRecord::Migration
  def up
    create_table :elections_political_parties do |t|
      t.integer :election_id
      t.integer :political_party_id
      t.timestamps
    end

    add_index :elections_political_parties, [:election_id, :political_party_id], :name => 'elections_political_parties_ids'
    
    rename_column :political_parties, :election_id, :election_id_old

    # create records
    PoliticalParty.transaction do 
      PoliticalParty.readonly(false).each do |party|
        party.election_ids = party.election_id_old
      end
    end
  end

  def down
    rename_column :political_parties, :election_id_old, :election_id
    
    remove_index :elections_political_parties, :name => 'elections_political_parties_ids'
    drop_table :elections_political_parties
  end
end
