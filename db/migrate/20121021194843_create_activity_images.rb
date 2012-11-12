class CreateActivityImages < ActiveRecord::Migration
  def change
    create_table :activity_images do |t|
      t.integer :activity_id
      t.has_attached_file :file

      t.timestamps
    end
		add_index :activity_images, :activity_id
  end
end
