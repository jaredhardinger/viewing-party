# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Register' do
  before :each do
    @john = User.create!(name: 'john', email: 'john@example.com')

    visit '/register'
  end

  it 'can register user' do
    fill_in 'Name', with: 'Susie'
    fill_in 'Email', with: 'susie@example.com'
    click_on 'Create User'
    expect(current_path).to eq("/users/#{@john.id + 1}")
    expect(page).to have_content("Susie's Dashboard")
    expect(page).to_not have_content("john's Dashboard")
  end

  it 'sad path testing 1' do # no name
    fill_in 'Email', with: 'susie@example.com'
    click_on 'Create User'
    expect(current_path).to eq('/register')
    expect(page).to_not have_content("Susie's Dashboard")
  end

  it 'sad path testing 2' do # duplicate email
    fill_in 'Name', with: 'Susie'
    fill_in 'Email', with: 'john@example.com'
    click_on 'Create User'
    expect(current_path).to eq('/register')
    expect(page).to_not have_content("Susie's Dashboard")
  end

  it 'has link to landing page' do
    expect(page).to have_link('Home')
    click_on 'Home'
    expect(current_path).to eq('/')
  end

  it "creates new user" do
    username = "funbucket13"
    password = "test"

    fill_in :username, with: username
    fill_in :password, with: password

    click_on "Create User"

    expect(page).to have_content("Welcome, #{username}!")
  end
end
