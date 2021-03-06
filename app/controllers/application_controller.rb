class ApplicationController < ActionController::Base
	require 'will_paginate/array'
  protect_from_forgery

	before_filter :set_locale
#	before_filter :is_browser_supported?
	before_filter :initialize_gon
	before_filter :set_elections
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

	Browser = Struct.new(:browser, :version)
	SUPPORTED_BROWSERS = [
		Browser.new("Chrome", "15.0"),
		Browser.new("Safari", "4.0.2"),
		Browser.new("Firefox", "10.0.2"),
		Browser.new("Internet Explorer", "9.0"),
		Browser.new("Opera", "11.0")
	]

	def is_browser_supported?
		user_agent = UserAgent.parse(request.user_agent)
logger.debug "////////////////////////// BROWSER = #{user_agent}"
		if SUPPORTED_BROWSERS.any? { |browser| user_agent < browser }
			# browser not supported
logger.debug "////////////////////////// BROWSER NOT SUPPORTED"
			render "layouts/unsupported_browser", :layout => false
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
    {
      :locale => I18n.locale,
      :election_id => @current_election_id
    }
  end

	def initialize_gon
		gon.set = true
		gon.highlight_first_form_field = true
	end

	# after user logs in, go to admin page
	def after_sign_in_path_for(resource)
		admin_path
	end

  def set_elections
    @elections_w_parties = Election.with_political_parties.sorted
    @elections_nav = Election.sorted.with_translations(I18n.locale).with_data

    @current_election = nil
    if user_signed_in?
      @current_election = (params[:election_id].blank? ? @elections_w_parties.first : @elections_w_parties.select{|x| x.id.to_s == params[:election_id]}.first)
    else
      @current_election = (params[:election_id].blank? ? @elections_nav.first : @elections_nav.select{|x| x.id.to_s == params[:election_id]}.first)
    end
    if @current_election.blank?
=begin
      # if getting political parties for election, it is possible election does not have any data yet,
      # so do not redirect if calling this action
      if !(params[:controller] == "elections" && params[:action] == "political_parties") &&
          params[:controller] != "political_parties" && params[:controller] != "candidates" && params[:controller] != "activities"
          params[:controller] != "platforms" && params[:controller] != "policy_briefs" && params[:controller] != "statements"
        redirect_to root_path, notice: t('app.msgs.does_not_exist')
      end
=end
        redirect_to root_path, notice: t('app.msgs.does_not_exist')
    else
      @current_election_id = @current_election.id
    end
  end

  def set_political_parties
   #@political_parties_nav = @current_election.nil? ? nil : @current_election.political_parties.with_translations(I18n.locale)
   #e_id = params[:election_id].present? ? params[:election_id] : @elections_nav.first.id

    @political_parties_nav = PoliticalParty.by_election(@current_election_id).sorted if @current_election_id.present?
#    @political_parties_nav = PoliticalParty.by_election(@current_election_id).with_data.sorted if @current_election_id.present?
  end

  def set_economic_categories
    @economic_categories_nav = EconomicCategory.sorted
  end

  def valid_role?(role)
    redirect_to formatted_root_path, :notice => t('app.msgs.not_authorized') if !current_user || !current_user.role?(role)
  end

	def get_stylesheet
		if Rails.env.production? || Rails.env.staging?
			"#{Rails.root}/public/assets/application.css"
		else
			"#{Rails.root}/app/assets/stylesheets/application.css"
		end
	end

	def clean_string(s)
	  s.gsub(/[^0-9A-Za-z ]/,'').split.join('_')
	end


  # add in required content for translations if none provided
  # - only do this if default locale trans record has data
  def add_missing_translation_content(ary_trans)
    if ary_trans.present?
      default_trans = ary_trans.select{|x| x.locale == I18n.default_locale.to_s}.first
      if default_trans.present? && default_trans.required_data_provided?
        ary_trans.each do |trans|
          if trans.locale != I18n.default_locale.to_s && !trans.required_data_provided?
            # add required content from default locale trans
            trans.add_required_data(default_trans)
          end
        end
      end
    end
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
