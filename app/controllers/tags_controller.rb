class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.all.order(taggings_count: :desc).page(params[:page]).per(10)
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @achievements = Achievement.left_joins(:bookmarks).tagged_with(@tag).group(:id).order(Arel.sql('count(user_id) desc')).page(params[:page]).per(10)
  end
end
