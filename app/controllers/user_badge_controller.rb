class UserBadgeController < ApplicationController

  def index
    @user_badges = current_user.badges
  end

end
