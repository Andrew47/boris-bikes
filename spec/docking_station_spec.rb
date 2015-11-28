require 'docking_station.rb'
require 'support/shared_examples_for_bike_container'

describe DockingStation do
  let(:bike) { double :bike }
  let(:station) {described_class.new}

  it_behaves_like BikeContainer

  it "responds to release_bike" do
    expect(subject).to respond_to :release_bike
  end

  it "released bike is working" do
    #Alternative to let and below: bike = double('bike', working?: true)
    allow(bike).to receive(:working?) { true }
    subject.dock bike
    bike = subject.release_bike
    expect(bike).to be_working
  end

  it "released working bike instead of broken" do
    subject.dock(double(:working_bike, working?: true))
    subject.dock(double(:broken_bike, working?: false))
    release_bike = subject.release_bike
    expect(release_bike).to be_working
  end


  it "will not release if all bikes broken" do
    allow(bike).to receive(:working?) { false }
    subject.capacity.times {subject.dock(bike)}
    expect{subject.release_bike}.to raise_error "All bikes broken"
  end

  it "can dock to station" do
    expect(subject).to respond_to(:dock).with(1).argument
  end

  it "responds to bike" do
    expect(subject).to respond_to :bikes
  end


  describe "#dock" do
    it "docks something" do
      expect(subject.dock(bike)).to eq [bike]
    end


    it "raises an error when station is full" do
      subject.capacity.times {subject.dock(double(:bike))}
      expect{subject.dock(double(:bike))}.to raise_error 'DockingStation full'
    end

    context "system maintainer has raised capacity" do
      subject {DockingStation.new(60)}
      let(:bike) {double(:bike)}

      it "accepts more bikes than before" do
        DockingStation::DEFAULT_CAPACITY.times {subject.dock(bike)}
        expect(subject.dock(bike)).to eq subject.bikes
      end


      it "raises an error when station is full" do
        60.times {subject.dock(bike)}
        expect{subject.dock(bike)}.to raise_error 'DockingStation full'
      end

    end


  end

  it "returns docked bikes" do
    subject.dock(bike)
    expect(subject.bikes).to eq [bike]
  end
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

  it "can assign a capacity value at initialize" do
    station = DockingStation.new(40)
    expect(station.capacity).to eq 40
  end

  it  'has a default capacity' do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end

end
