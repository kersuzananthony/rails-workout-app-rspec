require 'rails_helper'

RSpec.feature 'Signing User In' do

  before do
    @user = User.create!(email: 'jon.snow@example.com', password: 'password')
  end

  scenario 'An user sign in successfully' do
    visit '/'

    click_link 'Log In'

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'

    expect(page.status_code).to eq 200
    expect(page.current_path).to eq root_path
    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content "Signed in as #{@user.email}"
  end


end