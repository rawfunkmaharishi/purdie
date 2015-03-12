require 'thor'
require 'yaml'
require 'deep_merge'
require 'httparty'
require 'dotenv'
require 'cgi'
require 'active_support/inflector'

require 'purdie/version'
require 'purdie/helpers'
require 'purdie/bernard'
require 'purdie/config'
require 'purdie/ingester'
require 'purdie/source_list'
require 'purdie/license_manager'

require 'purdie/services/soundcloud'
require 'purdie/services/flickr'
require 'purdie/services/vimeo'
require 'purdie/services/youtube'

Dotenv.load

class Hash
  def attach_license license
    self['license'] = license['full_name']
    self['license_url'] = license['url']
  end
end
