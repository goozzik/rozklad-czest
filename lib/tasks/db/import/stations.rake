require 'nokogiri'
require 'open-uri'
require 'iconv'
require 'rake'

namespace :db do
  namespace :import do

    PACK_DIR = File.join(Rails.root, 'tmp', 'map_rozkl')
    STATIONS_FILE = File.join(PACK_DIR, 'rozklady', 'przystan.htm')

    desc "Import stations"
    task :stations => :environment do
      doc = Nokogiri::HTML(open(STATIONS_FILE))
      doc.xpath("//html/body/table/tr[*]/td/ul/li/a").map(&:content).each do |station|
        Station::Import.create_if_needed!(station)
      end
    end

  end
end
