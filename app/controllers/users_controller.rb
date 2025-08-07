class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # ログイン状態にする（セッションにIDを入れる）
      session[:user_id] = @user.id
      redirect_to root_path, notice: "登録に成功しました！"
    else
      render :new, status: :unprocessable_entity
    end
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
      render :show
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end