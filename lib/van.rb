require_relative 'docking_station'

class Van

  attr_reader :bikes, :capacity

  DEFAULT_CAPACITY= 20

  def initialize(capacity=DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity

  end


  def van_station_exchange(station)
    station.bikes.concat(bikes.select{|bike| bike.working?})
    bikes.delete_if{|bike| bike.working?}
    fail 'Van full' if bikes.size + station.bikes.select{|bike| !bike.working?}.size > capacity
    bikes.concat(station.bikes.select{|bike| !bike.working?})
    station.bikes.delete_if{|bike| !bike.working?}
  end

  def van_garage_exchange(garage)
    bikes.concat(garage.bikes.select{|bike| bike.working?})
    garage.bikes.delete_if{|bike| bike.working?}

    garage.bikes.concat(bikes.select{|bike| !bike.working?})
    bikes.delete_if{|bike| !bike.working?}
  end


end
