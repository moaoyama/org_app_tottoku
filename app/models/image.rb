class Image < ApplicationRecord
  belongs_to :document
  has_one_attached :file  

  validates :document, presence: true
end
