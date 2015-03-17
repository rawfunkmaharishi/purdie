require 'purdie'

module Purdie
  class CredentialsException < Exception
    attr_reader :service, :message

    def initialize service, message
      @service = service
      @message = message
    end
  end
end
