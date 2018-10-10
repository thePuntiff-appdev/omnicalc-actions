class LoanPaymentController < ApplicationController
  def loan_payment
    @apr = params.fetch("annual_percentage_rate").to_f
    @years = params.fetch("number_of_years").to_i
    @principal = params.fetch("principal_value").to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    annual_interest_rate = @apr.to_f / 100
    monthly_interest_rate = annual_interest_rate / 12
    months = @years.to_i * 12
    principal = @principal.to_f
    
    monthly_payment = (monthly_interest_rate*principal)/(1-(1+monthly_interest_rate)**-months)

    @monthly_payment = "#{monthly_payment}"

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment_templates/loan_payment.html.erb")
  end

  def loan_payment_form
    render("loan_payment_templates/loan_payment_form.html.erb")
  end
end
