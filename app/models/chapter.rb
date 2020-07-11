class Chapter < ApplicationRecord
  belongs_to :fanfic
  has_many :likes, dependent: :destroy

  searchkick
end
