Feature: Home Page

  Scenario: Entering home page when i have favourite with on_start_page set to true
    Given a favourite exists with on_start_page: true
    When I go to the home page
    Then I should see upper menu
    And I should see "Łatwo i szybko" within second header
    And I should see "rozkład.czest.pl w łatwy sposób pomoże ci odnaleźć połączenie między przystankami MPK w Częstochowie" within third header 
    And I should see "Udostępnij położenie" within second header 
    And I should see "Jeżeli chcesz korzystać z funkcji mapy, musisz najpierw udostępnic swoje położenie." within third header 
    And I should see function button "Odśwież położenie"
    And I should see link "Dom" within list item

  Scenario: Entering home page when i have favourite with on_start_page set to false 
    Given a favourite exists
    When I go to the home page
    Then I should see upper menu
    And I should see "Łatwo i szybko" within second header
    And I should see "rozkład.czest.pl w łatwy sposób pomoże ci odnaleźć połączenie między przystankami MPK w Częstochowie" within third header 
    And I should see "Udostępnij położenie" within second header 
    And I should see "Jeżeli chcesz korzystać z funkcji mapy, musisz najpierw udostępnic swoje położenie." within third header 
    And I should see function button "Odśwież położenie"
    And I should not see link "Dom" within list item

  Scenario: Navigate to search page
    When I go to the home page
    And I follow "SZUKAJ"
    Then I should see upper menu
    And I should see checkbox "from_station" with label "Z przystanku"
    And I should see checkbox "from_my_location" with label "Z mojego położenia"
    And I should see text field "station_to" with label "Przystanek docelowy"
    And I should see button "Szukaj" with icon "forward"

  Scenario: Navigate to favourite page when i have favourite
    Given a favourite exists
    When I go to the home page
    And I follow "ULUBIONE"
    Then I should see upper menu
    And I should see link "Dom" within list item
    And I should see link "Edytuj" within list item
    And I should see button "Dodaj" with icon "plus"

  Scenario: Navigate to favourite page when i don't have favourite
    When I go to the home page
    And I follow "ULUBIONE"
    Then I should see upper menu
    And I should see "W tej chwili nie masz żadnych ulubionych." within list item 
    And I should see button "Dodaj" with icon "plus"

  Scenario: Navigate to map page
    When I go to the home page
    And I follow "MAPA"
    Then I should see upper menu
    And I should see static map
