@HoldForReview
Feature: 4 Hold For Review Reasons Audit Report

  Background:
    Given I am logged into the portal with user "HFR1" using the default password
    And I am on the "Admin" tab


  Scenario: Verify that Hold For Review activity Audit Report is recorded for Hold and Resolve activities on a charge in manage Hold For Review Section
#    Test case:0001_Hold for Review_Audit Trial
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
    And I am on the "Admin" tab
    And I select the "System Management" subtab
    When I click the "Audit Report" link in the "System Management Navigation" pane
    Then the "Audit Report" pane should load
    When I enter "%Current Date MMDDYY%" in the "Start Date" field in the "Audit Report" pane
    And I enter "%Current Date MMDDYY%" in the "End Date" field in the "Audit Report" pane
    And I enter "HFR2" in the "Select Users" field in the "Audit Report" pane
    And I click the "Lookup User" element in the "Audit Report" pane
    And I click the "Show Audit Records" button in the "Audit Report" pane
    Then the "Audit Report" table should load
    And I click the "Audit Report Info" button in the row with "FORREVIEW2, HOLD" as the value under "User" in the "Audit Report" table
    Then the "Audit Report Info" pane should load
    Then the following text should appear in the "Audit Report Info" pane
      |Held for review Reason:|
      |Reason4                |
      |Held for review Reason:|
      |Reason2                |
    And I click the "Information OK" button in the "Audit Report Info" pane

  Scenario: Verify the Mark As Review activity Audit Report is recorded in Charge transaction screen, Holding Bin, and Search
#    Test case:0002_Mark As Reviewed_Audit
    Given I am logged into the portal with user "HFR2" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And I select "the first item" in the "Charges" table
    Then the text "Reason4, Reason2" should appear in the "Charge Detail" pane
    And I click the "Edit" button in the "Charge Detail" pane
#    For charge entry pane
    Then the text "Held for Review: Reason4, Reason2" should appear in the "Charge Entry" pane
    Then the "Mark As Review Popup" "pkdropdown" should be visible
    And I wait up to "20" seconds for the "Mark As Reviewed With Reasons" field of type "BUTTON" to be visible
    And I click the "Mark As Reviewed With Reasons" button
    Then the "Charges" table should load
    Then rows containing the following should appear in the "Charges" table
      |Date/Time             |Hold Reason  |
      |%Current Date MMDDYY% |Reason4      |
    And I wait "2" seconds
    And I am on the "Admin" tab
    And I select the "System Management" subtab
    When I click the "Audit Report" link in the "System Management Navigation" pane
    Then the "Audit Report" pane should load
    When I enter "%Current Date MMDDYY%" in the "Start Date" field in the "Audit Report" pane
    And I enter "%Current Date MMDDYY%" in the "End Date" field in the "Audit Report" pane
    And I enter "HFR2" in the "Select Users" field in the "Audit Report" pane
    And I click the "Lookup User" element in the "Audit Report" pane
    And I click the "Show Audit Records" button in the "Audit Report" pane
    Then the "Audit Report" table should load
    And I click the "Audit Report Info" button in the row with "FORREVIEW2, HOLD" as the value under "User" in the "Audit Report" table
    Then the "Audit Report Info" pane should load
    Then the following text should appear in the "Audit Report Info" pane
      |Resolved By:      |
      |                  |
      |Resolved By:      |
      |FORREVIEW2, HOLD  |
    And I click the "Information OK" button in the "Audit Report Info" pane
#    For Holding Bin
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And patient "Molly Darr" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the ICD-10 code "B65.1"
    And I enter the CPT code "86005"
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    And I click the "Submit" button
    Then the text "Reason4, Reason2" should appear in the "Charge Detail" pane
    When I am on the "Charges" tab
    And I select the "Holding Bin" subtab
    And I click the "Reset Criteria" button in the "Holding Bin" pane
    And I select "Current Week" from the "Timeframe" dropdown in the "Holding Bin" pane
    And I click the "Show Charges" button in the "Holding Bin" pane
    When I select the "Held for Review" link in the row with "DARR, MOLLY" as the value under "Patient" in the "Holding Bin" table
    Then the "Held For Review Charge" pane should load
    And I click the "Mark As Reviewed" button in the "Charge Entry" pane
    And I am on the "Admin" tab
    And I select the "System Management" subtab
    When I click the "Audit Report" link in the "System Management Navigation" pane
    Then the "Audit Report" pane should load
    When I enter "%Current Date MMDDYY%" in the "Start Date" field in the "Audit Report" pane
    And I enter "%Current Date MMDDYY%" in the "End Date" field in the "Audit Report" pane
    And I enter "HFR2" in the "Select Users" field in the "Audit Report" pane
    And I click the "Lookup User" element in the "Audit Report" pane
    And I click the "Show Audit Records" button in the "Audit Report" pane
    Then the "Audit Report" table should load
    And I click the "Audit Report Info" button in the row with "FORREVIEW2, HOLD" as the value under "User" in the "Audit Report" table
    Then the "Audit Report Info" pane should load
    Then the following text should appear in the "Audit Report Info" pane
      |Resolved By:      |
      |                  |
      |Resolved By:      |
      |FORREVIEW2, HOLD  |
    And I click the "Information OK" button in the "Audit Report Info" pane
