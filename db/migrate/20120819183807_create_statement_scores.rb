class CreateStatementScores < ActiveRecord::Migration
  def up
    create_table :statement_scores do |t|
      t.integer :statement_id
      t.integer :indicator_category_id
      t.integer :value

      t.timestamps
    end
    add_index :statement_scores, [:statement_id, :indicator_category_id, :value], :name => "statement_score_id_ind_cat_value"
  end
  def down
    remove_index :statement_scores, [:statement_id, :indicator_category_id, :value]
    drop_table :statement_scores
  end
end
