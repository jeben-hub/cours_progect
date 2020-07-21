class UsersController < ApplicationController
  include ApplicationHelper
  skip_before_action :require_login, only: [:new, :create, :activate, :show, :update_attribute_on_the_spot, :user_locale]
  skip_before_action :require_not_blocked, only: [:new, :create, :show, :destroy, :update_attribute_on_the_spot, :user_locale]
  skip_before_action :require_activate, only: [:activate, :new, :create, :show, :destroy, :update_attribute_on_the_spot, :user_locale]
  before_action :set_user, only: [:make_admin, :block, :unblock, :show, :destroy]
  before_action :require_admin, only: [:make_admin, :block, :unblock, :index]
  before_action :admin_protect, only: [:make_admin, :block, :unblock, :destroy]
  before_action :save_email, only: [:update_attribute_on_the_spot]

  can_edit_on_the_spot is_allowed: :check_access_to_edit, on_success: :new_email

  def user_locale
    User.find(current_user.id).set_user_locale(available_locale) if current_user
    redirect_to root_path
  end

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

  protected

  def check_access_to_edit(object, field)
    return has_access?(object.id.to_i) && current_user.active? && !(current_user.blocked?)
  end

  def new_email(updated_object, field, value)
    if field == "email" && email_is_new?(value)
      new_email_confirm(updated_object)
    end
  end

  private

  def available_locale
    I18n.available_locales.map(&:to_s).include?(params[:locale]) ? params[:locale] : :en
  end

  def email_is_new?(new_email)
    @old_email != new_email
  end

  def save_email
    @old_email = User.find(params[:id].split("__").last).email
  end

  def new_email_confirm(user)
    user.deactivate
    UserMailer.activation_needed_email(user).deliver_later
    flash[:warning] = 'Activation message sent to ' + user.email
  end

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
