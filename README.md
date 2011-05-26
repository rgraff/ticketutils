# Ticketutils!

## How To Use

### Set your auth key

    Ticketutils.auth_key = "1234567890123456789"

### List out Venues

    Ticketutils.venues(options) => returns a will_paginate collection of venues
    # options:
    #   page: defaults to 1
    #     First page is 1, 100 results to the page
    #   updated: defaults to nil
    #     Only show venues updated since this date. Defaults to all venues
    # ex: ticketutils.venues(:page => 2, :updated => 1.week.ago)

### Venue object

  venue.events(options) => returns a will_paginate collection of events_
  # options:
  #   page: defaults to 1
  #     First page is 1, 100 results to the page
  #   on: defaults to nil
  #     Only show events on this specific date. (all other options will be ignored)
  #   updated: defaults to nil
  #     Only show venues updated since this date. Defaults to all venues. (cannot be)

  venue.seating_charts => returns will_paginate collection of all searching charts    

### List out Seating Charts

  Ticketutils.seating_charts(options) => returns a will_paginate collection of seating charts
  # options:
  #   page: defaults to 1
  #     First page is 1, 100 results to the page
  #   updated: defaults to nil
  #     Only show venues updated since this date. Defaults to all venues
  #   per_page: defaults to 100
  #     Paginate this many per page. Limit is 100.