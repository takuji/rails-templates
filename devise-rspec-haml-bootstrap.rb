gem 'devise'
gem 'bootstrap-sass'
gem 'haml-rails'
gem 'kaminari'

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
end

gem_group :production do
  gem 'unicorn'  
end
