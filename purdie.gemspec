# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'purdie/version'

Gem::Specification.new do |spec|
  spec.name          = 'purdie'
  spec.version       = Purdie::VERSION
  spec.authors       = ['pikesley']
  spec.email         = ['github@orgraphone.org']
  spec.summary       = %q{Capture metadata from Flickr, SoundCloud et al for when we're building a static site}
  spec.description   = %q{Capture metadata from Flickr, SoundCloud et al for when we're building a static site}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'thor', '~> 0.19'
  spec.add_dependency 'httparty', '~> 0.13'
  spec.add_dependency 'deep_merge', '~> 1.0'
  spec.add_dependency 'dotenv', '~> 1.0'
  spec.add_dependency 'flickraw-cached', '= 20120701'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'google-api-client'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'aruba', '~> 0.5'
  spec.add_development_dependency 'guard', '~> 2.12'
  spec.add_development_dependency 'guard-rspec', '~> 4.5'
  spec.add_development_dependency 'guard-cucumber', '~> 1.5'
  spec.add_development_dependency 'terminal-notifier-guard', '~> 1.6'
  spec.add_development_dependency 'coveralls', '~> 0.7'
  spec.add_development_dependency 'webmock', '~> 1.20'
  spec.add_development_dependency 'vcr', '~> 2.9'
  spec.add_development_dependency 'timecop', '~> 0.7'
end
