class Project < ApplicationRecord

  # ==========================================================================================================
  # Relations ================================================================================================
  # ==========================================================================================================

  has_many :roles
  has_many :users,           through: :roles
  has_many :tasks,           dependent: :destroy
  has_many :task_labels,     dependent: :destroy
  has_many :document_labels, dependent: :destroy
  has_many :internal_events, dependent: :destroy
  has_many :milestones,      dependent: :destroy
  has_many :documents,       dependent: :destroy

  # ==========================================================================================================
  # Validations ==============================================================================================
  # ==========================================================================================================

  validates :name, presence: true
  validates :slug, uniqueness: true

  # ==========================================================================================================
  # Callbacks ================================================================================================
  # ==========================================================================================================

  before_create :generate_slug

  # ==========================================================================================================
  # Class methods ============================================================================================
  # ==========================================================================================================

  class << self

    def parse_role a, force_int=false
      if a.kind_of?(Integer)
        if force_int
          a
        else
          [:owner, :admin, :worker, :reader][a]
        end
      elsif a.kind_of?(Symbol)
        {
          owner: 0,
          admin: 1,
          worker: 2,
          reader: 3
        }[a]
      end
    end

  end

  # ==========================================================================================================
  # Instance methods =========================================================================================
  # ==========================================================================================================

  def join_user user, as=:worker
    # Try to find previous role, who was deleted before
    if role = Role.unscoped.where(user_id: user.id, project_id: self.id).first
      role.update!({
        deleted: false,
        level:   self.class.parse_role(as, true)
      })

      role
    else
      Role.create({
        level:      self.class.parse_role(as, true),
        project_id: self.id,
        user_id:    user.id
      })
    end
  end

  # ===============================
  # Internal events generation ====
  # ===============================

  def generate_add_member_internal_event adder_id, role_id
    InternalEvent.create({
      subject:    :project_member_added,
      klass:      :role,
      user_id:    adder_id,
      subject_id: role_id,
      project_id: self.id
    })
  end

  def generate_remove_member_internal_event adder_id, role_id
    InternalEvent.create({
      subject:    :project_member_removed,
      klass:      :role,
      user_id:    adder_id,
      subject_id: role_id,
      project_id: self.id
    })
  end

  def generate_creation_internal_event!
    InternalEvent.create({
      subject:    :project_creation,
      klass:      :project,
      user_id:    self.users.first.id,
      subject_id: self.id,
      project_id: self.id
    })
  end

  private

    def generate_slug
      self.slug = self.name.parameterize
    end
end
