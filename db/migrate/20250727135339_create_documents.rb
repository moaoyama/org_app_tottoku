class CreateDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :documents do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :gpt_result, null: false, foreign_key: true
      t.string :title
      t.string :location
      t.string :ai_decision
      t.text :user_comment
      t.string :user_override
      t.datetime :expires_at
      t.boolean :is_deleted
      t.datetime :deleted_at
      t.text :ocr_text

      t.timestamps
    end
  end
end
