require 'thor'
require 'yaml'
require 'deep_merge'
require 'httparty'
require 'dotenv'
require 'flickraw-cached'
require 'active_support/inflector'

require 'purdie/version'
require 'purdie/bernard'
require 'purdie/config'
require 'purdie/ingester'
require 'purdie/source_list'

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

  def Purdie.basename obj
    obj.class.name.to_s.split('::').last
  end

  def Purdie.wtf message
    File.open '../../wtf.log', 'w' do |f|
      f.write message
    end
  end
end
