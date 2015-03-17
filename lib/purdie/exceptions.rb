require 'purdie'

module Purdie
  class CredentialsException < Exception
    attr_reader :message

    def initialize message
      @message = message
    end
  end
end
