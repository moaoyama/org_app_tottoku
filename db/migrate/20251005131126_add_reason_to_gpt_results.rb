class AddReasonToGptResults < ActiveRecord::Migration[7.1]
  def change
    add_column :gpt_results, :reason, :string
  end
end
