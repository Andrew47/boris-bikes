module BikeContainer
  DEFAULT_CAPACITY = 20

  attr_reader :capacity, :bikes

  def initialize(capacity=DEFAULT_CAPACITY)
    @capacity = capacity
    @bikes = []
  end

  def add_bike(bike)
    fail "#{self.class.to_s} full" if full?
    bikes << bike
  end

  def remove_bike
    fail "#{self.class.to_s} empty" if empty?
    bikes.pop
  end

  def empty?
    bikes.empty?
  end

  def full?
    bikes.count >= capacity
  end



end
