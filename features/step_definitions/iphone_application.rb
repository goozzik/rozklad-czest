Then /^I should see link "([^"]*)" within list item on iphone$/ do |text|
  page.should have_xpath( "//li/div/div/a[contains(text(), \"#{text}\")]" )
end

Then /^I should not see link "([^"]*)" within list item on iphone$/ do |text|
  page.should_not have_xpath( "//li/div/div/a[contains(text(), \"#{text}\")]" )
end

Then /^I should see checkbox "([^"]*)" with label "([^"]*)" on iphone$/ do |name, label|
  page.should have_xpath( "//input[@type='checkbox'][@id='#{name}']" )
  page.should have_xpath( "//label/span/span[contains(text(), \"#{label}\")]" )
end

Then /^I should see border link "([^"]*)" within list item on iphone$/ do |link|
  page.should have_xpath( "//li/div/div/b/a[contains(text(), \"#{link}\")]" )
end

Then /^I should see icon "([^"]*)" within list item on iphone$/ do |icon|
  page.should have_xpath( "//a[@data-icon='#{icon}']" )
end
