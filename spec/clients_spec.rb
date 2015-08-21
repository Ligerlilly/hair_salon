require 'spec_helper'

describe Client do
  before do
    @client = Client.new({ id: nil, name: 'Lisa' })
  end
  describe '#id' do
    it 'should be 0 at first' do
      expect(@client.id).to eq 0
    end
  end

  describe '#nane' do
    it 'should be 0 at first' do
      expect(@client.name).to eq 'Lisa'
    end
  end
end
