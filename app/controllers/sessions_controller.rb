class SessionsController < ApplicationController
  def new
  end

  def create
    Rails.logger.debug "params: #{params.inspect}"
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      # flash[:notice] = "ログインしました"
      redirect_to home_path
    else
      flash.now[:alert] = "メールアドレスかパスワードが違います。"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = "ログアウトしました"
    redirect_to root_path
  end
end
