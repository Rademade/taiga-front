lock '3.4.0'

set :application, 'Taiga-frontend'

set :scm, :git

set :rvm_type,          :system
set :rvm_ruby_version,  'ruby-2.3.0@taiga'

set :linked_dirs, %w{bower_components node_modules}
set :keep_releases, 2

namespace :deploy do

  task 'npm:install' do
    on roles(:web) do
      within release_path do
        execute :npm, :install
      end
    end
  end

  task 'bower:install' do
    on roles(:web) do
      within release_path do
        execute :bower, :install
      end
    end
  end

  task 'gulp:install' do
    on roles(:web) do
      within release_path do
        execute "cd #{release_path} && node_modules/.bin/gulp deploy"
        sleep 3
        execute "cd #{release_path} && node_modules/.bin/gulp styles"
      end
    end
  end

  task 'config:build' do
    on roles(:web) do
      within release_path do
        execute "mv #{release_path}/conf/production.config.json #{release_path}/dist/conf.json"
      end
    end
  end

  after :updated, 'deploy:npm:install'
  after :updated, 'deploy:bower:install'
  after :updated, 'deploy:gulp:install'
  after :updated, 'deploy:config:build'

  after :finishing, 'deploy:cleanup'

end
