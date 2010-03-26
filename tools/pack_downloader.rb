#!/usr/bin/env ruby

require 'config/environment'
require 'rubygems'

ARCHIVE = "#{RAILS_ROOT}/tmp/map_rozkl.zip"

Net::HTTP.start("mpk.czest.pl") { |http|
  resp = http.get("/int_rozkl/mpk_rozkl.zip")
  open(ARCHIVE, "wb") { |file|
    file.write(resp.body)
   }
}

system("unzip #{ARCHIVE} -d #{RAILS_ROOT}/tmp/map_rozkl/")

