module Purdie
  class License
    def initialize
      @values = {}
      @values['type'] = 'Creative Commons'
      @values['url'] = 'http://creativecommons.org/licenses/by-nc-sa/4.0/'
      @values['short_name'] = 'BY-NC-SA'
      @values['full_name'] = 'Attribution-NonCommercial-ShareAlike'
    end

    def [] key
      @values[key]
    end
  end
end
