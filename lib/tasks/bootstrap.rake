desc 'Create development environment with loaded data'
task :bootstrap do
  [ 'db:bootstrap', 'pack:cleanup', 'pack:extract' ].each do |task|
    Rake::Task[task].invoke
  end
  system("ruby vendor/initial_html_data_extractor.rb extract")
end
