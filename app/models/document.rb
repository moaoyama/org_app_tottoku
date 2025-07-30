class Document < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :gpt_result, optional: true

  # app/models/document.rb
  has_one_attached :file
  # 画像1枚を添付する場合
  has_one_attached :image
  # 名前は好きなように変えられる

  before_save :set_judgement

  private

  def set_judgement
    if self.name.present? && (self.name.include?("保険") || self.name.include?("重要"))
      self.ai_decision = "保存する"
      self.reason = "『保険』や『重要』というキーワードがあるため"
    elsif self.name.present? && (self.name.include?("広告") || self.name.include?("チラシ"))
      self.ai_decision = "保存しない"
      self.reason = "広告やチラシと判断されたため"
    else
      self.ai_decision = "要確認"
      self.reason = "判定できない書類名のため"
    end
  end
end