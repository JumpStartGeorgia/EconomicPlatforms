class CreateEconomicCategories < ActiveRecord::Migration
  def up
    create_table :economic_categories do |t|
      t.timestamps
    end
    EconomicCategory.create_translation_table! :name => :string
    add_index :economic_category_translations, :name
  end
  def down
    drop_table :economic_categories
    remove_index :economic_category_translations, :name
    EconomicCategory.drop_translation_table!    
  end
end
