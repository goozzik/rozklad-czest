namespace :heroku do

  DB_PUSH_PARAMS = File.join(Rails.root, '.db_push_params')

  desc 'Install application on Heroku'
  task :install => [ :push_db, :push_master, :set_time_zone ] do
  end

  desc 'Push database to Heroku'
  task :push_db do
    if File.exist?(DB_PUSH_PARAMS)
      system("heroku db:push #{File.read(DB_PUSH_PARAMS)}")
    else
      system("heroku db:push")
    end
  end

  desc 'Push master branch to Heroku'
  task :push_master do
    system('git push heroku master')
  end
  
  desc 'Change local time zone on Heroku to Warsaw time'
  task :set_time_zone do
    system('heroku config:add TZ=Europe/Warsaw')
  end

end
