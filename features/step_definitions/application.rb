# coding: utf-8
Then /^I should see "([^"]*)" within upper menu link to "([^"]*)"$/ do |text, link|
  Then "I should see \"#{text}\" within \"div[@data-role='navbar']/ul/li/a[@rel='external'][@href='#{link}']\""
end

Then /^I should see upper menu$/ do
  Then "I should see \"Index\" within upper menu link to \"/\""
  Then "I should see \"Szukaj\" within upper menu link to \"/search_schedule/new_search\""
  Then "I should see \"Rozkłady\" within upper menu link to \"/schedules\""
  Then "I should see \"Mapa\" within upper menu link to \"/pages/static_map\""
end

Then /^I should see login form$/ do
  Then "I should see text field \"user_name\" with label \"Login\""
  Then "I should see password field \"password\" with label \"Hasło\""
  Then "I should see checkbox \"remember_me\" with label \"Zapamiętaj mnie\""
  Then "I should see button \"Zaloguj\""
end

Then /^I should see registration form$/ do
  Then "I should see text field \"user[user_name]\" with label \"Login\""
  Then "I should see password field \"user[password]\" with label \"Hasło\""
  Then "I should see password field \"user[password_confirmation]\" with label \"Hasło\""
  Then "I should see button \"Wyślij\""
end

Then /^I should see location info box$/ do
  Then "I should see \"Udostępnij położenie\" within h2"
  Then "I should see \"Jeżeli chcesz korzystać z funkcji mapy, musisz najpierw udostępnic swoje położenie.\" within h3"
  Then "I should see function button \"Odśwież położenie\""
end

Then /^I should see new favourite form$/ do
  Then "I should see text field \"favourite[name]\" with label \"Nazwa\""
  Then "I should see text field \"favourite[station_from]\" with label \"Przystanek odjazdowy\""
  Then "I should see text field \"favourite[station_to]\" with label \"Przystanek docelowy\""
  Then "I should see checkbox \"favourite[on_start_page]\" with label \"Pokaż na stronie startowej\""
  Then "I should see button \"Zapisz\""
end

Then /^I should see edit favourite form$/ do
  Then "I should see new favourite form"
  Then "I should see button \"Usuń\""
end

Then /^I should see post location info box$/ do
  Then "I should see new favourite form"
end

Then /^I should see function button "([^"]*)"$/ do |text|
  page.should have_xpath( "//input[@type='button'][@value='#{text}'][@data-icon='refresh']" )
end

Then /^I should see button "([^"]*)" with icon "([^"]*)"$/ do |text, icon|
  page.should have_xpath( "//input[@type='submit'][@value='#{text}'][@data-icon='#{icon}']" )
end

Then /^I should see button "([^"]*)"$/ do |text|
  page.should have_xpath( "//input[@type='submit'][@value='#{text}']" )
end

Then /^I should see checkbox "([^"]*)" with label "([^"]*)"$/ do |name, label|
  page.should have_xpath( "//input[@type='checkbox'][@name='#{name}']" )
  page.should have_xpath( "//label[contains(text(), \"#{label}\")]" )
end

Then /^I should see text field "([^"]*)" with label "([^"]*)"$/ do |name, label|
  page.should have_xpath( "//input[@type='text'][@name='#{name}']" )
  page.should have_xpath( "//label[contains(text(), \"#{label}\")]" )
end

Then /^I should see password field "([^"]*)" with label "([^"]*)"$/ do |name, label|
  page.should have_xpath( "//input[@type='password'][@name='#{name}']" )
  page.should have_xpath( "//label[contains(text(), \"#{label}\")]" )
end

Then /^I should see link "([^"]*)" within list item$/ do |link|
  page.should have_xpath( "//li/a[contains(text(), \"#{link}\")]" )
end

Then /^I should see border link "([^"]*)" within list item$/ do |link|
  page.should have_xpath( "//li/b/a[contains(text(), \"#{link}\")]" )
end

Then /^I should not see link "([^"]*)" within list item$/ do |link|
  page.should_not have_xpath( "//li/a[contains(text(), \"#{link}\")]" )
end

Then /^I should see "([^"]*)" within list item$/ do |text|
  page.should have_xpath( "//li[contains(text(), \"#{text}\")]" )
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
  page.should have_xpath ( "//li[@data-role='list-divider'][contains(text(), \"#{text}\")]" )
end

Then /^I should see div "([^"]*)" within list divider$/ do |text|
  page.should have_xpath ( "//li[@data-role='list-divider']/div[contains(text(), \"#{text}\")]" )
end

Then /^I should not see div "([^"]*)" within list divider$/ do |text|
  page.should_not have_xpath ( "//li[@data-role='list-divider']/div[contains(text(), \"#{text}\")]" )
end

Then /^I should see generated map$/ do
  page.should have_xpath ( "//div[@id='map']" )
end

Then /^I should see "([^"]*)" within h(\d+)$/ do |text, i|
  page.should have_xpath ( "//h#{i}[contains(text(), \"#{text}\")]" )
end

Given /^I am logged in$/ do
  When "I go to the home page"
  And "I fill in \"user_name\" with \"user\""
  And "I fill in \"password\" with \"password\""
  And "I click button \"Zaloguj\""
end

Then /^I should see road$/ do
  Then "I should see \"1 - kierunek: MALOWNICZA\" within list divider"
  Then "I should see link \"ZANA\" within list item"
  Then "I should see link \"MALOWNICZA\" within list item"
end

Then /^I should see full schedules$/ do
  Then "I should see \"Robocze\" within list divider"
  Then "I should see \"22\""
  Then "I should see \"40\""
end
