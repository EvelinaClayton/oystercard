require './lib/journey.rb'

describe Journey do

it 'returns minimum fare' do
  subject.entry_station = 'aabbcc'
  subject.exit_station = 'aabbcc'
  expect(subject.fare).to eq Journey::MINIMUM_FARE 
end

it 'returns penalty fare' do 
  expect(subject.fare).to eq Journey::PENALTY_FARE
end

end 