source "https://rubygems.org"

ruby '2.6.2'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
gem 'thin'
gem 'bcrypt'
gem 'shotgun'
gem 'rack-flash3'

group :test do
  gem 'database_cleaner', '~> 1.7'
  gem 'tux'
end

group :production do
  gem 'pg'
end
