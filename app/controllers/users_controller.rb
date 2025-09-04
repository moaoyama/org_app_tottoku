class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @user = User.new
  end

  def show
    @user = current_user
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "プロフィールを更新しました"
      redirect_to mypage_path
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def user_params
    if current_user.guest?
      params.require(:user).permit()
    else
      params.require(:user).permit(:name)
    end
  end
  
end