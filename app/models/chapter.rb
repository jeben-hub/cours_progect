class Chapter < ApplicationRecord
  belongs_to :fanfic
  searchkick
end
