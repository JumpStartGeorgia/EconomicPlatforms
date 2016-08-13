class CreateReportFiles < ActiveRecord::Migration
  def change
    create_table :report_files do |t|
      t.integer :election_translation_id
      t.has_attached_file :file

      t.timestamps
    end

    add_index :report_files, :election_translation_id
  end
end
