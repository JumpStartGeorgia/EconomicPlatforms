# encoding: UTF-8
class Add2012Election < ActiveRecord::Migration
  def up
    Election.transaction do
      # create election record
      election = Election.create(:date => '2012-10-01')
      election.election_translations.create(:name => '2012 Parliamentary Elections', :locale => 'en')
      election.election_translations.create(:name => '2012 წლის საპარლამენტო არჩევნები', :locale => 'ka')

      election2 = Election.create(:date => '2013-10-27')
      election2.election_translations.create(:name => '2013 Presidential Elections', :locale => 'en')
      election2.election_translations.create(:name => '2013 წლის საპრეზიდენტო არჩევნები', :locale => 'ka')

      # update all exisitng records to be for 2012 election
      Activity.update_all(:election_id => election.id)    
      Platform.update_all(:election_id => election.id)    
      PolicyBrief.update_all(:election_id => election.id)    
      PoliticalParty.update_all(:election_id => election.id)    
      Statement.update_all(:election_id => election.id)    
    end
  end

  def down
    Election.transaction do
      Activity.update_all(:election_id => nil)    
      Platform.update_all(:election_id => nil)    
      PolicyBrief.update_all(:election_id => nil)    
      PoliticalParty.update_all(:election_id => nil)    
      Statement.update_all(:election_id => nil)    

      Election.destroy_all    
    end
  end
end
