# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Register' do
  before :each do
    @john = User.create!(name: 'john', email: 'john@example.com', password: '123', password_confirmation: '123')

    visit '/register'
  end

  it 'can register user' do
    fill_in :user_name, with: 'Susie'
    fill_in :user_email, with: 'susie@example.com'
    fill_in :user_password, with: '123'
    fill_in :user_password_confirmation, with: '123'
    click_on 'Create User'
    expect(current_path).to eq("/users/#{User.last.id}")
    expect(page).to have_content("Susie's Dashboard")
    expect(page).to_not have_content("john's Dashboard")
  end

  it 'sad path no name' do # no name
    fill_in :user_email, with: 'susie@example.com'
    fill_in :user_password, with: '123'
    fill_in :user_password_confirmation, with: '123'
    click_on 'Create User'
    expect(current_path).to eq('/register')
    expect(page).to have_content("Name can't be blank")
  end

  it 'sad path duplicate email' do 
    fill_in :user_name, with: 'Susie'
    fill_in :user_email, with: 'john@example.com'
    fill_in :user_password, with: '123'
    fill_in :user_password_confirmation, with: '123'
    click_on 'Create User'
    expect(current_path).to eq('/register')
    expect(page).to have_content("Email has already been taken")
  end

  it 'sad path no email' do 
    fill_in :user_name, with: 'Susie'
    fill_in :user_password, with: '123'
    fill_in :user_password_confirmation, with: '123'
    click_on 'Create User'
    expect(current_path).to eq('/register')
    expect(page).to have_content("Email can't be blank")
  end

  it 'sad path no password' do 
    fill_in :user_name, with: 'Susie'
    fill_in :user_email, with: 'john@example.com'
    fill_in :user_password_confirmation, with: '123'
    click_on 'Create User'
    expect(current_path).to eq('/register')
    expect(page).to have_content("Password can't be blank")
  end

  it 'sad path no password confirmation' do 
    fill_in :user_name, with: 'Susie'
    fill_in :user_email, with: 'john@example.com'
    fill_in :user_password, with: '123'
    click_on 'Create User'
    expect(current_path).to eq('/register')
    expect(page).to have_content("Password confirmation can't be blank")
  end

  it 'sad path password and password confirmation must match' do 
    fill_in :user_name, with: 'Susie'
    fill_in :user_email, with: 'john@example.com'
    fill_in :user_password, with: '123'
    fill_in :user_password_confirmation, with: 'abc'
    click_on 'Create User'
    expect(current_path).to eq('/register')
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  it 'has link to landing page' do
    expect(page).to have_link('Home')
    click_on 'Home'
    expect(current_path).to eq('/')
  end

  it "creates new user" do
    name = "funbucket13"
    email = "funbucket13@example.com"
    password = "test"

    fill_in :user_name, with: name
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password

    click_on "Create User"

    expect(page).to have_content("Welcome, #{name}!")
  end
end
