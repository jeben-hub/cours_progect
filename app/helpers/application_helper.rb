module ApplicationHelper
  def has_access?(owner_id)
    return current_user.id == owner_id || current_user.admin?
  end
end
