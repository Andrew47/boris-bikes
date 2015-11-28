require 'garage'

describe Garage do

  it "mends bikes with #mend" do
    working_bike = double(:working_bike, working?: true)
    broken_bike = double(:broken_bike, working?: false, mend: working_bike)
    subject.bikes.concat([broken_bike,broken_bike])
    subject.mend
    expect(subject.bikes.all?{|bike| bike.working?}).to eq true
  end

=begin
  describe "#at_capacity?" do
    it "gives true if garage would be full after exchange with van" do
      bike = double(:bike, working?: true)
      subject.capacity.times {subject.bikes<<bike}
      van = double(:van, bikes: [bike])
      expect(subject.at_capacity?(van)).to eq true
    end

  end
=end


end
