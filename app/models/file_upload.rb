class FileUpload < ApplicationRecord
  mount_uploader :file, FileUploadUploader

  # ==========================================================================================================
  # Relations ================================================================================================
  # ==========================================================================================================

  belongs_to :document,     optional: true, foreign_key: :klass_id
  belongs_to :task,         optional: true, foreign_key: :klass_id
  belongs_to :task_comment, optional: true, foreign_key: :klass_id

  # ==========================================================================================================
  # Validations ==============================================================================================
  # ==========================================================================================================

  validates :file, presence: true
end
