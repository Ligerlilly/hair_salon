require 'spec_helper'

describe Stylist do
  before do
    @stylist = Stylist.new({id: nil, name: 'Billie'})
  end
  describe '#id' do
    it 'should be 0 to start' do
      expect(@stylist.id).to eq 0
    end
  end

  describe '#name' do
    it 'should return the stylist name' do
      expect(@stylist.name).to eq 'Billie'
    end
  end

  describe '.all' do
    it 'should return an empty array at first' do
      expect(Stylist.all).to eq []
    end
  end

  describe '#save' do
    it 'should save a stylist' do
      @stylist.save
      expect(Stylist.all).to eq [@stylist]
    end
  end

  describe '#==' do
    it 'should return true if all attributes are equal' do
      stylist2 = Stylist.new({id: nil, name: 'Billie'})
      expect(@stylist).to eq stylist2
    end
  end

  describe '.find' do
    it 'returns a stylist based on id' do
      @stylist.save
      expect(Stylist.find(@stylist.id)).to eq @stylist
    end
  end

  describe '#update' do
    it 'should be able to update the name of a stylist' do
      @stylist.save
      @stylist.update({ name: 'Steve' })
      expect(@stylist.name).to eq 'Steve'
    end
  end

  describe '#destroy' do
    it 'should remove object from database' do
      @stylist.save
      @stylist.destroy
      expect(Stylist.all).to eq []
    end
  end

  describe '#clients' do
    it 'should return all the clients associated with stylist' do
      @stylist.save
      client1 = Client.new(id: nil, name: 'Lisa', stylist_id: @stylist.id)
      client2 = Client.new(id: nil, name: 'Emily', stylist_id: @stylist.id)
      client1.save
      client2.save
      expect(@stylist.clients).to eq [client1, client2]

    end
  end

end
