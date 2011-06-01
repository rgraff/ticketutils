require 'spec_helper'

describe Ticketutils::SeatingChart do
  context ".find" do  
    context "with no options" do
      let(:seating_charts) { Ticketutils.seating_charts }

      use_vcr_cassette "seating_charts/find", :erb => { :auth_token => Ticketutils.auth_token }

      it "returns an exception" do
        begin
          seating_charts
        rescue Exception => e
          e.message.should == "No Filters Specified in the Request"
          e.class.should == Ticketutils::Error
        end
      end
    end

    context "updated in the last day" do
      let(:date) { Date.parse("May 18, 2011") }
      let(:seating_charts) { Ticketutils.seating_charts(:updated => date) }
      let(:seating_chart) { seating_charts.first }

      use_vcr_cassette "seating_charts/find_recent", :erb => { :auth_token => Ticketutils.auth_token }

      it_should_behave_like "seatingchart.find with results"

      it "returns an array of 100 items" do
        seating_charts.length.should == 100
      end

      it "contains 160 total results" do
        seating_charts.total_entries.should == 218
      end

      it "is on the first page of results" do
        seating_charts.current_page.should == 1
      end

      it "contains 20 page of results" do
        seating_charts.total_pages.should == 3
      end
    end
    
    context "for a specific venue" do
      let(:venue_id) { "6c307dea-2057-488b-9200-97c2c756c576" }
      let(:seating_charts) { Ticketutils.seating_charts(:venue_id => venue_id) }
      let(:seating_chart) { seating_charts.first }
      
      use_vcr_cassette "seating_charts/for_venue", :erb => { :auth_token => Ticketutils.auth_token }
      it_should_behave_like "seating charts"
    end
  end
end