module ApplicationHelper
  def has_access?(owner_id)
    return false unless current_user
    return current_user.id == owner_id || current_user.admin?
  end
end
