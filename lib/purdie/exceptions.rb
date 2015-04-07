module Purdie
  class CredentialsException < Exception
    attr_reader :service, :message

    def initialize service, message
      @service = service
      @message = message
    end
  end

  class PurdieException < Exception
    attr_reader :message

    def initialize message
      @message = message
    end
  end
end
