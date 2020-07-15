class Fanfic < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :chapters, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :rating, class_name: "Rating", dependent: :destroy

  searchkick

  def author
    User.find(self.user_id)
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip.downcase).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end
end
