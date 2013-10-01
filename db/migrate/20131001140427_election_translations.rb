class ElectionTranslations < ActiveRecord::Migration
  def up
    Election.create_translation_table! :name => :string
  end

  def down
    Election.drop_translation_table!
  end

end
