# coding: utf-8

@iphone
Feature: Home Page

  Scenario: Entering home page when i am not logged in
    When I go to the iphone home page
    Then I should see upper menu
    And I should see login form on iphone
    And I should see registration form

  Scenario: Entering home page when i am logged in and i have favourite with on_start_page set to true
    Given a favourite exists with on_start_page: true
    And I am logged in
    When I go to the iphone home page
    Then I should see upper menu
    And I should see login information box
    And I should see "Ulubione" within upper menu link to "/users/1/favourites"
    And I should see link "Dom" within list item on iphone

  Scenario: Entering home page when i am logged in and i have favourite with on_start_page set to false
    Given a favourite exists
    And I am logged in
    When I go to the iphone home page
    Then I should see upper menu
    And I should see login information box
    And I should see "Ulubione" within upper menu link to "/users/1/favourites"
    And I should not see link "Dom" within list item on iphone

  Scenario: Navigate to search page
    When I go to the iphone home page
    And I follow "SZUKAJ" on iphone
    Then I should see upper menu
    And I should see radio button "from_station" with label "Z przystanku" on iphone
    And I should see radio button "from_location" with label "Z mojego położenia" on iphone
    And I should see radio button "to_station" with label "Do przystanku" on iphone
    And I should see radio button "to_location" with label "Na adres" on iphone
    And I should see location refresh button
    And I should see button "Szukaj" with icon "forward"

  Scenario: Navigate to favourite page when i am logged in and i have favourite
    Given a favourite exists
    And I am logged in
    When I go to the iphone home page
    And I follow "Ulubione" on iphone
    Then I should see upper menu
    And I should see "Ulubione" within upper menu link to "/users/1/favourites"
    And I should see link "Dom" within list item on iphone
    And I should see icon "gear" within list item on iphone
    And I should see button "Dodaj" with icon "plus"

  Scenario: Navigate to favourite page when i am logged in and i do not have favourite
    Given a user exists
    And I am logged in
    When I go to the iphone home page
    And I follow "Ulubione" on iphone
    Then I should see upper menu
    And I should see "Ulubione" within upper menu link to "/users/1/favourites"
    And I should see "W tej chwili nie masz żadnych ulubionych." within list item
    And I should see button "Dodaj" with icon "plus"

  Scenario: Navigate to map page
    When I go to the iphone home page
    And I follow "Mapa" on iphone
    Then I should see upper menu
    And I should see static map

  Scenario: Navigate to schedules page
    When I go to the home page
    And I follow "Rozkłady"
    Then I should see "dla przystanku"
    Then I should see "dla linii"

  Scenario: Navigate to stations page
    Given a station from station exists
    And a station to station exists
    When I go to the iphone home page
    And I follow "Rozkłady" on iphone
    And I follow "dla przystanku"
    Then I should see upper menu
    And I should see "Z" within list divider
    And I should see link "ZANA" within list item on iphone
    And I should see "M" within list divider
    And I should see link "MALOWNICZA" within list item on iphone

  Scenario: Navigate to lines page
    Given a line exists
    When I go to the iphone home page
    And I follow "Rozkłady" on iphone
    And I follow "dla linii" on iphone
    Then I should see upper menu
    And I should see border link "1" within list item on iphone
