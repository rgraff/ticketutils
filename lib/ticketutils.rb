require 'httparty'

directory = File.expand_path(File.dirname(__FILE__))
require File.join(directory, 'ticketutils', 'base')
require File.join(directory, 'ticketutils', 'error')
require File.join(directory, 'ticketutils', 'seating_chart')
require File.join(directory, 'ticketutils', 'venue')

module Ticketutils
  class << self
    def auth_token
      @@auth_token
    end

    def auth_token=(auth_token)
      @@auth_token = auth_token
    end

    def secret
      @@secret
    end

    def secret=(secret)
      @@secret = secret
    end

    def venues(options = {})
      Venue.find(options)
    end

    def seating_charts(options = {})
      SeatingChart.find(options)
    end
  end
end
