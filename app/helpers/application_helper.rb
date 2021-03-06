module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def election_sub_title(page_title)
    content_for(:election_sub_title) { page_title }
  end

  def sub_title(page_title)
		if page_title
			content_for(:sub_title) { page_title }
		end
  end

  def title_image(image_url)
    content_for(:title_image) { image_url }
  end

	def page_title
	  title = ""

		title << "#{content_for(:title)}" if content_for?(:title)
		title << " > #{content_for(:sub_title)}" if content_for?(:sub_title) && title.present?
		title << " > #{content_for(:election_sub_title)}" if content_for?(:election_sub_title) && title.present?
		title << " | " if title.present?
		title << t('app.common.app_name')
	end

	def flash_translation(level)
    case level
    when :notice then "alert-info"
    when :success then "alert-success"
    when :error then "alert-error"
    when :alert then "alert-error"
    end
  end

	# make sure the scores are in the correct order
	def order_scores(scores)
		if scores && !scores.empty?
			new_order = []
			cats = IndicatorCategory.sorted
			cats.each do |cat|
				score = scores.select{|x| x.indicator_category_id == cat.id}
				if score && !score.empty?
					new_order << score.first
				end
			end
			return new_order if !new_order.empty?
		end
	end

  def get_current_url
		"#{request.protocol}#{request.host_with_port}#{request.fullpath}"
  end
  
	def full_url(path)
		"#{request.protocol}#{request.host_with_port}#{path}"
	end
  
	def current_url(new_params)
		url_for :params => params.merge(new_params)
	end

	# from http://www.kensodev.com/2012/03/06/better-simple_format-for-rails-3-x-projects/
	# same as simple_format except it does not wrap all text in p tags
	def simple_format_no_tags(text, html_options = {}, options = {})
		text = '' if text.nil?
		text = smart_truncate(text, options[:truncate]) if options[:truncate].present?
		text = sanitize(text) unless options[:sanitize] == false
		text = text.to_str
		text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n
#		text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline   -> br
		text.html_safe
	end

	# put the default locale first and then sort the remaining locales
	def create_sorted_translation_objects(trans)
	  if trans.present?
      # sort
      trans.sort!{|x,y| x.locale <=> y.locale}

      # move default locale to first position
      default = trans.index{|x| x.locale == I18n.default_locale.to_s}
      if default.present? && default > 0
        trans.unshift(trans[default])
        trans.delete_at(default+1)
      end
	  end
    return trans
	end
	
	# build the language switcher links so default language is first and the rest are alphabetical
  def build_language_switcher_links
    html = ''
    locales = I18n.available_locales.clone
    # pull out default locale
    default = locales.select{|x| x == I18n.default_locale}.first
    locales.delete(default) if default.present?
    # now sort the left over
    locales.sort!{|x,y| y.to_s <=> x.to_s}
    # add default back in
    locales << default if default.present?
    
	  locales.each do |locale|
		  if locale != I18n.locale
		    html << "<li>"
		    html << generate_language_switcher_link(locale)
		    html << "</li>"
		  end
	  end
	  
    return html.html_safe
  end

	# since the url contains english or georgian text, the text must be updated to the correct language
	# for the language switcher link to work
	def generate_language_switcher_link(locale)
		party = nil
		ec = nil

		if @political_party
			party = PoliticalPartyTranslation.where(:locale => locale, :political_party_id => @political_party.id)
		end

		if @economic_category
			ec = EconomicCategoryTranslation.where(:locale => locale, :economic_category_id => @economic_category.id)
		end

		if party && !party.empty? && ec && !ec.empty?
			link_to t("app.language.#{locale}"), params.merge(:locale => locale,
						:political_party_id => party.first.permalink,
						:economic_category_id => ec.first.permalink)
		elsif party && !party.empty?
			link_to t("app.language.#{locale}"), params.merge(:locale => locale,
						:political_party_id => party.first.permalink)
		elsif ec && !ec.empty?
			link_to t("app.language.#{locale}"), params.merge(:locale => locale,
						:economic_category_id => ec.first.permalink)
		else
			link_to t("app.language.#{locale}"), params.merge(:locale => locale)
		end

	end
	
	
	def is_public_page?
	  public = true
	  
	  public = false if !(params[:controller] == 'root' || params[:controller] == 'activities' || params[:controller] == 'party' || params[:controller] == 'category')
	  
	  return public
	end

	# Based on https://gist.github.com/1182136
  class BootstrapLinkRenderer < ::WillPaginate::ActionView::LinkRenderer
    protected

    def html_container(html)
      tag :div, tag(:ul, html), container_attributes
    end

    def page_number(page)
      tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
    end

    def gap
      tag :li, link(super, '#'), :class => 'disabled'
    end

    def previous_or_next_page(page, text, classname)
      tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
    end
  end

  def page_navigation_links(pages)
    will_paginate(pages, :class => 'pagination', :inner_window => 2, :outer_window => 0, :renderer => BootstrapLinkRenderer, :previous_label => '&larr;'.html_safe, :next_label => '&rarr;'.html_safe)
  end
end
