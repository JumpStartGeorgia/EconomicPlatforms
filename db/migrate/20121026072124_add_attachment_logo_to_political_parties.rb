class AddAttachmentLogoToPoliticalParties < ActiveRecord::Migration
  def self.up
    add_column :political_parties, :logo_file_name, :string
    add_column :political_parties, :logo_content_type, :string
    add_column :political_parties, :logo_file_size, :integer
    add_column :political_parties, :logo_updated_at, :datetime
  end

  def self.down
    remove_column :political_parties, :logo_file_name
    remove_column :political_parties, :logo_content_type
    remove_column :political_parties, :logo_file_size
    remove_column :political_parties, :logo_updated_at
  end
end
