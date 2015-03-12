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
    FileUtils.rmdir File.join(File.dirname(__FILE__), '..', '_sources')
  end
end

def unset_env
  e = File.readlines '.env'
  $envs = {}
  e.each do |line|
    next if line =~ /^$/
    v = line.split ':'
    $envs[v[0]] = v[1].strip
    ENV[v[0]] = nil
  end
end

def randomise_env
  e = File.readlines '.env'
  $envs = {}
  e.each do |line|
    next if line =~ /^$/
    v = line.split ':'
    $envs[v[0]] = v[1].strip
    ENV[v[0]] = Random.rand(10000000).to_s(16)
  end
end

def reset_env
  $envs.each_pair do |k, v|
    ENV[k] = v
  end
end
