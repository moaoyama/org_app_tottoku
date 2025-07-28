class Document < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :gpt_result, optional: true

  # app/models/document.rb
  has_one_attached :file  # ファイル添付（Active Storage）
  # file という名前は好きなように変えられる
end