

module ActivitiesHelper

  def char_limit (text, limit)
    t = ''
    if text.blank?
      return t
    end

    words = strip_tags(text).split(' ')
    charcount = 0
    words.each do |word|
      sum = charcount + word.length + 1
      if sum >= limit
        break
      end
      charcount = sum
      t += ' ' + word
    end

    (t + '...').html_safe
  end


  def video_frame_tag(url, width, height)
    #require 'rack'
    #require 'uri'
    v = Rack::Utils.parse_query(URI(url).query)['v']

    content_tag(:iframe, "", :width => width, :height => height, :src => "http://www.youtube.com/embed/" + v, :frameborder => 0, :allowfullscreen => "")

   #'<iframe width="' + width.to_s + '" height="' + height.to_s + '" src="http://www.youtube.com/embed/' + v + '" frameborder="0" allowfullscreen=""></iframe>'
  end

end
