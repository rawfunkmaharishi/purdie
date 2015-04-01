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
    FileUtils.mkdir_p File.join(File.dirname(__FILE__), '..', '_sources')
  end

  config.after :each do
    FileUtils.rm File.join(File.dirname(__FILE__), '..', '_config/purdie.yaml')
    FileUtils.rm_rf File.join(File.dirname(__FILE__), '..', '_sources')
  end
end

$keys = [
  'FLICKR_API_KEY',
  'FLICKR_SECRET',
  'SOUNDCLOUD_CLIENT_ID',
  'VIMEO_BEARER_TOKEN',
  'YOUTUBE_API_KEY',
]

$envs = {} unless $envs

def unset_env
  $envs = {}
  $keys.each do |k|
    $envs[k] = ENV[k]
    ENV[k] = nil
  end
end

def randomise_env
  $envs = {}
  $keys.each do |k|
    $envs[k] = ENV[k]
    ENV[k] = Random.rand(10000000).to_s(16)
  end
end

def reset_env
  $keys.each do |k|
    ENV[k] = $envs[k]
  end
end
