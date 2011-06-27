Feature: User edits their account.
  As a user
  I want to edit my account
  So I can change my email, and password.

  Scenario: happy
    Given I am signed in as "alice@example.com/testing"
    And I am on the account page
    When I follow "Edit"
    And I fill in "Email" with "alicia@example.com"
    And I fill in "Password" with "soooper"
    And I press "Update"
    Then I should be on the account page
    And I should see "Account updated!"
    And I should see "alicia@example.com"
    And the password for "alicia@example.com" should be "soooper"

  Scenario: no password change
    Given I am signed in as "alice@example.com/testing"
    And I am on the account page
    When I follow "Edit"
    And I fill in "Email" with "alicia@example.com"
    And I press "Update"
    Then I should be on the account page
    And I should see "Account updated!"
    And I should see "alicia@example.com"
    And the password for "alicia@example.com" should be "testing"

  Scenario: empty
    Given I am signed in as "alice@example.com/testing"
    And I am on the account page
    When I follow "Edit"
    And I fill in "Email" with "alicia"
    And I fill in "Password" with ""
    And I press "Update"
    Then I should be on the account page
    And I should see an error message
    And the password for "alice@example.com" should be "testing"

  Scenario: success
    Given I am signed in as "alice@example.com/testing"
    And I am on the account page
    When I follow "Sign out"
    Then I should be on the sign in page
    And I should see "Signed out."

  Scenario: user deactivates account
    Given I sign in
    And I am on the account page
    When I press "Cancel My Account"
    Then I should be on the sign up page
    And I should see "Account canceled. We're sorry to see you go."
