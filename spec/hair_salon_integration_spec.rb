require 'capybara/rspec'
require './app'
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe 'hair_salon path', { type: :feature } do
  it 'should be able to add a stylist' do
    visit '/'
    click_link 'Stylists'
    fill_in 'name', with: 'Gordon'
    click_button 'Submit'
    expect(page).to have_content "Gordon"
  end
end
