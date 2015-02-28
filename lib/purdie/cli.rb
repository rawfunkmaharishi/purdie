require 'purdie'

module Purdie
  class CLI < Thor
    desc 'version', 'Print purdie version'
    def version
      puts "purdie version #{VERSION}"
    end
    map %w(-v --version) => :version

    desc 'fetch', 'Fetch the data'
    def fetch
      b = Bernard.new
      b.fetch
    end
  end
end
