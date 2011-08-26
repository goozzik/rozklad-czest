Feature: Layout

  Scenario: Site description
    When I am on the home page
    Then I should see "Jedyny serwis wyszukujący połączenia komunikacji miejskiej w Częstochowie."

  Scenario: Title tag
    When I am on the home page
    Then I should see "rozkład.czest.pl - Jedyny serwis wyszukujący połączenia komunikacji miejskiej w Częstochowie." within title

