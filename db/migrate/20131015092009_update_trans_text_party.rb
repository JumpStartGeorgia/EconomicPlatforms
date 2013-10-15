# encoding: UTF-8
class UpdateTransTextParty < ActiveRecord::Migration
  def up
    PoliticalParty.transaction do
      # political party names
      ###############################
      puts '###############################'
      puts 'political parties'
      puts '###############################'

      # ერთიანი ნაციონალური მოძრაობა
      puts '###############################'
      puts 'ერთიანი ნაციონალური მოძრაობა'
      trans = PoliticalPartyTranslation.where(:locale => 'am', :name => 'ერთიანი ნაციონალური მოძრაობა').readonly(false)
      if trans.present?
        puts '- updating am' 
        trans.first.name = 'Միասնական ազգային շարժումը'
        trans.first.permalink = nil
        trans.first.save
      end
      trans = PoliticalPartyTranslation.where(:locale => 'az', :name => 'ერთიანი ნაციონალური მოძრაობა').readonly(false)
      if trans.present?
        puts '- updating az' 
        trans.first.name = 'Vahid Milli Hərəkatı'
        trans.first.permalink = nil
        trans.first.save
      end
      trans = PoliticalPartyTranslation.where(:locale => 'ru', :name => 'ერთიანი ნაციონალური მოძრაობა').readonly(false)
      if trans.present?
        puts '- updating ru' 
        trans.first.name = 'Единое национальное движение'
        trans.first.permalink = nil
        trans.first.save
      end
      ###############################
      # კოალიცია "ქართული ოცნება"
      puts '###############################'
      puts 'კოალიცია "ქართული ოცნება"'
      trans = PoliticalPartyTranslation.where(:locale => 'am', :name => 'კოალიცია "ქართული ოცნება"').readonly(false)
      if trans.present?
        puts '- updating am' 
        trans.first.name = '"Վրացական երազանք" կոալիցիան'
        trans.first.permalink = nil
        trans.first.save
      end
      trans = PoliticalPartyTranslation.where(:locale => 'az', :name => 'კოალიცია "ქართული ოცნება"').readonly(false)
      if trans.present?
        puts '- updating az' 
        trans.first.name = 'Koalisiya "Gürcü Arzusu"'
        trans.first.permalink = nil
        trans.first.save
      end
      trans = PoliticalPartyTranslation.where(:locale => 'ru', :name => 'კოალიცია "ქართული ოცნება"').readonly(false)
      if trans.present?
        puts '- updating ru' 
        trans.first.name = 'Коалиция "Грузинская мечта"'
        trans.first.permalink = nil
        trans.first.save
      end
      ###############################
      # ქრისტიან-დემოკრატიული მოძრაობა
      puts '###############################'
      puts 'ქრისტიან-დემოკრატიული მოძრაობა'
      trans = PoliticalPartyTranslation.where(:locale => 'am', :name => 'ქრისტიან-დემოკრატიული მოძრაობა').readonly(false)
      if trans.present?
        puts '- updating am' 
        trans.first.name = 'Քրիստոնեա-ժողովրդավարական շարժումը'
        trans.first.permalink = nil
        trans.first.save
      end
      trans = PoliticalPartyTranslation.where(:locale => 'az', :name => 'ქრისტიან-დემოკრატიული მოძრაობა').readonly(false)
      if trans.present?
        puts '- updating az' 
        trans.first.name = 'Xristiyan-Demokratik Hərəkatı'
        trans.first.permalink = nil
        trans.first.save
      end
      trans = PoliticalPartyTranslation.where(:locale => 'ru', :name => 'ქრისტიან-დემოკრატიული მოძრაობა').readonly(false)
      if trans.present?
        puts '- updating ru' 
        trans.first.name = 'Христиан-демократическое движение'
        trans.first.permalink = nil
        trans.first.save
      end
      ###############################
      # საქართველოს ეროვნულ-დემოკრატიული პარტია
      puts '###############################'
      puts 'საქართველოს ეროვნულ-დემოკრატიული პარტია'
      trans = PoliticalPartyTranslation.where(:locale => 'am', :name => 'საქართველოს ეროვნულ-დემოკრატიული პარტია').readonly(false)
      if trans.present?
        puts '- updating am' 
        trans.first.name = 'Վրաստանի Ազգային ֊ ժողովրդավարական կուսակցությունը'
        trans.first.permalink = nil
        trans.first.save
      end
      trans = PoliticalPartyTranslation.where(:locale => 'az', :name => 'საქართველოს ეროვნულ-დემოკრატიული პარტია').readonly(false)
      if trans.present?
        puts '- updating az' 
        trans.first.name = 'Gürcüstanın Milli-Demokratik Partiyası'
        trans.first.permalink = nil
        trans.first.save
      end
      trans = PoliticalPartyTranslation.where(:locale => 'ru', :name => 'საქართველოს ეროვნულ-დემოკრატიული პარტია').readonly(false)
      if trans.present?
        puts '- updating ru' 
        trans.first.name = 'Национально-демократическая партия Грузии'
        trans.first.permalink = nil
        trans.first.save
      end
      ###############################
      # ახალი მემარჯვენეები
      puts '###############################'
      puts 'ახალი მემარჯვენეები'
      trans = PoliticalPartyTranslation.where(:locale => 'am', :name => 'ახალი მემარჯვენეები').readonly(false)
      if trans.present?
        puts '- updating am' 
        trans.first.name = 'Նոր աջերը'
        trans.first.permalink = nil
        trans.first.save
      end
      trans = PoliticalPartyTranslation.where(:locale => 'az', :name => 'ახალი მემარჯვენეები').readonly(false)
      if trans.present?
        puts '- updating az' 
        trans.first.name = 'Yeni Sağçılar'
        trans.first.permalink = nil
        trans.first.save
      end
      trans = PoliticalPartyTranslation.where(:locale => 'ru', :name => 'ახალი მემარჯვენეები').readonly(false)
      if trans.present?
        puts '- updating ru' 
        trans.first.name = 'Новые правые'
        trans.first.permalink = nil
        trans.first.save
      end
      ###############################
      # ლეიბორისტული პარტია
      puts '###############################'
      puts 'ლეიბორისტული პარტია'
      trans = PoliticalPartyTranslation.where(:locale => 'am', :name => 'ლეიბორისტული პარტია').readonly(false)
      if trans.present?
        puts '- updating am' 
        trans.first.name = 'Լեյբորիստական կուսակցությունը'
        trans.first.permalink = nil
        trans.first.save
      end
      trans = PoliticalPartyTranslation.where(:locale => 'az', :name => 'ლეიბორისტული პარტია').readonly(false)
      if trans.present?
        puts '- updating az' 
        trans.first.name = 'Leiboristlər Partiyası'
        trans.first.permalink = nil
        trans.first.save
      end
      trans = PoliticalPartyTranslation.where(:locale => 'ru', :name => 'ლეიბორისტული პარტია').readonly(false)
      if trans.present?
        puts '- updating ru' 
        trans.first.name = 'Лейбористская партия'
        trans.first.permalink = nil
        trans.first.save
      end
      ###############################
      # დემოკრატიული მოძრაობა - "ერთიანი საქართველო"
      puts '###############################'
      puts 'დემოკრატიული მოძრაობა - "ერთიანი საქართველო"'
      trans = PoliticalPartyTranslation.where(:locale => 'am', :name => 'დემოკრატიული მოძრაობა  - "ერთიანი საქართველო"').readonly(false)
      if trans.present?
        puts '- updating am' 
        trans.first.name = '"Միասնական Վրաստան" Ժողովրդավարական շարժում '
        trans.first.permalink = nil
        trans.first.save
      end
        puts '- no az' 
