namespace :db do

  desc 'Load current data from mpk.czest.pl (schedules, lines, stations and connections)'
  task :data_load => [ :migrate ] do
    system "ruby vendor/initial_html_data_extractor.rb extract"
  end

end
