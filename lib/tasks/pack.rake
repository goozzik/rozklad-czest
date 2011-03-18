namespace :pack do

  TMP = File.join(Rails.root, 'tmp')
  ARCHIVE = File.join(TMP, 'map_rozkl.zip')
  UNPACK = File.join(TMP, 'map_rozkl')

  desc "Download data pack"
  task :download => [ :ensure_tmp ] do
    require 'net/http'
    Net::HTTP.start('mpk.czest.pl') do |http|
      resp = http.get('/int_rozkl/mpk_rozkl.zip')
      open(ARCHIVE, 'wb') do |file|
        file.write(resp.body)
      end
    end
  end

  desc 'Extract downloaded data pack'
  task :extract => [ :ensure_tmp ] do
    Rake::Task['pack:download'].invoke unless File.exist?(ARCHIVE)
    system("unzip #{ARCHIVE} -d #{UNPACK}")
  end

  desc 'Remove data pack'
  task :cleanup do
    system("rm -rf #{UNPACK}") if File.directory?(UNPACK)
    system("rm -f #{ARCHIVE}") if File.exist?(ARCHIVE)
  end

  task :ensure_tmp do
    system("mkdir -p #{TMP}") unless File.directory?(TMP)
  end

end