=begin      
      trans = PoliticalPartyTranslation.where(:locale => 'az', :name => 'დემოკრატიული მოძრაობა  - "ერთიანი საქართველო"').readonly(false)
      if trans.present?
        puts '- updating az' 
        trans.first.name = 'Vahid Milli Hərəkatı'
        trans.first.permalink = nil
        trans.first.save
      end
=end      
      trans = PoliticalPartyTranslation.where(:locale => 'ru', :name => 'დემოკრატიული მოძრაობა  - "ერთიანი საქართველო"').readonly(false)
      if trans.present?
        puts '- updating ru' 
        trans.first.name = 'Демократическое движение - "Единая Грузия"'
        trans.first.permalink = nil
        trans.first.save
      end
      ###############################
      # მოძრაობა "სამართლიანი საქართველოსთვის"
      puts '###############################'
      puts 'მოძრაობა "სამართლიანი საქართველოსთვის"'
      trans = PoliticalPartyTranslation.where(:locale => 'am', :name => 'მოძრაობა "სამართლიანი საქართველოსთვის"').readonly(false)
      if trans.present?
        puts '- updating am' 
        trans.first.name = '"Արդարացի Վրաստանի համար" շարժում'
        trans.first.permalink = nil
        trans.first.save
      end
        puts '- no az' 
