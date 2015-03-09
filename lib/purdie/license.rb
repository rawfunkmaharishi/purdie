module Purdie
  class License
    LOOKUPS = {
      'BY' => 'Attribution',
      'NC' => 'NonCommercial',
      'SA' => 'ShareAlike'
    }

    def initialize seed = nil
      @values = defaults

      if seed
        parts = seed.split '-'
        case parts.first.length
          when 2
            generate parts
        end
      end
    end

    def defaults
      {
        type: 'Creative Commons',
        url: 'http://creativecommons.org/licenses/by-nc-sa/4.0/',
        short_name: 'BY-NC-SA',
        full_name: 'Attribution-NonCommercial-ShareAlike'
      }
    end

    def generate parts
      @values[:full_name] = parts.map { |part| LOOKUPS[part] }.join '-'
    end

    def [] key
      @values[key]
    end
  end
end
