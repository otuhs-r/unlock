class AchievementsController < ApplicationController
  before_action :login_required, only: %i[new create]

  def index
    @achievements = Achievement.includes(:users)
  end

  def new
    @achievement = Achievement.new
  end

  def create
    @achievement = Achievement.find_by(title: achievement_params[:title]) || Achievement.new(achievement_params)

    if @achievement.save
      create_bookmark(@achievement)
    else
      render :new
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def achievement_params
    params.require(:achievement).permit(:title, :tag_list)
  end

  def create_bookmark(achievement)
    bookmark = Bookmark.new(user_id: current_user.id,
                            achievement_id: achievement.id,
                            status: params[:only_create] ? :locked : :unlocked)
    if bookmark.save
      redirect_to params[:only_create] ? user_path(current_user) : user_bookmark_path(current_user, bookmark)
    else
      render :new
    end
  end
end
