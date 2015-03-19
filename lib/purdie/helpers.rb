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

  def Purdie.create_outpath original_path, infiltrator
    path = File.dirname original_path
    leaf = File.basename original_path

    File.join(path, "#{infiltrator}.#{leaf.split('.')[-1]}")
  end

  def Purdie.add_yaml original
    "#{strip_extension original}.yaml"
  end

  def Purdie.strip_extension original
    original.split('.')[0..-2].join '.'
  end

  def Purdie.debug message
    File.open '../../wtf.log', 'w' do |f|
      f.write message
    end
  end
end
