require 'purdie'

module Purdie
  class CLI < Thor
    desc 'version', 'Print purdie version'
    def version
      puts "purdie version #{VERSION}"
    end
    map %w(-v --version) => :version

    desc 'fetch', 'Fetch the data'
    method_option :source_file,
                  :aliases => '-f',
                  :desc => 'Specify source file to process'
    def fetch
      b = Bernard.new
      b.source_file options[:source_file] if options[:source_file]
      b.fetch
    end
  end
end
