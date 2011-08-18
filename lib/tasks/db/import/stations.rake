require 'nokogiri'
require 'open-uri'
require 'iconv'
require 'rake'
require 'rubygems'
require './config/environment'

namespace :db do
  namespace :import do

    desc "Import stations"
    task :stations => :environment do
      doc = Nokogiri::HTML(open('http://mpk.czest.pl/int_rozkl/rozklady/przystan_all.htm'))
      doc.xpath("//html/body/table/tr[*]/td/ul/li/a").map(&:content).each do |station|
        Station::Import.create_if_needed!(station)
      end
    end

  end
end
