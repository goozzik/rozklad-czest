Feature: Home Page

  Scenario: Entering home page
    When I go to the home page
    Then I should see upper menu
    And I should see "rozkład.czest.pl w łatwy sposób pomoże ci odnaleźć połączenie między przystankami MPK w Częstochowie" within paragraph
    And I should see "Jeżeli chcesz korzystać z funkcji mapy, musisz najpierw udostępnic swoje położenie." within paragraph
    And I should see function button "Odśwież położenie"
