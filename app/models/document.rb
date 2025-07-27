class Document < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :gpt_result, optional: true
end
