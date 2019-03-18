class AchievementsController < ApplicationController
  before_action :login_required, only: %i[new create]

  def index
    @achievements = Achievement.includes(:users)
  end

  def new
    @achievement = Achievement.new
  end

  def create
    @achievement = Achievement.new(achievement_params)

    if @achievement.save
      bookmark = Bookmark.new(user_id: current_user.id,
                              achievement_id: @achievement.id,
                              status: params[:only_create] ? :locked : :unlocked)
      bookmark.save
      redirect_to params[:only_create] ? achievements_path : user_bookmark_path(current_user, bookmark)
    else
      render :new
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def achievement_params
    params.require(:achievement).permit(:title, :tag_list)
  end
end
