class UsersController < ApplicationController
  before_action :correct_user, only: [:edit]

  def show
    @user = User.includes(:bookmarks).find(params[:id])
    @unlocked_bookmarks = @user.unlocked_bookmarks.order(unlock_date: 'DESC').page(params[:unlocked_page]).per(10)
    @locked_bookmarks = @user.locked_bookmarks.order(created_at: 'DESC').page(params[:locked_page]).per(10)
  end

  def edit
    @unlocked_bookmarks = current_user.unlocked_bookmarks.order(unlock_date: 'DESC').page(params[:unlocked_page]).per(10)
    @locked_bookmarks = current_user.locked_bookmarks.order(created_at: 'DESC').page(params[:locked_page]).per(10)
  end

  private

  def correct_user
    user = User.find(params[:id])
    redirect_to root_path unless user == current_user
  end
end
