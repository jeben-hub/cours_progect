class CommentsController < ApplicationController
  skip_before_action :require_login, only: [:index]
  skip_before_action :require_activate, only: [:index]
  skip_before_action :require_not_blocked, only: [:index]
  before_action :set_fanfic, except: [:destroy]


  def index
    @comments = @fanfic.comments.order(created_at: :desc)
  end

  def create
    @comment = @fanfic.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to @fanfic
    #render json: { errors: @comment.errors }, status: :unprocessable_entity unless @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user_id == current_user.id || current_user.admin?
      @comment.destroy
    else
      flash[:warning] = 'You have no asses to do this.'
    end
    redirect_to @comment.fanfic
  end


  private

  def set_fanfic
    @fanfic = Fanfic.find(params[:fanfic_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
