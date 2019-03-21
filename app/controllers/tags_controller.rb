class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.all.order(taggings_count: :desc).page(params[:page]).per(10)
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @achievements = Achievement.tagged_with(@tag).page(params[:page]).per(10)
  end
end
