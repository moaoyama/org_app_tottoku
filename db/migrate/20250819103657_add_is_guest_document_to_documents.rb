class AddIsGuestDocumentToDocuments < ActiveRecord::Migration[7.1]
  def change
    add_column :documents, :is_guest_document, :boolean, default: false
  end
end
