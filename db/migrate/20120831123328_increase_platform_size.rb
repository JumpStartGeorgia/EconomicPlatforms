class IncreasePlatformSize < ActiveRecord::Migration
  def up
		change_column :platform_translations, :description, :text, :limit => 16777215
  end
  def down
		change_column :platform_translations, :description, :text, :limit => 65535
  end
end
