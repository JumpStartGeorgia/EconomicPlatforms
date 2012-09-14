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
	  resources :pages
	  resources :platforms
		resources :policy_brief_scores
		resources :policy_briefs
    resources :political_parties
    resources :statement_scores
    resources :statements

		# party profile
		match '/party/:political_party_id', :to => 'party#index', :as => :party
		match '/party/:political_party_id/platform/:economic_category_id', :to => 'party#platform', :as => :party_platform
		match '/party/:political_party_id/policy_brief/:economic_category_id', :to => 'party#policy_brief', :as => :party_policy_brief
		match '/party/:political_party_id/statement/:id', :to => 'party#statement', :as => :party_statement


		# category profile
		match '/category/:economic_category_id', :to => 'category#index', :as => :category
		match '/category/:economic_category_id/platform/:political_party_id', :to => 'category#platform', :as => :category_platform
		match '/category/:economic_category_id/policy_brief/:political_party_id', :to => 'category#policy_brief', :as => :category_policy_brief
		match '/category/:economic_category_id/statement/:id', :to => 'category#statement', :as => :category_statement

    # comments and voting
		match '/add_comment_to/:type/:commentable_id', :to => 'comments#create', :as => :add_comment, :via => :post
		match '/vote/:type/:votable_id/:status', :to => 'comments#vote', :as => :vote, :via => :get


		match '/admin', :to => 'admin#index', :as => :admin, :via => :get
		match '/about', :to => 'root#about', :as => :about, :via => :get
		match '/methodology', :to => 'root#methodology', :as => :methodology, :via => :get

		root :to => 'root#index'
	  match "*path", :to => redirect("/#{I18n.default_locale}") # handles /en/fake/path/whatever
	end

	match '', :to => redirect("/#{I18n.default_locale}") # handles /
	match '*path', :to => redirect("/#{I18n.default_locale}/%{path}") # handles /not-a-locale/anything

end
