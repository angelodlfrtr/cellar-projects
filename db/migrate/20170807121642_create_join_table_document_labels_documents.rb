class CreateJoinTableDocumentLabelsDocuments < ActiveRecord::Migration[5.1]
  def change
    create_join_table :document_labels, :documents do |t|
      t.index [:document_label_id, :document_id],
        name: 'index_doc_labels_docts_on_doc_label_id_and_doc_id'
      t.index [:document_id, :document_label_id],
        name: 'index_doc_labels_docs_on_doc_id_and_doc_label_id'
    end
  end
end
