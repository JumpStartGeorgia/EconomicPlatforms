class ApplicationController < ActionController::Base
  protect_from_forgery

	before_filter :set_locale
	before_filter :initialize_gon
	before_filter :set_political_parties
	before_filter :set_economic_categories

	unless Rails.application.config.consider_all_requests_local
		rescue_from Exception,
		            :with => :render_error
		rescue_from ActiveRecord::RecordNotFound,
		            :with => :render_not_found
		rescue_from ActionController::RoutingError,
		            :with => :render_not_found
		rescue_from ActionController::UnknownController,
		            :with => :render_not_found
		rescue_from ActionController::UnknownAction,
		            :with => :render_not_found

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, :alert => exception.message
    end
	end


	def set_locale
    if params[:locale] and I18n.available_locales.include?(params[:locale].to_sym)
      I18n.locale = params[:locale]
    else
      I18n.locale = I18n.default_locale
    end
	end

  def default_url_options(options={})
    { :locale => I18n.locale }
  end

	def initialize_gon
		gon.set = true
	end

	# after user logs in, go to admin page
	def after_sign_in_path_for(resource)
		admin_path
	end

  def set_political_parties
    @political_parties_nav = PoliticalParty.with_translations(I18n.locale)
  end

  def set_economic_categories
    @economic_categories_nav = EconomicCategory.with_translations(I18n.locale)
  end

  def valid_role?(role)
    redirect_to root_path, :notice => t('app.msgs.not_authorized') if !current_user || !current_user.role?(role)
  end

	def get_stylesheet
		if Rails.env.production?
			"#{Rails.root}/public/assets/application.css"
		else
			"#{Rails.root}/app/assets/stylesheets/application.css"
		end
	end

	def clean_string(s)
	  s.gsub(/[^0-9A-Za-z ]/,'').split.join('_')
	end

  #######################
	def render_not_found(exception)
		ExceptionNotifier::Notifier
		  .exception_notification(request.env, exception)
		  .deliver
		render :file => "#{Rails.root}/public/404.html", :status => 404
	end

	def render_error(exception)
		ExceptionNotifier::Notifier
		  .exception_notification(request.env, exception)
		  .deliver
		render :file => "#{Rails.root}/public/500.html", :status => 500
	end


end
