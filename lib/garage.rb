require_relative 'van'

class Garage

  include BikeContainer

  def mend
    bikes.map! { |bike| bike.mend  }
    bikes
  end

private

  def at_capacity?(van)
    (bikes + van.bikes).select{|bike| bike.working?}.size > capacity
  end

end
