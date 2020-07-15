module RatingHelper
  def get_midle_rating(fanfic)
    all_fanfic_rating = fanfic.rating.all
    all_fanfic_rating.map(&:rate).sum.to_f / all_fanfic_rating.count
  end
end
