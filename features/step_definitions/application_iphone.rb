# coding: utf-8
Then /^I should see link "([^"]*)" within list item on iphone$/ do |text|
  page.should have_xpath( "//li/div/div/a[contains(text(), \"#{text}\")]" )
end

Then /^I should not see link "([^"]*)" within list item on iphone$/ do |text|
  page.should_not have_xpath( "//li/div/div/a[contains(text(), \"#{text}\")]" )
end

Then /^I should see radio button "([^"]*)" with label "([^"]*)" on iphone$/ do |name, label|
  page.should have_xpath( "//input[@type='radio'][@id='#{name}']" )
  page.should have_xpath( "//label/span/span[contains(text(), \"#{label}\")]" )
end

Then /^I should see checkbox "([^"]*)" with label "([^"]*)" on iphone$/ do |name, label|
  page.should have_xpath( "//input[@type='checkbox'][@id='#{name}']" )
  page.should have_xpath( "//label/span/span[contains(text(), \"#{label}\")]" )
end

Then /^I should see border link "([^"]*)" within list item on iphone$/ do |link|
  page.should have_xpath( "//li/b/a[contains(text(), \"#{link}\")]" )
end

Then /^I should see icon "([^"]*)" within list item on iphone$/ do |icon|
  page.should have_xpath( "//a[@data-icon='#{icon}']" )
end

Then /^I should not see icon "([^"]*)" within list item on iphone$/ do |icon|
  page.should_not have_xpath( "//a[@data-icon='#{icon}']" )
end

Then /^I should see new favourite form on iphone$/ do
  Then "I should see text field \"favourite_name\" with label \"Nazwa\" on iphone"
  Then "I should see text field \"favourite_station_from\" with label \"Przystanek odjazdowy\" on iphone"
  Then "I should see text field \"favourite_station_to\" with label \"Przystanek docelowy\" on iphone"
  Then "I should see checkbox \"favourite_on_start_page\" with label \"Pokaż na stronie startowej\" on iphone"
  Then "I should see button \"Zapisz\""
end

Then /^I should see text field "([^"]*)" with label "([^"]*)" on iphone$/ do |name, label|
  page.should have_xpath( "//input[@type='text'][@id='#{name}']" )
  page.should have_xpath( "//label[contains(text(), \"#{label}\")]" )
end

Then /^I should see edit favourite form on iphone$/ do
  Then "I should see new favourite form on iphone"
  Then "I should see button \"Usuń\""
end

Then /^I should see road on iphone$/ do
  Then "I should see \"1 - kierunek: MALOWNICZA\" within list divider"
  Then "I should see link \"ZANA\" within list item on iphone"
  Then "I should see link \"MALOWNICZA\" within list item on iphone"
end

When /^I follow "([^"]*)" on iphone$/ do |link|
  with_scope("div.ui-page-active") do
    click_link(link)
  end
end

Then /^I should see login form on iphone$/ do
  Then "I should see text field \"user_name\" with label \"Login\""
  Then "I should see password field \"password\" with label \"Hasło\""
  Then "I should see checkbox \"remember_me\" with label \"Zapamiętaj mnie\" on iphone"
  Then "I should see button \"Zaloguj\""
end

When /^I wait till map load$/ do
  sleep(10)
end

Then /^I should have full screen$/ do
  page.should have_xpath( "//meta[@content='yes'][@name='apple-mobile-web-app-capable']" )
end
