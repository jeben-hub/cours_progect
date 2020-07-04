module ApplicationHelper
  def has_access?(owner)
    return current_user.id == owner.id #current_user.admin?
  end
end
