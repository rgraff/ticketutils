module Ticketutils
  class SeatingChart < Base
    attr_accessor :name, :id, :url, :url_medium, :url_large, :status, :venue_id, :version

    # Ticketutils.seating_charts(options) => returns a will_paginate collection of seating charts
    # options:
    #   page: defaults to 1
    #     First page is 1, 100 results to the page
    #   per_page: defaults to 100
    #     Paginate this many per page. Limit is 100.
    #   updated: defaults to before the sevice was up
    #     Only show venues updated since this date.
    #   venue_id: Only tickets for a specific venue
    def self.find(options = {})
      results = if options[:venue_id]
        to_sign = "/SeatingChart/Charts?VenueId=#{options[:venue_id]}"
      elsif options[:updated]
        to_sign = "/SeatingChart/Charts?UpdatedSince=#{options[:updated].strftime("%Y%m%d%H%M")}&Page=#{options[:page] || 1}"
      else
        params = { :VenueId => options[:venue_id], 
                   :page => options[:page] || 1,
                   :itemsPerPage => options[:per_page] || 100,
                   :updatedSince => options[:updated] }.reject{|k,v| v.nil?}.collect { |k, v| "#{k}=#{v}" }
        to_sign = "/SeatingChart/Charts?#{params.join("&")}"
      end
      results = signed_get(to_sign)
      return parse_response(results)
    end

    protected
    def self.parse_response(response)
      raise Error.parse(response) if response["Status"] == 2
      # return an array of venues
      pagination = response["Pagination"]

      charts = response["Items"].collect do |chart|
        new(
          :id => chart["SeatingChartId"],
          :name => chart["Name"],
          :venue_id => chart["VenueId"],
          :status => chart["Status"],
          :version => chart["Version"],
          :url => chart["Url"],
          :url_medium => chart["Url500px"],
          :url_large => chart["Url2000px"]
        )
      end

      return WillPaginate::Collection.create(
        pagination["CurrentPage"],
        pagination["PerPage"] || 100,
        pagination["TotalResults"]
      ) do |pager|
        pager.replace(charts)
      end
    end

    private
    def initialize(options)
      @id = options[:id]
      @name = options[:name]
      @url = options[:url]
      @venue_id = options[:venue_id]
      @status = options[:status]
      @version = options[:version]
      @url_medium = options[:url_medium]
      @url_large = options[:url_large]
    end

  end
end
