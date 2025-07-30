class AddMemoToDocuments < ActiveRecord::Migration[7.1]
  def change
    add_column :documents, :memo, :text
  end
end
