$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spina/jobs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spina-jobs"
  s.version     = Spina::Jobs::VERSION
  s.authors     = ["Tom Simnett"]
  s.email       = ["tom@initforthe.com"]
  s.homepage    = "https://github.com/initforthe/spina-jobs"
  s.summary     = "Job posting manager for Spina CMS"
  s.description = "Post jobs and accept applications for them within Spina CMS"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_runtime_dependency 'spina', '>= 0.11.1'
  s.add_runtime_dependency 'friendly_id', '~> 5.2', '>= 5.2.1'
  s.add_runtime_dependency 'draper', '~> 3.0', '>= 3.0.0'
  s.add_runtime_dependency 'tel_link_rails', '~> 0.0.2'

  s.add_development_dependency 'pg', '~> 0.20'
  s.add_development_dependency 'simplecov', '~> 0'
  s.add_development_dependency 'rspec-rails', '~> 3.6.0', '>= 3.6.0'
  s.add_development_dependency 'factory_bot_rails', '~> 4.0'
  s.add_development_dependency 'pry-rails', '~> 0'
  s.add_development_dependency 'rails-controller-testing', '~> 1.0.2', '>= 1.0.2'
  s.add_development_dependency 'capybara', '~> 2.14.3', '>= 2.14.3'
end