=begin
      trans = PoliticalPartyTranslation.where(:locale => 'az', :name => 'მოძრაობა "სამართლიანი საქართველოსთვის"').readonly(false)
      if trans.present?
        puts '- updating az' 
        trans.first.name = 'Vahid Milli Hərəkatı'
        trans.first.permalink = nil
        trans.first.save
      end
=end      
      trans = PoliticalPartyTranslation.where(:locale => 'ru', :name => 'მოძრაობა "სამართლიანი საქართველოსთვის"').readonly(false)
      if trans.present?
        puts '- updating ru' 
        trans.first.name = 'Движения "Справедливая Грузия"'
        trans.first.permalink = nil
        trans.first.save
      end


  
      ###############################
      ###############################

      # candidate names
      ###############################
      puts '###############################'
      puts 'candidates'
      puts '###############################'

      # გიორგი მარგველაშვილი
      puts '###############################'
      puts 'გიორგი მარგველაშვილი'
      trans = CandidateTranslation.where(:locale => 'am', :name => 'გიორგი მარგველაშვილი').readonly(false)
      if trans.present?
        puts '- updating am' 
        trans.first.name = 'Գիորգի Մարգվելաշվիլի'
        trans.first.save
      end
        puts '- no az' 
=begin      
      trans = CandidateTranslation.where(:locale => 'az', :name => 'გიორგი მარგველაშვილი').readonly(false)
      if trans.present?
        puts '- updating az' 
        trans.first.name = 'Գիորգի Մարգվելաշվիլի '
        trans.first.save
      end
=end      
      trans = CandidateTranslation.where(:locale => 'ru', :name => 'გიორგი მარგველაშვილი').readonly(false)
      if trans.present?
        puts '- updating ru' 
        trans.first.name = 'Георгий Маргвелашвили'
        trans.first.save
      end
      ###############################
      # დავით ბაქრაძე
      puts '###############################'
      puts 'დავით ბაქრაძე'
      trans = CandidateTranslation.where(:locale => 'am', :name => 'დავით ბაქრაძე').readonly(false)
      if trans.present?
        puts '- updating am' 
        trans.first.name = 'Դավիթ Բաքրաձե'
        trans.first.save
      end
        puts '- no az' 
=begin      
      trans = CandidateTranslation.where(:locale => 'az', :name => 'დავით ბაქრაძე').readonly(false)
      if trans.present?
        puts '- updating az' 
        trans.first.name = 'Գիորգի Մարգվելաշվիլի '
        trans.first.save
      end
=end      
      trans = CandidateTranslation.where(:locale => 'ru', :name => 'დავით ბაქრაძე').readonly(false)
      if trans.present?
        puts '- updating ru' 
        trans.first.name = 'Давид Бакрадзе'
        trans.first.save
      end
      ###############################
      # გიორგი თარგამაძე
      puts '###############################'
      puts 'გიორგი თარგამაძე'
      trans = CandidateTranslation.where(:locale => 'am', :name => 'გიორგი თარგამაძე').readonly(false)
      if trans.present?
        puts '- updating am' 
        trans.first.name = 'Գիորգի Թարգամաձե'
        trans.first.save
      end
        puts '- no az' 
