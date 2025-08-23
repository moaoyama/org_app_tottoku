class GptResult < ApplicationRecord
  belongs_to :document

  def clean_reason
    return nil if reason.blank?
    reason.gsub(/【判定】：\d*\.?\s*【理由】：/, "").gsub(/\A\d+\.\s*/, '')
  end
end
