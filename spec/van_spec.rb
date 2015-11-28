require 'van'

describe Van do
  let(:station) { double :station }
  let(:bike) {double :bike}
  let(:garage) {double :garage}
  let(:van) {described_class.new}

  it  'has a default capacity' do
    expect(subject.capacity).to eq Van::DEFAULT_CAPACITY
  end


  describe "#van_station_collect" do


    it "delivers working bikes over broken" do
      station = double(:station, bikes: [], capacity: Van::DEFAULT_CAPACITY - 1)
      working_bike = double(:working_bike, working?: true)
      broken_bike = double(:broken_bike, working?: false)
      subject.bikes.concat([working_bike,broken_bike])
      subject.van_station_collect(station)
      expect(subject.bikes).to eq [broken_bike]
    end

    it "collects broken bikes over working" do
      working_bike = double(:working_bike, working?: true)
      broken_bike = double(:broken_bike, working?: false)
      station = double(:station, bikes: [working_bike, broken_bike], capacity: Van::DEFAULT_CAPACITY - 1)
      subject.van_station_collect(station)
      expect(subject.bikes).to eq [broken_bike]
    end

=begin

    it "raises an error when van full" do

      station = double(:station, capacity: Van::DEFAULT_CAPACITY + 1)
      expect{subject.van_station_collect(station)}.to raise_error 'Van full'
    end



  end

  context "van has raised capacity" do
    subject {Van.new(60)}
    let(:bike) {double(:bike)}

    it "accepts more bikes than before" do
      array = []
      bike = double(:bike, working?: false)
      Van::DEFAULT_CAPACITY.times{array.concat([bike])}
      station = double(:station, bikes: array, capacity: Van::DEFAULT_CAPACITY)
      expect(subject.van_station_collect(station)).to eq array
    end

    it "raises an error when full van" do
      allow(station).to receive(:capacity) {61}
      expect{subject.van_station_collect(station)}.to raise_error 'Van full'
    end

  end

  it "can be assigned a capacity value at initialize" do
    station = DockingStation.new(40)
    expect(station.capacity).to eq 40
  end

  describe "#van_garage_deliver" do

  #Am stuck at this point:
  
    it "delivers broken bikes" do
      subject.bikes.concat([bike,bike])
      subject.van_garage_deliver(garage)
      expect(subject.bikes).to be_empty
    end
=end




  end


end

=begin

describe "#release_bike" do
it 'releases a bike' do
allow(bike).to receive(:working?) {true}
subject.dock(bike)
expect(subject.release_bike).to eq bike
end
it 'raises an error when there are no bikes available' do
expect{subject.release_bike}.to raise_error 'No bikes available'
end
end

=end
