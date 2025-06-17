module SavingsAccount
  def self.interest_rate(balance)
    case
    when balance.negative?    then 3.213
    when balance < 1000       then 0.5
    when balance < 5000       then 1.621
    else                           2.475
    end
  end

  def self.annual_balance_update(balance)
    # If balance is 0, return 0 as there's no interest
    return balance if balance.zero?

    # Get the base interest rate
    rate = interest_rate(balance)

    # For negative balances, we use the absolute rate
    rate = rate.abs

    # Convert percentage to decimal for calculation
    decimal_rate = rate / 100.0

    # Calculate interest earned
    interest = balance * decimal_rate

    # Return original balance plus interest
    balance + interest
  end

  def self.years_before_desired_balance(current_balance, desired_balance)
    years_before_desired_balance = 0

    while current_balance < desired_balance
      current_balance = annual_balance_update(current_balance)
      years_before_desired_balance += 1
    end
    years_before_desired_balance
  end
end