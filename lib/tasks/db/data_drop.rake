namespace :db do

  desc 'Drop current data (schedules, lines, stations and connections)'
  task :data_drop do
    system "rake db:migrate:down VERSION=20110826072440" # 20110826072440_add_index_schedules_line_id_station_id.rb
    system "rake db:migrate:down VERSION=20110413044254" # 20110413044254_create_lines_stations.rb
    system "rake db:migrate:down VERSION=20101129054056" # 20101129054056_create_schedules.rb
    system "rake db:migrate:down VERSION=20101129054042" # 20101129054042_create_lines.rb
    system "rake db:migrate:down VERSION=20101129053938" # 20101129053938_create_stations.rb
  end

end
