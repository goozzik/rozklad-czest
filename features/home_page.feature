Feature: Home Page

  Scenario: Entering home page when i am not logged in
    When I go to the home page
    Then I should see upper menu
    And I should see login form
    And I should see registration form

  Scenario: Entering home page when i am logged in and i have favourite with on_start_page set to true
    Given a favourite exists with on_start_page: true
    And I am logged in
    When I go to the home page
    Then I should see upper menu
    And I should see login information box
    And I should see "Ulubione" within upper menu link to "/users/1/favourites"
    And I should see link "Dom" within list item

  Scenario: Entering home page when i am logged in and i have favourite with on_start_page set to false
    Given a favourite exists
    And I am logged in
    When I go to the home page
    Then I should see upper menu
    And I should see login information box
    And I should see "Ulubione" within upper menu link to "/users/1/favourites"
    And I should not see link "Dom" within list item

  Scenario: Navigate to search page
    When I go to the home page
    And I follow "Szukaj"
    Then I should see upper menu
    And I should see radio button "from_station" with label "Z przystanku"
    And I should see radio button "from_location" with label "Z mojego położenia"
    And I should see radio button "to_station" with label "Do przystanku"
    And I should see radio button "to_location" with label "Na adres"
    And I should see location refresh button
    And I should see button "Szukaj" with icon "forward"

  Scenario: Navigate to favourite page when i am logged in and i have favourite
    Given a favourite exists
    And I am logged in
    When I go to the home page
    And I follow "Ulubione"
    Then I should see upper menu
    And I should see "Ulubione" within upper menu link to "/users/1/favourites"
    And I should see link "Dom" within list item
    And I should see link "Edytuj" within list item
    And I should see button "Dodaj" with icon "plus"

  Scenario: Navigate to favourite page when i am logged in and i do not have favourite
    Given a user exists
    And I am logged in
    When I go to the home page
    And I follow "Ulubione"
    Then I should see upper menu
    And I should see "Ulubione" within upper menu link to "/users/1/favourites"
    And I should see "W tej chwili nie masz żadnych ulubionych." within list item
    And I should see button "Dodaj" with icon "plus"

  Scenario: Navigate to schedules page
    When I go to the home page
    And I follow "Rozkłady"
    Then I should see "Dla przystanku"
    Then I should see "Dla linii"
    Then I should see "Mapa przystanków"

  Scenario: Navigate to stations page
    Given a station from station exists
    And a station to station exists
    When I go to the home page
    And I follow "Rozkłady"
    And I follow "Dla przystanku"
    Then I should see upper menu
    And I should see "Z" within list divider
    And I should see link "ZANA" within list item
    And I should see "M" within list divider
    And I should see link "MALOWNICZA" within list item

  Scenario: Navigate to lines page
    Given a line exists
    When I go to the home page
    And I follow "Rozkłady"
    And I follow "Dla linii"
    Then I should see upper menu
    And I should see border link "1" within list item

  Scenario: Navigate to stations map page
    When I go to the home page
    And I follow "Rozkłady"
    And I follow "Mapa przystanków"
    Then I should see upper menu
    And I should see static map
