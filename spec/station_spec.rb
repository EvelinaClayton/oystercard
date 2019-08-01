require './lib/station.rb'

describe Station do
  subject(:station_name) { described_class.new('aabbcc', 1) }

  describe 'initialize' do
    it 'should return station_name' do
      expect(subject.station_name).to eq 'aabbcc'
    end

    it 'should return station_name' do 
      expect(subject.zone).to eq 1
    end
  end 
end 
