# frozen_string_literal: true

require 'net/http'
require 'json'

##
# Service to verify if a GitHub account exists
class GithubAccountVerifier
  # GitHub API URL for user data
  GITHUB_API_URL = 'https://api.github.com/users/'

  ##
  # Verifies if a GitHub account exists
  #
  # @param username [String] GitHub username to verify
  # @return [Boolean] true if account exists, false otherwise
  def self.exists?(username)
    return false if username.blank?

    begin
      uri = URI("#{GITHUB_API_URL}#{username}")
      response = Net::HTTP.get_response(uri)

      # GitHub returns 200 if user exists, 404 if not
      response.code == '200'
    rescue StandardError => e
      Rails.logger.error("Error verifying GitHub account: #{e.message}")
      # In case of error, we'll return false to be safe
      false
    end
  end
end