=begin      
      trans = CandidateTranslation.where(:locale => 'az', :name => 'გიორგი თარგამაძე').readonly(false)
      if trans.present?
        puts '- updating az' 
        trans.first.name = 'Գիորգի Մարգվելաշվիլի '
        trans.first.save
      end
=end      
      trans = CandidateTranslation.where(:locale => 'ru', :name => 'გიორგი თარგამაძე').readonly(false)
      if trans.present?
        puts '- updating ru' 
        trans.first.name = 'Георгий Таргамадзе'
        trans.first.save
      end
      ###############################
      # ნინო ბურჯანაძე
      puts '###############################'
      puts 'ნინო ბურჯანაძე'
      trans = CandidateTranslation.where(:locale => 'am', :name => 'ნინო ბურჯანაძე').readonly(false)
      if trans.present?
        puts '- updating am' 
        trans.first.name = 'Նինո Բուրջանաձե'
        trans.first.save
      end
        puts '- no az' 
=begin      
      trans = CandidateTranslation.where(:locale => 'az', :name => 'ნინო ბურჯანაძე').readonly(false)
      if trans.present?
        puts '- updating az' 
        trans.first.name = 'Գիորգի Մարգվելաշվիլի '
        trans.first.save
      end
=end      
      trans = CandidateTranslation.where(:locale => 'ru', :name => 'ნინო ბურჯანაძე').readonly(false)
      if trans.present?
        puts '- updating ru' 
        trans.first.name = 'Нино Бурджанадзе'
        trans.first.save
      end
      ###############################
      # სერგო ჯავახიძე
      puts '###############################'
      puts 'სერგო ჯავახიძე'
      trans = CandidateTranslation.where(:locale => 'am', :name => 'სერგო ჯავახიძე').readonly(false)
      if trans.present?
        puts '- updating am' 
        trans.first.name = 'Սերգո Ջավախաձե'
        trans.first.save
      end
        puts '- no az' 
=begin      
      trans = CandidateTranslation.where(:locale => 'az', :name => 'სერგო ჯავახიძე').readonly(false)
      if trans.present?
        puts '- updating az' 
        trans.first.name = 'Գիորգի Մարգվելաշվիլի '
        trans.first.save
      end
=end      
      trans = CandidateTranslation.where(:locale => 'ru', :name => 'სერგო ჯავახიძე').readonly(false)
      if trans.present?
        puts '- updating ru' 
        trans.first.name = 'Серго Джавахидзе'
        trans.first.save
      end
  
  
  
  
    end
  end

  def down
    party_names = ['ერთიანი ნაციონალური მოძრაობა', 'კოალიცია "ქართული ოცნება"', 'ქრისტიან-დემოკრატიული მოძრაობა', 'საქართველოს ეროვნულ-დემოკრატიული პარტია', 'ახალი მემარჯვენეები', 'ლეიბორისტული პარტია', 'დემოკრატიული მოძრაობა - "ერთიანი საქართველო"', 'მოძრაობა "სამართლიანი საქართველოსთვის"']
    candidate_names = ['გიორგი მარგველაშვილი', 'დავით ბაქრაძე', 'გიორგი თარგამაძე', 'ნინო ბურჯანაძე', 'სერგო ჯავახიძე']
    locales = ['am', 'az', 'ru']
    
    PoliticalParty.transaction do
      party_names.each do |name|
        ka = PoliticalPartyTranslation.where(:locale => 'ka', :name => name)
        if ka.present?
          PoliticalPartyTranslation.where(:locale => locales, :political_party_id => ka.first.political_party_id).update_all(:name => name)
        end
      end

      candidate_names.each do |name|
        ka = CandidateTranslation.where(:locale => 'ka', :name => name)
        if ka.present?
          CandidateTranslation.where(:locale => locales, :candidate_id => ka.first.candidate_id).update_all(:name => name)
        end
      end
    end  
  end
end
