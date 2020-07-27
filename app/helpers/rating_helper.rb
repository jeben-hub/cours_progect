module RatingHelper
  def get_midle_rating(fanfic)
    return 0  if (all_fanfic_rating = fanfic.rating.all).empty?
    all_fanfic_rating.map(&:rate).sum.to_f / all_fanfic_rating.count
  end
end