#    For Search section
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And patient "Molly Darr" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the ICD-10 code "D36.7"
    And I enter the CPT code "86003"
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    And I click the "Submit" button
    Then the text "Reason4, Reason2" should appear in the "Charge Detail" pane
    When I am on the "Charges" tab
    And I select the "Search" subtab
    And I click the "Back To Criteria" button if it exists
    And I click the "Reset Criteria" button in the "ChargeSearch" pane
    And I select "Current Week" from the "Timeframe" dropdown in the "Charge Search" pane
    And I click the "Show Charges" button in the "Charge Search" pane
    When I select the "Held for Review" link in the row with "DARR, MOLLY" as the value under "Patient" in the "Charge Search Results" table
    And I click the "Mark As Reviewed With Reasons" button in the "Charge Entry" pane
    And I am on the "Admin" tab
    And I select the "System Management" subtab
    When I click the "Audit Report" link in the "System Management Navigation" pane
    When I enter "%Current Date MMDDYY%" in the "Start Date" field in the "Audit Report" pane
    And I enter "%Current Date MMDDYY%" in the "End Date" field in the "Audit Report" pane
    And I enter "HFR2" in the "Select Users" field in the "Audit Report" pane
    And I click the "Lookup User" element in the "Audit Report" pane
    And I click the "Show Audit Records" button in the "Audit Report" pane
    Then the "Audit Report" table should load
    And I click the "Audit Report Info" button in the row with "FORREVIEW2, HOLD" as the value under "User" in the "Audit Report" table
    Then the "Audit Report Info" pane should load
    Then the following text should appear in the "Audit Report Info" pane
      |Resolved By:      |
      |                  |
      |Resolved By:      |
      |FORREVIEW2, HOLD  |
    And I click the "Information OK" button in the "Audit Report Info" pane


  Scenario: Verify the Audit Report is recorded When Hold For Review reasons are edited in HFR Screen
#     Test case:0003_Hold For Review Manage reasons_Audit
    And I am on the manage hold for review page
    And I click the "Custom Reason Edit" button
    Then the "Edit Reason Roles Mapping" pane should load
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "no" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I am on the "Admin" tab
    And I select the "System Management" subtab
    When I click the "Audit Report" link in the "System Management Navigation" pane
    When I enter "%Current Date MMDDYY%" in the "Start Date" field in the "Audit Report" pane
    And I enter "%Current Date MMDDYY%" in the "End Date" field in the "Audit Report" pane
    And I enter "HFR1" in the "Select Users" field in the "Audit Report" pane
    And I click the "Lookup User" element in the "Audit Report" pane
    And I click the "Show Audit Records" button in the "Audit Report" pane
    Then the "Audit Report" table should load
    And I click the "Audit Report Info" button in the row with "FORREVIEW, HOLD" as the value under "User" in the "Audit Report" table
    Then the "Audit Report Info" pane should load
    Then the following text should appear in the "Audit Report Info" pane
      |Default state:|
      |1             |
      |Default value:|
      |0             |
    And I click the "OK" button in the "Audit Report Info" pane

  Scenario: Initial settings to verify the state of Hold For Review Checkbox and Hold for review comment
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "EditPreferencesSettings" dropdown
    And I select "Show, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I select "1" from the "Hold Charge For Review Comment" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box

  Scenario: Verify the Audit Report is recorded When Status of Hold For Review Checkbox Changes its status
