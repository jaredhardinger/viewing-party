class User < ApplicationRecord
  has_many :party_users
  has_many :parties, through: :party_users
  validates_presence_of :name
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :password_confirmation

  has_secure_password

  enum role: %w(default admin)

  def hosting
    party_users.where(host: true)
  end

  def invited
    party_users.where(host: false)
  end
end
