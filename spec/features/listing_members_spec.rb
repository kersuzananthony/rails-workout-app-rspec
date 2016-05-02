require 'rails_helper'

RSpec.feature 'Listing Members' do

  before do
    @jon = User.create!(email: 'jon.snow@example.com', password: 'password', first_name: 'Jon', last_name: 'Snow')
    @sansa = User.create!(email: 'sansa.stark@example.com', password: 'password', first_name: 'Sansa', last_name: 'Stark')
  end

  scenario 'An User can see a list of other members' do
    visit '/'

    expect(page.status_code).to eq 200
    expect(page.current_path).to eq root_path
    expect(page).to have_content 'List of Members'
    expect(page).to have_content @jon.full_name
    expect(page).to have_content @sansa.full_name
  end

end