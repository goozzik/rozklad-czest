# #!/usr/bin/env ruby
# require 'net/http'
# require 'fileutils'

require 'zip/zip'
require 'zip/zipfilesystem'


Net::HTTP.start("mpk.czest.pl") { |http|
  resp = http.get("/int_rozkl/mpk_rozkl.zip")
  open("map_rozkl.zip", "wb") { |file|
    file.write(resp.body)
   }
}

Zip::ZipFile.open("/map_rozklad.zip").each do |single_file|
  single_file.extract(single_file.name)
end


