class AddAttachmentFileToPlatformFiles < ActiveRecord::Migration
  def up
    create_table :platform_files do |t|
      t.integer :platform_id
      t.has_attached_file :file

      t.timestamps
    end

		add_index :platform_files, :platform_id
  end

  def self.down
    drop_table :platform_files
		remove_index :platform_files, :platform_id
  end
end
