class ActivityFields < ActiveRecord::Migration
  def change
    rename_column :activities, :published_at, :date
    remove_column :activities, :image
  end
end
