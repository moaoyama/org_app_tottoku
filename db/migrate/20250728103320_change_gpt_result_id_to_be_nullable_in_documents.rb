class ChangeGptResultIdToBeNullableInDocuments < ActiveRecord::Migration[7.1]
  def change
    change_column_null :documents, :gpt_result_id, true
  end
end
