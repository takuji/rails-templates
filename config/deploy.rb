require 'bundler/capistrano'

set :stages, %w(production staging)
set :default_stage, "production"
require 'capistrano/ext/multistage'

set :application, "app"
#set :repository,  "your-git-repository"
#set :deploy_via, :copy
set :unicorn_port, 3000

set :scm, :git

set :user, 'app'
set :deploy_to, "/home/#{user}/apps/#{application}"
set :use_sudo, false
set :keep_releases, 5

ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]

namespace :deploy do
  desc "Start unicorn"
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && bundle exec unicorn_rails -c config/unicorn.rb -E production -D -l0.0.0.0:#{unicorn_port}"
    #run "cd #{current_path} && RAILS_ENV=production script/delayed_job start"
  end

  desc "Stop unicorn"
  task :stop, :roles => :app, :except => {:no_release => true} do
    run "kill -s QUIT `cat #{shared_path}/pids/unicorn.pid`"
    #run "cd #{current_path} && RAILS_ENV=production script/delayed_job stop"
  end

  desc "Restart unicorn"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "kill -s USR2 `cat #{shared_path}/pids/unicorn.pid`"
    #run "kill -s QUIT `cat #{shared_path}/pids/unicorn.pid.oldbin`"
    #run "cd #{current_path} && RAILS_ENV=production script/delayed_job stop"
    #run "cd #{current_path} && RAILS_ENV=production script/delayed_job start"
  end

  # desc "Start Solr"
  # task :start_solr do
  #   run "cd #{solr_path} && java -jar start.jar"
  # end

  # desc "Make the symlink to public/uploads directory"
  # task :symlink_uploads do
  #   run "mkdir -p #{shared_path}/uploads"
  #   run "ln -nfs #{shared_path}/uploads  #{release_path}/public/uploads"
  # end
end

#after 'deploy:update_code', 'deploy:symlink_uploads'
