source :rubygems

group :default do
  gem 'rails',          '>= 3.1'
  gem 'sugar-high',     '>= 0.6.1'
  gem 'sweetloader',    '~> 0.1.6'
  gem 'hashie',         '~> 1.2'

  gem 'cantango-permits',  '>= 0.1.1'
end

group :development do
  gem "bundler",  ">= 1.1.rc"
  gem "jeweler",  ">= 1.6.4"
  gem "rcov",     ">= 0"
end

group :test do
  gem 'require_all', '~> 1.2.0'

  gem 'forgery'
  gem 'sqlite3'
  # Data
  gem 'database_cleaner'
  gem 'factory_girl'

  # Specs
  gem 'spork'

  # Debug and performance tests
  gem 'cutter'
  
  # Adapters
  gem 'sourcify'
  gem 'dkastner-moneta',  '>= 1.0'
end

group :test, :development do
  gem "rspec",    ">= 2.6.0"
end
