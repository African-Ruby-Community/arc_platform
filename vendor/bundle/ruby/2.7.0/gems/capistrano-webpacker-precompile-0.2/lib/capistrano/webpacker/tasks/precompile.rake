config = YAML.load_file'config/webpacker.yml'

namespace :webpacker do
  desc 'Precompile assets locally and then rsync to web servers'
  task :precompile do
    run_locally do
      with rails_env: :production do
        execute :rails, 'webpacker:clobber'
        execute :rails, 'webpacker:compile'
      end
    end

    on roles(:web), in: :parallel do |server|
      run_locally do
        execute :rsync,
          "-a --delete ./public/#{config['production']['source_entry_path']}/ #{fetch(:user)}@#{server.hostname}:#{shared_path}/public/#{config['production']['source_entry_path']}/"
      end
    end

    run_locally do
      execute :rm, "-rf public/#{config['production']['source_entry_path']}"
    end
  end
end