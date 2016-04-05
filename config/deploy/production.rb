set :repo_url, 'git@github.com-taiga-frontend:Rademade/taiga-front.git'

set :deploy_to, "/home/taiga/website-production/frontend"

server '138.201.48.226', user: 'taiga', roles: %w{web app}
