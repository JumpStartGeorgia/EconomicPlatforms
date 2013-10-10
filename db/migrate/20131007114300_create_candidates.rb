# encoding: UTF-8
class CreateCandidates < ActiveRecord::Migration
  def up
    create_table :candidates do |t|
      t.integer :election_id
      t.integer :political_party_id

      t.timestamps
    end
    add_index :candidates, [:election_id, :political_party_id]

    Candidate.create_translation_table! :name => :string
    add_index :candidate_translations, :name

    # create records for 2013
    election_id = 2
    locales = ['en', 'ka', 'ru', 'am', 'az']
    party_names = ['Coalition - Georgian Dream', 'United National Movement', 'Christian Democratic Movement']
    candidate_names = [
      {:en => 'Giorgi Margvelashvili', :ka => 'გიორგი მარგველაშვილი'},
      {:en => 'David Bakradze', :ka => 'დავით ბაქრაძე'},
      {:en => 'Giorgi Targamadze', :ka => 'გიორგი თარგამაძე'},
      {:en => 'Nino Burjanadze', :ka => 'ნინო ბურჯანაძე'},
      {:en => 'Sergo Javakhadze', :ka => 'სერგო ჯავახიძე'}
    ]
    
    Candidate.transaction do
      # add new parties
      dem = PoliticalParty.create(:election_ids => election_id, :color => '#079fe2')
      locales.each_with_index do |locale, i|
        if i == 0
          dem.political_party_translations.create(:locale => locale, :name => 'Democratic Movement – United Georgia')
        else
          dem.political_party_translations.create(:locale => locale, :name => 'დემოკრატიული მოძრაობა  - "ერთიანი საქართველო"')
        end
      end
      party_names << 'Democratic Movement – United Georgia'
      
      justice = PoliticalParty.create(:election_ids => election_id, :color => '#007f14')
      locales.each_with_index do |locale, i|
        if i == 0
          justice.political_party_translations.create(:locale => locale, :name => 'Movement – Justice for Georgia')
        else
          justice.political_party_translations.create(:locale => locale, :name => 'მოძრაობა "სამართლიანი საქართველოსთვის"')
        end
      end
      party_names << 'Movement – Justice for Georgia'
      
      # make sure existing parties have 2013 election
      # and add candidate names
      party_names.each_with_index do |party, party_index|
        puts "working on #{party}"
        parties = PoliticalPartyTranslation.where(:name => party)
        if parties.present?
          puts "- found party"
          parties.each do |trans|
            puts "- workgin on party #{trans.name}"
            trans.political_party.election_ids << election_id

            puts "- creating candidate"
            c = Candidate.create(:election_id => election_id, :political_party_id => trans.political_party_id)
            locales.each_with_index do |locale, i|
              if i == 0
                c.candidate_translations.create(:locale => locale, :name => candidate_names[party_index][:en])
              else
                c.candidate_translations.create(:locale => locale, :name => candidate_names[party_index][:ka])
              end
            end
          end
        end
      end
    end
    
  end

  def down
    drop_table :candidates
    Candidate.drop_translation_table!
    
    names = ['Democratic Movement – United Georgia' , 'Movement – Justice for Georgia']
    PoliticalPartyTranslation.transaction do
      names.each do |name|
        parties = PoliticalPartyTranslation.where(:name => name)
        
        if parties.present?
          parties.each do |party|
            PoliticalParty.delete_hack(party.political_party_id)
          end
        end
      end
    end      
    
  end
end
