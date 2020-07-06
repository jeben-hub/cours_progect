class Fanfic < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  def author
    User.find(self.user_id)
  end
end
