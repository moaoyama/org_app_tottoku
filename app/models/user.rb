class User < ApplicationRecord
  has_many :documents
  has_many :admin_logs, foreign_key: :admin_id
  has_secure_password
end