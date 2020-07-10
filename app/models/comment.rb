class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :fanfic
  searchkick
  validates :body, presence: true, allow_blank: false
end
