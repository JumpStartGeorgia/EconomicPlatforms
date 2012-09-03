class AddPartyColor < ActiveRecord::Migration
  def up
    add_column :political_parties, :color, :string

    # assign colors
    parties = PoliticalParty.all

    #unm
    party = parties.select{|x| x.id == 1}.first
    party.color = "#E99334"
    party.save

    #geo dream
    party = parties.select{|x| x.id == 2}.first
    party.color = "#c83639"
    party.save

    #cdm
    party = parties.select{|x| x.id == 3}.first
    party.color = "#A29B88"
    party.save

    #nat dems
    party = parties.select{|x| x.id == 4}.first
    party.color = "#8AB2C1"
    party.save

    # new rights
    party = parties.select{|x| x.id == 5}.first
    party.color = "#4a7a8b"
    party.save

    #labour
    party = parties.select{|x| x.id == 6}.first
    party.color = "#985271"
    party.save
  end

  def down
    remove_column :political_parties, :color
  end
end
