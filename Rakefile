require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'
require 'coveralls/rake/task'

Coveralls::RakeTask.new
RSpec::Core::RakeTask.new
#Cucumber::Rake::Task.new

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --tags ~@broken"
end

task :default => [:spec, :features, 'coveralls:push']
