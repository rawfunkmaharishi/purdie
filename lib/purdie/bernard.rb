require 'purdie'

module Purdie
  class Bernard
    def fetch
      FileUtils.mkdir '_data'
      FileUtils.touch '_data/sounds.yaml'
    end
  end
end
