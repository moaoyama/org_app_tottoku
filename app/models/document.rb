class Document < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :gpt_result, optional: true
  # belongs_to :document, optional: true
  # belongs_to :document_id, optional: true

  # app/models/document.rb
  has_one_attached :file
  
  has_many :images, dependent: :destroy
  # 名前は好きなように変えられる


  private


  
end