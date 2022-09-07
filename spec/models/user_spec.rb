# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email)}
    it { should validate_presence_of(:password)}
    it { should validate_presence_of(:password_confirmation)}
    it { should have_secure_password}
  end
  describe 'relationships' do
    it { should have_many :party_users }
    it { should have_many(:parties).through(:party_users) }
  end

  describe 'class methods' do
    before :each do
      @terry = User.create!(name: 'terry', email: 'terry@example.com', password: '123', password_confirmation: '123')
      @susie = User.create!(name: 'susie', email: 'susie@example.com', password: 'abc', password_confirmation: 'abc')
      @john = User.create!(name: 'John', email: 'john@example.com', password: 'abc123', password_confirmation: 'abc123')

      @hannibal = Party.create!(movie_id: 109_445, movie_title: 'hannibal', start_time: '2022-12-25 06:30:00 UTC',
                              duration: 90)
      @tombstone = Party.create!(movie_id: 2_277_834, movie_title: 'tombstone', start_time: '2022-12-31 12:00:00 UTC',
                             duration: 120)

      @th = PartyUser.create!(party: @hannibal, user: @terry, host: true)
      @sh = PartyUser.create!(party: @hannibal, user: @susie, host: false)
      @jh = PartyUser.create!(party: @hannibal, user: @john, host: false)
      @st = PartyUser.create!(party: @tombstone, user: @susie, host: true)
      @tt = PartyUser.create!(party: @tombstone, user: @terry, host: false)
    end

    it 'can find hosted party users' do
      expect(@terry.hosting).to eq([@th])
      expect(@susie.hosting).to eq([@st])
      expect(@john.hosting).to eq([])
    end

    it 'can find invited party users' do
      expect(@terry.invited).to eq([@tt])
      expect(@susie.invited).to eq([@sh])
      expect(@john.invited).to eq([@jh])
    end
  end
end
