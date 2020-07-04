module FanficsHelper
  def fanfic_user(fanfic)
    User.find(fanfic.user_id)
  end
end
