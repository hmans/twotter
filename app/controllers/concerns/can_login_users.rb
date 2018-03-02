module CanLoginUsers
  def login_user(user)
    session[:current_user_id] = user.id
  end

  def logout_user
    session[:current_user_id] = nil
  end
end
