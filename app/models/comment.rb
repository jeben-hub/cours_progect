class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :fanfic

  validates :body, presence: true, allow_blank: false
end
