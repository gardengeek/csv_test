source 'http://rubygems.org'

gem 'rails', '3.0.7'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'sqlite3'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

# Currently using plugins for authlogic and cucumber-rails due to migration pain
#gem "authlogic"

group :development, :test do
  gem 'sqlite3'
  gem "rspec-rails"
  gem "cucumber"
end

group :test do
  gem "factory_girl"
  gem "cucumber-rails"
  gem "capybara"
  gem "database_cleaner"
  gem "launchy"
  gem "webrat"
  gem "rcov"
  gem "ruby-debug"
  gem "shoulda"
  gem "autotest-rails"
  #gem "autotest-fsevent"
end

gem "clearance"
gem "cancan"
gem "bartt-ssl_requirement", :require => "ssl_requirement"
