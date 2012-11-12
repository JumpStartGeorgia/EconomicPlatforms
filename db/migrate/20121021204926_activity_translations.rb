class ActivityTranslations < ActiveRecord::Migration
  def up
    remove_column :activities, :title
    remove_column :activities, :body
    Activity.create_translation_table! :title => :string, :body => :text
  end

	def down
    add_column :activities, :title, :string
    add_column :activities, :body, :text
    Activity.drop_translation_table!
	end
end
