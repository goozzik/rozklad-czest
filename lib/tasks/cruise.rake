desc "Run CruiseControl.rb tests"
task :cruise do
  [ 'rspec spec', 'cucumber' ].each do |task|
    system(task)
  end
end
