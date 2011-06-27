Feature: User forgot their password.
  As a user
  I want to forget my password
  So I can use the app to send me an email with instructions on how to change it.

  Scenario: email exists
    Given I am signed up as "alice@example.com/testing"
    And I am on the sign in page
    When I follow "Forgot password"
    And I fill in "Email address" with "alice@example.com"
    And I press "Reset password"
    Then alice@example.com should receive an email
    And I should be on the sign in page
    And I should see /You will receive an email w.thin the next few minutes. It contains instructions for changing your password./

  Scenario: email does not exist
    Given I am signed up as "alice@example.com/testing"
    And I am on the sign in page
    When I follow "Forgot password"
    And I fill in "Email address" with "malory@example.com"
    And I press "Reset password"
    Then I should be on the passwords page
    And I should see "Unknown email."
