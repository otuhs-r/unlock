class BookmarksController < ApplicationController
  before_action :login_required, except: :show
  before_action :correct_user, except: :show

  def create
    @bookmark = Bookmark.new(user_id: current_user.id,
                             achievement_id: bookmark_params[:achievement_id],
                             status: :locked)
    if @bookmark.save
      render
    else
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:user_id])
    @bookmark = @user.bookmarks.find(params[:id])
    redirect_to root_path if @bookmark.locked?
  end

  def update
    @bookmark = current_user.bookmarks.find(params[:id])
    @bookmark.reverse
    @bookmark.unlock_date = unlock_date if @bookmark.unlocked?
    @bookmark.save
  end

  def destroy
    @bookmark = current_user.bookmarks.find(params[:id])
    @bookmark.destroy
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:achievement_id, :unlock_date)
  end

  def correct_user
    user = User.find(params[:user_id])
    redirect_to root_path unless user == current_user
  end

  def unlock_date
    bookmark_params[:unlock_date].present? ? bookmark_params[:unlock_date] : Time.zone.now.to_date
  end
end
