class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================



    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.delete(" ").delete("\r\n").length

    words = @text.split

    @word_count = words.size

    special_occur = 0

    words.each do |word|
      if word.downcase == @special_word.downcase
        special_occur += 1
      end
    end

    @occurrences = special_occur

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    apr_as_percent = @apr / 100
    # r = periodic interest rate
    r = apr_as_percent / 12

    @monthly_payment = (@principal * r) / (1 - (1 + r)**(-@years * 12.0))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @starting - @ending
    @minutes = @seconds / 60.0
    @hours = @minutes / 60.0
    @days = @hours / 24.0
    @weeks = @days / 7.0
    @years = @weeks / 52.0

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    num_amt = @numbers.size

    @sorted_numbers = @numbers.sort

    @count = num_amt

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[num_amt-1]

    @range = @maximum - @minimum

    if @numbers.size % 2 == 0
      @median = (@sorted_numbers[num_amt/2] + @sorted_numbers[(num_amt/2)-1])/2
    else
      @median = @sorted_numbers[(@numbers.size+1)/2]
    end

    @sum = @numbers.sum

    @mean = @sum / num_amt * 1.0

    squared_diff = 0
    @numbers.each do |num|
      squared_diff += (num - @mean)**2
    end

    @variance =   squared_diff / (num_amt)

    @standard_deviation = @variance**0.5

    placeholder_count = 0
    placeholder_num = 0
    count = 0

    @sorted_numbers.each_with_index do |num,index|
      if index == @sorted_numbers.length - 2
        break
      end

      current_num = num

      if @sorted_numbers[index+1] == num
        count += 1
      else
        if count > placeholder_count
          placeholder_num = current_num
          placeholder_count = count
        end
        count = 0
      end
    end

    @mode = placeholder_count

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
