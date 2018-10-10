class StatsController < ApplicationController
  def stats
    @numbers = params.fetch("list_of_numbers").gsub(",", "").split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = "#{@numbers.sort}"

    @count = "#{@numbers.count}"

    @minimum = "#{@numbers.min}"

    @maximum = "#{@numbers.max}"

    @range = "#{@numbers.max - @numbers.min}"

    # Median
    # ======
    numbers = @numbers.sort
    how_long = @numbers.count
    
    if how_long.odd? == true
      median = numbers[(how_long/2)]
    else
      left_of_middle = numbers[(how_long/2)-1]
      right_of_middle = numbers[how_long/2]
      median = (left_of_middle+right_of_middle)/2.0
    end

    @median = "#{median}"

    sum = 0
    @numbers.each do |num|
      sum += num
    end 

    @sum = "#{sum}"

    @mean = "#{sum/@numbers.count}"

    # Variance
    # ========
    difference_from_mean = []
    
    @numbers.each do |num|
      difference_from_mean.push((sum/@numbers.count)-num)
    end
    
    squared_difference_from_mean = []
    
    difference_from_mean.each do |num|
      squared_difference_from_mean.push(num**2)
    end
  
    variance_sum = 0
      squared_difference_from_mean.each do |num|
      variance_sum += num
    end 
    variance = variance_sum/squared_difference_from_mean.count

    @variance = "#{variance}"

    @standard_deviation = "#{variance**0.5}"

    # Mode
    # ====
    mode = @numbers[0]
    count_of_mode = @numbers.count(@numbers[0])
      
    @numbers.each do |num|
      if @numbers.count(num) > count_of_mode
        count_of_mode = @numbers.count(num)
        mode = num
      end
    end 


    @mode = "#{mode}"

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("stats_templates/stats.html.erb")
  end

  def stats_form
    render("stats_templates/stats_form.html.erb")
  end
  
end
