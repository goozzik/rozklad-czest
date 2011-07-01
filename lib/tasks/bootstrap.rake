desc 'Create development environment with loaded data'
task :bootstrap do
  Rake::Task['db:bootstrap'].invoke
  system("ruby vendor/initial_html_data_extractor.rb extract")
end
