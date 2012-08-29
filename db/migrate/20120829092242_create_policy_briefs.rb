class CreatePolicyBriefs < ActiveRecord::Migration
  def up
    create_table :policy_briefs do |t|
      t.integer :political_party_id
      t.integer :economic_category_id
      t.integer :ngo_id

      t.timestamps
    end
    PolicyBrief.create_translation_table! :analysis => :text
    add_index :policy_briefs, [:political_party_id, :economic_category_id], :name => 'pol_briefs_party_ec_cat'
    add_index :policy_briefs, :ngo_id
  end
  def down
    remove_index :policy_briefs, :name => 'pol_briefs_party_ec_cat'
    remove_index :policy_briefs, :ngo_id
    drop_table :policy_briefs
    PolicyBrief.drop_translation_table!
  end
end
