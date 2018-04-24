lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'spree_social_products/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_social_products'
  s.version     = SpreeSocialProducts.version
  s.summary     = 'Adds social network sharing to product pages'
  s.required_ruby_version = '>= 2.2.0'

  s.author    = 'John Dyer'
  s.email     = 'jdyer@spreecommerce.com'
  s.homepage  = 'http://www.spreecommerce.com'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  spree_version = '>= 3.2.0', '< 4.0.0'
  s.add_dependency 'spree_core', spree_version

  s.add_development_dependency 'capybara', '~> 2.18.0'
  s.add_development_dependency 'coffee-rails', '~> 4.2.2'
  s.add_development_dependency 'database_cleaner', '~> 1.6.2'
  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'poltergeist', '~> 1.17.0'
  s.add_development_dependency 'selenium-webdriver', '~> 3.11.0'
  s.add_development_dependency 'rspec-rails', '~> 3.5', '>= 3.5.2'
  s.add_development_dependency 'sass-rails', '~> 5.0.7'
  s.add_development_dependency 'sqlite3', '~> 1.3.13'
  s.add_development_dependency 'simplecov', '~> 0.16.1'
  s.add_development_dependency 'pry-rails', '~> 0.3.6'
  s.add_development_dependency 'rubocop', '~> 0.55.0'
  s.add_development_dependency "appraisal"
end
