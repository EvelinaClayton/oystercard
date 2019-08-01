# frozen_string_literal: true
require_relative 'journey'

class Oystercard
  attr_reader :balance, :currently_in_use, :all_journeys

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @currently_in_use = false
    # clear_stations
    @all_journeys = []
    @journey = Journey.new 
  end

  def top_up(amount)
    error_message = "Maximum balance of #{MAXIMUM_BALANCE} exceeded."
    raise error_message if amount + balance > MAXIMUM_BALANCE

    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient balance to touch in' if @balance < MINIMUM_BALANCE

    @currently_in_use = true
    @journey.entry_station = station
  end

  def touch_out(station_name)
    deduct(MINIMUM_CHARGE)
    @currently_in_use = false
    @journey.exit_station = station_name
    log_journey
  end

  def log_journey
    @all_journeys << @journey.entry_station
    @all_journeys << @journey.exit_station
    clear_stations
  end

#   def current_journey
#     {
#       touch_in: @entry_station,
#       touch_out: @exit_station
#     }
#   end

  def clear_stations
    # journey.current_journey = [] 
    @journey.entry_station = nil
    @journey.exit_station = nil
  end

  def in_journey?
    @currently_in_use
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
