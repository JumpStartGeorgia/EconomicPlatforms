class ChangeName < ActiveRecord::Migration
  def change
		rename_column :statement_translations, :statement, :statement_made
  end
end
