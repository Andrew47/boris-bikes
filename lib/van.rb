require_relative 'docking_station'

class Van

  attr_reader :bikes, :capacity

  DEFAULT_CAPACITY= 20

  def initialize(capacity=DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity

  end


  def van_station_collect(station)
    fail 'Van full' if capacity < station.capacity
    bikes.concat(station.bikes.select{|bike| !bike.working?})
    station.bikes.concat(bikes.select{|bike| bike.working?})
    station.bikes.delete_if{|bike| !bike.working?}
    bikes.delete_if{|bike| bike.working?}

  end


end
