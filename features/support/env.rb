require 'coveralls'
Coveralls.wear_merged!

ENV['RACK_ENV'] = 'test'

require 'aruba/cucumber'
require 'aruba/in_process'
require 'rspec'

$fixtures = File.join(File.dirname(__FILE__), 'fixtures/')
