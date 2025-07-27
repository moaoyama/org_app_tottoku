class CreateAdminLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :admin_logs do |t|
      t.bigint :admin_id
      t.string :action
      t.string :target_table
      t.bigint :target_id

      t.timestamps
    end
  end
end
