Paperclip.interpolates('platform_id') do |attachment, style|
  attachment.instance.platform_id
end

Paperclip.interpolates('page_id') do |attachment, style|
  attachment.instance.page_id
end

Paperclip.interpolates('activity_id') do |attachment, style|
  attachment.instance.activity_id
end


Paperclip.interpolates('election_id') do |attachment, style|
  attachment.instance.election_translation.election_id
end

Paperclip.interpolates('locale') do |attachment, style|
  attachment.instance.election_translation.locale
end
