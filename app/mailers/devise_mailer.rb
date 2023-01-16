class DeviseMailer < Devise::Mailer
  default from: "no-reply@rubycommunity.africa"
  layout "mailer"
end
