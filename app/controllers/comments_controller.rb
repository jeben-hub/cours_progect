class CommentsController < ApplicationController
  skip_before_action :require_login, only: [:index]
  skip_before_action :require_activate, only: [:index]
  skip_before_action :require_not_blocked, only: [:index]
  before_action :set_fanfic, except: [:destroy]


  def create
    @comment = @fanfic.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      ActionCable.server.broadcast "fanfic_#{@fanfic.id}", comments_data
    end
    redirect_to @fanfic
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user_id == current_user.id || current_user.admin?
      @comment.destroy
    else
      flash[:warning] = t("notice.access")
    end
    redirect_to @comment.fanfic
  end


  private

  def comments_data
    { content: @comment.body,
      user_name: current_user.name,
      datetime: @comment.created_at.strftime("%m/%d/%Y at %I:%M%p")}
   end

  def set_fanfic
    @fanfic = Fanfic.find(params[:fanfic_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
