require 'purdie'

module Purdie
  class Bernard
    attr_reader :config

    def initialize config_file = '~/.purdie'
      @config = YAML.load File.read config_file
    end

    def fetch
      FileUtils.mkdir '_data'
      FileUtils.touch '_data/sounds.yaml'
    end
  end
end
