require 'spec_helper'

describe Ticketutils::Venue do
  context ".find" do
    context "with no options" do
      let(:venues) { Ticketutils.venues }
      let(:venue) { venues.first }

      use_vcr_cassette "venues/find", :erb => { :auth_token => Ticketutils.auth_token }

      it_should_behave_like "venues.find with results"

      it "returns an array of 100 items" do
        venues.length.should == 100
      end

      it "contains 1990 total results" do
        venues.total_entries.should == 1990
      end

      it "is on the first page of results" do
        venues.current_page.should == 1
      end

      it "contains 20 page of results" do
        venues.total_pages.should == 20
      end
    end
    
    context "updated in the last day" do
      let(:date) { Date.parse("May 18, 2011") }
      let(:venues) { Ticketutils.venues(:updated => date) }
      let(:venue) { venues.first }

      use_vcr_cassette "venues/find_recent", :erb => { :auth_token => Ticketutils.auth_token }
      
      it_should_behave_like "venues.find with results"
      
      it "returns an array of 100 items" do
        venues.length.should == 100
      end

      it "contains 1105 total results" do
        venues.total_entries.should == 1105
      end

      it "is on the first page of results" do
        venues.current_page.should == 1
      end
    
      it "contains exactly 12 page of results" do
        venues.total_pages.should == 12
      end
    end

    context "on page 2" do
      let(:venues) { Ticketutils.venues(:page => 2) }
      let(:venue) { venues.first }

      use_vcr_cassette "venues/find_page_2", :erb => { :auth_token => Ticketutils.auth_token }
    
      it_should_behave_like "venues.find with results"
      
      it "returns an array of 100 items" do
        venues.length.should == 100
      end

      it "contains 1993 total results" do
        venues.total_entries.should == 1993
      end

      it "is on the second page of results" do
        venues.current_page.should == 2
      end
    
      it "contains exactly 20 page of results" do
        venues.total_pages.should == 20
      end
    end
    
    context "limiting to 50 results" do
      let(:venues) { Ticketutils.venues(:per_page => 50) }
      let(:venue) { venues.first }

      use_vcr_cassette "venues/find_per_page_50", :erb => { :auth_token => Ticketutils.auth_token }
    
      it_should_behave_like "venues.find with results"
      
      it "returns an array of 50 items" do
        venues.length.should == 50
      end
      
      it "contains 1993 total results" do
        venues.total_entries.should == 1993
      end

      it "is on the first page of results" do
        venues.current_page.should == 1
      end
    
      it "contains 20 pages of results" do
        venues.total_pages.should == 20
      end
    end
  end
  
  context "a venue object" do
    let(:venue_id) { "6c307dea-2057-488b-9200-97c2c756c576" }
    let(:venue) { Ticketutils::Venue.new(:id => venue_id, :name => "Venue") }
    let(:seating_charts) { venue.seating_charts }
    let(:seating_chart) { seating_charts.first }
    

    context "#seating_charts" do
      use_vcr_cassette "seating_charts/for_venue", :erb => { :auth_token => Ticketutils.auth_token }
      it_should_behave_like "seating charts"
    end
  end
end