Feature: Home Page

  Scenario: Entering home page when i am not logged in
    When I go to the home page
    Then I should see upper menu
    And I should see login form
    And I should see registration form
    And I should see service info box
    And I should see location info box

  Scenario: Entering home page when i am logged in and i have favourite with on_start_page set to true
    Given a favourite exists with on_start_page: true
    And I am logged in
    When I go to the home page
    Then I should see upper menu
    And I should see "ULUBIONE" within upper menu link to "/users/1/favourites"
    And I should see service info box
    And I should see location info box
    And I should see link "Dom" within list item

  Scenario: Entering home page when i am logged in and i have favourite with on_start_page set to false 
    Given a favourite exists
    And I am logged in
    When I go to the home page
    Then I should see upper menu
    And I should see "ULUBIONE" within upper menu link to "/users/1/favourites"
    And I should see service info box
    And I should see location info box
    And I should not see link "Dom" within list item

  Scenario: Navigate to search page
    When I go to the home page
    And I follow "SZUKAJ"
    Then I should see upper menu
    And I should see checkbox "from_station" with label "Z przystanku"
    And I should see checkbox "from_my_location" with label "Z mojego położenia"
    And I should see text field "station_to" with label "Przystanek docelowy"
    And I should see button "Szukaj" with icon "forward"

  Scenario: Navigate to favourite page when i am logged in and i have favourite
    Given a favourite exists
    And I am logged in
    When I go to the home page
    And I follow "ULUBIONE"
    Then I should see upper menu
    And I should see "ULUBIONE" within upper menu link to "/users/1/favourites"
    And I should see link "Dom" within list item
    And I should see link "Edytuj" within list item
    And I should see button "Dodaj" with icon "plus"

  Scenario: Navigate to favourite page when i am logged in and i do not have favourite
    Given a user exists
    And I am logged in
    When I go to the home page
    And I follow "ULUBIONE"
    Then I should see upper menu
    And I should see "ULUBIONE" within upper menu link to "/users/1/favourites"
    And I should see "W tej chwili nie masz żadnych ulubionych." within list item 
    And I should see button "Dodaj" with icon "plus"

  Scenario: Navigate to map page
    When I go to the home page
    And I follow "MAPA"
    Then I should see upper menu
    And I should see static map

  Scenario: Navigate to stations page
    Given a station from station exists
    And a station to station exists
    When I go to the home page
    And I follow "PRZYSTANKI"
    Then I should see upper menu
    And I should see "Z" within list divider
    And I should see link "ZANA" within list item
    And I should see "M" within list divider
    And I should see link "MALOWNICZA" within list item

  Scenario: Navigate to lines page
    Given a line exists
    When I go to the home page
    And I follow "LINIE"
    Then I should see upper menu
    And I should see border link "1" within list item
