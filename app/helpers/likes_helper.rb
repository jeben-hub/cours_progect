module LikesHelper
  def pre_like(chapter)
    return nil unless current_user
    chapter.likes.find { |like| like.user_id == current_user.id}
  end
end
