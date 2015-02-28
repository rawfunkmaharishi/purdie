ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'lib/purdie.rb')

require 'capybara'
require 'capybara/cucumber'
require 'aruba/cucumber'
require 'rspec'

require 'coveralls'
Coveralls.wear_merged!

Capybara.app = Purdie

class PurdieWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  PurdieWorld.new
end
