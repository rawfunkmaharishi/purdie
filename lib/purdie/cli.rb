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
    method_option :outfiles_from_infiles,
                  :aliases => '-o',
                  :desc => 'Create output filenames from input filenames'
    def fetch
      b = Bernard.new
      b.source_file = options[:source_file] if options[:source_file]
      b.outfiles_from_infiles = true if options[:outfiles_from_infiles]

      begin
        b.fetch
      rescue Exception => e
        $stderr.puts "\n"
        $stderr.puts e.message
      #  exit 1
      end
    end

    default_task :fetch
  end
end
