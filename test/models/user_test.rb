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

class UserTest < ActiveSupport::TestCase
  setup do
    @valid_attributes = {
      email: 'test@example.com',
      name: 'Test User',
      phone_number: '1234567890',
      github_username: 'valid-github-user',
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

  test 'should not be valid without a github_username' do
    user = User.new(@valid_attributes.merge(github_username: nil))
    assert_not user.valid?
    assert_includes user.errors[:github_username], "can't be blank"
  end

  test 'should not be valid with an invalid github_username format' do
    user = User.new(@valid_attributes.merge(github_username: 'invalid--username'))
    assert_not user.valid?
    assert_includes user.errors[:github_username], 'is invalid'
  end

  test 'should not be valid with a non-existent github account' do
    # Mock the GitHub account verification to return false
    GithubAccountVerifier.stubs(:exists?).returns(false)

    user = User.new(@valid_attributes)
    assert_not user.valid?
    assert_includes user.errors[:github_username], 'must be a valid GitHub account'
  end
end
