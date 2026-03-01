# frozen_string_literal: true

require 'brevo'

class BrevoDeliveryMethod
  def initialize(settings)
    @settings = settings
  end

  def deliver!(mail)
    validate_mail!(mail)

    api_instance = Brevo::TransactionalEmailsApi.new
    send_smtp_email = build_email(mail)

    send_with_brevo(api_instance, send_smtp_email)
  end

  private

  def validate_mail!(mail)
    raise ArgumentError, 'Mail object cannot be nil' if mail.nil?
    raise ArgumentError, 'Mail must have from address' if mail.from.blank?
    raise ArgumentError, 'Mail must have to address' if mail.to.blank?
    raise ArgumentError, 'Mail must have subject' if mail.subject.blank?
  end

  def build_email(mail)
    Brevo::SendSmtpEmail.new(
      sender: {
        email: @settings[:default_sender_email] || mail.from.first,
        name: @settings[:sender_name] || 'Africa Ruby Community'
      },
      to: recipients(mail),
      subject: mail.subject,
      html_content: html_content(mail),
      text_content: text_content(mail)
    )
  end

  def recipients(mail)
    mail.to.map { |email| { email: email } }
  end

  def html_content(mail)
    mail.html_part&.body&.to_s || "<p>#{mail.body}</p>"
  end

  def text_content(mail)
    mail.text_part&.body&.to_s || mail.body.to_s
  end

  def send_with_brevo(api_instance, send_smtp_email)
    api_instance.send_transac_email(send_smtp_email)
  rescue Brevo::ApiError => e
    Rails.logger.error "Brevo API Error: #{e.message}"
    raise "Email delivery failed: #{e.message}"
  end
end
