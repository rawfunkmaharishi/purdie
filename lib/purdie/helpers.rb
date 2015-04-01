module Purdie
  def Purdie.strip_scheme url
    url.match(/http[s]?:(.*)/)[1]
  end

  def Purdie.sanitise_url url
    url.strip!
    url = url[0..-2] if url[-1] == '/'
    url
  end

  def Purdie.get_id url
    case url
    when /\?.*v=/
        return CGI.parse(URI.parse(url).query)['v'].first
      else
        sanitised = Purdie.sanitise_url url
        parts = sanitised.split('/')
        parts.reverse.each do |part|
          next if ['in', 'photostream'].include? part
          return part.to_i
        end
    end
  end

  def Purdie.basename obj
    if obj.class == Class
      return obj.name.to_s.split('::').last
    end

    obj.class.name.to_s.split('::').last
  end

  def Purdie.debug message
    File.open '../../wtf.log', 'w' do |f|
      f.write message
    end
  end
end

class Hash
  def attach_license service, license
    l = Purdie::LicenseManager.get service, license
    self['license'] = l['full_name']
    self['license_url'] = l['url']
  end
end
