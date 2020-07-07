class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :require_not_blocked

  private

  def not_authenticated
    flash[:warning] = 'You have to authenticate to access this page.'
    redirect_to log_in_path
  end

  def require_not_blocked
    return unless current_user.blocked?
    redirect_to user_path(current_user), alert: 'Your accoun has blocked'
  end

end
