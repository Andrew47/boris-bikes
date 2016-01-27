require 'bike'

describe Bike do

  describe "#initialize" do
    it "works by default" do
      expect(subject.working?).to eq true
    end
  end

  it "can be reported broken" do
    subject.broken
    expect(subject).not_to be_working
  end

  it 'responds to working?' do
    expect(subject).to respond_to :working?
  end

end
