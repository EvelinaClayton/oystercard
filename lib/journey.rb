class Journey 
  attr_accessor :current_journey, :entry_station, :exit_station

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize 
    @current_journey = []
    @entry_station = nil
    @exit_station = nil 
  end 

  def fare 
    if exit_station == nil || entry_station == nil
      PENALTY_FARE
    else
      MINIMUM_FARE
    end   
  end

end