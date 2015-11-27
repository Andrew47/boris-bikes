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
  (bikes << station.bikes.delete_if{|bike| bike.working?}).flatten
end


def van_station_deliver(station)
  station.bikes.concat(bikes)
  bikes = []
end

end
