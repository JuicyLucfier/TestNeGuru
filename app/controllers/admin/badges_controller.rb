class Admin::BadgesController < Admin::BaseController
  before_action :find_badge, only: %i[show update edit destroy]

  def index
    @badges = Badge.all
    @user_badges = current_user.badges
  end

  def show; end

  def new
    @badge = Badge.new
  end

  def create
    @badge = Badge.new(badge_params)

    if @badge.save
      redirect_to admin_badge_url(@badge)
    else
      render :new
    end
  end

  def update
    if @badge.update(badge_params)
      redirect_to admin_badge_url(@badge)
    else
      render :edit
    end
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_path
  end

  private

  def badge_params
    params.require(:badge).permit(:title, :image, :rule, :parameter)
  end

  def find_badge
    @badge = Badge.find(params[:id])
  end

end
