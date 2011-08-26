set :application, "rozklad.czest.pl"
set :repository,  "git@192.168.88.2:rozklad.czest.pl.git"

set :rvm_gemset, application
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, "1.9.2@#{rvm_gemset}"        # Or whatever env you want it to run in.
require "bundler/capistrano"

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
set :gem_path, "#{deploy_to}/.rvm/gems/ruby-1.9.2-p290@#{rvm_gemset}"
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

namespace :bundle do

  task :install do
    run "cd #{current_path} && rvm '#{rvm_ruby_string}' && bundle install --gemfile #{latest_release}/Gemfile --quiet --without development test"
  end

end


namespace :deploy do

  task :start, :roles => :app, :except => { :no_release => true } do 
    run "cd #{current_path} && #{try_sudo} #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  end

  task :stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -9 `cat #{unicorn_pid}`"
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

  task :data_reload, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=production rake db:data_reload"
  end

  task :notify_newrelic, :roles => :app, :except => { :no_release => true } do
    system "newrelic deployments"
  end

end

after "deploy", "deploy:notify_newrelic"
