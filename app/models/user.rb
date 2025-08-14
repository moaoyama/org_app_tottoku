class User < ApplicationRecord
   validates :name, presence: true
   
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  has_many :documents
  has_many :admin_logs, foreign_key: :admin_id
end