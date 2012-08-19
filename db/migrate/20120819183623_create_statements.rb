class CreateStatements < ActiveRecord::Migration
  def up
    create_table :statements do |t|
      t.date :date_made
      t.integer :political_party_id
      t.integer :economic_category_id

      t.timestamps
    end
    Statement.create_translation_table! :statement => :text, :source => :string, :author => :string 
    add_index :statements, :date_made
    add_index :statements, [:political_party_id, :economic_category_id]
    add_index :statement_translations, :source
    add_index :statement_translations, :author
  end
  def down
    remove_index :statements, :date_made
    remove_index :statements, [:political_party_id, :economic_category_id]
    drop_table :statements
    remove_index :statement_translations, :source
    remove_index :statement_translations, :author
    Statement.drop_translation_table!    
  end
end
