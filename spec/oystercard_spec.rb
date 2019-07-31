# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  it 'has a balance of 0' do
    oystercard = Oystercard.new
    expect(oystercard.balance).to eq 0
  end

  it 'has a method top_up' do
    oystercard = Oystercard.new
    expect(oystercard).to respond_to(:top_up).with(1).argument
  end

  it 'can top up the balance' do
    expect { subject.top_up 1 }.to change { subject.balance }.by 1
  end

  it 'raises an error if the maximum balance is exceeded' do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    subject.top_up(maximum_balance)
    error_message = "Maximum balance of #{maximum_balance} exceeded."
    expect { subject.top_up 1 }.to raise_error(error_message)
  end

  it 'has a method deduct' do
    expect(subject).to respond_to(:deduct).with(1).argument
  end

  it 'has a method touch_in' do
    expect(subject).to respond_to(:touch_in)
  end

  it 'has a method touch_out' do
    expect(subject).to respond_to(:touch_out)
  end

  it 'is initially not in a journey' do
    expect(subject).not_to be_in_journey
  end

  it 'can touch in' do
    subject.top_up(1)
    subject.touch_in 
    expect(subject).to be_in_journey 
  end

  it 'can touch out' do
    subject.top_up(1)
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  it 'will not touch in if below minimum balance' do 
    expect{ subject.touch_in }.to raise_error "Insufficient balance to touch in"
  end
end

