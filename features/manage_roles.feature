Feature: Manage roles
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new role
    Given I am signed in as an admin
      And I am on the new role page
    When I fill in "Title" with "title 1"
    And I press "Create"
    Then I should see "title 1"

  Scenario: Delete role
    Given I am signed in as an admin
      And the following roles:
      |title|
      |title 1|
      |title 2|
      |title 3|
      |title 4|
    When I delete the 3rd role
    Then I should see the following roles:
      |Title|
      |admin|
      |title 1|
      |title 3|
      |title 4|
