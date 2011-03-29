Then /^I should see "([^"]*)" within upper menu link to "([^"]*)"$/ do |text, link|
  Then "I should see \"#{text}\" within \"div[@data-role='navbar']/ul/li/a[@rel='external'][@href='#{link}']\""
end

Then /^I should see upper menu$/ do
  Then "I should see \"Index\" within upper menu link to \"/\""
  Then "I should see \"Szukaj\" within upper menu link to \"/search_schedule/new_search\""
  Then "I should see \"Ulubione\" within upper menu link to \"/favourites\""
  Then "I should see \"Mapa\" within upper menu link to \"/pages/static_map\""
end

Then /^I should see "([^"]*)" within paragraph$/ do |text|
  page.should have_xpath( "//p[contains(text(), \"#{text}\")]" )
end

Then /^I should see function button "([^"]*)"$/ do |text|
  page.should have_xpath( "//input[@type='button'][@value='#{text}'][@data-icon='refresh']" )
end

Then /^I should see checkbox "([^"]*)" with label "([^"]*)"$/ do |name, label|
  page.should have_xpath( "//input[@type='checkbox'][@name='#{name}']" )
  page.should have_xpath( "//label[contains(text(), \"#{label}\")]" )
end

Then /^I should see text field "([^"]*)" with label "([^"]*)"$/ do |name, label|
  page.should have_xpath( "//input[@type='text'][@name='#{name}']" )
  page.should have_xpath( "//label[contains(text(), \"#{label}\")]" )
end

Then /^I should see button "([^"]*)" with icon "([^"]*)"$/ do |text, icon|
  page.should have_xpath( "//input[@type='submit'][@value='#{text}'][@data-icon='#{icon}']" )
end

Then /^I should see button "([^"]*)"$/ do |text|
  page.should have_xpath( "//input[@type='submit'][@value='#{text}']" )
end

Then /^I should see link "([^"]*)" within list item$/ do |link|
  page.should have_xpath( "//li/a[contains(text(), \"#{link}\")]" )
end

Then /^I should not see link "([^"]*)" within list item$/ do |link|
  page.should_not have_xpath( "//li/a[contains(text(), \"#{link}\")]" )
end

Then /^I should see "([^"]*)" within div$/ do |text|
  page.should have_xpath ( "//div[contains(text(), \"#{text}\")]" )
end

Then /^I should see static map$/ do
  page.should have_xpath ( '//iframe' )
end

Given /^I have time 22:30$/ do
  Time.stub!(:now => Time.new(2011, 3, 24, 22, 30))
end

When /^I check checkbox "([^"]*)"$/ do |checkbox|
  check( "#{checkbox}" )
end

When /^I click button "([^"]*)"$/ do |button|
  click_button( "#{button}" )
end

Then /^I should see "([^"]*)" within list divider$/ do |text|
  page.should have_xpath ( "//li[@class='item_box'][@data-role='list-divider'][contains(text(), \"#{text}\")]" )
end

Then /^I should see generated map$/ do
  page.should have_xpath ( "//div[@id='map']" )
end
