source 'http://rubygems.org'

gem 'rails', '3.0.9'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3-ruby','1.3.3', :require => 'sqlite3'

gem 'gravatar_image_tag', '0.1.0'

#including will_paginate - To paginate users - so that (for exanple) only 30 users show up on a page at any one one time. Will_paginate is the simplest and most robust pagination method.
gem 'will_paginate'

#Faker gem allow us to make sample users with semi-realistic names and email addresses.
gem 'faker'

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

#Gems needed: 1) Gem for RSpec; 2) Gem for RSpec library (testing framework)
#This includes rspec-rails in development mode so that we have access to RSpec specific generators, and...

group :development do
	gem 'rspec-rails', '2.0.1'
	gem 'annotate'
	#Faker gem allow us to make sample users with semi-realistic names and email addresses.
	#gem 'faker'
end

#...it includes rspec in test mode in order to run tests...

group :test do
	gem 'rspec', '2.0.1'

#Webrat - testing utility.

	gem 'webrat', '0.7.1'


#Spork loads the environment once, and then maintains a pool of processes for running future tests.
	gem 'spork'

	gem 'factory_girl_rails', '1.0'
end

