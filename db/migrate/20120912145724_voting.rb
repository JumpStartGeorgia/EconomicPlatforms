class Voting < ActiveRecord::Migration
  def change
    create_table :voter_ips do |t|
      t.string :ip, :limit => 50, :default => "" 
      t.timestamps
    end

    add_column :statements, :vote, :string
    add_column :platforms, :vote, :string
    add_column :policy_briefs, :vote, :string
    add_column :comments, :vote, :string
  end

  def down
    drop_table :voter_ips

    remove_column :statements, :vote
    remove_column :platforms, :vote
    remove_column :policy_briefs, :vote
    remove_column :comments, :vote
  end
end
