require 'rails_helper'

RSpec.feature 'Accessing Home Page' do

  scenario 'An User Visit the Homepage' do
    visit '/'

    expect(page).to have_link 'Athletes Den'
    expect(page).to have_link 'Home'
    expect(page).to have_content 'Workout Lounge'
    expect(page.current_path).to eq root_path
    expect(page.status_code).to eq 200
  end

end