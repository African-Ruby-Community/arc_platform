# frozen_string_literal: true

require 'net/http'
require 'json'

class BrevoDeliveryMethod
  def initialize(settings)
    @settings = settings
  end

  def deliver!(mail)
    validate_mail!(mail)
    
    Rails.logger.info "Attempting to send email to: #{mail.to.join(', ')}"
    Rails.logger.info "Email subject: #{mail.subject}"
    
    api_key = Rails.application.credentials.dig(:brevo, :api_key)
    
    if api_key.blank?
      Rails.logger.error "Brevo API key is missing!"
      raise "Brevo API key not configured"
    end
    
    uri = URI('https://api.brevo.com/v3/smtp/email')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri)
    request['accept'] = 'application/json'
    request['api-key'] = api_key
    request['content-type'] = 'application/json'

    sender_email = @settings[:default_sender_email] || mail.from.first
    body = {
      sender: { 
        email: sender_email,
        name: @settings[:sender_name] || 'Africa Ruby Community'
      },
      to: mail.to.map { |email| { email: email } },
      subject: mail.subject,
      htmlContent: mail.html_part&.body&.to_s,
      textContent: mail.text_part&.body&.to_s || mail.body.to_s
    }

    Rails.logger.info "Sending email from: #{sender_email}"
    
    request.body = body.to_json
    response = http.request(request)

    Rails.logger.info "Brevo API Response: #{response.code}"
    
    if response.code.to_i.between?(200, 299)
      Rails.logger.info "Email sent successfully"
    else
      Rails.logger.error "Brevo API Error: #{response.code} - #{response.body}"
      raise "Email delivery failed: #{response.code} - #{response.body}"
    end
  end

  private

  def validate_mail!(mail)
    raise ArgumentError, 'Mail object cannot be nil' if mail.nil?
    raise ArgumentError, 'Mail must have from address' if mail.from.nil? || mail.from.empty?
    raise ArgumentError, 'Mail must have to address' if mail.to.nil? || mail.to.empty?
    raise ArgumentError, 'Mail must have subject' if mail.subject.nil? || mail.subject.empty?
  end
end

ActionMailer::Base.add_delivery_method :brevo, BrevoDeliveryMethod, {
  default_sender_email: 'no-reply@rubycommunity.africa',
  sender_name: 'Africa Ruby Community'
}