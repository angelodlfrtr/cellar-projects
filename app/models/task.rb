class Task < ApplicationRecord

  # ==========================================================================================================
  # Relations ================================================================================================
  # ==========================================================================================================

  belongs_to :user
  belongs_to :project
  belongs_to :milestone, optional: true
  belongs_to :assigned, foreign_key: :assigned_id, class_name: :User
  has_many :task_comments, dependent: :destroy

  # ==========================================================================================================
  # Validations ==============================================================================================
  # ==========================================================================================================

  validates :name, presence: true
  validates :user, presence: :true
  validates :project, presence: :true

  # ==========================================================================================================
  # Callbacks ================================================================================================
  # ==========================================================================================================

  after_commit :generate_creation_internal_event, on: :create

  # ==========================================================================================================
  # Scopes ===================================================================================================
  # ==========================================================================================================

  default_scope { where(deleted: false) }

  scope :closed, -> { where(closed: true) }
  scope :opened, -> { where(closed: false) }

  # ==========================================================================================================
  # Instance methods =========================================================================================
  # ==========================================================================================================

  def parsed_name
    if self.closed
      "[CLOSED] #{self.name}"
    else
      self.name
    end
  end

  def parsed_desc
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    markdown.render(self.description)
  end

  def get_comments_with_events
    task_comments = self.task_comments.to_a
    events        = self.internal_events.where.not(subject: 'task_comment_creation').to_a

    (task_comments + events).sort_by! { |e| e.created_at }
  end

  def internal_events
    InternalEvent.where(subject_id: self.id, klass: 'task')
  end

  def close! user
    self.update!(closed: true)
    self.generate_close_internal_event(user.id)
  end

  def reopen! user
    self.update!(closed: false, deleted: false)
    self.generate_reopen_internal_event(user.id)
  end

  def generate_close_internal_event closer_id
    InternalEvent.create({
      subject:    :task_close,
      klass:      :task,
      subject_id: self.id,
      user_id:    closer_id,
      project_id: self.project.id
    })
  end

  def generate_reopen_internal_event reopener_id
    InternalEvent.create({
      subject:    :task_reopen,
      klass:      :task,
      subject_id: self.id,
      user_id:    reopener_id,
      project_id: self.project.id
    })
  end

  def generate_deletion_internal_event destroyer_id
    InternalEvent.create({
      subject:    :task_deletion,
      klass:      :task,
      subject_id: self.id,
      user_id:    destroyer_id,
      project_id: self.project.id
    })
  end

  private

    def generate_creation_internal_event
      InternalEvent.create({
        subject:    :task_creation,
        klass:      :task,
        subject_id: self.id,
        user_id:    self.user.id,
        project_id: self.project.id
      })
    end
end
