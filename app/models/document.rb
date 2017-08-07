class Document < ApplicationRecord

  # ==========================================================================================================
  # Relations ================================================================================================
  # ==========================================================================================================

  has_one :file_upload, foreign_key: :klass_id, dependent: :destroy
  belongs_to :project
  belongs_to :user
  has_and_belongs_to_many :document_labels

  # ==========================================================================================================
  # Validations ==============================================================================================
  # ==========================================================================================================

  validates :project, :user, :name, presence: true
end
