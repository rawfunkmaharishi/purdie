require 'thor'
require 'yaml'
require 'deep_merge'
require 'httparty'
require 'dotenv'

require 'purdie/version'
require 'purdie/bernard'
require 'purdie/config'

require 'purdie/services/soundcloud'
require 'purdie/services/flickr'

module Purdie
  def Purdie.strip_scheme url
    url.match(/http[s]?:\/\/(.*)/)[1]
  end
end
