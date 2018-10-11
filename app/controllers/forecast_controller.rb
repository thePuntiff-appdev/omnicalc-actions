require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather
    @lat = params.fetch("user_latitude").strip
    @lng = params.fetch("user_longitude").strip

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================
    
    url = "https://api.darksky.net/forecast/dcdc1364c62099b31d76c0e99232e7c8/#{@lat},#{@lng}"
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)

    current_temperature = parsed_data.dig("currently", "temperature")
    current_summary = parsed_data.dig("currently", "summary")
    summary_of_next_sixty_minutes = parsed_data.dig("minutely", "summary")
    summary_of_next_several_hours = parsed_data.dig("hourly", "summary")
    summary_of_next_several_days = parsed_data.dig("daily", "summary")

    @current_temperature = "#{current_temperature}" 

    @current_summary = "#{current_summary}"

    @summary_of_next_sixty_minutes = "#{summary_of_next_sixty_minutes}"

    @summary_of_next_several_hours = "#{summary_of_next_several_hours}"

    @summary_of_next_several_days = "#{summary_of_next_several_days}"

    render("forecast_templates/coords_to_weather.html.erb")
  end

  def coords_to_weather_form
    render("forecast_templates/coords_to_weather_form.html.erb")
  end
  
end
