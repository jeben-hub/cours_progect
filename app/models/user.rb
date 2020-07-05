class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :fanfics
  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :email, uniqueness: true, email_format: { message: 'has invalid format' }
  validates :name, uniqueness: true

  def self.admin?
    self.admin
  end

  def self.blocked?
    self.blocked
  end
end
