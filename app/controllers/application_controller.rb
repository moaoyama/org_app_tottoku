class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  private


  # 今ログインしているユーザーを返す（いる場合）
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # ログインしているかどうか判定する
  def logged_in?
    !!current_user
  end

  # ログイン必須のページで使う
  def require_login
    unless logged_in?
      redirect_to login_path, alert: "ログインしてください"
    end
  end
end
