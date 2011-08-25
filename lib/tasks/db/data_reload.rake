namespace :db do

  desc 'Reload current data from mpk.czest.pl (schedules, lines, stations and connections)'
  task :data_reload => [ :data_drop, :data_load ] do
  end

end
