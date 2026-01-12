# frozen_string_literal: true
class Users::SessionsController < Devise::SessionsController
  # 一般ユーザーゲストのログイン処理
  def guest_sign_in
    user = User.find_by!(email: 'guest_user@example.com')
    sign_in user
    redirect_to home_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  # 管理者ゲストのログイン処理
  def admin_guest_sign_in
    user = User.find_by!(email: 'admin_guest_user@example.com')
    sign_in user
    redirect_to rails_admin_path, notice: '管理者ゲストユーザーとしてログインしました。'
  end
end