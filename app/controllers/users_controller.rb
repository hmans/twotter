class UsersController < ApplicationController
  before_action :load_user, except: [:new, :create, :show]
  before_action :require_user, except: [:new, :create, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user(@user)
      redirect_to :timeline, notice: "Welcome to TWOTTER!"
    else
      render :new
    end
  end

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

  def user_params
    params
      .require(:user)
      .permit(%w[name full_name email password password_confirmation])
  end
end
