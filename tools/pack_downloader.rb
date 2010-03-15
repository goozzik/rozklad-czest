# #!/usr/bin/env ruby
# require 'net/http'
# require 'fileutils'

require 'config/environment'
require 'rubygems'

# require 'zip/zip'
# require 'zip/zipfilesystem'


ARCHIVE = "#{RAILS_ROOT}/tmp/map_rozkl.zip"

Net::HTTP.start("mpk.czest.pl") { |http|
  resp = http.get("/int_rozkl/mpk_rozkl.zip")
  open(ARCHIVE, "wb") { |file|
    file.write(resp.body)
   }
}

system("unzip #{ARCHIVE} -d #{RAILS_ROOT}/tmp/map_rozkl/")

