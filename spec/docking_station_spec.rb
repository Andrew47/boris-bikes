require 'docking_station.rb'

describe DockingStation do
it "responds to release_bike" do
  expect(subject).to respond_to :release_bike
end
it "release_bike gets a bike" do
  bike = subject.release_bike
  expect(bike).to be_working
end

end
