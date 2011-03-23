desc 'Create development environment with loaded data'
task :bootstrap do
  [ 'db:bootstrap', 'pack:cleanup', 'pack:extract', 'db:import:stations' ].each do |task|
    Rake::Task[task].invoke
  end
end
