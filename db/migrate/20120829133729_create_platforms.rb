class CreatePlatforms < ActiveRecord::Migration
  def up
    create_table :platforms do |t|
      t.integer :political_party_id
      t.integer :economic_category_id

      t.timestamps
    end
    Platform.create_translation_table! :description => :text
    add_index :platforms, [:political_party_id, :economic_category_id], :name => 'platform_party_ec_cat'

		#rename policy_brief_scores to platform
    remove_index :policy_brief_scores, :name => "pol_brief_score_id_ind_cat_value"
		rename_table :policy_brief_scores, :platform_scores
		rename_column :platform_scores, :policy_brief_id, :platform_id
    add_index :platform_scores, [:platform_id, :indicator_category_id, :indicator_id, :value], :name => "platform_score_id_ind_cat_value"

		#remove ngo from policy briefs - client not want
		remove_column :policy_briefs, :ngo_id
  end
  def down
    remove_index :platforms, :name => 'platform_party_ec_cat'
    drop_table :platforms
    Platform.drop_translation_table!

		#rename platform_scores to policy_brief
    remove_index :platform_scores, :name => "platform_score_id_ind_cat_value"
		rename_column :platform_scores, :platform_id, :policy_brief_id
		rename_table :platform_scores, :policy_brief_scores
    add_index :policy_brief_scores, [:policy_brief_id, :indicator_category_id, :indicator_id, :value], :name => "pol_brief_score_id_ind_cat_value"

		add_column :policy_briefs, :ngo_id, :integer
  end
end
