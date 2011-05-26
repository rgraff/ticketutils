shared_examples_for "venues.find with results" do
  it "contains only venues" do
    venues.each do |venue|
      venue.is_a?(Ticketutils::Venue).should == true
    end
  end

  it "parses the results into venues" do
    venue.id.should == "61b62126-add8-47e2-ad73-fca15abb3aff"
    venue.name.should == "105 Valley St"
    venue.country.should == "United States"
    venue.state.should == "California"
    venue.city.should == "Pasadena"
  end
end