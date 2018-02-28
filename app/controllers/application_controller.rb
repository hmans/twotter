class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :current_user?

  def current_user
    @current_user ||= load_current_user
  end

  def current_user?
    current_user.present?
  end

  def load_current_user
    if session[:current_user_id].present?
      User.find(session[:current_user_id])
    end
  rescue ActiveRecord::NotFoundError
    nil
  end

  def require_user
    unless current_user?
      redirect_to :root
    end
  end
end
