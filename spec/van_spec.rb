require 'van'
require 'support/shared_examples_for_bike_container'

describe Van do
  let(:station) { double :station }
  let(:bike) {double :bike}
  let(:garage) {double :garage}
  let(:van) {described_class.new}

  it_behaves_like BikeContainer


  describe "#van_station_exchange" do

    it "delivers working bikes over broken" do
      station = double(:station, bikes: [])
      working_bike = double(:working_bike, working?: true)
      broken_bike = double(:broken_bike, working?: false)
      subject.send(:bikes).concat([working_bike,broken_bike])
      subject.van_station_exchange(station)
      expect(subject.send(:bikes)).to eq [broken_bike]
      expect(station.bikes).to eq [working_bike]
    end

    it "collects broken bikes over working" do
      working_bike = double(:working_bike, working?: true)
      broken_bike = double(:broken_bike, working?: false)
      station = double(:station, bikes: [working_bike, broken_bike])
      subject.van_station_exchange(station)
      expect(subject.send(:bikes)).to eq [broken_bike]
      expect(station.bikes).to eq [working_bike]
    end

    describe "#van_garage_exchange" do

      it "delivers broken bikes over working" do
        garage = double(:garage, bikes: [], at_capacity?: false)
        working_bike = double(:working_bike, working?: true)
        broken_bike = double(:broken_bike, working?: false)
        subject.send(:bikes).concat([working_bike,broken_bike])
        subject.van_garage_exchange(garage)
        expect(subject.send(:bikes)).to eq [working_bike]
        expect(garage.bikes).to eq [broken_bike]
      end

      it "collects working bikes over broken" do
        working_bike = double(:working_bike, working?: true)
        broken_bike = double(:broken_bike, working?: false)
        garage = double(:garage, bikes: [working_bike, broken_bike], at_capacity?: false)
        subject.van_garage_exchange(garage)
        expect(subject.send(:bikes)).to eq [working_bike]
        expect(garage.bikes).to eq [broken_bike]
      end

    end

    context "van's capacity" do

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
        garage = double(:garage, bikes: array, at_capacity?: false)
        expect{subject.van_garage_exchange(garage)}.to raise_error "Van full"
      end
    end

    context "garage's capacity" do
      it "#van_garage_exchange raises an error when garage full" do
        garage = double(:garage, at_capacity?: true)
        expect{subject.van_garage_exchange(garage)}.to raise_error "Garage full"
      end
    end
  end
end
