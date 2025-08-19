class Users::SessionsController < Devise::SessionsController
  # 一般ユーザーゲストのログイン処理
  def guest_sign_in
    # データベースから、あらかじめ作っておいた「一般ゲスト」のアカウントを見つける
    user = User.find_by!(email: 'guest_user@example.com')
    # そのアカウントでログインさせる
    sign_in user
    # ログイン後、トップページに戻るようにする
    redirect_to home_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  # 管理者ゲストのログイン処理
  def admin_guest_sign_in
    # データベースから、「管理者ゲスト」のアカウントを見つける
    user = User.find_by!(email: 'admin_guest_user@example.com')
    # そのアカウントでログインさせる
    sign_in user
    # ログイン後、管理者ページに戻るようにする
    redirect_to rails_admin_path, notice: '管理者ゲストユーザーとしてログインしました。'
  end
end