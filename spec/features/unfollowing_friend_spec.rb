require 'rails_helper'

RSpec.feature 'Unfollowing Friend' do

  before do
    @jon = User.create!(email: 'jon@example.com', password: 'password', last_name: 'Snow', first_name: 'Jon')
    @sansa = User.create!(email: 'sansa@example.com', password: 'password', last_name: 'Stark', first_name: 'Sansa')

    login_as @jon

    @following = Friendship.create(user: @jon, friend: @sansa)
  end

  scenario 'An User can unfollow a friend' do
    visit '/'

    click_link 'My Lounge'

    expect(page).to have_link @sansa.full_name

    link = "a[href='/friendships/#{@following.id}'][data-method='delete']"

    find(link).click

    expect(page).to have_content(@sansa.full_name + ' unfollowed')

    expect(page.current_path).to eq user_exercises_path(@jon.id)
    expect(page).not_to have_link @sansa.full_name
  end

end