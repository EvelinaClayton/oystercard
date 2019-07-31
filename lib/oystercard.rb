# frozen_string_literal: true

class Oystercard
  attr_reader :balance, :currently_in_use, :all_journeys

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @currently_in_use = false
    clear_stations
    @all_journeys = []
  end

  def top_up(amount)
    error_message = "Maximum balance of #{MAXIMUM_BALANCE} exceeded."
    raise error_message if amount + balance > MAXIMUM_BALANCE

    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient balance to touch in' if @balance < MINIMUM_BALANCE

    @currently_in_use = true
    @entry_station = station
  end

  def touch_out(station_name)
    deduct(MINIMUM_CHARGE)
    @currently_in_use = false
    @exit_station = station_name
    log_journey
  end

  def log_journey
    @all_journeys << current_journey
    clear_stations
  end

  def current_journey
    {
      touch_in: @entry_station,
      touch_out: @exit_station
    }
  end

  def clear_stations
    @entry_station = nil
    @exit_station = nil
  end

  def in_journey?
    @currently_in_use
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
