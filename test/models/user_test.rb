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
require 'test_helper'
require 'ostruct'

class UserTest < ActiveSupport::TestCase
  setup do
    @valid_attributes = {
      email: 'test@example.com',
      name: 'Test User',
      password: 'password123',
      password_confirmation: 'password123'
    }
  end

  test 'should be valid with valid attributes' do
    # Mock the GitHub account verification to return true
    GithubAccountVerifier.stubs(:exists?).returns(true)

    user = User.new(@valid_attributes)
    assert user.valid?, 'User should be valid with valid attributes'
  end

  test 'should be valid without a github_username' do
    user = User.new(@valid_attributes.merge(github_username: nil))
    assert user.valid?, 'User should be valid without github_username'
  end

  test 'should be valid with a github_username when account exists' do
    # Mock the GitHub account verification to return true
    GithubAccountVerifier.stubs(:exists?).returns(true)

    user = User.new(@valid_attributes)
    assert user.valid?, 'User should be valid with valid github_username'
  end

  test 'should not be valid with a non-existent github account' do
    # Mock the GitHub account verification to return false
    GithubAccountVerifier.stubs(:exists?).returns(false)

    user = User.new(@valid_attributes.merge(github_username: 'nonexistent-user'))
    assert_not user.valid?
    assert_includes user.errors[:github_username], 'must be a valid GitHub account'
  end

  test 'should create user from omniauth data' do
    auth_data = OpenStruct.new(
      info: OpenStruct.new(
        email: 'oauth@example.com',
        name: 'OAuth User',
        nickname: 'oauth-user'
      )
    )

    user = User.from_omniauth(auth_data)

    assert user.persisted?, 'User should be saved'
    assert_equal 'oauth@example.com', user.email
    assert_equal 'OAuth User', user.name
    assert_equal 'oauth-user', user.github_username
    assert user.confirmed_at.present?, 'OAuth user should be auto-confirmed'
  end

  test 'should find existing user from omniauth data' do
    existing_user = User.create!(@valid_attributes.merge(email: 'existing@example.com', confirmed_at: Time.current))

    auth_data = OpenStruct.new(
      info: OpenStruct.new(
        email: 'existing@example.com',
        name: 'Updated Name',
        nickname: 'updated-username'
      )
    )

    user = User.from_omniauth(auth_data)

    assert_equal existing_user.id, user.id, 'Should return existing user'
    assert_equal existing_user.email, user.email
  end
end
