require 'rails_helper'

RSpec.feature 'Listing exercises' do

  before do
    @user = User.create!(email: 'jon@example.com', password: 'password')
    login_as @user

    @exercise1 = @user.exercises.build(duration_in_min: 70, workout: 'Exercise 1', workout_date: '2016-04-05')
    @exercise2 = @user.exercises.build(duration_in_min: 20, workout: 'Exercise 2', workout_date: '2016-04-06')
  end

  scenario 'Shows user\'s workout for last 7 days' do
    visit '/'

    click_link 'My Lounge'

    expect(page).to have_content @exercise1.duration_in_min
    expect(page).to have_content @exercise1.workout
    expect(page).to have_content @exercise1.workout_date
    expect(page).to have_content @exercise2.duration_in_min
    expect(page).to have_content @exercise2.workout
    expect(page).to have_content @exercise2.workout_date
    expect(page.current_path).to eq user_exercises_path(@user)
    expect(page.status_code).to eq 200
  end

end