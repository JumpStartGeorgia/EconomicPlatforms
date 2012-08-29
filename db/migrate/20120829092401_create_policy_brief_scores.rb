class CreatePolicyBriefScores < ActiveRecord::Migration
  def change
    create_table :policy_brief_scores do |t|
      t.integer :policy_brief_id
      t.integer :indicator_category_id
      t.integer :indicator_id
      t.integer :value

      t.timestamps
    end
    add_index :policy_brief_scores, [:policy_brief_id, :indicator_category_id, :indicator_id, :value], :name => "pol_brief_score_id_ind_cat_value"
  end
end
