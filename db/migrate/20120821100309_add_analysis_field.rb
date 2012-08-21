class AddAnalysisField < ActiveRecord::Migration
  def up
		add_column :statement_translations, :analysis, :text
  end

  def down
		remove_column :statement_translations, :analysis
  end
end
