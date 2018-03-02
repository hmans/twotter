concern :ProvidesCurrentUser do
  included do
    helper_method :current_user, :current_user?
  end

  def current_user
    @current_user ||= load_current_user
  end

  def current_user?
    current_user.present?
  end

  private

  def load_current_user
    if session[:current_user_id].present?
      User.find(session[:current_user_id])
    end
  rescue ActiveRecord::NotFoundError
    nil
  end
end
