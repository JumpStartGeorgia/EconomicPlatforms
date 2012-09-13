class AddStatusVoterIps < ActiveRecord::Migration
  def up
    add_column :voter_ips, :status, :string
  end

  def down
    remove_column :voter_ips, :status
  end
end
