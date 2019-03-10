class UsersController < ApplicationController
  before_action :correct_user, only: [:edit]

  def show
    @user = User.find(params[:id])
  end

  def edit
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
