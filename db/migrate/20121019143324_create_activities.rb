class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :title
      t.date :published_at
      t.text :body
      t.string :image
      t.string :video

      t.timestamps
    end
  end
end
