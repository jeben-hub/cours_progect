class LikesController < ApplicationController
  before_action :find_chapter
  before_action :find_like, only: [:destroy]


  def create
    @chapter.likes.create(user_id: current_user.id) unless already_liked?
    redirect_to fanfic_chapter_path(@chapter.fanfic, @chapter)
  end

  def destroy
    @like.destroy if already_liked?
    redirect_to fanfic_chapter_path(@chapter.fanfic, @chapter)
  end


  private

  def find_like
   @like = @chapter.likes.find { |like| like.user_id == current_user.id}
  end


  def find_chapter
    @chapter = Chapter.find(params[:chapter_id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, chapter_id: params[:chapter_id]).exists?
  end

end
