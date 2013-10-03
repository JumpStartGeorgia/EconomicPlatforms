class UpdatePartyColors < ActiveRecord::Migration
  def up
    PoliticalParty.transaction do
      PoliticalParty.where(:id => 1).update_all(:color => '#ca4748')
      PoliticalParty.where(:id => 2).update_all(:color => '#1b70af')
      PoliticalParty.where(:id => 3).update_all(:color => '#ca9c6c')
      PoliticalParty.where(:id => 4).update_all(:color => '#8AB2C1')
      PoliticalParty.where(:id => 5).update_all(:color => '#4a7a8b')
      PoliticalParty.where(:id => 6).update_all(:color => '#934e4e')
    end
  end

  def down
    PoliticalParty.transaction do
      PoliticalParty.where(:id => 1).update_all(:color => '#E99334')
      PoliticalParty.where(:id => 2).update_all(:color => '#c83639')
      PoliticalParty.where(:id => 3).update_all(:color => '#A29B88')
      PoliticalParty.where(:id => 4).update_all(:color => '#8AB2C1')
      PoliticalParty.where(:id => 5).update_all(:color => '#4a7a8b')
      PoliticalParty.where(:id => 6).update_all(:color => '#985271')
    end
  end
end
