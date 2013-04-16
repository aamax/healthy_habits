source 'https://rubygems.org'
gem 'rails', '3.2.12'
gem 'pg'
gem 'activerecord-postgres-hstore', github: 'engageis/activerecord-postgres-hstore'
gem 'ng-rails-csrf', :git => "git://github.com/xrd/ng-rails-csrf.git" #helps rails csrf with angular

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem "twitter-bootstrap-rails", ">= 2.2.4"
  gem 'angular-rails'
end
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem "therubyracer"
gem "less-rails"


group :production do
  gem "unicorn", ">= 4.3.1"
end

group :test, :development do
  gem "rspec-rails", ">= 2.12.2"
  gem "factory_girl_rails", ">= 4.2.0"
  gem "pry"
end

group :test do
  gem "database_cleaner", ">= 1.0.0.RC1"
  gem "email_spec", ">= 1.4.0"
  gem "launchy", ">= 2.2.0"
  gem "capybara", ">= 2.0.3"
end

group :development do
  gem "quiet_assets", ">= 1.0.2"
  gem "better_errors", ">= 0.7.2"
  gem "annotate"
end

#gem "bootstrap-sass", ">= 2.3.0.0"
gem "devise", ">= 2.2.3"
gem "cancan", ">= 1.6.9"
gem "rolify", ">= 3.2.0"
gem "simple_form", ">= 2.1.0"
gem "figaro", ">= 0.6.3"
gem 'tinymce-rails', :git => 'git://github.com/spohlenz/tinymce-rails.git'
gem "paperclip", "~> 3.0"
gem 'aws-sdk'
gem 'mailchimp-gem'