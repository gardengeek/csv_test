Feature: User forgot their password.
  As a user
  I want to forget my password
  So I can use the app to send me an email with instructions on how to change it.

  Scenario: email exists
    Given I am signed up as "alice@example.com/testing"
    And I am on the sign in page
    When I follow "Forgot password"
    And I fill in "Email" with "alice@example.com"
    And I press "Send me reset password instructions"
    Then alice@example.com should receive an email
    And I should be on the user sign in page
    And I should see "You will receive an email with instructions about how to reset your password in a few minutes."

  Scenario: email does not exist
    Given I am signed up as "alice@example.com/testing"
    And I am on the sign in page
    When I follow "Forgot password"
    And I fill in "Email" with "malory@example.com"
    And I press "Send me reset password instructions"
    Then I should be on the passwords page
    And I should see "Email not found"
