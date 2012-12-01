gem 'devise'
gem 'bootstrap-sass'
gem 'haml-rails'

gem_group :development, :test do
  gem 'rspec-rails'
end

gem_group :production do
  gem 'unicorn'  
end
