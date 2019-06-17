class User < ApplicationRecord
  # As a OWNER
  has_many :flats, foreign_key: "owner_id", dependent: :destroy
  has_many :rentals, through: :flats

  # As a TENANT
  has_one :rental

  # As a CANDIDATE
  has_many :dossiers, foreign_key: "candidate_id", dependent: :destroy

  # As a OWNER or CONCIERGE
  has_many :tasks, dependent: :destroy
  has_many :assignments

  devise :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

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
  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice("provider", "uid")
    user_params.merge! auth.info.slice("email", "first_name", "last_name")
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0, 20] # Fake password for validation
      user.save
    end

    return user
  end

  def self.from_omniauth(access_token)
      data = access_token.info
      user = User.where(email: data['email']).first

      # Uncomment the section below if you want users to be created if they don't exist
      unless user
          user = User.create(
             email: data['email'],
             password: Devise.friendly_token[0,20],
             first_name: data['first_name'],
             last_name: data['last_name']
          )
      end
      user
  end
end
