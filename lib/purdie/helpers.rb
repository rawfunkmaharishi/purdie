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
end
