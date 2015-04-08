require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'
require 'coveralls/rake/task'

Coveralls::RakeTask.new
RSpec::Core::RakeTask.new

wtf_features = []
Dir.glob('features/*.feature').each do |f|
  if File.readlines(f).grep(/wtf/).any?
    wtf_features.push f.match(/features\/(.*)\.feature/)[1].gsub('-', '_').to_sym
  end
end

namespace :cukes do
  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "features --tags ~@wtf"
  end

  wtf_features.each do |wtf|
    Cucumber::Rake::Task.new(wtf) do |t|
      t.cucumber_opts = "features/#{wtf.to_s.gsub '_', '-'}.feature"
    end
  end
end

task :default => [
  :spec,
  wtf_features.map { |f| "cukes:#{f}"},
  'cukes:features',
  'coveralls:push'
].flatten
