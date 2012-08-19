class CreateIndicators < ActiveRecord::Migration
  def up
    create_table :indicators do |t|
      t.integer :indicator_category_id
      t.integer :value

      t.timestamps
    end
    Indicator.create_translation_table! :name => :string
    add_index :indicators, [:indicator_category_id,:value]
    add_index :indicator_translations, :name
  end
  def down
    remove_index :indicators, [:indicator_category_id,:value]
    drop_table :indicators
    remove_index :indicator_translations, :name
    Indicator.drop_translation_table!    
  end
end
