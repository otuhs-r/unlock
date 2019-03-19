class AchievementsController < ApplicationController
  before_action :login_required, only: %i[new create]

  def index
    @achievements = Achievement.includes(:users)
  end

  def new
    @achievement = Achievement.new
    @titles_json = Achievement.all.map { |achievement| [achievement.title, nil] }.to_h.to_json
    @chips_json = ActsAsTaggableOn::Tag.all.map { |chip| [chip.name, nil] }.to_h.to_json
  end

  def create
    @achievement = Achievement.find_by(title: achievement_params[:title]) || Achievement.new(achievement_params)

    if @achievement.save
      create_bookmark(@achievement)
    else
      render :new
    end
  end

  def search
    search_words = params[:search].split.map { |word| "%#{word}%" }
    achievements_title_hit = Achievement.ransack(title_matches_any: search_words).result
    achievements_tag_hit = Achievement.tagged_with(params[:search].split, any: true, wild: true)
    @achievements = achievements_title_hit.to_a.concat(achievements_tag_hit.to_a)
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
