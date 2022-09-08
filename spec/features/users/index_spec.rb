# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do
    @john = User.create!(name: 'john', email: 'john@example.com', password: 'abc', password_confirmation: 'abc')
    @susie = User.create!(name: 'susie', email: 'susie@example.com', password: '123', password_confirmation: '123')

    visit '/'
  end

  it 'contains app title' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has button to create user' do
    expect(page).to have_button('Create New User')
    click_button 'Create New User'
    expect(current_path).to eq('/register')
  end

  it 'lists existing users with links to dashboard' do
    within "#user-#{@john.id}" do
      expect(page).to have_link('john')
    end

    within "#user-#{@susie.id}" do
      expect(page).to have_link('susie')
      click_on 'susie'
      expect(current_path).to eq("/users/#{@susie.id}")
    end
  end

  it 'has link to landing page' do
    expect(page).to have_link('Home')
    click_on 'Home'
    expect(current_path).to eq('/')
  end

  it "can log in with valid credentials" do
    click_on "Log In"

    expect(current_path).to eq(login_path)

    fill_in :email, with: @john.email
    fill_in :password, with: @john.password

    click_on "Log In"

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Welcome, #{@john.name}")
  end
  
  it "cannot log in with bad credentials" do
    visit login_path

    fill_in :email, with: @john.email
    fill_in :password, with: "incorrect password"

    click_on "Log In"

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Sorry, your credentials are bad.")
  end
end
