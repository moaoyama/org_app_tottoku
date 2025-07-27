class AdminLog < ApplicationRecord
  belongs_to :admin, class_name: "User"
end
