class UsersController < ApplicationController
  before_action :correct_user, only: [:edit]

  def show
    @user = User.includes(:bookmarks).find(params[:id])
    @unlocked_bookmarks = @user.bookmarks.unlocked
    @locked_bookmarks = @user.bookmarks.locked
  end

  def edit
    @unlocked_bookmarks = current_user.bookmarks.unlocked
    @locked_bookmarks = current_user.bookmarks.locked
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:provider, :uid, :nickname, :image_url)
  end

  def correct_user
    user = User.find(params[:id])
    redirect_to root_path unless user == current_user
  end
end
