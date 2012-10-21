module ActivitiesHelper

  def char_limit (text, limit)
    t = ''

    words = text.split(' ')
    charcount = 0
    words.each do |word|
      sum = charcount + word.length + 1
      if sum >= limit
        break
      end
      charcount = sum
      t += ' ' + word
    end

    t + '...'
  end

end
