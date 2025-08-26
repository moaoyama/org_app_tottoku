class GptResult < ApplicationRecord
  belongs_to :document, optional: true

  def clean_reason
    return nil if reason.blank?
    reason.gsub(/【判定】：\d*\.?\s*【理由】：/, "").gsub(/\A\d+\.\s*/, '')
  end
end
