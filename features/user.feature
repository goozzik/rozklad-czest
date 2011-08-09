Feature: User

  Scenario: Register with valid attributes
    When I go to the home page
    And I fill in "user_user_name" with "user"
    And I fill in "user_password" with "password"
    And I fill in "user_password_confirmation" with "password"
    And I click button "Wyślij"
    Then I should see "Rejestracja przebiegła pomyślnie."

  Scenario: Register with not matching password
    When I go to the home page
    And I fill in "user_user_name" with "user"
    And I fill in "user_password" with "password"
    And I fill in "user_password_confirmation" with "ssword"
    And I click button "Wyślij"
    Then I should see "Podane hasła nie zgadzają się." within list item

  Scenario: Register with user name that already exist
    Given a user exists
    When I go to the home page
    And I fill in "user_user_name" with "user"
    And I fill in "user_password" with "password"
    And I fill in "user_password_confirmation" with "password"
    And I click button "Wyślij"
    Then I should see "Użytkownik o podanym loginie już istnieje." within list item

  Scenario: Register with blank name
    When I go to the home page
    And I fill in "user_user_name" with ""
    And I fill in "user_password" with ""
    And I fill in "user_password_confirmation" with ""
    And I click button "Wyślij"
    Then I should see "Wypełnij pole Login." within list item

  Scenario: Register with blank password
    When I go to the home page
    And I fill in "user_user_name" with ""
    And I fill in "user_password" with ""
    And I fill in "user_password_confirmation" with ""
    And I click button "Wyślij"
    Then I should see "Wypełnij pole Hasło." within list item

  Scenario: Log in with valid attributes
    Given a user exist
    When I go to the home page
    And I fill in "user_name" with "user"
    And I fill in "password" with "password"
    And I click button "Zaloguj"
    Then I should see "user" within h2

  Scenario: Log in with invalid attributes
    Given a user exist
    When I go to the home page
    And I fill in "user_name" with "bad_user"
    And I fill in "password" with "bad_password"
    And I click button "Zaloguj"
    Then I should not see "user"
