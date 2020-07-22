class User < ApplicationRecord
  authenticates_with_sorcery!

  searchkick
  has_many :fanfics, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :rating, class_name: "Rating", dependent: :destroy


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

  def set_user_locale(locale)
    self.update_attribute("locale", locale)
  end

  def set_dark_theme
    self.update_attribute("dark_theme", !self.dark_theme)
  end
end
