require_relative 'bike_container'

class DockingStation

include BikeContainer

attr_reader :bikes, :capacity

DEFAULT_CAPACITY= 20

def initialize(capacity=DEFAULT_CAPACITY)
  @bikes = []
  @capacity = capacity

end

  def release_bike
    fail 'No bikes available' if empty?
    fail 'All bikes broken' if all_broken?
    bikes.sort!{|x,y| x.working?.to_s <=> y.working?.to_s}.pop
  end

def dock(bike)
  add_bike bike
end

private

def all_broken?
  bikes.all?{|bike| bike.working? == false}
end

end
