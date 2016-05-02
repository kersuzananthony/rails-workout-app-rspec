require 'rails_helper'

RSpec.feature 'Searching for Users' do

  before do
    @jon = User.create!(email: 'jon.snow@example.com', password: 'password', first_name: 'Jon', last_name: 'Stark')
    @sansa = User.create!(email: 'sansa.stark@example.com', password: 'password', first_name: 'Sansa', last_name: 'Stark')
  end

  scenario 'With existing name returns all those users' do
    visit '/'

    fill_in 'search_name', with: 'Stark'
    click_button 'Search'

    expect(page).to have_content @jon.full_name
    expect(page).to have_content @sansa.full_name
    expect(page.current_path).to eq '/dashboard/search'
  end
end