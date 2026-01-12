# frozen_string_literal: true
class User < ApplicationRecord
  validates :name, presence: true
   
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :documents
  has_many :admin_logs, foreign_key: :admin_id

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :admin, inclusion: { in: [true, false] }

  def guest?
    email == 'guest_user@example.com' || email == 'admin_guest_user@example.com'
  end
  
  def admin_guest?
    email == 'admin_guest_user@example.com'
  end
end