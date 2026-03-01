# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.19.2'

set :user, 'ubuntu'

set :application, 'arc_platform'
set :repo_url, 'git@github.com:Judahsan/arc_platform.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/#{fetch :application}"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w[config/database.yml config/credentials/production.key]
set :linked_dirs, %w[ vendor/bundle public/system log tmp/pids tmp/cache tmp/sockets
                      public/packs .bundle node_modules ]

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:restart'
end

namespace :sentry do
  desc 'Notify Sentry of a new release'
  task :notify_release do
    on roles(:web) do
      within release_path do
        begin
          # Get Sentry credentials with validation
          auth_token = capture(:bundle, :exec, :rails, :runner, "puts Rails.application.credentials.dig(:sentry, :auth_token)")
          org = capture(:bundle, :exec, :rails, :runner, "puts Rails.application.credentials.dig(:sentry, :org)")
          
          if auth_token.strip.empty? || org.strip.empty?
            warn "Sentry credentials missing - skipping release notification"
            next
          end
          
          # Create release and upload sourcemaps
          release_version = capture(:git, 'rev-parse HEAD').strip
          
          with rails_env: fetch(:rails_env),
               SENTRY_AUTH_TOKEN: auth_token.strip,
               SENTRY_ORG: org.strip do
            
            # Create release
            execute :bundle, :exec, :sentry, "releases new #{release_version}"
            
            # Upload sourcemaps if assets exist
            if test("[ -d #{release_path}/public/assets ]") 
              execute :bundle, :exec, :sentry, "releases files #{release_version} upload-sourcemaps ./public/assets --url-prefix '~/assets'"
            end
            
            # Finalize release
            execute :bundle, :exec, :sentry, "releases finalize #{release_version}"
          end
          
          info "Sentry release #{release_version} created successfully"
        rescue => e
          warn "Sentry release notification failed: #{e.message}"
        end
      end
    end
  end
end

after 'deploy:published', 'sentry:notify_release'
