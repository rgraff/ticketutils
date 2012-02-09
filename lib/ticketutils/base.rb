require "will_paginate"

module Ticketutils
  class Base
    include HTTParty
    base_uri 'charts.ticketutils.com'
    headers 'Content-Type' => 'application/json'
  end
end