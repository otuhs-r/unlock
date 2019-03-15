class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.all.order(taggings_count: :desc)
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @achievements = Achievement.tagged_with(@tag)
  end
end
