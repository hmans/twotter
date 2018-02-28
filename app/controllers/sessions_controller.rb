class SessionsController < ApplicationController
  def new
  end

  def create
    if user = find_user.try(:authenticate, password)
      session[:current_user_id] = user.id
      redirect_to :root, notice: "Welcome back!"
    else
      flash.now[:error] = "Login attempt failed."
      render 'new'
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to :root, notice: "You have been logged out."
  end

  private

  def password
    params[:login][:password]
  end

  def name_or_email
    params[:login][:name_or_email]
  end

  def find_user
    User.find_by(name: name_or_email) ||
      User.find_by(email: name_or_email)
  end
end
