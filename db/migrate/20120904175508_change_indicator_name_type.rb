class ChangeIndicatorNameType < ActiveRecord::Migration
  def change
	  remove_index :indicator_translations, :name
		change_column :indicator_translations, :name, :text

  end

  def down
		change_column :indicator_translations, :name, :string
	  add_index :indicator_translations, :name
  end
end
