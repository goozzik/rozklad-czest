require 'open-uri'
# require 'gzip'

url = "http://www.mpk.czest.pl/int_rozkl/mpk_rozkl.zip"

open(url) { |page| package = page.read() }
decompress(package)
Zlib::GzipReader.new(StringIO.new(package)).read



