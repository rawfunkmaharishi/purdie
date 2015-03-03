require 'purdie'
require_relative 'support/vcr_setup'
require 'timecop'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.order = :random

  config.before :each do
    FileUtils.cp File.join(File.dirname(__FILE__), '..', 'features/support/fixtures/_config/purdie.yaml'),
      File.join(File.dirname(__FILE__), '..', '_config/purdie.yaml')
  end

  config.after :each do
    FileUtils.rm File.join(File.dirname(__FILE__), '..', '_config/purdie.yaml')
  end
end
