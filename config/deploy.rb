set :application, "rozklad.czest.pl"
set :repository,  "git@192.168.88.2:rozklad.czest.pl.git"

set :ruby_version, "1.9.2"
set :ruby_patch, "290"

set :nexus_server, "176.9.20.181"
set :user, "rozklad"

#
# Next lines depends on previous configuration (please do not change them)
#

role :web, nexus_server                          # Your HTTP server, Apache/etc
role :app, nexus_server                          # This may be the same as your `Web` server
role :db,  nexus_server, :primary => true        # This is where Rails migrations will run

set :rvm_gemset, application
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                               # Load RVM's capistrano plugin.
set :rvm_ruby_string, "#{ruby_version}@#{rvm_gemset}"  # Or whatever env you want it to run in.
require "bundler/capistrano"

set :scm, :git
set :git_shallow_clone, 1
set :deploy_via, :copy
set :use_sudo, false
set :deploy_to, "/var/apps/#{user}"

set :rvm_type, :user  # Copy the exact line. I really mean :user here
set :gem_path, "#{deploy_to}/.rvm/gems/ruby-#{ruby_version}-p#{ruby_patch}@#{rvm_gemset}"
set :default_environment, {
  'PATH' => "#{gem_path}/bin:#{deploy_to}/.rvm/bin:#{deploy_to}/.rvm/ruby-#{ruby_version}-p#{ruby_patch}/bin:$PATH",
  'RUBY_VERSION' => "ruby #{ruby_version}",
  'GEM_HOME'     => gem_path,
  'GEM_PATH'     => gem_path,
  'BUNDLE_PATH'  => gem_path
}

set :rails_env, :production
set :unicorn_binary, "unicorn_rails"
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"

namespace :bundle do

  task :install do
    run "cd #{latest_release} && rvm '#{rvm_ruby_string}' && bundle install --gemfile #{latest_release}/Gemfile --quiet --without development test"
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

after "deploy:symlink", "deploy:migrate"
after "deploy", "deploy:notify_newrelic"

require './config/boot'
require 'airbrake/capistrano'
