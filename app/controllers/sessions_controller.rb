class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  skip_before_action :require_not_blocked
  skip_before_action :require_activate

  def new
  end

  def create
    if login(params[:email], params[:password])
      redirect_back_or_to root_path
    else
      flash.now[:warning] = t("notice.incorrect")
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to log_in_path
  end
end
