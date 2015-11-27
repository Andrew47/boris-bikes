require 'van'

describe Van do
  let(:station) { double :station }
  let(:bike) {double :bike}
  let(:van) {described_class.new}

  it  'has a default capacity' do
    expect(subject.capacity).to eq Van::DEFAULT_CAPACITY
  end


  describe "#van_collect" do

    it "collects broken bikes over working" do
      working_bike = double(:working_bike, working?: true)
      broken_bike = double(:broken_bike, working?: false)
      station = double(:station, bikes: [working_bike, broken_bike])
      expect(subject.van_collect(station)).to eq [broken_bike]
    end
    


  end

end

=begin
    it "raises an error when van full" do
      allow(station).to receive(:capacity) {van.capacity + 1}
      expect{subject.van_collect(station)}.to raise_error 'Van full'
    end

    context "van has raised capacity" do
      subject {Van.new(60)}
      let(:bike) {double(:bike)}

      it "accepts more bikes than before" do
        allow(station).to receive(:capacity) {van.capacity + 1}
        expect(subject.van_collect(station)).to eq subject.bikes
      end


      it "raises an error when full van" do
        allow(station).to receive(:capacity) {61}
        expect{subject.van_collect(station)}.to raise_error 'Van full'
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

=end
