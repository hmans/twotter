class UsersController < ApplicationController
  before_action :load_user, except: [:show]
  before_action :require_user, except: [:show]

  def show
    @user = User.includes(:posts).find(params[:id])
  end

  def follow
    current_user.follow!(@user)
    redirect_back fallback_location: @user,
      notice: "You now follow #{@user.full_name}."
  end

  def unfollow
    current_user.unfollow!(@user)
    redirect_back fallback_location: @user,
      notice: "You no longer follow #{@user.full_name}."
  end

  private

  def load_user
    @user = User.find(params[:id])
  end
end
