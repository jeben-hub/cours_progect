module LikesHelper
  def pre_like(chapter)
    return nil unless current_user
    chapter.likes.find { |like| like.user_id == current_user.id}
  end

  def likes_count(chapter)
    chapter.likes.count.to_s + (chapter.likes.count == 1 ? ' Like' : ' Likes')
  end
end
