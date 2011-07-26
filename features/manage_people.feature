Feature: Manage people
  In order to manage people
  An Admin
  wants to add, update and delete people
  
  Scenario: Register new person
    Given I am signed in as an admin
      And I am on the new person page
    When I fill in "First Name*" with "Mike"
      And I fill in "Last Name*" with "last_name 1"
      And I fill in "Birth Date" with "04241966"
      And I select "Indiana" from "State*"
      And I press "Create"
    Then I should see "Mike"
      And I should see "last_name 1"
      And I should see "1966-04-24"
      And I should see "Indiana"
    When I follow "Edit"
      And I fill in "First Name*" with "Janet"
      And I fill in "Last Name*" with "Jones"
      And I press "Update"
    Then I should see "Janet"
      And I should see "Jones"

  Scenario: Delete person
    Given the following people:
      |first_name|last_name|birth_date|state_id|
      |Mike|last_name 1|09151966|1|
      |Jack|last_name 2|10121950|2|
      |Janet|last_name 3||3|
      |Mitch|last_name 4||4|
      And I am signed in as an admin
    When I delete the 3rd person
    Then I should see the following people:
      |First name|Last name|State|
      |Mike|last_name 1|AB|
      |Jack|last_name 2|BC|
      |Mitch|last_name 4|NB|
