@HoldForReview
Feature: 3 Hold For Review Reasons Mark As Reviewed

  Background:
    Given I am logged into the portal with user "HFR1" using the default password
    And I am on the "Admin" tab

#  Mark As review Testcases
  Scenario: Verify Mark As Reviewed Button is Available When Reviewing User is set to Yes
#      Test case:0001_Mark As Reviewed Button Availablitiy_Reviewing User set to Yes
    And I select the "User" subtab
    And I search for the user "HFR3"
    And I select the user "HFR3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "true" from the "Reviewing User" radio list
    And I select "Show, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR1" using the default password
    And I am on the "Admin" tab
    And I am on the manage hold for review page
    And I click the "Reason 1 Edit" button
    Then the "Edit Reason Roles Mapping" pane should load
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane
    And I click the "Resolve Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And patient "Molly Darr" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value           |
      |Bill Area    |Cardiology      |
      |Svc Site     |Inpatient       |
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "86000"
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Reason4          |
      |Reason2          |
      |CustomReason     |
      |Reason1          |
      |Review requested |
    And I click the "Submit" button
    Then the text "Reason4, Reason2" should appear in the "Charge Detail" pane
    And I click the "Edit" button in the "Charge Detail" pane
    Then the text "Held for Review: Reason4, Reason2" should appear in the "Charge Entry" pane
    Then the "Mark As Reviewed With Reasons" "button" should be visible
    And I click the "Mark As Reviewed With Reasons" button
    Then rows containing the following should appear in the "Charges" table
      |Date/Time             |Hold Reason  |
      |%Current Date MMDDYY% |Reason4      |


  Scenario:Verify Mark As Reviewed Button is Available When Reviewing User is set to NO
#       Test case: 0001A_ Mark As Reviewed Button Availablitiy_Reviewing user set to No
    And I select the "User" subtab
    And I search for the user "HFR3"
    And I select the user "HFR3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "false" from the "Reviewing User" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And patient "Molly Darr" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value           |
      |Bill Area    |Cardiology      |
      |Svc Site     |Inpatient       |
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "86000"
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    And I click the "Submit" button
    Then the text "Reason4, Reason2" should appear in the "Charge Detail" pane
    And I click the "Edit" button in the "Charge Detail" pane
    Then the text "Held for Review: Reason4, Reason2" should appear in the "Charge Entry" pane
    Then the "Mark As Reviewed With Reasons" "button" should not be visible
    And I click the "Close" image

  Scenario: Verify Mark As Reviewed Button when Editing a Charge in charge entry screen that is held for review with one or more reasons
#      Test case: 0002_Mark As Reviewed_Editing Charge that is held for review
    Given I am logged into the portal with user "HFR2" using the default password
    And I am on the "Admin" tab
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "EditPreferencesSettings" dropdown
    And I select "true" from the "Reviewing User" radio list
    And I select "Show, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And patient "Molly Darr" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "86001"
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Reason4          |
      |Reason2          |
      |CustomReason     |
      |Reason1          |
      |Review requested |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    Then I check the following checkbox in the "Hold For Review Popup" dropdown
      |CustomReason |
    And I click the "Submit" button
    Then the text "Reason4, Reason2, CustomReason" should appear in the "Charge Detail" pane
    And I click the "Edit" button in the "Charge Detail" pane
    Then the text "Held for Review: Reason4, Reason2, CustomReason" should appear in the "Charge Entry" pane
    Then the "Mark As Review Popup" "pkdropdown" should be visible
    And I click the "Mark As Reviewed With Reasons" button
    Then rows containing the following should appear in the "Charges" table
      |Date/Time             |Hold Reason  |
      |%Current Date MMDDYY% |Reason4      |


  Scenario: Verify Mark As Reviewed Button Under charge detail pane when charge is held for review with one or more reasons
#    Test case: 0003_Mark As Reviewed Button_Charge Details Pane
    Given I am logged into the portal with user "HFR2" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And patient "Molly Darr" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the ICD-10 code "F40.9"
    And I enter the CPT code "86005"
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    And I click the "Submit" button
    Then the text "Reason4, Reason2" should appear in the "Charge Detail" pane
    And I click the "Mark As Reviewed Charge Detail" button in the "Charge Detail" pane
    And I wait "2" seconds
    And I select "the first item" in the "Charges" table
    Then the text "Reason4" should appear in the "Charge Detail" pane
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "86003"
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Reason4          |
      |Reason2          |
      |CustomReason     |
      |Reason1          |
      |Review requested |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    Then I check the following checkbox in the "Hold For Review Popup" dropdown
      |CustomReason |
    And I click the "Submit" button
    And I select "the first item" in the "Charges" table
    Then the text "Reason4, Reason2, CustomReason" should appear in the "Charge Detail" pane
    And I click the "Mark As Reviewed Charge Detail" button in the "Charge Detail" pane
    Then the text "Reason4" should appear in the "Charge Detail" pane

  Scenario: Verify Mark As Reviewed Button for charge transaction under Holding Bin Subtab
