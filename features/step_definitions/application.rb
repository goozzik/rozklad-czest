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

Then /^I should see checkbox "([^"]*)" with label "([^"]*)"$/ do |name, label|
  page.should have_xpath( "//input[@type='checkbox'][@name='#{name}']/../label[contains(text(), \"#{label}\")]" )
end

Then /^I should see text field "([^"]*)" with label "([^"]*)"$/ do |name, label|
  page.should have_xpath( "//input[@type='text'][@name='#{name}']/../label[contains(text(), \"#{label}\")]" )
end

Then /^I should see button "([^"]*)" with icon "([^"]*)"$/ do |text, icon|
  page.should have_xpath( "//input[@type='submit'][@value='#{text}'][@data-icon='#{icon}']" )
end

Then /^I should see link "([^"]*)" within list item$/ do |link|
  page.should have_xpath( "//li[@class='item_box']/a[contains(text(), \"#{link}\")]" )
end

Then /^I should not see link "([^"]*)" within list item$/ do |link|
  page.should_not have_xpath( "//li[@class='item_box']/a[contains(text(), \"#{link}\")]" )
end
