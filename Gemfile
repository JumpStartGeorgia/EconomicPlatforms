source 'https://rubygems.org'

gem 'bundler'
gem "rails", "3.2.22.2"
gem "mysql2", "~> 0.3.18" # this gem works better with utf-8

gem "json"
gem "jquery-rails", "3.1.2"
gem "devise", "2.0.4" # user authentication
gem "cancan", "~> 1.6.8" # user authorization
gem "formtastic", "2.1.1" # create forms easier
gem "formtastic-bootstrap", :git => "https://github.com/cgunther/formtastic-bootstrap.git", :branch => "bootstrap-2"
gem "nested_form", "~> 0.3.2", :git => "https://github.com/davidray/nested_form.git" # easily build nested model forms with ajax links
##############################
## HACK!!!!!
## - checkout the readme to learn how the globalize3 gem was hacked
##############################
gem "globalize3", "0.2.0" # internationalization
gem "psych", "2.0.13" # yaml parser - default psych in rails has issues
gem "will_paginate", "3.0.3" # add paging to long lists
gem "gon", "5.2.3" # push data into js
gem "dynamic_form", "1.1.4" # to see form error messages
gem "i18n-js", "~> 2.1.2" # to show translations in javascript
gem "paperclip", "~> 3.4.0" # to upload files
gem "has_permalink", "~> 0.1.4" # create permalink slugs for nice urls
gem "capistrano", "~> 2.12.0" # to deploy to server
gem "exception_notification", "2.5.2" # send an email when exception occurs
gem "paper_trail", "~> 2.6.3" # keep audit log of all transactions
gem "pdfkit", "~> 0.5.2" # generate pdfs
gem "useragent", :git => "https://github.com/jilion/useragent.git" # browser detection
# gem "use_tinymce", "~> 0.0.15" # wysiwyg
gem 'tinymce-rails', "~> 4.1.6" #tinymce editor
gem "rails_autolink", "~> 1.0.9" # convert string to link if it is url
gem 'acts_as_commentable', '2.0.1' #comments
gem "unidecoder", "~> 1.1.2" #convert utf8 to ascii for permalinks
gem 'rack-utf8_sanitizer', '~> 1.2.2' # prevent invalid encoding error

# Gems used only for assets and not required
# in production environments by default.
group :assets do
	gem "sass-rails", "3.2.6"
	gem "coffee-rails", "~> 3.2.2"
	gem "uglifier", ">= 1.0.3"
	gem 'therubyracer', '~> 0.11.4'
	gem 'less-rails', "~> 2.6.0"
	gem "twitter-bootstrap-rails", "~> 2.2.8"
	gem 'jquery-ui-rails', '~> 5.0', '>= 5.0.5'
end

group :development do
	# gem "mailcatcher", "0.5.5" # small smtp server for dev, http://mailcatcher.me/
#	gem "wkhtmltopdf-binary", "~> 0.9.5.3" # web kit that takes html and converts to pdf
  gem 'yaml2csv'
end

group :staging, :production do
	gem "unicorn", "4.8.3" # http server
end
