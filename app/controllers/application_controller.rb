class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :require_not_blocked
  before_action :require_activate

  private

  def not_authenticated
    flash[:warning] = 'You have to authenticate to access this page.'
    redirect_to log_in_path
  end

  def require_not_blocked
    return unless current_user.blocked?
    redirect_to user_path(current_user), alert: 'Your accoun has blocked'
  end

  def require_activate
    return if current_user.active?
    redirect_to user_path(current_user), alert: 'You have to activate your account'
  end

end
