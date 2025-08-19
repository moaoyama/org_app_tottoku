class AddDefaultToAdminInUsers < ActiveRecord::Migration[7.1]
  def up
    User.where(admin: nil).update_all(admin: false)
    change_column_default :users, :admin, from: nil, to: false
    change_column_null :users, :admin, false
  end

  def down
    change_column_null :users, :admin, true
    change_column_default :users, :admin, from: false, to: nil
  end
end