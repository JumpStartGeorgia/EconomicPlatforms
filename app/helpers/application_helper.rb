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

end
