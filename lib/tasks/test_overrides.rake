# frozen_string_literal: true

# In the test environment, skip building JS and CSS assets to speed up tests
# and avoid requiring external toolchains (Node, tailwind CLI, etc.).
if ENV['RAILS_ENV'] == 'test'
  # Safely clear existing tasks if they were defined by railties/gems
  begin
    Rake::Task['css:build'].clear
  rescue StandardError
    # no-op
  end
  begin
    Rake::Task['javascript:build'].clear
  rescue StandardError
    # no-op
  end

  namespace :css do
    desc 'No-op in test environment'
    task build: :environment do
      puts '[test] Skipping css:build'
    end
  end

  namespace :javascript do
    desc 'No-op in test environment'
    task build: :environment do
      puts '[test] Skipping javascript:build'
    end
  end
end
