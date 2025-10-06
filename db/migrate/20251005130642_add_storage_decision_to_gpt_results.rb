class AddStorageDecisionToGptResults < ActiveRecord::Migration[7.1]
  def change
    add_column :gpt_results, :storage_decision, :string
  end
end
