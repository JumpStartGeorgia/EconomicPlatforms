class AddIndToScores < ActiveRecord::Migration
  def up
    add_column :statement_scores, :indicator_id, :integer
    remove_index :statement_scores, :name => "statement_score_id_ind_cat_value"
    add_index :statement_scores, [:statement_id, :indicator_category_id, :indicator_id, :value], :name => "statement_score_record"
  end
  def down
    remove_column :statement_scores, :indicator_id, :integer
    add_index :statement_scores, [:statement_id, :indicator_category_id, :value], :name => "statement_score_id_ind_cat_value"
    remove_index :statement_scores, :name => "statement_score_record"
  end
end
