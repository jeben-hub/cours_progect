class Fanfic < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :chapters, -> { order(:number) }, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :rating, class_name: "Rating", dependent: :destroy
  validates :title, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false

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

  def self.top(count)
    Fanfic.all.sort {|a, b| b.midle_rating <=> a.midle_rating }.first(count)
  end

  def midle_rating
    return 1 if (rates = self.rating.all).empty?
    rates.map(&:rate).sum.to_f / rates.count
  end

end
