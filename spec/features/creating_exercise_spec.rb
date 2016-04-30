require 'rails_helper'

RSpec.feature 'Creating exercise' do

  before do
    @user = User.create!(email: 'jon.snow@example.com', password: 'password')
    login_as @user
  end

  scenario 'An signed in user can created an exercise' do
    visit '/'

    click_link 'My Lounge'
    click_link 'New Workout'

    expect(page).to have_link 'Back'

    fill_in 'Duration', with: 70
    fill_in 'Workout Details', with: 'Weight lifting'
    fill_in 'Activity date', with: '2015-09-07'
    click_button 'Add Exercise'

    expect(page.status_code).to eq 200
    expect(page).to have_content 'Exercise has been created.'

    last_exercise = Exercise.last
    expect(page.current_path).to eq user_exercise_path(@user, last_exercise)
  end

end