#      Test case: 0004_Mark As Reviewed_Holding Bin and Search tabs
    Given I am logged into the portal with user "HFR2" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And patient "Molly Darr" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "86000"
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    And I click the "Submit" button
    Then the text "Reason4, Reason2" should appear in the "Charge Detail" pane
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    And patient "Neil Heath" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "86000"
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Reason4          |
      |Reason2          |
      |CustomReason     |
      |Reason1          |
      |Review requested |
    And I click the "Submit" button
    And I wait "5" seconds
    When I am on the "Charges" tab
    And I select the "Holding Bin" subtab
    And I click the "Reset Criteria" button in the "Holding Bin" pane
    And I select "Current Week" from the "Timeframe" dropdown in the "Holding Bin" pane
    And I click the "Show Charges" button in the "Holding Bin" pane
    When I select the "Held for Review" link in the row with "DARR, MOLLY" as the value under "Patient" in the "Holding Bin" table
    Then the "Held For Review Charge" pane should load
    Then the text "Held for Review: Reason4, Reason2" should appear in the "Charge Entry" pane
    And I click the "Mark As Reviewed With Reasons" button in the "Charge Entry" pane
    And I select the "Held for Review" link in the row with "DARR, MOLLY" as the value under "Patient" in the "Holding Bin" table
    Then the text "Held for Review: Reason4" should appear in the "Charge Entry" pane
    And I click the "Close" image
    When I select the "Held for Review" link in the row with "HEATH, NEIL" as the value under "Patient" in the "Holding Bin" table
    Then the text "Held for Review: Reason4, Reason2" should appear in the "Charge Entry" pane
    And I click the "Mark As Reviewed With Reasons" button in the "Charge Entry" pane
    When I select the "Held for Review" link in the row with "HEATH, NEIL" as the value under "Patient" in the "Holding Bin" table
    Then the text "Held for Review: Reason4" should appear in the "Charge Entry" pane
    And I click the "Close" image


  Scenario: Verify Mark As Reviewed Button for charge transaction under Search Subtab
#  Test case: 0004_Mark As Reviewed_Holding Bin and Search tabs
    Given I am logged into the portal with user "HFR2" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And patient "Molly Darr" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "86000"
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    And I click the "Submit" button
    Then the text "Reason4, Reason2" should appear in the "Charge Detail" pane
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    And patient "Neil Heath" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the ICD-10 code "B36.1"
    And I enter the CPT code "86000"
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Reason4          |
      |Reason2          |
      |CustomReason     |
      |Reason1          |
      |Review requested |
    And I click the "Submit" button
    When I am on the "Charges" tab
    And I select the "Search" subtab
    And I click the "Back To Criteria" button if it exists
    And I click the "Reset Criteria" button in the "ChargeSearch" pane
    And I select "Current Week" from the "Timeframe" dropdown in the "Charge Search" pane
    And I click the "Show Charges" button in the "Charge Search" pane
    When I select "DARR, MOLLY" from the "Patient" column in the "Charge Search Results" table
    And I click the "Mark As Reviewed Charge Search" button
    Then the text "Are you sure you want to mark the transaction as reviewed?" should appear in the "Question" pane
    And I click the "Yes" button in the "Question" pane
    And I select the "Held for Review" link in the row with "DARR, MOLLY" as the value under "Patient" in the "Charge Search Results" table
    Then the text "Held for Review: Reason4" should appear in the "Charge Entry" pane
    And I click the "Close" image
    When I select "DARR, MOLLY" from the "Patient" column in the "Charge Search Results" table
    When I select "HEATH, NEIL" from the "Patient" column in the "Charge Search Results" table
    And I click the "Mark As Reviewed Charge Search" button
    Then the text "Are you sure you want to mark the transaction as reviewed?" should appear in the "Question" pane
    And I click the "Yes" button in the "Question" pane
    When I select the "Held for Review" link in the row with "HEATH, NEIL" as the value under "Patient" in the "Charge Search Results" table
    Then the text "Held for Review: Reason4" should appear in the "Charge Entry" pane
    And I click the "Close" image

  Scenario: Pre-requisite for Custom reason, Hide Checked
    And I am on the manage hold for review page
    And I click the "CustomReason Edit" button
    Then the "Edit Reason Roles Mapping" pane should load
    And I select "No" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box

  Scenario: Verify that transaction is not held for reviewed reasons again when custom reason is Hide checked
#       Test case: 0005_Reasons already reviewed_Provider Review, Hide Checked
    Given I am logged into the portal with user "HFR2" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And patient "Molly Darr" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "86602"
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    And I click the "Submit" button
    Then the text "Reason4, CustomReason, Reason2" should appear in the "Charge Detail" pane
    And I click the "Edit" button in the "Charge Detail" pane
    And I wait "5" seconds
    Then the "Mark As Review Popup" "pkdropdown" should be visible
    And I click the "Mark As Reviewed With Reasons" button
    Then rows containing the following should appear in the "Charges" table
      |Date/Time             |Hold Reason  |
      |%Current Date MMDDYY% |Reason4      |

  Scenario: Reverting the Pre-requisite settings for Custom reason, Show, UnChecked
    And I am on the manage hold for review page
    And I click the "Custom Reason Edit" button
    Then the "Edit Reason Roles Mapping" pane should load
    And I select "Yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "no" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait up to "20" seconds for the "Manage Hold For Review Close" field of type "BUTTON" to be visible
    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box


