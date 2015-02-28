require 'purdie'

module Purdie
  class CLI < Thor
    desc 'version', 'Print purdie version'
    def version
      puts "purdie version #{VERSION}"
    end
    map %w(-v --version) => :version

    desc 'fetch', 'Fetch the data'
    method_option :config,
                 :aliases => '-c',
                 :desc => 'Specify config file'
    def fetch
      b = Bernard.new options[:config]
      b.fetch
    end
  end
end
