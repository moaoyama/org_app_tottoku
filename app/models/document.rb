# frozen_string_literal: true
class Document < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :gpt_result, optional: true

  validates :title, presence: true, length: { maximum: 255 }
  validates :user_id, presence: true

  has_many_attached :images

  validates :location, length: { maximum: 255 }
  validates :ai_decision, length: { maximum: 50 }, allow_blank: true
  validates :user_override, length: { maximum: 50 }, allow_blank: true
  validates :user_comment, length: { maximum: 500 }
  validates :name, length: { maximum: 255 }, allow_blank: true
  validates :memo, length: { maximum: 500 }, allow_blank: true

  validates :location, presence: { message: "は空欄だと保存できません" }, on: :location_update

  validates :user_comment, presence: { message: "は空欄だと保存できません" }, on: :comment_update

  # カスタムバリデーション
  validate :ai_decision_must_exist_if_user_override_present

  scope :recent, -> { order(created_at: :desc) }
  
  def update_expiry_date(new_expiry_param)
    new_expiry = new_expiry_param.present? ? Time.parse(new_expiry_param) : nil
   update(expires_at: new_expiry)
  end

  def attach_images(image_files)
    image_files.each { |img| images.attach(img) } if image_files.present?
  end

  def remove_image_by_id(image_id)
    image = images.find(image_id)
    image.purge
  end

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