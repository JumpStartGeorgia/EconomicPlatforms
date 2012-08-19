EconomicPlatforms::Application.routes.draw do

	#--------------------------------	
	# all resources should be within the scope block below
	#--------------------------------	
	scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do

		devise_for :users

		root :to => 'root#index'
	  match "*path", :to => redirect("/#{I18n.default_locale}") # handles /en/fake/path/whatever
	end

	match '', :to => redirect("/#{I18n.default_locale}") # handles /
	match '*path', :to => redirect("/#{I18n.default_locale}/%{path}") # handles /not-a-locale/anything

end
