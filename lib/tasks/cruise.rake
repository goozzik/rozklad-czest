desc "Run CruiseControl.rb tests"
task :cruise do
  Rake::Task['db:migrate'].invoke
  [ 'rspec spec', 'cucumber features/home_page.feature', 'cucumber features/home_page_iphone.feature', 'cucumber features/search.feature', 'cucumber features/search_iphone.feature', 'cucumber features/favourite.feature', 'cucumber features/favourite_iphone.feature', 'cucumber features/user.feature', 'cucumber features/user_iphone.feature', 'cucumber features/layout.feature', 'cucumber features/schedule.feature', 'cucumber features/schedule_iphone.feature' ].each do |task|
    system(task) or raise
  end
end
