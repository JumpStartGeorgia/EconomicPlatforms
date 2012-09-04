class AddPublicFlag < ActiveRecord::Migration
  def change
		add_column :platforms, :is_public, :boolean, :default => false
		add_index :platforms, :is_public
		add_column :policy_briefs, :is_public, :boolean, :default => false
		add_index :policy_briefs, :is_public
		add_column :statements, :is_public, :boolean, :default => false
		add_index :statements, :is_public

		# update all existing record to turn flag on
		Platform.all.each do |platform|
			platform.is_public = true
			platform.save
		end
		PolicyBrief.all.each do |brief|
			brief.is_public = true
			brief.save
		end
		Statement.all.each do |statement|
			statement.is_public = true
			statement.save
		end
  end

end
