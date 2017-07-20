class InternalEvent < ApplicationRecord

  # ==========================================================================================================
  # Relations ================================================================================================
  # ==========================================================================================================

  belongs_to :user
  belongs_to :project
  has_and_belongs_to_many :users

  # ==========================================================================================================
  # Validations ==============================================================================================
  # ==========================================================================================================

  validates :user, presence: true
  validates :project, presence: true
  validates :subject, presence: true
  validates :subject_id, presence: true, numericality: true

  # ==========================================================================================================
  # Callbacks ================================================================================================
  # ==========================================================================================================

  after_commit :join_users, on: :create

  # ==========================================================================================================
  # Instance methods =========================================================================================
  # ==========================================================================================================

  def desc
    _data = nil
    unless self.data.blank?
      begin
        _data = JSON.parse(self.data)
      rescue
        _data = self.data
      end
    end

    case self.subject
    when 'project_creation'
      project_link = Rails.application.routes.url_helpers.project_url(self.project.slug)
      user_link    = Rails.application.routes.url_helpers.user_url(self.user.username)

      [
        ActionController::Base.helpers.link_to(self.user.username, user_link),
        'created project',
        ActionController::Base.helpers.link_to(self.project.name, project_link)
      ].join(' ').html_safe
    when 'task_creation'
      task      = Task.find(self.subject_id)
      task_link = Rails.application.routes.url_helpers.task_url(self.project.slug, task.id)
      user_link = Rails.application.routes.url_helpers.user_url(self.user.username)

      r = [
        ActionController::Base.helpers.link_to(self.user.username, user_link),
        'created task'
      ]
      if task.deleted
        r.push task.name
      else
        r.push ActionController::Base.helpers.link_to(task.name, task_link)
      end

      r.join(' ').html_safe
    when 'task_close'
      task      = Task.find(self.subject_id)
      task_link = Rails.application.routes.url_helpers.task_url(self.project.slug, task.id)
      user_link = Rails.application.routes.url_helpers.user_url(self.user.username)

      r = [
        ActionController::Base.helpers.link_to(self.user.username, user_link),
        'a fermé la tâche'
      ]

      if task.deleted
        r.push task.name
      else
        r.push ActionController::Base.helpers.link_to(task.name, task_link)
      end

      r.join(' ').html_safe
    when 'task_reopen'
      task      = Task.find(self.subject_id)
      task_link = Rails.application.routes.url_helpers.task_url(self.project.slug, task.id)
      user_link = Rails.application.routes.url_helpers.user_url(self.user.username)

      r = [
        ActionController::Base.helpers.link_to(self.user.username, user_link),
        'a réouvert la tâche'
      ]

      if task.deleted
        r.push task.name
      else
        r.push ActionController::Base.helpers.link_to(task.name, task_link)
      end

      r.join(' ').html_safe
    when 'task_deletion'
      task      = Task.find(self.subject_id)
      task_link = Rails.application.routes.url_helpers.task_url(self.project.slug, task.id)
      user_link = Rails.application.routes.url_helpers.user_url(self.user.username)

      r = [
        ActionController::Base.helpers.link_to(self.user.username, user_link),
        'a supprimé la tâche'
      ]

      if task.deleted
        r.push task.name
      else
        r.push ActionController::Base.helpers.link_to(task.name, task_link)
      end

      r.join(' ').html_safe
    when 'task_comment_creation'
      comment   = TaskComment.find(self.subject_id)
      task_link = Rails.application.routes.url_helpers.task_url(self.project.slug, comment.task.id) + "/#comment_#{comment.id}"
      user_link = Rails.application.routes.url_helpers.user_url(self.user.username)

      r = [
        ActionController::Base.helpers.link_to(self.user.username, user_link),
        'a commenté la tâche'
      ]

      if comment.task.deleted
        r.push comment.task.name
      else
        r.push ActionController::Base.helpers.link_to(comment.task.name, task_link)
      end

      r.join(' ').html_safe
    else
      'NC'
    end
  end

  private

    def join_users
      self.project.users.each do |user|
        user.internal_events << self
      end
    end
end
