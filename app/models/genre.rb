class Genre < ApplicationRecord
  has_many :fanfics
  searchkick
end
