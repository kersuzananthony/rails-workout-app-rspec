require 'rails_helper'
require 'date'

RSpec.feature 'Creating exercise' do

  before do
    @user = User.create!(email: 'jon.snow@example.com', password: 'password')
    login_as @user
  end

  scenario 'An signed in user can created an exercise' do
    go_to_exercise_form

    fill_in 'Duration', with: 70
    fill_in 'Workout Details', with: 'Weight lifting'
    fill_in 'Activity date', with: Date.today
    click_button 'Add Exercise'

    expect(page.status_code).to eq 200
    expect(page).to have_content 'Exercise has been created.'

    last_exercise = Exercise.last
    expect(page.current_path).to eq user_exercise_path(@user, last_exercise)
  end

  scenario 'An signed in user cannot create an exercise due to invalid inputs' do
    go_to_exercise_form

    fill_in 'Duration', with: nil
    fill_in 'Workout Details', with: ''
    fill_in 'Activity date', with: ''
    click_button 'Add Exercise'

    expect(page).to have_content 'Exercise has not been created.'
    expect(page).to have_content 'Duration in min can\'t be blank'
    expect(page).to have_content 'Duration in min is not a number'
    expect(page).to have_content 'Workout can\'t be blank'
    expect(page).to have_content 'Workout date can\'t be blank'
  end

  private
  def go_to_exercise_form
    visit '/'

    click_link 'My Lounge'
    click_link 'New Workout'

    expect(page).to have_link 'Back'
  end

end