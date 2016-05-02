require 'rails_helper'

RSpec.feature 'Following friends' do

  before do
    @jon = User.create!(email: 'jon@example.com', password: 'password', last_name: 'Snow', first_name: 'Jon')
    @sansa = User.create!(email: 'sansa@example.com', password: 'password', last_name: 'Sansa', first_name: 'Stark')

    login_as @jon
  end

  scenario 'An User can follow another member' do
    visit '/'

    expect(page).to have_content @sansa.full_name
    expect(page).to have_content @jon.full_name

    expect(page).not_to have_link('Follow', :href => "/friendships?friend_id=#{@jon.id}")
    expect(page).to have_link('Follow', :href => "/friendships?friend_id=#{@sansa.id}")
    link = "a[href='/friendships?friend_id=#{@sansa.id}']"
    find(link).click

    expect(page).not_to have_link('Follow', :href => "/friendships?friend_id=#{@sansa.id}")
  end

end