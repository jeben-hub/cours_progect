module ApplicationHelper
  def has_access?(owner_id)
    return false unless current_user
    return current_user.id == owner_id || current_user.admin?
  end

  def current_user_admin?
    return false unless current_user
    return current_user.admin?
  end
end
