require 'singleton'

module Purdie
  class Config
    include Singleton

    def initialize
      reset!
    end

    def reset! # testing a singleton is hard
      @config = OpenStruct.new fetch_yaml 'defaults'

      if File.exists? '_config/purdie.yaml'
        @local = OpenStruct.new YAML.load File.read '_config/purdie.yaml'

        @config = OpenStruct.new (@config.to_h.deep_merge @local)
      end
    end

    def config
      @config
    end

    private

    def fetch_yaml file
      YAML.load(File.open(File.join(File.dirname(__FILE__), '..', '..', '_config/%s.yaml' % file)))
    end
  end
end
