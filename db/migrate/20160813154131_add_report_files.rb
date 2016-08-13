class AddReportFiles < ActiveRecord::Migration
  def up
  	path = "#{Rails.root}/db/reports/"
  	#2012
  	locales = ['ka', 'en']
  	locales.each do |locale|
  		puts "year = 2012 / locale = #{locale}"
			trans = ElectionTranslation.where('name like "%2012%" and locale = ?', locale)
			if trans.present?
				trans.each do |et|
					if et.report_file.nil?
						et.build_report_file(file: File.open(path + "2012/Report_#{locale}.pdf"))
						et.save
					end
				end
			end
		end

  	#2014
  	locales = ['am', 'az', 'ru']
  	locales.each do |locale|
  		puts "year = 2014 / locale = #{locale}"
			trans = ElectionTranslation.where('name like "%2014%" and locale = ?', locale)
			if trans.present?
				trans.each do |et|
					if et.report_file.nil?
						et.build_report_file(file: File.open(path + "2014/Report_#{locale}.pdf"))
						et.save
					end
				end
			end
		end
  end

  def down
  	ReportFile.destroy_all
  end
end
