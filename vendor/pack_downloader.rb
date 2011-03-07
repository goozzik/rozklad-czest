# !/usr/bin/env ruby

require 'net/http'
require 'rubygems'


ARCHIVE = "/tmp/map_rozkl.zip"

Net::HTTP.start("mpk.czest.pl") { |http|
  resp = http.get("/int_rozkl/mpk_rozkl.zip")
  open(ARCHIVE, "wb") { |file|
    file.write(resp.body)
   }
}

system("unzip #{ARCHIVE} -d ./tmp/map_rozkl/")
