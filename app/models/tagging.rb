class Tagging < ApplicationRecord
  belongs_to :fanfic
  belongs_to :tag
end
