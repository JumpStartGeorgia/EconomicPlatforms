class CreateIndicatorCategories < ActiveRecord::Migration
  def up
    create_table :indicator_categories do |t|
      t.timestamps
    end
    IndicatorCategory.create_translation_table! :name => :string
    add_index :indicator_category_translations, :name
  end
  def down
    drop_table :indicator_categories
    remove_index :indicator_category_translations, :name
    IndicatorCategory.drop_translation_table!    
  end
end
