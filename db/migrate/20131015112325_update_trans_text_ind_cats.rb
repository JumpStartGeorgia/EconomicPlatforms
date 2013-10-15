# encoding: UTF-8
class UpdateTransTextIndCats < ActiveRecord::Migration
  def up
    IndicatorCategoryTranslation.transaction do
    
      puts "#################################"
      puts "ფაქტობრივი სიზუსტე"
      IndicatorCategoryTranslation.where(:locale => 'am', :name => 'ფაქტობრივი სიზუსტე').update_all(:name => 'փաստացի ճշտությունը')
      IndicatorCategoryTranslation.where(:locale => 'az', :name => 'ფაქტობრივი სიზუსტე').update_all(:name => 'Faktiki Dəqiqlik')
      IndicatorCategoryTranslation.where(:locale => 'ru', :name => 'ფაქტობრივი სიზუსტე').update_all(:name => 'Фактическая точность')

      puts "#################################"
      puts "შინაგანი თანმიმდევრულობა"
      IndicatorCategoryTranslation.where(:locale => 'am', :name => 'შინაგანი თანმიმდევრულობა').update_all(:name => 'ներքին հետեւողականություն')
      IndicatorCategoryTranslation.where(:locale => 'az', :name => 'შინაგანი თანმიმდევრულობა').update_all(:name => 'Daxili Ardıcıllıq')
      IndicatorCategoryTranslation.where(:locale => 'ru', :name => 'შინაგანი თანმიმდევრულობა').update_all(:name => 'Внутренняя последовательность')

      puts "#################################"
      puts "ეკონომიკური დასაბუთება"
      IndicatorCategoryTranslation.where(:locale => 'am', :name => 'ეკონომიკური დასაბუთება').update_all(:name => 'տնտեսական փաստավորում')
      IndicatorCategoryTranslation.where(:locale => 'az', :name => 'ეკონომიკური დასაბუთება').update_all(:name => 'İqtisadi Təsdiqləmələr')
      IndicatorCategoryTranslation.where(:locale => 'ru', :name => 'ეკონომიკური დასაბუთება').update_all(:name => 'Экономическое обоснование')

      puts "#################################"
      puts "განხორციელებადობა"
      IndicatorCategoryTranslation.where(:locale => 'am', :name => 'განხორციელებადობა').update_all(:name => 'իրականացվելի')
      IndicatorCategoryTranslation.where(:locale => 'az', :name => 'განხორციელებადობა').update_all(:name => 'Həyata Keçiriləbiləcəyi')
      IndicatorCategoryTranslation.where(:locale => 'ru', :name => 'განხორციელებადობა').update_all(:name => 'Осуществимость')

      puts "#################################"
      puts "ადგილი იდეოლოგიურ/პოლიტიკურ რუკაზე"
      IndicatorCategoryTranslation.where(:locale => 'am', :name => 'ადგილი იდეოლოგიურ/პოლიტიკურ რუკაზე').update_all(:name => 'տեղը գաղափարական/քաղաքական քարտեզի վրա')
      IndicatorCategoryTranslation.where(:locale => 'az', :name => 'ადგილი იდეოლოგიურ/პოლიტიკურ რუკაზე').update_all(:name => 'İdeoloji/Siyasi Xəritədəki Yeri')
      IndicatorCategoryTranslation.where(:locale => 'ru', :name => 'ადგილი იდეოლოგიურ/პოლიტიკურ რუკაზე').update_all(:name => 'Место на идеологической/политической карте')

      puts "#################################"
      puts "იდეოლოგიური ფოკუსი"
      IndicatorCategoryTranslation.where(:locale => 'am', :name => 'იდეოლოგიური ფოკუსი').update_all(:name => 'գաղափարական ֆոկուսը')
      IndicatorCategoryTranslation.where(:locale => 'az', :name => 'იდეოლოგიური ფოკუსი').update_all(:name => 'İdeoloji Fokusu')
      IndicatorCategoryTranslation.where(:locale => 'ru', :name => 'იდეოლოგიური ფოკუსი').update_all(:name => 'Идеологический фокус')
    
    end
  end

  def down
    ind_cats = ['ფაქტობრივი სიზუსტე', 'შინაგანი თანმიმდევრულობა', 'ეკონომიკური დასაბუთება', 'განხორციელებადობა', 'ადგილი იდეოლოგიურ/პოლიტიკურ რუკაზე', 'იდეოლოგიური ფოკუსი']
    locales = ['am', 'az', 'ru']
    
    IndicatorCategoryTranslation.transaction do
      ind_cats.each do |name|
        ka = IndicatorCategoryTranslation.where(:locale => 'ka', :name => name)
        if ka.present?
          IndicatorCategoryTranslation.where(:locale => locales, :indicator_category_id => ka.first.indicator_category_id).update_all(:name => name)
        end
      end
    end  
  end
end
