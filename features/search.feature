Feature: Search

  Scenario: Search from station when station from not exist
    Given a station to station exists
    When I go to the search page
    And I fill in "station_from" with "zana"
    And I fill in "station_to" with "malownicza"
    And I click button "Szukaj"
    Then I should see "Przystanek odjazdowy nie istnieje." within list item

  Scenario: Search from station when station to not exist
    Given a station from station exists
    When I go to the search page
    And I fill in "station_from" with "zana"
    And I fill in "station_to" with "malownicza"
    And I click button "Szukaj"
    Then I should see "Przystanek docelowy nie istnieje." within list item

  Scenario: Search from station when line not exist
    Given a station to station exists
    And a station from station exists
    When I go to the search page
    And I fill in "station_from" with "zana"
    And I fill in "station_to" with "malownicza"
    And I click button "Szukaj"
    Then I should see "Brak połączeń." within list item

  Scenario: Search from station and check map when i haven't passed my location
    Given a schedule exists
    And I have time 22:30
    When I go to the search page
    And I fill in "station_from" with "zana"
    And I fill in "station_to" with "malownicza"
    And I click button "Szukaj"
    Then I should see div "Z: ZANA" within list divider
    And I should see div "Kierunek: MALOWNICZA" within list divider
    And I should see div "Do: MALOWNICZA" within list divider
    And I should see link "1 o 22:40" within list item
    And I should not see "Dodaj do ulubionych"
    When I follow "1 o 22:40"
    Then I should see "Jeżeli chcesz korzystać z funkcji mapy, musisz najpierw udostępnić swoje położenie." within list item

  Scenario: Search from station and do not show inversely line
    Given a schedule exists
    And an inversely schedule exists
    And I have time 22:30
    When I go to the search page
    And I fill in "station_from" with "zana"
    And I fill in "station_to" with "malownicza"
    And I click button "Szukaj"
    Then I should see div "Z: ZANA" within list divider
    And I should see div "Kierunek: MALOWNICZA" within list divider
    And I should see div "Do: MALOWNICZA" within list divider
    And I should see link "1 o 22:40" within list item
    And I should not see "Dodaj do ulubionych"

  Scenario: Search for schedule and add found schedule to favourites when im logged in
    Given a user exists
    And I am logged in
    And a schedule exists
    And I have time 22:30
    When I go to the search page
    And I fill in "station_from" with "zana"
    And I fill in "station_to" with "malownicza"
    And I click button "Szukaj"
    Then I should see div "Z: ZANA" within list divider
    And I should see div "Kierunek: MALOWNICZA" within list divider
    And I should see div "Do: MALOWNICZA" within list divider
    And I should see link "1 o 22:40" within list item
    And I should see border link "Dodaj do ulubionych" within list item
    When I follow "Dodaj do ulubionych"
    Then I should see link "ZANA -> MALOWNICZA" within list item

  Scenario: Search from station to address when address not exist
    Given a schedule exists
    And I have time 22:30
    When I go to the search page
    And I fill in "station_from" with "zana"
    And I choose "Na adres"
    And I fill in "location_to" with "xxxasd"
    And I click button "Szukaj"
    Then I should see "Brak połączeń." within list item

  Scenario: Search from station to address when address is too far
    Given a schedule exists
    And I have time 22:30
    When I go to the search page
    And I fill in "station_from" with "zana"
    And I choose "Na adres"
    And I fill in "location_to" with "warszawa"
    And I click button "Szukaj"
    Then I should see "Brak połączeń." within list item

  Scenario: Search from station to address when station from not exist
    Given a station to station exists
    When I go to the search page
    And I fill in "station_from" with "zana"
    And I choose "Na adres"
    And I fill in "location_to" with "malownicza"
    And I click button "Szukaj"
    Then I should see "Przystanek odjazdowy nie istnieje." within list item

  Scenario: Search from station to address when line not exist
    Given a station to station exists
    And a station from station exists
    When I go to the search page
    And I fill in "station_from" with "zana"
    And I choose "Na adres"
    And I fill in "location_to" with "malownicza"
    And I click button "Szukaj"
    Then I should see "Brak połączeń." within list item

  Scenario: Search from station to address
    Given a schedule exists
    And I have time 22:30
    When I go to the search page
    And I fill in "station_from" with "zana"
    And I choose "Na adres"
    And I fill in "location_to" with "malownicza"
    And I click button "Szukaj"
    Then I should see div "Z: ZANA" within list divider
    And I should see div "Kierunek: MALOWNICZA" within list divider
    And I should see div "Do: MALOWNICZA" within list divider
    And I should see link "1 o 22:40" within list item

#  TODO: Scenario: Search from location to address
#  TODO: Get know how to get access to session variables
#  Scenario: Search from station and check map when i have passed my location
#    Given a schedule exists
#    And I have time 22:30
#    When I go to the search page
#    And I check checkbox "Z przystanku"
#    And I fill in "station_from" with "zana"
#    And I fill in "station_to" with "malownicza"
#    And I click button "Szukaj"
#    Then I should see upper menu
#    And I should see "Przystanek: ZANA" within div
#    And I should see "Kierunek: NIERADA" within div
#    And I should see link "1 o 22:40" within list item
#    When I follow "1 o 22:40"
#    Then I should see generated map
#
#  Scenario: Search from location 
#    Given I have passed my location
#    And a schedule exists
#    And I have time 22:30
#    When I go to the search page
#    And I check checkbox "Z mojego położenia"
#    And I fill in "within" with "2"
#    And I fill in "station_to" with "malownicza"
#    And I click button "Szukaj"
#    Then I should see "Przystanek: ZANA" within div
#    And I should see "Kierunek: NIERADA" within div
#    And I should see link "1 o 22:40" within list item
#    When I follow "1 o 22:40"
#    Then I should see generated map
