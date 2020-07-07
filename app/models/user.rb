class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :fanfics, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :email, uniqueness: true, email_format: { message: 'has invalid format' }
  validates :name, uniqueness: true

  def admin?
    self.admin
  end

  def blocked?
    self.blocked
  end

  def active?
    self.activation_state == "active"
  end
end
