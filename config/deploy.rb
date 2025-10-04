lock "~> 3.19.2"

set :application, "tottoku"
set :repo_url, "https://github.com/moaoyama/org_app_tottoku.git"
set :bundle_without, %w{test}.join(':')

set :rbenv_version, '3.3.0'
append :linked_files, 'config/master.key'
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/uploads} 
set :keep_releases, 5
set :rbenv_ruby, '3.3.0'
set :log_level, :info
set :branch, 'main'
set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"
set :unicorn_config_path, "#{current_path}/config/unicorn/production.rb"

after 'deploy:published', 'deploy:seed'
after 'deploy:finished', 'deploy:restart'

namespace :deploy do
   desc 'Run seed'
   task :seed do
    on roles(:db) do
       with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end
  
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
end
