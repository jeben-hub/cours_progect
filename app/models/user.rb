class User < ApplicationRecord
  authenticates_with_sorcery!

  searchkick
  has_many :fanfics, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy


  validates :password, length: { minimum: 6 }, if: -> {new_record? || changes[:crypted_password]}
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

  def deactivate
    self.update_attribute("activation_state", "pending")
    self.update_attribute("activation_token", Sorcery::Model::TemporaryToken.generate_random_token)
  end
end
