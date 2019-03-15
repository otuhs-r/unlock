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
      redirect_to achievements_path
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
