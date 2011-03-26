namespace :heroku do

  desc "Bootstrap application locally and push it to heroku"
  task :bootstrap do
    Rake::Task['bootstrap'].invoke
    Rake::Task['heroku:install'].invoke
  end

end
