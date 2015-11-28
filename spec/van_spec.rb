require 'van'

describe Van do
  let(:station) { double :station }
  let(:bike) {double :bike}
  let(:garage) {double :garage}
  let(:van) {described_class.new}


  describe "#van_station_exchange" do

    it "delivers working bikes over broken" do
      station = double(:station, bikes: [])
      working_bike = double(:working_bike, working?: true)
      broken_bike = double(:broken_bike, working?: false)
      subject.bikes.concat([working_bike,broken_bike])
      subject.van_station_exchange(station)
      expect(subject.bikes).to eq [broken_bike]
      expect(station.bikes).to eq [working_bike]
    end

    it "collects broken bikes over working" do
      working_bike = double(:working_bike, working?: true)
      broken_bike = double(:broken_bike, working?: false)
      station = double(:station, bikes: [working_bike, broken_bike])
      subject.van_station_exchange(station)
      expect(subject.bikes).to eq [broken_bike]
      expect(station.bikes).to eq [working_bike]
    end

    describe "#van_garage_exchange" do

      it "delivers broken bikes over working" do
        garage = double(:garage, bikes: [])
        working_bike = double(:working_bike, working?: true)
        broken_bike = double(:broken_bike, working?: false)
        subject.bikes.concat([working_bike,broken_bike])
        subject.van_garage_exchange(garage)
        expect(subject.bikes).to eq [working_bike]
        expect(garage.bikes).to eq [broken_bike]
      end

      it "collects working bikes over broken" do
        working_bike = double(:working_bike, working?: true)
        broken_bike = double(:broken_bike, working?: false)
        garage = double(:garage, bikes: [working_bike, broken_bike])
        subject.van_garage_exchange(garage)
        expect(subject.bikes).to eq [working_bike]
        expect(garage.bikes).to eq [broken_bike]
      end

    end

    context "van's capacity" do

      it  'has a default capacity' do
        expect(subject.capacity).to eq Van::DEFAULT_CAPACITY
      end

      it "#van_station_exchange raises an error when van full" do
        broken_bike = double(:broken_bike, working?: false)
        array = []
        (subject.capacity + 1).times{array<<broken_bike}
        station = double(:station, bikes: array)
        expect{subject.van_station_exchange(station)}.to raise_error "Van full"
      end

      it "#van_garage_exchange raises an error when van full" do
        working_bike = double(:working_bike, working?: true)
        array = []
        (subject.capacity + 1).times{array<<working_bike}
        garage = double(:garage, bikes: array)
        expect{subject.van_garage_exchange(garage)}.to raise_error "Van full"
      end
    end

=begin

    it "raises an error when van full" do

      station = double(:station, capacity: Van::DEFAULT_CAPACITY + 1)
      expect{subject.van_station_exchange(station)}.to raise_error 'Van full'
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
      expect(subject.van_station_exchange(station)).to eq array
    end

    it "raises an error when full van" do
      allow(station).to receive(:capacity) {61}
      expect{subject.van_station_exchange(station)}.to raise_error 'Van full'
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
