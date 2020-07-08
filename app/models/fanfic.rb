class Fanfic < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :chapters, dependent: :destroy

  def author
    User.find(self.user_id)
  end
end
