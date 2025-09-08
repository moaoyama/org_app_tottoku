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
require 'securerandom'

admin_user = User.find_or_create_by!(email: "admin@example.com") do |user|
  user.name = "AdminUser"
  user.password = "password123"
  user.password_confirmation = "password123"
  user.admin = true
end

# 一般ユーザーゲストを作成する
guest_user = User.find_or_create_by!(email: "guest_user@example.com") do |user|
  random_password = SecureRandom.urlsafe_base64
  user.name = "ゲストユーザー"
  user.password = random_password
  user.password_confirmation = random_password
end

# 管理者ゲストを作成する
admin_guest_user = User.find_or_create_by!(email: "admin_guest_user@example.com") do |user|
  random_password = SecureRandom.urlsafe_base64
  user.name = "管理者ゲストユーザー"
  user.password = random_password
  user.password_confirmation = random_password
  user.admin = true
end

# サンプルユーザー（5件以上）
5.times do |i|
  User.find_or_create_by!(email: "sample#{i + 1}@example.com") do |user|
    user.name = "サンプルユーザー#{i + 1}"
    user.password = "password"
    user.password_confirmation = "password"
    user.admin = false
  end
end

# Categories（documents の分類）
category_names = ["仕事", "プライベート", "その他"]
categories = category_names.map do |name|
  Category.find_or_create_by!(name: name)
end

# GPTResults（AI判定結果）
GptResult.delete_all
gpt_results_data = [
  ["紙で保管が必要", "紙で保管する必要があります"],
  ["データ保管でOK", "データとして保管すればOKです"],
  ["処分してOK", "処分して問題ありません"]
]

gpt_results = gpt_results_data.map do |storage_decision, reason|
  GptResult.find_or_create_by!(storage_decision: storage_decision) do |gr|
    gr.reason = reason
  end
end


# サンプルドキュメント
sample_doc = Document.find_or_initialize_by(name: "サンプル書類")
sample_doc.assign_attributes(
  title: "サンプル書類タイトル",
  user: admin_user,
  category: Category.find_by(name: "仕事"),
  gpt_result: GptResult.find_by(storage_decision: "処分してOK"),
  result: "処分してOK",
  reason: "テスト用の初期データ",
  memo: "ここにメモを書けます"
)
sample_doc.save!

puts "Seeds loaded successfully"
puts "Users: #{User.count}, Categories: #{Category.count}, GPTResults: #{GptResult.count}, Sample Document persisted: #{sample_doc.persisted?}"