class CreateElectionsTable < ActiveRecord::Migration
  def self.up
    create_table :elections do |t|
      t.date :date
      t.timestamps
    end

		add_column :activities,        :election_id, :integer
		add_column :platforms,         :election_id, :integer
		add_column :policy_briefs,     :election_id, :integer
		add_column :political_parties, :election_id, :integer
		add_column :statements,        :election_id, :integer
  end



  def self.down
    drop_table :elections

		remove_column :activities,        :election_id
		remove_column :platforms,         :election_id
		remove_column :policy_briefs,     :election_id
		remove_column :political_parties, :election_id
		remove_column :statements,        :election_id
  end

end
