module Ticketutils
  class Error < StandardError
    attr_accessor :code, :message, :status

    def self.parse(response)
      new(response["Status"], response["Errors"].first["ErrorCode"], response["Errors"].first["ErrorDescription"])
    end

    private
    def initialize(status, code, message)
      @status = status
      @code = code
      @message = message
    end
  end
end