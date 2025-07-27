class CreateGptResults < ActiveRecord::Migration[7.1]
  def change
    create_table :gpt_results do |t|
      t.string :storage_decision
      t.text :reason

      t.timestamps
    end
  end
end
