require "rubygems"
require "selenium/client"

begin
  @selenium = Selenium::Client::Driver.new \
    :host => "localhost",
    :port => 4444,
    :browser => "*chrome",
    :url => "http://www.maps.google.pl/",
    :timeout_in_second => 60

  @selenium.start_new_browser_session

  @selenium.open "/"
  @selenium.click "//*[@id='gbi4s1']"
  @selenium.wait_for_page_to_load "30000"
  @selenium.type "//*[@id='Email']", "rozkladczestpl"
  @selenium.type "//*[@id='Passwd']", "123edcxzaq"
  @selenium.click "//*[@id='PersistentCookie']"
  @selenium.click "//*[@id='signIn']"
  @selenium.wait_for_page_to_load "30000"
  @selenium.click "//*[@id='m_launch']"
  @selenium.wait_for_page_to_load "30000"
  @selenium.click "//a[@jsaction='mp.showMore'][@mpt='2011-07-27']"

  1.upto(103) do |i|
    puts @selenium.content "//div[@class='mp-item'][@jsinstance='#{i}]/div[@class='mp-title']/a[@jsaction='mp.loadMap']/@href"
  end

end

