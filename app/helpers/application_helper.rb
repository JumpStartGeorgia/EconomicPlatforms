module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
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
			cats = IndicatorCategory.all
			cats.each do |cat|
				score = scores.select{|x| x.indicator_category_id == cat.id}
				if score && !score.empty?
					new_order << score.first
				end
			end
			return new_order if !new_order.empty?
		end
	end

	def current_url(new_params)
		url_for :params => params.merge(new_params)
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
