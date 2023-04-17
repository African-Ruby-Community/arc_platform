set :stage, :production
set :branch, 'main'

server '207.154.236.227', user: 'ubuntu', roles: %w{app db web}
