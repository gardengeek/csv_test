Feature: Manage users
  In order to maintain users
  An admin
  wants a maintenance screen

  Scenario: Edit existing user
    Given I am signed in as an admin
    And the following users:
      |first_name|
      |Manny|
      |Moe|
      |Jack|
    And I am on the users page
    And I follow "Edit"
    When I fill in "Email" with "new_user@example.com"
    And I fill in "First name" with "Joe"
    And I fill in "Last name" with "Blow"
    And I fill in "Password" with "asecret"
    And I fill in "Phone number" with "BR549"
    And I fill in "Company name" with "State Lunatic Hospital"
    And I fill in "Title" with "Inmate"
    And I fill in "Address line 1" with "Kirkbride Building"
    And I fill in "Address line 2" with "450 Maple St"
    And I fill in "City" with "Danvers"
    And I select "Massachusetts" from "State/Province"
    And I fill in "Postal code" with "01923"
    And I select "UNITED STATES" from "Country"
    And I check "Admin"
    And I press "Update"
    Then I should see "new_user@example.com"
    And I should see "Joe Blow"
    And I should see "BR549"
    And I should see "State Lunatic Hospital"
    And I should see "Inmate"
    And I should see "Kirkbride Building"
    And I should see "450 Maple St"
    And I should see "Danvers MA 01923"
    And I should see "UNITED STATES"
    And I should see "admin"
    When I follow "Edit"
    And I fill in "First name" with "Jane"
    And I fill in "Last name" with "Doe"
    And I press "Update"
    Then I should see "Jane Doe"

  Scenario: Delete user
    Given the following users:
      |id|email|first_name|
      |2|email_1@example.com|Alpha|
      |3|email_2@example.com|Bravo|
      |4|email_3@example.com|Charlie|
      |5|email_4@example.com|Delta|
    And I am signed in as an admin
    When I delete the 2nd user
    Then I should see the following users:
      |Email|Name|Roles|
      |email_1@example.com|Alpha Jones||
      |email_3@example.com|Charlie Jones||
      |email_4@example.com|Delta Jones||
      |insider@example.com|Insider Jones|admin|
