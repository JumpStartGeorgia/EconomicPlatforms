class AddPermalinkToEconomicCategoryTranslation < ActiveRecord::Migration
  def self.up
    add_column :economic_category_translations, :permalink, :string
    add_index :economic_category_translations, :permalink
  end
  def self.down
    remove_column :economic_category_translations, :permalink
  end
end