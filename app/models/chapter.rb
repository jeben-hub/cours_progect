class Chapter < ApplicationRecord
  belongs_to :fanfic
  has_many :likes, dependent: :destroy
  validates :body, presence: true, allow_blank: false
  validates :name, presence: true, allow_blank: false
  searchkick
end
