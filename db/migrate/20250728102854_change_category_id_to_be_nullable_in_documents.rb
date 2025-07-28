class ChangeCategoryIdToBeNullableInDocuments < ActiveRecord::Migration[7.1]
  def change
    change_column_null :documents, :category_id, true
  end
end
