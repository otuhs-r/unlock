class BookmarksController < ApplicationController
  before_action :login_required
  before_action :correct_user

  def create
    @bookmark = Bookmark.new(user_id: current_user.id,
                             achievement_id: bookmark_params[:achievement_id],
                             status: :locked)
    @bookmark.save
    redirect_to achievements_path
  end

  def update
    @bookmark = current_user.bookmarks.find(params[:id])
    @bookmark.reverse.save

    respond_to do |format|
      format.html { redirect_back(fallback_location: user_path(current_user)) }
      format.js
    end
  end

  def destroy
    @bookmark = current_user.bookmarks.find(params[:id])
    @bookmark.destroy
    redirect_to edit_user_path(current_user)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:achievement_id)
  end

  def correct_user
    user = User.find(params[:user_id])
    redirect_to root_path unless user == current_user
  end
end
