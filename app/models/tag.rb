class Tag < ApplicationRecord
  has_many :taggings
  has_many :fanfics, through: :taggings
  searchkick word_start: [:name]

end
