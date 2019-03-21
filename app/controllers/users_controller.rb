class UsersController < ApplicationController
  before_action :correct_user, only: [:edit]

  def show
    @user = User.includes(:bookmarks).find(params[:id])
    @unlocked_bookmarks = @user.bookmarks.unlocked.order(unlock_date: 'DESC').page(params[:unlocked_page]).per(10)
    @locked_bookmarks = @user.bookmarks.locked.page(params[:locked_page]).per(10)
  end

  def edit
    @unlocked_bookmarks = current_user.bookmarks.unlocked.page(params[:unlocked_page]).per(10)
    @locked_bookmarks = current_user.bookmarks.locked.page(params[:locked_page]).per(10)
  end

  private

  def correct_user
    user = User.find(params[:id])
    redirect_to root_path unless user == current_user
  end
end
