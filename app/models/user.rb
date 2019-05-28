class User < ApplicationRecord
  # As a OWNER
  has_many :flats, foreign_key: "owner_id", dependent: :destroy
  has_many :rentals, through: :flats

  # As a TENANT
  has_one :rental

  # As a CANDIDATE
  has_many :dossiers, foreign_key: "candidate_id", dependent: :destroy

  # As a OWNER or CONCIERGE
  has_many :tasks
  has_many :assignments

  ROLES = %w[owner concierge tenant]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ALL TASKS AS A CONCIERGE
  has_many :owned_tasks, -> { order('status ASC,') }, class_name: 'Task'
  # APPLIED
  has_many :assignments_applied, -> { where(validated: false) }, class_name: 'Assignment'
  has_many :tasks_applied, -> { where(status: "0") }, through: :assignments_applied, source: :task
  # VALIDATED
  has_many :assignments_validated, -> { where(validated: true) }, class_name: 'Assignment'
  has_many :tasks_validated, -> { order('status ASC') }, through: :assignments, source: :task
  has_many :tasks_to_do, -> { order('status ASC') }, through: :assignments_validated, source: :task
  # MISSED 
  has_many :tasks_missed, through: :assignments_applied, source: :task
  # has_many :tasks_missed, -> { where(validated: true) where.not(user_id: current_user) }, class_name: 'Assignment'
  # has_many :tasks_missed, through: :assignments_validated, source: :tasks
end
