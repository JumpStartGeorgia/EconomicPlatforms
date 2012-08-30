EconomicPlatforms::Application.routes.draw do
	#--------------------------------
	# all resources should be within the scope block below
	#--------------------------------
	scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do

		devise_for :users

		namespace :admin do
			resources :users
		end

    resources :indicator_categories
    resources :indicators
    resources :economic_categories
	  resources :platforms
		resources :policy_brief_scores
		resources :policy_briefs
    resources :political_parties
    resources :statement_scores
    resources :statements

		# party profile
		match '/party/:political_party_id', :to => 'party#index', :as => :party
		match '/party/:political_party_id/platform', :to => 'party#platform', :as => :party_platform
		match '/party/:political_party_id/policy_brief', :to => 'party#policy_brief', :as => :party_policy_brief
		match '/party/:political_party_id/statement/:id', :to => 'party#statement', :as => :party_statement


		# category profile
		match '/category/:economic_category_id', :to => 'category#index', :as => :category
		match '/category/:economic_category_id/statement/:id', :to => 'category#statement', :as => :category_statement

		# old statements - to be deleted
		match '/statements/political_party/:political_party_id', :to => 'statements#political_party',
			:as => :political_party_statements, :via => :get
		match '/statements/political_party/:political_party_id/:id', :to => 'statements#political_party_show',
			:as => :political_party_statement, :via => :get
		match '/statements/economic_category/:economic_category_id', :to => 'statements#economic_category',
			:as => :economic_category_statements, :via => :get
		match '/statements/economic_category/:economic_category_id/:id', :to => 'statements#economic_category_show',
			:as => :economic_category_statement, :via => :get


		match '/admin', :to => 'admin#index', :as => :admin, :via => :get

		root :to => 'root#index'
	  match "*path", :to => redirect("/#{I18n.default_locale}") # handles /en/fake/path/whatever
	end

	match '', :to => redirect("/#{I18n.default_locale}") # handles /
	match '*path', :to => redirect("/#{I18n.default_locale}/%{path}") # handles /not-a-locale/anything

end
