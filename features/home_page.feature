Feature: Home Page

  Scenario: Entering home page
    When I go to the home page
    Then I should see upper menu
    And I should see "rozkład.czest.pl w łatwy sposób pomoże ci odnaleźć połączenie między przystankami MPK w Częstochowie" within paragraph
    And I should see "Jeżeli chcesz korzystać z funkcji mapy, musisz najpierw udostępnic swoje położenie." within paragraph
    And I should see function button "Odśwież położenie"

  Scenario: Navigate to search page
    When I go to the home page
    And I follow "Szukaj"
    Then I should see upper menu
    And I should see checkbox "from_station" with label "Z przystanku"
    And I should see checkbox "from_my_location" with label "Z mojego położenia"
    And I should see text field "station_to" with label "Przystanek docelowy"
    And I should see forward button "Szukaj"
