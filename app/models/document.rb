class Document < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :gpt_result, optional: true
  # belongs_to :document, optional: true
  # belongs_to :document_id, optional: true

  validates :title, presence: true, length: { maximum: 255 }
  validates :user_id, presence: true

  # app/models/document.rb
  has_many_attached :images

  # オプションで文字数制限やカスタムバリデーションも追加可能
  validates :location, length: { maximum: 255 }
  validates :ai_decision, length: { maximum: 50 }, allow_blank: true
  validates :user_override, length: { maximum: 50 }, allow_blank: true
  validates :user_comment, length: { maximum: 500 }
  # 定義書にないもの(0818現在)
  validates :name, length: { maximum: 255 }, allow_blank: true
  validates :memo, length: { maximum: 500 }, allow_blank: true

  validates :location, presence: { message: "は空欄だと保存できません" }, on: :location_update

  validates :user_comment, presence: { message: "は空欄だと保存できません" }, on: :comment_update

  # カスタムバリデーション
  validate :ai_decision_must_exist_if_user_override_present

  private

  # 例：ユーザーが上書きした場合、AI判定結果も必須
  def ai_decision_must_exist_if_user_override_present
    if user_override.present? && ai_decision.blank?
      errors.add(:ai_decision, "が必要です（ユーザー上書きがある場合）")
    end
  end

  def images_presence
    errors.add(:images, "を選択してください") if images.blank?
  end
end