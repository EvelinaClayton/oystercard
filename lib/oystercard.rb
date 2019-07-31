# frozen_string_literal: true

class Oystercard
  attr_reader :balance, :currently_in_use
  
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @currently_in_use = false
  end

  def top_up(amount)
    error_message = "Maximum balance of #{MAXIMUM_BALANCE} exceeded."
    raise error_message if amount + balance > MAXIMUM_BALANCE

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    fail "Insufficient balance to touch in" if @balance < MINIMUM_BALANCE
    @currently_in_use = true
  end

  def touch_out
    @currently_in_use = false
  end

  def in_journey?
    @currently_in_use
  end
end
