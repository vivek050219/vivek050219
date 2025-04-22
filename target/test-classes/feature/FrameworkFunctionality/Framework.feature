@Framework
Feature: Framework

#  Background:
#    Given I am logged into the portal with user "pkadmin" using the default password
#    And I am on the "Patient List" tab
#
#  @Framework
#  Scenario:
#    Given I am logged into the portal with user "notabuser" using the default password
#    And I am on the "Patient List" tab
#    And I select "My Patients" from the "Patient List" dropdown button filter
#    And "Molly Darr" is on the patient list
#    When I select patient "Molly Darr" from the patient list
#    And I click the "Summary" link in the "Patient Dashboard" section in the "Patient List" pane
#    And I wait for "Patient Dashboard" screen items to load

  Scenario:
    Given API: I am logged into the portal with user "pkadmin" using the default password
    And API: I close the following tabs
      |A|B|
    And API: I open the following tabs
      |A|B|