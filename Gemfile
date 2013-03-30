source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'sass-rails', '~> 3.2'
gem 'bootstrap-sass', '~> 2.3.1.0'
gem 'bcrypt-ruby'
gem 'mailboxer'
gem 'haml'
gem 'simple_form'
gem 'delayed_job_active_record'
gem 'hirefire'

group :development, :test do
  gem 'sqlite3', '1.3.5'
  gem 'rspec-rails', '2.11.0'
  gem 'test-unit'
  gem 'faker', '1.0.1'
  gem 'factory_girl_rails'
  gem 'nifty-generators'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
end

gem 'jquery-rails', '2.0.2'
gem 'fancybox-rails'

group :test do
  gem 'capybara', '1.1.2'
end

group :production do
  gem 'pg', '0.12.2'
  gem 'unicorn'
  gem 'rake', '0.8.7'
end

gem "mocha", :group => :test