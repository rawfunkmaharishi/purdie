ENV['RACK_ENV'] = 'test'

require 'aruba/cucumber'
require 'aruba/in_process'
require 'rspec'

require 'coveralls'
Coveralls.wear_merged!
