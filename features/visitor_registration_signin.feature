Feature: Visitor signs up for an account.
  As a visitor
  I want to sign up for an account
  So that I sign in.

  Scenario: Visitor can register
    Given I am on the sign in page
    When I follow "Sign up"
    And I fill in "Email" with "jq@example.com"
    And I fill in "First name" with "John"
    And I fill in "Last name" with "Smith"
    And I select "(GMT-05:00) Eastern Time (US & Canada)" from "Time zone"
    And I fill in "Password" with "humpty dumpty"
    And I fill in "Phone number" with "BR549"
    And I fill in "Company name" with "State Lunatic Hospital"
    And I fill in "Address line 1" with "Kirkbride Building"
    And I fill in "Address line 2" with "450 Maple St"
    And I fill in "City" with "Danvers"
    And I select "Massachusetts" from "State/Province"
    And I fill in "Postal code" with "01923"
    And I select "UNITED STATES" from "Country"
    And I press "Sign up"
    Then jq@example.com should receive an email
    And I should be on the sign in page
    And I should see "Instructions to confirm your account have been emailed to you. Please check your email."

  Scenario: Visitor can confirm account
    Given the unconfirmed user "alice@example.com/testing"
    When I go to my account confirmation page
    Then I should be on the user confirmation page
    And I should see "Account Confirmed"

  Scenario: Visitor can't see protected pages
    When I go to the users page
    Then I should be on the home page
    And I should see "You need to sign in or sign up before continuing"

  Scenario: Account cannot be confirmed twice
    Given I am signed up as "alice@example.com/testing"
    When I go to my account confirmation page
    Then I should be on the new account page
    And I should see "That account has already been confirmed!"

  Scenario: Visitor can resend confirmation message
    Given the unconfirmed user "alice@example.com/testing"
    When I go to an invalid account confirmation page
    Then I should be on the new account confirmation page
    And I should see "We're sorry, but that link is invalid or expired. Please try again."
    When I fill in "email" with "alice@example.com"
    And I press "Resend confirmation"
    Then alice@example.com should receive an email
    And I should be on the sign in page
    And I should see "Instructions to confirm your account have been emailed to you. Please check your email."

  Scenario: Visitor has a link to resend confirmation if lost
    Given I am on the sign in page
    When I follow "Resend confirmation"
    Then I should be on the new account confirmation page

  Scenario: Visitor receives an appropriate message for invalid email
    Given I am on the new account confirmation page
    When I fill in "Email" with "malory@example.com"
    And I press "Resend confirmation"
    Then I should be on the account confirmations page
    And I should see "Email not found"

  Scenario: missing field
    Given I am on the sign in page
    When I follow "Sign up"
    And I fill in "Password" with "humpty dumpty"
    And I press "Sign up"
    Then I should be on the user registration page
    And I should see error messages

  Scenario: signed in user can't use register page
    Given I am signed in as "alice@example.com/testing"
    When I go to the new account page
    Then I should be on the account page

  Scenario: success
    Given I have signed up as "alice@example.com/testing"
    When I go to the sign in page
    And I fill in "Email" with "alice@example.com"
    And I fill in "Password" with "testing"
    And I press "Sign in"
    Then I should be on the account page

  Scenario: failure
    Given I have signed up as "alice@example.com/testing"
    When I go to the sign in page
    And I fill in "Email" with "alice@example.com"
    And I fill in "Password" with "bah"
    And I press "Sign in"
    Then I should be on the user sign in page
    And I should see "Invalid email or password"
