require 'spec_helper'

describe Client do
  before do
    @client = Client.new({ id: nil, name: 'Lisa', stylist_id: nil })
  end
  describe '#id' do
    it 'should be 0 at first' do
      expect(@client.id).to eq 0
    end
  end

  describe '#name' do
    it 'should be 0 at first' do
      expect(@client.name).to eq 'Lisa'
    end
  end

  describe '.all' do
    it 'should return an empty array at first' do
      expect(Client.all).to eq []
    end
  end

  describe '#stylist_id' do
    it "should return id of client's stylist, should be zero at first" do
      expect(@client.stylist_id).to eq 0
    end
  end
end
