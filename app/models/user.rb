class User < ApplicationRecord
  attr_accessor :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # ==========================================================================================================
  # Relations ================================================================================================
  # ==========================================================================================================

  has_many :roles
  has_many :projects, through: :roles
  has_many :created_tasks, class_name: :Task, foreign_key: :user_id
  has_many :tasks, foreign_key: :assigned_id
  has_and_belongs_to_many :internal_events, -> { order(created_at: :desc) }

  # ==========================================================================================================
  # Validations ==============================================================================================
  # ==========================================================================================================

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :username,
    presence: true,
    format: { with: /^[a-zA-Z0-9_\.]*$/, multiline: true },
    uniqueness: { :case_sensitive => false }

  # ==========================================================================================================
  # Class methods ============================================================================================
  # ==========================================================================================================

  class << self

    def find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      conditions[:email].downcase! if conditions[:email]
      if login = conditions.delete(:login)
        where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_hash).first
      end
    end

  end

  # ==========================================================================================================
  # Instance methods =========================================================================================
  # ==========================================================================================================

  def full_name
    "#{self.first_name}" "#{self.last_name}"
  end
end
