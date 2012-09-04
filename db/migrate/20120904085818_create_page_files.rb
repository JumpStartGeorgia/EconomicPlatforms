class CreatePageFiles < ActiveRecord::Migration
  def change
    create_table :page_files do |t|
      t.integer :page_id
      t.has_attached_file :file

      t.timestamps
    end
		add_index :page_files, :page_id
  end
end
