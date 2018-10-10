class TimeBetweenController < ApplicationController
  def time_between
    @starting = Chronic.parse(params.fetch("starting_time"))
    @ending = Chronic.parse(params.fetch("ending_time"))

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = "#{@ending - @starting}"
    @minutes = "#{(@ending - @starting)/60}"
    @hours = "#{(@ending - @starting)/3600}"
    @days = "#{(@ending - @starting)/86400}"
    @weeks = "#{(@ending - @starting)/604800}"
    @years = "#{(@ending - @starting)/31536000}"

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between_templates/time_between.html.erb")
  end

  def time_between_form
    render("time_between_templates/time_between_form.html.erb")
  end
end
