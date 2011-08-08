@iphone
Feature: Favourites

  Scenario: Enter new favourite page
    Given a user exists
    And I am logged in
    When I go to the iphone new favourite page
    Then I should see upper menu
    And I should see new favourite form on iphone

  Scenario: Enter edit favourite page
    Given a favourite exists
    And I am logged in
    When I go to the iphone edit favourite page
    Then I should see upper menu
    And I should see edit favourite form on iphone

  Scenario: Create favourite when line not exists
    Given a user exists
    And I am logged in
    And a station from station exists
    And a station to station exists
    When I go to the iphone favourite page
    And I click button "Dodaj"
    And I fill in "favourite_name" with "Dom"
    And I fill in "favourite_station_from" with "zana"
    And I fill in "favourite_station_to" with "malownicza"
    And I click button "Zapisz"
    Then I should see "Brak połączeń." within list item

  Scenario: Create favourite when station from and station to not exists
    Given a user exists
    And I am logged in
    When I go to the iphone favourite page
    And I click button "Dodaj"
    And I fill in "favourite_name" with "Dom"
    And I fill in "favourite_station_from" with "zana"
    And I fill in "favourite_station_to" with "malownicza"
    And I click button "Zapisz"
    Then I should see "Przystanek odjazdowy nie istnieje." within list item
    And I should see "Przystanek docelowy nie istnieje." within list item

  Scenario: Create favourite
    Given a user exists
    And I am logged in
    And a line exists
    When I go to the iphone favourite page
    And I click button "Dodaj"
    And I fill in "favourite_name" with "Dom"
    And I fill in "favourite_station_from" with "zana"
    And I fill in "favourite_station_to" with "malownicza"
    And I click button "Zapisz"
    Then I should see link "Dom" within list item on iphone
    And I should see icon "gear" within list item on iphone

  Scenario: Edit favourite when line not exists
    Given a favourite exists
    And a noline station exists
    And I am logged in
    When I go to the iphone favourite page
    And I follow "Edytuj" on iphone
    And I fill in "favourite_name" with "Dom"
    And I fill in "favourite_station_from" with "malownicza"
    And I fill in "favourite_station_to" with "noline"
    And I click button "Zapisz"
    Then I should see "Brak połączeń." within list item

  Scenario: Edit favourite when station from and station to not exists
    Given a favourite exists
    And I am logged in
    When I go to the iphone favourite page
    And I follow "Edytuj" on iphone
    And I fill in "favourite_name" with "Dom"
    And I fill in "favourite_station_from" with "rynek wieluński"
    And I fill in "favourite_station_to" with "ii aleja najświętszej maryi panny"
    And I click button "Zapisz"
    Then I should see "Przystanek odjazdowy nie istnieje." within list item
    And I should see "Przystanek docelowy nie istnieje." within list item

  Scenario: Edit favourite
    Given a favourite exists
    And I am logged in
    When I go to the iphone favourite page
    And I follow "Edytuj" on iphone
    And I fill in "favourite_name" with "Dom"
    And I fill in "favourite_station_from" with "zana"
    And I fill in "favourite_station_to" with "kopernika"
    And I click button "Zapisz"
    Then I should see link "Dom" within list item on iphone
    And I should see icon "gear" within list item on iphone

  Scenario: Delete favourite
    Given a favourite exists
    And I am logged in
    When I go to the iphone edit favourite page
    And I click button "Usuń"
    Then I should not see link "Dom" within list item on iphone
    And I should not see icon "gear" within list item on iphone
