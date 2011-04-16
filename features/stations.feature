Feature: Stations

  Scenario: Go to station 
    Given a line exists
    When I am on the stations page
    And I follow "ZANA"
    Then I should see "ZANA" within list divider
    And I should see link "1 - kierunek: NIERADA" within list item
