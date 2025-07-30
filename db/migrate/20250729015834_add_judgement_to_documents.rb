class AddJudgementToDocuments < ActiveRecord::Migration[7.1]
  def change
    add_column :documents, :result, :string
    add_column :documents, :reason, :text
  end
end
