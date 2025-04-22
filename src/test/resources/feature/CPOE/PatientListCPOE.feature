Feature: Patient List CPOE

  Background:
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "Card Group" owned by "pkadminv2" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I click the "Refresh Patient List" button
    And I select "Card Group" from the "Patient List" menu

  @BuildVerificationTest
  Scenario: Add order to patient
    Given "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And I select "Orders" from clinical navigation
    And I select "All" from the "Order Type" menu
    And I click the "Enter Orders" button
    And I click the "OK" button in the "Warning" pane if it exists
    And I select "the first item" from the "Order for Visit" dropdown
    And I enter "tylenol" in the "Add Order" field in the "Enter Orders" pane
    And I select "Tylenol 8 Hour tablet,extended release (acetaminophen)  650MG Oral Daily" from the "Formulary Med Orders" list in the search results
    When I select "Provider Aware - Continue as ordered" as override reason in the "Order Clinical Decision Support Warnings" pane if it exists
    And I click the "CDSW OK" button in the "Order Clinical Decision Support Warnings" pane if it exists
    And I fill the mandatory order details in the "Edit Order" pane if it exists
    And I click the "Sign/Submit" button in the "Order Submission" pane
    And rows starting with the following should appear in the "Orders" table
      |  | Existing orders for                                                     | Start          | Status    |
      |  | Tylenol 8 Hour tablet,extended release (acetaminophen) 650MG Oral Daily | %Current Date% | Submitted |