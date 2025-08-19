class User < ApplicationRecord
   validates :name, presence: true
   
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :documents
  has_many :admin_logs, foreign_key: :admin_id

  # バリデーション
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :admin, inclusion: { in: [true, false] }

  # ゲストユーザーかどうかを判断するメソッド
  def guest?
    email == 'guest_user@example.com' || email == 'admin_guest_user@example.com'
  end
  
  # 管理者ゲストユーザーかどうかを判断するメソッド
  def admin_guest?
    email == 'admin_guest_user@example.com'
  end
end