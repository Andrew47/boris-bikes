require_relative 'van'

class Garage

  attr_reader :bikes, :capacity

  DEFAULT_CAPACITY= 20

  def initialize(capacity=DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity

  end

end
