class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :require_not_blocked
  before_action :require_activate
  before_action :set_locale

  private

  def default_url_options
    { locale: I18n.locale }
  end

  def not_authenticated
    flash[:warning] = t("notice.authenticate")
    redirect_to log_in_path
  end

  def require_not_blocked
    return unless current_user.blocked?
    redirect_to user_path(current_user), alert: t("notice.blocked")
  end

  def require_activate
    return if current_user.active?
    redirect_to user_path(current_user), alert: t("notice.activate")
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
    I18n.locale = current_user.locale if current_user
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

end
