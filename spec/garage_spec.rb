require 'garage'

describe Garage do

  it "mends bikes with #mend" do
    working_bike = double(:working_bike, working?: true)
    broken_bike = double(:broken_bike, working?: false, mend: working_bike)
    subject.send(:bikes).concat([broken_bike,broken_bike])
    subject.mend
    expect(subject.send(:bikes).all?{|bike| bike.working?}).to eq true
  end

end
