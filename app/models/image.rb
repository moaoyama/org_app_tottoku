class Image < ApplicationRecord
  belongs_to :document
  has_one_attached :file  # 画像ファイルをActiveStorageで管理する場合

  validates :document, presence: true
end
