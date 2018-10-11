require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather
    @street_address = params.fetch("user_street_address")
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================
    goog_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address + "&key=AIzaSyA5qwIlcKjijP_Ptmv46mk4cCjuWhSzS78"
    goog_raw_data = open(goog_url).read
    goog_parsed_data = JSON.parse(goog_raw_data)
    lat = goog_parsed_data.dig("results", 0, "geometry", "location", "lat")
    lng = goog_parsed_data.dig("results", 0, "geometry", "location", "lng")
    
    darksky_key = ENV.fetch("DARKSKY_KEY")
    
    darksky_url = "https://api.darksky.net/forecast/#{darksky_key}/#{lat},#{lng}"
    darksky_raw_data = open(darksky_url).read
    darksky_parsed_data = JSON.parse(darksky_raw_data)

    current_temperature = darksky_parsed_data.dig("currently", "temperature")
    current_summary = darksky_parsed_data.dig("currently", "summary")
    summary_of_next_sixty_minutes = darksky_parsed_data.dig("minutely", "summary")
    summary_of_next_several_hours = darksky_parsed_data.dig("hourly", "summary")
    summary_of_next_several_days = darksky_parsed_data.dig("daily", "summary")
    
    
    @current_temperature = "#{current_temperature}" 

    @current_summary = "#{current_summary}"

    @summary_of_next_sixty_minutes = "#{summary_of_next_sixty_minutes}"

    @summary_of_next_several_hours = "#{summary_of_next_several_hours}"

    @summary_of_next_several_days = "#{summary_of_next_several_days}"

    render("meteorologist_templates/street_to_weather.html.erb")
  end

  def street_to_weather_form
    render("meteorologist_templates/street_to_weather_form.html.erb")
  end
end
