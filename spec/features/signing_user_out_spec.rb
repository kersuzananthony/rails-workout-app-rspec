require 'rails_helper'

RSpec.feature 'Signing user out' do

  before do
    @user = User.create!(email: 'jon.snow@example.com', password: 'password')

    visit '/'

    click_link 'Log In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end

  scenario 'An user log out successfully' do
    visit '/'

    click_link 'Log Out'

    expect(page.status_code).to eq 200
    expect(page.current_path).to eq root_path
    expect(page).to have_content 'Signed out successfully.'
  end

end