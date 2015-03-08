require 'vcr'
require 'webmock/cucumber'

require 'purdie/cli'

VCR.configure do |c|
  c.default_cassette_options = { :record => :once }
  c.cassette_library_dir = 'features/support/fixtures/vcr'
  c.hook_into :webmock

  [
    'SOUNDCLOUD_CLIENT_ID',
    'FLICKR_API_KEY',
    'FLICKR_SECRET',
    'VIMEO_BEARER_TOKEN',
    'YOUTUBE_API_KEY'
  ].each do |env_var|
    c.filter_sensitive_data("<#{env_var}>") { ENV[env_var] }
  end
end

VCR.cucumber_tags do |t|
  t.tag '@vcr', use_scenario_name: true
end

class VcrFriendlyMain
  def initialize(argv, stdin, stdout, stderr, kernel)
    @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
  end

  def execute!
    $stdin = @stdin
    $stdout = @stdout
    $stderr = @stderr
    Purdie::CLI.start(@argv)
  end
end

Before('@vcr') do
  Aruba::InProcess.main_class = VcrFriendlyMain
  Aruba.process = Aruba::InProcess
end

After('@vcr') do
  Aruba.process = Aruba::SpawnProcess
  VCR.eject_cassette
  $stdin = STDIN
  $stdout = STDOUT
  $stderr = STDERR
end
