@iphone
Feature: Schedule

  Scenario: Go to station - line road - schedule
    Given a schedule exists
    When I am on the iphone stations page
    And I follow "ZANA" on iphone
    Then I should see "ZANA" within list divider
    And I should see link "1 - kierunek: MALOWNICZA" within list item on iphone
    When I follow "1 - kierunek: MALOWNICZA" on iphone
    Then I should see road on iphone
    When I follow "ZANA" on iphone
    Then I should see full schedules

  Scenario: Go to line - line directions - line road - schedule
    Given a schedule exists
    When I am on the iphone lines page
    And I follow "1" on iphone
    And I should see link "1 - kierunek: MALOWNICZA" within list item on iphone
    When I follow "1 - kierunek: MALOWNICZA" on iphone
    Then I should see road on iphone
    When I follow "ZANA" on iphone
    Then I should see full schedules

  Scenario: Go to station - line road - schedule
    Given a line exists
    When I am on the stations page
    And I follow "ZANA"
    Then I should see "ZANA" within list divider
    And I should see link "1 - kierunek: MALOWNICZA" within list item
    When I follow "1 - kierunek: MALOWNICZA"
    Then I should see road
    When I follow "ZANA"
    Then I should see "Brak tablicy rozkładów dla tego przystanku."
