ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'lib/purdie.rb')

require 'aruba/cucumber'
require 'rspec'

require 'coveralls'
Coveralls.wear_merged!

$fixtures = File.join(File.dirname(__FILE__), 'fixtures/')
