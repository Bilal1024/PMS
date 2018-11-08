# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:login]

  validate :validate_username
  validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: /^[a-zA-Z0-9_\.]*$/, multiline: true }

  ADMIN = 'admin'

  enum role: %i[admin manager user]

  scope :non_admin_users, -> { where.not(role: :admin) }

  has_many :time_logs, dependent: :destroy

  attr_writer :login

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  def validate_username
    errors.add(:username, :invalid) if User.where(email: username).exists?
  end

  def active_for_authentication?
    super && active?
  end

  def inactive_message
    active? ? super : :not_active
  end

  def toggle_active
    update(active: !active)
  end
end