#        Test case:0004_Audit log for Status of Hold for review flag
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "EditPreferencesSettings" dropdown
    And I select "Hide, Checked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I select the "System Management" subtab
    When I click the "Audit Report" link in the "System Management Navigation" pane
    When I enter "%Current Date MMDDYY%" in the "Start Date" field in the "Audit Report" pane
    And I enter "%Current Date MMDDYY%" in the "End Date" field in the "Audit Report" pane
    And I enter "HFR1" in the "Select Users" field in the "Audit Report" pane
    And I click the "Lookup User" element in the "Audit Report" pane
    And I click the "Show Audit Records" button in the "Audit Report" pane
    Then the "Audit Report" table should load
    Then rows starting with the following should appear in the "Audit Report" table
      |	User           |Description                                                                       |
      |FORREVIEW, HOLD |Web - changed user level setting HoldForReviewFlag from 3 to 4 for UserName: HFR1 |
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "EditPreferencesSettings" dropdown
    And I select "Hide, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I select the "System Management" subtab
    When I click the "Audit Report" link in the "System Management Navigation" pane
    When I enter "%Current Date MMDDYY%" in the "Start Date" field in the "Audit Report" pane
    And I enter "%Current Date MMDDYY%" in the "End Date" field in the "Audit Report" pane
    And I enter "HFR1" in the "Select Users" field in the "Audit Report" pane
    And I click the "Lookup User" element in the "Audit Report" pane
    And I click the "Show Audit Records" button in the "Audit Report" pane
    Then the "Audit Report" table should load
    Then rows starting with the following should appear in the "Audit Report" table
      |	User           |Description                                                                        |
      |FORREVIEW, HOLD |Web - changed user level setting HoldForReviewFlag from 4 to 1 for UserName: HFR1  |
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "EditPreferencesSettings" dropdown
    And I select "Show, Checked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I select the "System Management" subtab
    When I click the "Audit Report" link in the "System Management Navigation" pane
    When I enter "%Current Date MMDDYY%" in the "Start Date" field in the "Audit Report" pane
    And I enter "%Current Date MMDDYY%" in the "End Date" field in the "Audit Report" pane
    And I enter "HFR1" in the "Select Users" field in the "Audit Report" pane
    And I click the "Lookup User" element in the "Audit Report" pane
    And I click the "Show Audit Records" button in the "Audit Report" pane
    Then the "Audit Report" table should load
    Then rows starting with the following should appear in the "Audit Report" table
      |	User           |Description                                                                        |
      |FORREVIEW, HOLD |Web - changed user level setting HoldForReviewFlag from 1 to 2 for UserName: HFR1  |
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "EditPreferencesSettings" dropdown
    And I select "Show, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I select the "System Management" subtab
    When I click the "Audit Report" link in the "System Management Navigation" pane
    When I enter "%Current Date MMDDYY%" in the "Start Date" field in the "Audit Report" pane
    And I enter "%Current Date MMDDYY%" in the "End Date" field in the "Audit Report" pane
    And I enter "HFR1" in the "Select Users" field in the "Audit Report" pane
    And I click the "Lookup User" element in the "Audit Report" pane
    And I click the "Show Audit Records" button in the "Audit Report" pane
    Then the "Audit Report" table should load
    Then rows starting with the following should appear in the "Audit Report" table
      |	User           |Description                                                                        |
      |FORREVIEW, HOLD |Web - changed user level setting HoldForReviewFlag from 2 to 3 for UserName: HFR1  |

  Scenario: Verify the Audit Report is recorded When Hold Charge for review when comment entered in User preference
#        test case:0005_Audit log for Automatically Hold Charge for Review
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "EditPreferencesSettings" dropdown
#    Selecting prompt user option
    And I select "0" from the "Hold Charge For Review Comment" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I select the "System Management" subtab
    When I click the "Audit Report" link in the "System Management Navigation" pane
    When I enter "%Current Date MMDDYY%" in the "Start Date" field in the "Audit Report" pane
    And I enter "%Current Date MMDDYY%" in the "End Date" field in the "Audit Report" pane
    And I enter "HFR1" in the "Select Users" field in the "Audit Report" pane
    And I click the "Lookup User" element in the "Audit Report" pane
    And I click the "Show Audit Records" button in the "Audit Report" pane
    Then the "Audit Report" table should load
    Then rows starting with the following should appear in the "Audit Report" table
      |	User           |Description                                                                                 |
      |FORREVIEW, HOLD |Web - changed user level setting AutomaticHoldForReview from 1 to 0 for UserName: HFR1      |
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "EditPreferencesSettings" dropdown
    And I select "2" from the "Hold Charge For Review Comment" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I select the "System Management" subtab
    When I click the "Audit Report" link in the "System Management Navigation" pane
    When I enter "%Current Date MMDDYY%" in the "Start Date" field in the "Audit Report" pane
    And I enter "%Current Date MMDDYY%" in the "End Date" field in the "Audit Report" pane
    And I enter "HFR1" in the "Select Users" field in the "Audit Report" pane
    And I click the "Lookup User" element in the "Audit Report" pane
    And I click the "Show Audit Records" button in the "Audit Report" pane
    Then the "Audit Report" table should load
    Then rows starting with the following should appear in the "Audit Report" table
      |	User           |Description                                                                                 |
      |FORREVIEW, HOLD |Web - changed user level setting AutomaticHoldForReview from 0 to 2 for UserName: HFR1      |
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "EditPreferencesSettings" dropdown
    And I wait "3" seconds
    And I select "1" from the "Hold Charge For Review Comment" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I select the "System Management" subtab
    When I click the "Audit Report" link in the "System Management Navigation" pane
    When I enter "%Current Date MMDDYY%" in the "Start Date" field in the "Audit Report" pane
    And I enter "%Current Date MMDDYY%" in the "End Date" field in the "Audit Report" pane
    And I enter "HFR1" in the "Select Users" field in the "Audit Report" pane
    And I click the "Lookup User" element in the "Audit Report" pane
    And I click the "Show Audit Records" button in the "Audit Report" pane
    Then the "Audit Report" table should load
    Then rows starting with the following should appear in the "Audit Report" table
      |	User           |Description                                                                                 |
      |FORREVIEW, HOLD |Web - changed user level setting AutomaticHoldForReview from 2 to 1 for UserName: HFR1      |
    And I click the logout button

  Scenario: Deactivate the Hold For review Reasons
    And I am on the manage hold for review page
    And I deactivate the following reasons in manage hold for review pane
      |CustomReason    |
      |Reason1         |
      |Reason2         |
      |Reason3         |
      |Reason4         |
    And I click the "Manage Hold For Review Close" button
    And I click the logout button