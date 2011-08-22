require "bundler/capistrano"

set :application, "rozklad.czest.pl"
set :repository,  "git@192.168.88.2:rozklad.czest.pl.git"

set :scm, :git

role :web, "176.9.20.181"                          # Your HTTP server, Apache/etc
role :app, "176.9.20.181"                          # This may be the same as your `Web` server
role :db,  "176.9.20.181", :primary => true        # This is where Rails migrations will run

set :user, "rozklad"
set :git_shallow_clone, 1
set :deploy_via, :copy
set :use_sudo, false
set :deploy_to, "/var/apps/rozklad"

set :rvm_type, :user  # Copy the exact line. I really mean :user here
set :gem_path, "#{deploy_to}/.rvm/gems/ruby-1.9.2-p290@#{application}"
set :default_environment, {
  'PATH' => "#{gem_path}/bin:#{deploy_to}/.rvm/bin:#{deploy_to}/.rvm/ruby-1.9.2-p290/bin:$PATH",
  'RUBY_VERSION' => 'ruby 1.9.2',
  'GEM_HOME'     => gem_path,
  'GEM_PATH'     => gem_path,
  'BUNDLE_PATH'  => gem_path
}

set :rails_env, :production
set :unicorn_binary, "unicorn_rails"
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do 
    run "cd #{current_path} && #{try_sudo} #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do 
    run "#{try_sudo} kill `cat #{unicorn_pid}`"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
end
