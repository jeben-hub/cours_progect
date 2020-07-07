class UsersController < ApplicationController
  include ApplicationHelper
  skip_before_action :require_login, only: [:new, :create, :activate, :show]
  skip_before_action :require_not_blocked, only: [:show, :destroy]
  before_action :set_user, only: [:make_admin, :block, :unblock, :show, :destroy]
  before_action :require_admin, only: [:make_admin, :block, :unblock, :index]
  before_action :admin_protect, only: [:make_admin, :block, :unblock, :destroy]

  def index
    @users = User.all
  end

  def make_admin
    @user.update_attribute("admin", true)
    redirect_back(fallback_location: user_path)
  end

  def block
    @user.update_attribute("blocked", true)
    redirect_back(fallback_location: user_path)
  end

  def unblock
    @user.update_attribute("blocked", false)
    redirect_back(fallback_location: user_path)
  end

  def new
    @user = User.new
  end

  def show
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

  def admin_protect
    return unless @user.admin?
    redirect_back fallback_location: root_path, alert: 'You have no asses to do this with admin'
  end

  def require_admin
    return if current_user.admin?
    redirect_back_or_to root_path, alert: 'You have no asses to do this'
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
