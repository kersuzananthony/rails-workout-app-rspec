require 'rails_helper'

RSpec.feature 'Editing exercise do' do

  before do
    @owner = User.create!(email: 'jon@example.com', password: 'password', last_name: 'Snow', first_name: 'Jon')
    login_as @owner

    @exercise = @owner.exercises.build(duration_in_min: 50, workout: 'Workout', workout_date: Date.today)
  end

  scenario 'Edit with valid inputs' do
    go_to_edit_page

    fill_in 'Duration', with: 30
    click_button 'Update Exercise'

    expect(page).to have_content 'Exercise has been updated.'
    expect(page).to have_content 30
    expect(page).not_to have_content 50
    expect(page.status_code).to eq 200
    expect(page.current_path).to eq user_exercise_path(@owner.id, @exercise.id)
  end

  scenario 'Edit with invalid inputs' do
    go_to_edit_page

    fill_in 'Duration', with: nil
    click_button 'Update Exercise'

    expect(page).to have_content 'Exercise has not been updated.'
    expect(page.current_path).to eq user_exercise_path(@owner.id, @exercise.id)
  end

  def go_to_edit_page
    visit '/'

    click_link 'My Lounge'
    link = "a[href='/users/#{@owner.id}/exercises/#{@exercise.id}/edit']"
    find(link).click
  end

end