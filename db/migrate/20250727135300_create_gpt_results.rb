# frozen_string_literal: true
class CreateGptResults < ActiveRecord::Migration[7.1]
  def change
    create_table :gpt_results do |t|
      t.string :result_text
      t.timestamps
    end
  end
end
