require 'thor'
require 'yaml'
require 'deep_merge'
require 'httparty'
require 'dotenv'
require 'active_support/inflector'

require 'purdie/version'
require 'purdie/bernard'
require 'purdie/config'

require 'purdie/services/soundcloud'
require 'purdie/services/flickr'
require 'purdie/services/vimeo'

module Purdie
  def Purdie.strip_scheme url
    url.match(/http[s]?:\/\/(.*)/)[1]
  end

  def Purdie.sanitise_url url
    url.strip!
    url = url[0..-2] if url[-1] == '/'

    url
  end

  def Purdie.get_id url
    Purdie.sanitise_url(url).split('/')[-1].to_i
  end
end
