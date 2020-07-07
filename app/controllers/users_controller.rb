class UsersController < ApplicationController
  include ApplicationHelper
  skip_before_action :require_login, only: [:new, :create, :activate, :show]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @fanfics = @user.fanfics.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(params[:user][:email], params[:user][:password])
      flash[:warning] = 'Activation message sent to ' + @user.email
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    if has_access?(params[:id].to_i)
      @user = User.find(params[:id])
      @user.destroy
    else
      flash[:warning] = 'Cannot delete this user.'
    end
    redirect_to root_path
  end

  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      flash[:success] = 'User was successfully activated.'
    else
      flash[:warning] = 'Cannot activate this user.'
    end
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
