module Ticketutils
  class Venue < Base
    attr_accessor :id, :city, :country, :name, :state, :seating_charts, :status

    def self.find(options = {})
      results = if options[:updated]
        to_sign = "/SeatingChart/Venues?UpdatedSince=#{options[:updated].strftime("%Y%m%d%H%M")}&page=#{options[:page] || 1}"
      else
        options = { :page => options[:page] || 1,
                    :itemsPerPage => options[:per_page] || 100,
                    :updatedSince => options[:updated] }.reject {|k,v| v.nil?}.collect { |k, v| "#{k}=#{v}" }
        to_sign = "/SeatingChart/Venues?#{options.join("&")}"
      end
      results = signed_get(to_sign).parsed_response
      return parse_response(results)
    end

    def seating_charts
      @seating_charts ||= Ticketutils::SeatingChart.find(:venue_id => @id)
    end

    protected
    def self.parse_response(response)
      raise Error.parse(response) if response["Status"] == 2
      pagination = response["Pagination"]

      venues = response["Items"].collect do |venue|
        Ticketutils::Venue.new(
          :id => venue["VenueId"],
          :name => venue["Name"],
          :country => venue["Country"],
          :state => venue["State"],
          :city => venue["City"],
          :status => venue["Status"]
        )
      end

      return WillPaginate::Collection.create(
        pagination["CurrentPage"],
        pagination["PerPage"] || 100,
        pagination["TotalResults"]
      ) do |pager|
        pager.replace(venues)
      end
    end

    private
    def initialize(options)
      @id = options[:id]
      @name = options[:name]
      @country = options[:country]
      @city = options[:city]
      @state = options[:state]
      @status = options[:status]
      @seating_charts = options[:seating_charts]
    end
  end
end
