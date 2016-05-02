require 'rails_helper'

RSpec.feature 'Signing User Up' do

  scenario 'An User Sign Up Successfully' do
    visit '/'

    click_link 'Log In'
    click_link 'Sign up'

    fill_in 'Email', with: 'jon.snow@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'First name', with: 'Jon'
    fill_in 'Last name', with: 'Snow'
    click_button 'Sign up'

    expect(page).to have_content 'You have signed up successfully.'
    expect(page.current_path).to eq root_path
    expect(page.status_code).to eq 200

    visit '/'
    expect(page).to have_content 'Jon Snow'
  end

  scenario 'An User Sign Up with invalid credentials' do
    visit '/'

    click_link 'Log In'
    click_link 'Sign up'

    fill_in 'Email', with: 'jon.snow@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'First name', with: ''
    fill_in 'Last name', with: ''
    click_button 'Sign up'

    expect(page).to have_content 'First name can\'t be blank'
    expect(page).to have_content 'Last name can\'t be blank'
  end
end