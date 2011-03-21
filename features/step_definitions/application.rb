Then /^I should see "([^"]*)" within upper menu link to "([^"]*)"$/ do |text, link|
  Then "I should see \"#{text}\" within \"div[@data-role='navbar']/ul/li/a[@rel='external'][@href='#{link}']\""
end

Then /^I should see upper menu$/ do
  Then "I should see \"Index\" within upper menu link to \"/\""
  Then "I should see \"Szukaj\" within upper menu link to \"/search_schedule/new_search\""
  Then "I should see \"Ulubione\" within upper menu link to \"/favourites\""
  Then "I should see \"Mapa\" within upper menu link to \"/pages/map\""
end

Then /^I should see "([^"]*)" within paragraph$/ do |text|
  page.should have_xpath( "//p[contains(text(), \"#{text}\")]" )
end

Then /^I should see function button "([^"]*)"$/ do |text|
  page.should have_xpath( "//input[@type='button'][@value='#{text}'][@data-icon='refresh']" )
end
