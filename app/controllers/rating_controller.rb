class RatingController < ApplicationController

  def create
    @rating = Rating.find_or_create_by(
      fanfic_id: params[:fanfic_id],
      user_id: current_user.id)
    @rating.rate = params[:value].to_i
    @rating.save
  end
end
