class BookmarksController < ApplicationController
  before_action :login_required 

  def create
    @bookmark = Bookmark.new(user_id: current_user.id,
                             achievement_id: bookmark_params[:achievement_id],
                             status: :locked
                            )

    if @bookmark.save
      redirect_to achievements_path
    else
      redirect_to achievements_path
    end
  end

  def update
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.update(bookmark_params)
      redirect_to achievements_path
    else
      redirect_to achievements_path
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to achievements_path
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:achievement_id, :status)
  end
end
