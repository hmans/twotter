concern :HandlesAuthorization do
  def require_user
    unless current_user?
      redirect_to :root
    end
  end
end
