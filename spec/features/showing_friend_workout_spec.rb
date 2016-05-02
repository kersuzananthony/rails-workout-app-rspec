require 'rails_helper'

RSpec.feature 'Showing Friend Workout' do

  before do
    @user = User.create!(email: 'jon@example.com', password: 'password', last_name: 'Snow', first_name: 'Jon')
    @user2 = User.create!(email: 'sansa@example.com', password: 'password', last_name: 'Stark', first_name: 'Sansa')
    login_as @user

    @exercise1 = @user.exercises.build(duration_in_min: 70, workout: 'Exercise 1', workout_date: Date.today)
    @exercise2 = Exercise.create(duration_in_min: 20, workout: 'Exercise 2', workout_date: Date.today, user_id: @user2.id)

    @following = Friendship.create(user: @user, friend: @user2)
  end

  scenario 'Shows friend\'s workout for last 7 days' do
    visit '/'

    click_link 'My Lounge'
    click_link @user2.full_name

    expect(page).to have_content(@user2.full_name + "'s Exercises")
    expect(page).to have_content(@exercise2.workout)
    expect(page).to have_css 'div#chart'
  end

end