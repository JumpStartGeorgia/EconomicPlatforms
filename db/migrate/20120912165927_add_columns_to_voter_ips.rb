class AddColumnsToVoterIps < ActiveRecord::Migration
  def change
    add_column :voter_ips, :votable_type, :string
    add_column :voter_ips, :votable_id, :integer
  end

  def down
    remove_column :voter_ips, :votable_type
    remove_column :voter_ips, :votable_id
  end
end
