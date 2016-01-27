class Garage

  include BikeContainer

  def mend
    bikes.map! { |bike| bike.send :mend  }
    bikes
  end

  def at_capacity?(van)
    (bikes + van.bikes).select{|bike| bike.working?}.size > capacity
  end

end
