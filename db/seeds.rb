# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 一般ユーザーゲストを作成する
User.find_or_create_by!(email: 'guest_user@example.com') do |user|
  user.password = SecureRandom.urlsafe_base64
  user.name = 'ゲストユーザー'
end

# 管理者ゲストを作成する
User.find_or_create_by!(email: 'admin_guest_user@example.com') do |user|
  user.password = SecureRandom.urlsafe_base64
  user.name = '管理者ゲストユーザー'
  user.admin = true # <-- 管理者であることを示す「特別な印」
end