require_relative 'van'

class Garage

  attr_reader :bikes, :capacity

  DEFAULT_CAPACITY= 20

  def initialize(capacity=DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity

  end

  def mend
    bikes.map! { |bike| bike.mend  }
    bikes
  end


  def at_capacity?(van)
    (bikes + van.bikes).select{|bike| bike.working?}.size > capacity

  end

end
