require 'rails_helper'

RSpec.feature 'Deleting exercise' do

  before do
    @owner = User.create!(email: 'jon@example.com', password: 'password', last_name: 'Snow', first_name: 'Jon')
    login_as @owner

    @exercise = @owner.exercises.build(duration_in_min: 50, workout: 'Workout', workout_date: Date.today)
  end

  scenario 'An User can delete his own exercise' do
    visit '/'

    click_link 'My Lounge'
    link = "a[href='/users/#{@owner.id}/exercises/#{@exercise.id}'][data-method='delete']"
    find(link).click

    expect(page).to have_content 'Exercise has been deleted.'
    expect(page).not_to have_content 50
    expect(page.status_code).to eq 200
    expect(page.current_path).to eq user_exercises_path(@owner.id)
  end

end