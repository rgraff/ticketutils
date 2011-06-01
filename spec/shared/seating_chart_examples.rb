shared_examples_for "seating charts" do
  it "returns 1 result" do
    seating_charts.length.should == 1
  end

  it "contains exactly 1 total results" do
    seating_charts.total_entries == 1
  end

  it "contains exactly 1 page of results" do
    seating_charts.total_pages == 1
  end

  it "is on the first page of results" do
    seating_charts.current_page.should == 1
  end

  it "returns all seating charts" do
    seating_charts.each do |seating_chart|
      seating_chart.is_a?(Ticketutils::SeatingChart).should == true
    end
  end

  it "parses the seating charts" do
    seating_chart.id.should == "87fae816-53c6-4fca-8549-044568191197"
    seating_chart.name.should == "Main Map"
    seating_chart.url.should == "http://images2.ticketutils.com/1000X/87fae816-53c6-4fca-8549-044568191197.jpg"
    seating_chart.url_medium.should == "http://images2.ticketutils.com/500X/87fae816-53c6-4fca-8549-044568191197.jpg"
    seating_chart.url_large.should == nil
    seating_chart.venue_id.should == venue_id
    seating_chart.status.should == 1
    seating_chart.version.should == 1
  end
end

shared_examples_for "seatingchart.find with results" do
  it "contains only seating charts" do
    seating_charts.each do |seating_chart|
      seating_chart.is_a?(Ticketutils::SeatingChart).should == true
    end
  end

  it "parses the results into seating charts" do
    seating_chart.id.should == "3cd7427c-dabc-4a5e-b26c-016863684549"
    seating_chart.name.should == "General Admission"
    seating_chart.url.should == "http://images2.ticketutils.com/1000X/3cd7427c-dabc-4a5e-b26c-016863684549.jpg"
    seating_chart.venue_id.should == "7b1d2d7d-c270-47c7-bf5f-262057c77fc1"
    seating_chart.status.should == 1
    seating_chart.version.should == 1
    seating_chart.url_medium.should == "http://images2.ticketutils.com/500X/3cd7427c-dabc-4a5e-b26c-016863684549.jpg"
    seating_chart.url_large.should == "http://images2.ticketutils.com/2000X/3cd7427c-dabc-4a5e-b26c-016863684549.jpg"
  end
end