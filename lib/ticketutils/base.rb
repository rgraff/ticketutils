require "will_paginate"

module Ticketutils
  class Base
    include HTTParty
    base_uri 'api.ticketutils.net'
    headers 'Content-Type' => 'application/json'

    def self.d256(string)
      digester = OpenSSL::Digest::Digest.new('sha256')
      digested = OpenSSL::HMAC.digest(digester, Ticketutils.secret, string)
      Base64.encode64(digested).chomp
    end

    def self.signed_get(string)
      Rails.logger.info ['Ticketutils: ', string].join if defined?(Rails)
      get(string, :headers => { 'X-Token' => Ticketutils.auth_token, 'X-Signature' => d256(string) })
    end
  end
end
