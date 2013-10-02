class CreateRecordsNewLocales < ActiveRecord::Migration
  def up
    locales = ['am', 'az', 'ru']
    default = I18n.default_locale.to_s
    
    ActivityTranslation.transaction do
      ActivityTranslation.where(:locale => default).each do |trans|
        am = trans.dup
        am.locale = 'am'
        am.save
        
        az = trans.dup
        az.locale = 'az'
        az.save
        
        ru = trans.dup
        ru.locale = 'ru'
        ru.save
      end
      
      EconomicCategoryTranslation.where(:locale => default).each do |trans|
        am = trans.dup
        am.locale = 'am'
        am.save
        
        az = trans.dup
        az.locale = 'az'
        az.save
        
        ru = trans.dup
        ru.locale = 'ru'
        ru.save
      end
      
      ElectionTranslation.where(:locale => default).each do |trans|
        am = trans.dup
        am.locale = 'am'
        am.save
        
        az = trans.dup
        az.locale = 'az'
        az.save
        
        ru = trans.dup
        ru.locale = 'ru'
        ru.save
      end
      
      IndicatorTranslation.where(:locale => default).each do |trans|
        am = trans.dup
        am.locale = 'am'
        am.save
        
        az = trans.dup
        az.locale = 'az'
        az.save
        
        ru = trans.dup
        ru.locale = 'ru'
        ru.save
      end
      
      IndicatorCategoryTranslation.where(:locale => default).each do |trans|
        am = trans.dup
        am.locale = 'am'
        am.save
        
        az = trans.dup
        az.locale = 'az'
        az.save
        
        ru = trans.dup
        ru.locale = 'ru'
        ru.save
      end
      
      PageTranslation.where(:locale => default).each do |trans|
        am = trans.dup
        am.locale = 'am'
        am.save
        
        az = trans.dup
        az.locale = 'az'
        az.save
        
        ru = trans.dup
        ru.locale = 'ru'
        ru.save
      end
      
      PlatformTranslation.where(:locale => default).each do |trans|
        am = trans.dup
        am.locale = 'am'
        am.save
        
        az = trans.dup
        az.locale = 'az'
        az.save
        
        ru = trans.dup
        ru.locale = 'ru'
        ru.save
      end
      
      PolicyBriefTranslation.where(:locale => default).each do |trans|
        am = trans.dup
        am.locale = 'am'
        am.save
        
        az = trans.dup
        az.locale = 'az'
        az.save
        
        ru = trans.dup
        ru.locale = 'ru'
        ru.save
      end
      
      PoliticalPartyTranslation.where(:locale => default).each do |trans|
        am = trans.dup
        am.locale = 'am'
        am.save
        
        az = trans.dup
        az.locale = 'az'
        az.save
        
        ru = trans.dup
        ru.locale = 'ru'
        ru.save
      end
      
      StatementTranslation.where(:locale => default).each do |trans|
        am = trans.dup
        am.locale = 'am'
        am.save
        
        az = trans.dup
        az.locale = 'az'
        az.save
        
        ru = trans.dup
        ru.locale = 'ru'
        ru.save
      end
    end    
  end

  def down
    locales = ['am', 'az', 'ru']
    ActivityTranslation.transaction do
      ActivityTranslation.where(:locale => locales).delete_all
      
      EconomicCategoryTranslation.where(:locale => locales).delete_all
      
      ElectionTranslation.where(:locale => locales).delete_all
      
      IndicatorTranslation.where(:locale => locales).delete_all

      IndicatorCategoryTranslation.where(:locale => locales).delete_all
      
      PageTranslation.where(:locale => locales).delete_all
      
      PlatformTranslation.where(:locale => locales).delete_all
      
      PolicyBriefTranslation.where(:locale => locales).delete_all
      
      PoliticalPartyTranslation.where(:locale => locales).delete_all
      
      StatementTranslation.where(:locale => locales).delete_all
    end    
  end
end
