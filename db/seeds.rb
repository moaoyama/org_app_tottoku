# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# ----------------------------------
# Users（管理者ユーザー）
User.find_or_create_by!(
  name: "AdminUser",
  email: "admin@example.com",
  password: "password123",
  password_confirmation: "password123",
  admin: true
)

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

# Categories（documents の分類）
['仕事', 'プライベート', 'その他'].each do |name|
  Category.find_or_create_by!(name: name)
end

# GPTResults（AI判定結果）
[['紙で保管が必要', '紙で保管する必要があります'],
  ['データ保管でOK', 'データとして保管すればOKです'],
   ['処分してOK', '処分して問題ありません']].each do |storage_decision, reason|
    GptResult.find_or_create_by!(storage_decision: storage_decision) do |gr|
      gr.reason = reason
    end
end


# サンプルドキュメント
Document.find_or_create_by!(
  name: 'サンプル書類',
  category: Category.first,
  gpt_result: GptResult.first,
  result: '処分してOK',
  reason: 'テスト用の初期データ',
  memo: 'ここにメモを書けます'
)