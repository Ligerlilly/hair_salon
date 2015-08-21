require 'capybara/rspec'
require './app'
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe 'hair_salon path', { type: :feature } do
  it 'should be able to add a stylist' do
    visit '/'
    click_link("Stylists", :match => :first)
    fill_in 'name', with: 'Gordon'
    click_button 'Submit'
    expect(page).to have_content "Gordon"
  end

  it 'should be able to add a client' do
    visit '/'
    click_link("Client", :match => :first)
    fill_in 'name', with: 'Maureen'
    click_button 'Submit'
    expect(page).to have_content "Maureen"
  end

  it 'should be able to go to an individual client page' do
    @client = Client.new({ name: 'Katy', id: nil, stylist_id: nil })
    @client.save
    visit '/clients'
    click_link "Katy"
    expect(page).to have_content 'Client: Katy'
  end

  it 'should be able to go to an individual stylist page' do
    @client = Stylist.new({ name: 'Mark', id: nil })
    @client.save
    visit '/stylists'
    click_link "Mark"
    expect(page).to have_content 'Stylist: Mark'
  end

  it 'should be able to delete a stylist' do
    @stylist = Stylist.new({ name: 'George', id: nil })
    @stylist.save
    visit '/stylists'
    click_link 'George'
    click_button 'Delete'
    expect(page).not_to have_content 'George'
  end

  it 'should be able to delete a client' do
    @client = Client.new({ name: 'Maria', stylist_id: nil, id: nil })
    @client.save
    visit '/clients'
    click_link 'Maria'
    click_button 'Delete'
    expect(page).not_to have_content 'George'
  end
end
