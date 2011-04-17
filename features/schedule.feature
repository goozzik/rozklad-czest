Feature: Schedule

  Scenario: Go to station - line road - schedule
    Given a line exists
    When I am on the stations page
    And I follow "ZANA"
    Then I should see "ZANA" within list divider
    And I should see link "1 - kierunek: NIERADA" within list item
    When I follow "1 - kierunek: NIERADA"
    Then I should see road
    When I follow "ZANA"
    Then I should see full schedules

  Scenario: Go to line - line directions - line road - schedule
    Given a line exists
    When I am on the lines page
    And I follow "1"
    Then I should see link "1 - kierunek: NIERADA" within list item
    When I follow "1 - kierunek: NIERADA"
    Then I should see road
    When I follow "ZANA"
    Then I should see full schedules
