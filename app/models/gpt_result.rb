class GptResult < ApplicationRecord
  has_many :documents

  def clean_reason
    return nil if reason.blank?
    reason.gsub(/【判定】：\d*\.?\s*【理由】：/, "")
  end
end
