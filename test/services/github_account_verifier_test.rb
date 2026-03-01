# frozen_string_literal: true

require 'test_helper'

class GithubAccountVerifierTest < ActiveSupport::TestCase
  test 'returns false for blank username' do
    assert_not GithubAccountVerifier.exists?(nil)
    assert_not GithubAccountVerifier.exists?('')
  end

  test 'returns true for existing GitHub account' do
    # Mock the HTTP response for an existing account
    mock_response = mock('response')
    mock_response.stubs(:code).returns('200')
    Net::HTTP.stubs(:get_response).returns(mock_response)

    assert GithubAccountVerifier.exists?('octocat')
  end

  test 'returns false for non-existing GitHub account' do
    # Mock the HTTP response for a non-existing account
    mock_response = mock('response')
    mock_response.stubs(:code).returns('404')
    Net::HTTP.stubs(:get_response).returns(mock_response)

    assert_not GithubAccountVerifier.exists?('this-user-does-not-exist-12345')
  end

  test 'returns false when an error occurs' do
    # Mock an exception during the HTTP request
    Net::HTTP.stubs(:get_response).raises(StandardError.new('API error'))

    assert_not GithubAccountVerifier.exists?('any-username')
  end
end
