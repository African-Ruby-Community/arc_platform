# frozen_string_literal: true

namespace :events do
  desc 'Generate slugs for existing events'
  task generate_slugs: :environment do
    Event.where(slug: nil).find_each do |event|
      event.send(:generate_slug)
      event.save(validate: false)
      puts "Generated slug '#{event.slug}' for event: #{event.title}"
    end
    puts 'Done!'
  end
end
