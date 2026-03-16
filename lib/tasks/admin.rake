# frozen_string_literal: true

namespace :admin do
  desc 'Promote a user to organization_admin role'
  task :promote, [:email] => :environment do |_t, args|
    email = args[:email]

    if email.blank?
      puts 'Usage: rails admin:promote[user@example.com]'
      exit 1
    end

    user = User.find_by(email: email)

    if user.nil?
      puts "User with email '#{email}' not found."
      exit 1
    end

    user.update!(role: :organization_admin)
    puts "Successfully promoted #{user.email} (#{user.name}) to organization_admin!"
  end
end
