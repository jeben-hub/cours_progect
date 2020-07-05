class Fanfic < ApplicationRecord
  belongs_to :user

  def author
    User.find(self.user_id)
  end
end
