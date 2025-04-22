@HoldForReview
Feature: 2 Hold For Review Reasons Section

  Background:
    Given I am logged into the portal with user "HFR1" using the default password
    And I am on the "Admin" tab


  Scenario: Verify the Hold For Review Reasons Popup in Charge Entry, Worklist and Search Section
#   Test case:00011_Access to Hold For Review Reasons Button with dropdown
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And patient "Molly Darr" has no charges
#      Verifying Holdforreview popup from Add/Charge Screen
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    When I click the "Close" image
    #Verifying Holdforreview popup from WorkList
    And I am on the "Charges" tab
    And I select the "Worklist" subtab
    And I click the "Reset Criteria" button in the "Worklist" pane
    And I select "Current Month" from the "Timeframe" dropdown in the "Worklist" pane
    And I check the "Include Charges with No Edits" checkbox in the "Worklist" pane
    When I select the "Add" link in the row with "BLAZER, ROY E*" as the value under "Patient" in the "Worklist" table
    And I wait for loading to complete
    Then the "Charge Hold For Review popup" "pkdropdown" should be visible
    When I click the "Close" image
#       # Verifying Holdforreview popup from Search
    And I am on the "Charges" tab
    And I select the "Search" subtab
    And I click the "Back To Criteria" button if it exists
    And I click the "Reset Criteria" button in the "ChargeSearch" pane
    And I select "Current Month" from the "Timeframe" dropdown in the "Charge Search" pane
    And I click the "Show Charges" button in the "Charge Search" pane
    When I select the "Add" link in the row with "BLAZER, ROY E*" as the value under "Patient" in the "Charge Search Results" table
    Then the "Charge Hold For Review popup" "pkdropdown" should be visible
    When I click the "Close" image
    Then the "Charge Entry" pane should close


  Scenario: Verify the Hold For Review Reasons Button with dropdown and Standard and custom reasons displayed as per the user settings in BCE Screen
#  Test case: 00012_Hold For Review Reasons Button with dropdow_BCE Screen, 0013_Hold for review reasons button and dropdown arrow
    And I am on the "Charges" tab
    And I select the "Batch Charge Entry" subtab
    Then the "BCE Hold For Review Popup" "pkdropdown" should be visible
    Then I verify the availability of the following checkbox in the "BCE Hold For Review Popup" dropdown
      |Reason4            |
      |Reason3            |
      |Reason2            |
      |Reason1            |
      |CustomReason       |
      |Review requested   |
    And I select patient "Molly Darr" from the "Name (\d)" column in the "Visits" table
    And I am on the "Patient List V2" tab

  Scenario: Verify the Hold For Review Reasons Button with dropdown in BCE Screen by changing the Reasons Settings in Manage Hold For Review Section
    And I am on the manage hold for review page
    #       Editing Standard reason Resolve Roles
    And I click the "Review Requested Edit" button
    Then the "Edit Reason Roles Mapping" pane should load
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane
    And I click the "Resolve Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
#       Editing Custom reason Hold Roles
    And I wait up to "10" seconds for the "Reason1 Edit" field of type "BUTTON" to be visible
    And I click the "Reason1 Edit" button
    And I click the "Hold Roles Delete" image in the "Edit Reason Roles Mapping" pane
    And I click the "Hold Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "no" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Charges" tab
    And I select the "Batch Charge Entry" subtab
    Then I verify the availability of the following checkbox in the "BCE Hold For Review Popup" dropdown
      |CustomReason       |
      |Reason4            |
      |Reason3            |
      |Reason2            |
      |Reason1            |
      |Review requested |
    And I select patient "Molly Darr" from the "Name (\d)" column in the "Visits" table
    Then I uncheck the following checkbox in the "BCE Hold For Review Popup" dropdown
      |Reason2 |
    And I click the "Add Edit Charges" button in the "BatchChargeEntry" pane
    Then the "Charge Hold For Review popup" "pkdropdown" should not be visible
    When I click the "Close" image