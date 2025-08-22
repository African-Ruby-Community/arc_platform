# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  github_username        :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  name                   :string
#  phone_number           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_github_username       (github_username) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable

  # Associations
  has_many :users_chapters, dependent: :nullify
  has_many :chapters, through: :users_chapters

  # Callbacks
  before_create :set_defaults # Set model defaults before create

  # Enums
  enum :role, { member: 0, chapter_admin: 1, organization_admin: 2 }

  # Validations
  validates :email, :name, :phone_number, :github_username, presence: true
  validates :github_username, :phone_number, uniqueness: true

  # Validate the format the Github username when it's present
  validates :github_username, format:
    { with: /\A(?!.*--|.*-$|.*_)[a-zA-Z0-9][\w-]+[a-zA-Z0-9]{0,39}\z/ },
                              unless: -> { github_username.blank? }

  # Validate that the GitHub account exists
  validate :github_account_exists, if: -> { github_username.present? }

  private

  ##
  # A method to set model defaults if they are not set. e.g. if role is not set the default will be
  # :member.
  def set_defaults
    self.role ||= :member
  end

  ##
  # Validates that the GitHub account exists using the GithubAccountVerifier service
  def github_account_exists
    return if GithubAccountVerifier.exists?(github_username)

    errors.add(:github_username, 'must be a valid GitHub account')
  end
end
