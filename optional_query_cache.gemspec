lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'optional_query_cache/version'

Gem::Specification.new do |s|
  s.name                  = 'optional_query_cache'
  s.version               = OptionalQueryCache::VERSION::STRING
  s.required_ruby_version = '>= 2'
  s.license               = 'MIT'

  s.homepage          = 'https://github.com/ministryofjustice'
  s.summary           = 'Disable ActiveRecord::QueryCache for specific routes.'
  s.description       = 'Rails middleware for disabling ' \
                        'ActiveRecord::QueryCache on specific routes.'

  s.authors           = [
    'Ministry of Justice',
    'Steve Marshall'
  ]
  s.email             = 'dev@digital.justice.gov.uk'

  s.files             = %w(Rakefile README.md) + Dir.glob('{lib,spec}/**/*')
  s.require_path      = 'lib'
  s.test_files        = Dir['spec/*_spec.rb']

  s.add_dependency 'activerecord', '~> 4'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec-rails', '~> 3'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov-rcov'
end
