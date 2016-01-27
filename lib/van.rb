require_relative 'bike_container'

class Van

  include BikeContainer

  def van_station_exchange(station)
    station.bikes.concat(bikes.select{|bike| bike.working?})
    bikes.delete_if{|bike| bike.working?}
    fail 'Van full' if bikes.size + station.bikes.select{|bike| !bike.working?}.size > capacity
    bikes.concat(station.bikes.select{|bike| !bike.working?})
    station.bikes.delete_if{|bike| !bike.working?}
  end

  def van_garage_exchange(garage)
    fail 'Garage full' if garage.at_capacity?(self)
    garage.bikes.concat(bikes.select{|bike| !bike.working?})
    bikes.delete_if{|bike| !bike.working?}
    fail 'Van full' if bikes.size + garage.bikes.select{|bike| bike.working?}.size > capacity
    bikes.concat(garage.bikes.select{|bike| bike.working?})
    garage.bikes.delete_if{|bike| bike.working?}
  end


end
