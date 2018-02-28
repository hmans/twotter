class LandingPageController < ApplicationController
  def root
    redirect_to current_user.present? ? timeline_path : global_path
  end
end
