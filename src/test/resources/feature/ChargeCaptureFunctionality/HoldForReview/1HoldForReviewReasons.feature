@HoldForReview
Feature: 1 Hold For Review Reasons

  Background:
    Given I am logged into the portal with user "HFR1" using the default password
    And I am on the "Admin" tab

  Scenario: Configuring the settings for Hold For Review Reasons Deactivate all the reasons
    And I select the "User" subtab
    And I search for the user "HFR1"
    And I select the user "HFR1"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "true" from the "Reviewing User" radio list
    And I select "Show, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
#    The step below navigates to Admin > Institution > Edit Settings dropdown: "Charge Capture" >
#    Charge Entry Controls heading > next to Enable Hold For Review label click the "Manage Link"
    And I am on the manage hold for review page
    Then the "Manage Hold For Review Reasons" pane should load
#    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane
#  Editing Custom reason
#    When manually following steps, this "Custom Reason Edit" button is an icon actually:
    And I click the "Custom Reason Edit" button
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Resolve Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
#    From the methods these 2 steps call, 'yes' goes to the radio button in position 1, and no goes to position 2.
#    From the UI, 'yes' or the 1st radio btn is labeled "Show"
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
#    From the UI, 'no' or the 2nd radio btn is labeled "Unchecked"
    And I select "no" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
#  Editing Standard reason
#    Like above, this is an icon:
    And I click the "Review Requested Edit" button
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Resolve Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
#  Editing Custom reason Reason1
    And I click the "Reason1 Edit" button
    And I click the "Hold Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Hold Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Resolve Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "no" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
#  Editing Custom reason Reason2
    And I click the "Reason2 Edit" button
    And I click the "Hold Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Hold Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Resolve Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
#  Editing Custom reason Reason3
    And I click the "Reason3 Edit" button
    And I click the "Hold Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Hold Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles BILLER" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Resolve Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
    #  Editing Custom reason Reason4
    And I click the "Reason4 Edit" button
    And I click the "Hold Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Resolve Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles BILLER" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
#    Deactivate = Uncheck vice versa Activate = Check
    And I deactivate the following reasons in manage hold for review pane
      |Test1      |
      |Test2      |
      |Test3      |
      |AddReason1 |
      |AddReason2 |
      |AddReason3 |
#    This close btn keeps failing in Chrome
#    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
#    This X btn works in ie11 and Chrome:
    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button

  Scenario: Pre-Requisite - Institution_Enable Hold for Review setting
#     Test case:0002_Institution_Enable Hold for Review setting,0003_Enable Hold for Review_Manage, 0005_Manage Hold for Review Table _Search.
#     Test case: 0006_Manage Hold For Review Table_Reasons,0007_Manage Hold for Review Table_Delete, 0008_Manage Hold for Review Table_Active/Inactivate
    And I am on the manage hold for review page
    And the following fields should display in the "Manage Hold For Review Reasons" pane
      |Name                             |Type     |
      |Hold For Review Delete           |element  |
      |Create New Reason Roles Mapping  |button   |
      |Hold For Review Search           |text     |
    Then the "Manage Hold For Review Reasons" table should load with the following columns
      | Reason  |
      | Hold    |
      | Resolve |
      | Active  |
      | Role    |
#    And I click the "Manage Hold For Review Close" button
    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane

  Scenario: Verify Standard Reasons under Manage Hold for Review Table
#      Test case:0004_Manage Hold for Review Table _Standard Reasons
    And I am on the manage hold for review page
    Then rows containing the following should appear in the "Manage Hold For Review Reasons" table
      |Comment Review   |
      |Review requested |

  Scenario: Verify Hold for review reason fields in Create New Custom Reason-Roles Mapping
#     Test case:0009_Manage Hold for Review Reasons_Create New Custom Reason-Roles Mapping
    And I am on the manage hold for review page
    And I click the "Create New Reason Roles Mapping" button in the "Manage Hold For Review Reasons" pane
    Then the "Create Reason Roles Mapping" pane should load
    And the following fields should display in the "Create Reason Roles Mapping" pane
      |Name                           |Type     |
      |Roles Mapping Reason           |text     |
      |Roles Mapping Hold Roles       |text     |
      |Roles Mapping Resolve Roles    |text     |
      |Roles Mapping Active           |check    |
      |Default State                  |radio    |
      |Default Value                  |radio    |
      |Roles Mapping Save             |button   |
      |Roles Mapping Cancel           |button   |
      |Roles Mapping Close            |button   |
      |Hold Roles Lookup              |element  |
      |Resolve Roles Lookup           |element  |
    And I click the "Roles Mapping Close" button in the "Create Reason Roles Mapping" pane

  Scenario: Verify the Provider Review Edit reason under Manage Hold For Review Section
  # Test Case: 10_Standard Reason_Provider Review_Edit Reason Roles Mapping
    And I am on the manage hold for review page
    And I click the "Review Requested Edit" button
    And The following fields should be disabled in the "Edit Reason Roles Mapping" pane
      |Name                  |Type   |
      |Provider Review Reason|element|
    And The following fields should display in the "Edit Reason Roles Mapping" pane
      |Active Checked  Off|
    And The following fields should not display in the "Edit Reason Roles Mapping" pane
      |Hold Roles Lookup|
    And the following text should appear in the "Edit Reason Roles Mapping" pane
      |Provider and Comment Review hold reasons are controlled by the user preferences in Charge Capture Settings.|
    And I click the "Resolve Roles Lookup" image
    And I check the following checkboxes in the "Roles" pane
      |Roles Admin    |
      |Roles BILLER   |
      |Roles PROVIDER |
    And I click the "Roles Ok" button
    Then the following text should appear in the "Roles" pane
      |Admin    |
      |Biller   |
      |PROVIDER |
    And The following fields should display in the "Edit Reason Roles Mapping" pane
      |Name                  |Type   |
      |Roles Mapping Save    |button |
      |Roles Mapping Cancel  |button |
      |Roles Mapping Close   |button |
    And I click the "Roles Mapping Cancel" button
#    And I click the "Manage Hold For Review Close" button
    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane


  Scenario: Verify the Comment Review Edit reason  under Manage Hold For Review Section
  # Test Case: 10_Default Reason_Comment  Review_Edit Reason Roles Mapping
    And I am on the manage hold for review page
    And I click the "Comment Review Edit" button
    And The following fields should be disabled in the "Edit Reason Roles Mapping" pane
      |Name                  |Type   |
      |Comment Review Reason|element|
    And The following fields should display in the "Edit Reason Roles Mapping" pane
      |Active Checked  Off|
    And The following fields should not display in the "Edit Reason Roles Mapping" pane
      |Hold Roles Lookup|
    And the following text should appear in the "Edit Reason Roles Mapping" pane
      |Provider and Comment Review hold reasons are controlled by the user preferences in Charge Capture Settings.|
    And I click the "Resolve Roles Lookup" image
    And I check the following checkboxes in the "Roles" pane
      |Roles Admin    |
      |Roles BILLER   |
      |Roles PROVIDER |
    And I click the "Roles Ok" button
    Then the following text should appear in the "Roles" pane
      |Admin    |
      |Biller   |
      |PROVIDER |
    And The following fields should display in the "Edit Reason Roles Mapping" pane
      |Name                   |Type   |
      |Roles Mapping Save     |button |
      |Roles Mapping Cancel   |button |
      |Roles Mapping Close    |button |
    And I click the "Roles Mapping Cancel" button
#    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane

  Scenario: Verify the Warning message on deleting Hold For Review Reason Role Mapping entity
  # Test Case: 10_Deleting a Hold for Review Reason Role mapping entity
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I click the "Submit" button
    And I wait "2" seconds
    And I am on the "Admin" tab
    And I am on the manage hold for review page
    And I click the "Reason1 Delete" image
    And I click the "Roles Ok" button
    Then the text "Delete Failed: There are charge transactions held for this reason. Review charge transactions" should appear in the "Manage Hold For Review Reasons" pane
#    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane

  Scenario: Verify the State of "Hold For Review checkbox , if allowed when editing charges that are not held for review" under CC preferences
#   Test case:0010A_Remove CC User Pref_State of Hold For Review checkbox , if allowed when editing charges that are not held for review
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "EditPreferencesSettings" dropdown
    And the text "State of Hold For Review checkbox , if allowed when editing charges that are not held for review" should not appear in the "UserPreferences" pane

#Dev issue Scenarios
  Scenario: Pre-requisite to activate the Reasons under Manage Hold For Review
#    The step below navigates to Admin > Institution > Edit Settings dropdown: "Charge Capture" >
#    Charge Entry Controls heading > next to Enable Hold For Review label click the "Manage Link"
    And I am on the manage hold for review page
    Then the "Manage Hold For Review Reasons" pane should load
    And I activate the following reasons in manage hold for review pane
      |CustomReason     |
      |Reason1          |
      |Reason2          |
      |Reason3          |
      |Reason4          |
#    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane
    And I select the "User" subtab
    And I search for the user "HFR3"
    And I select the user "HFR3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "true" from the "Reviewing User" radio list
    And I select "Show, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box


  Scenario: Verify the Scrollbar under Manage Hold for review Section when multiple reasons are present [DEV-70736]
#    Test case: 0005_Manage Hold for review reasons table_Scrollbars [DEV-70736]
    And I am on the manage hold for review page
    Then the "Manage Hold For Review Reasons" pane should load
    Then the vertical scrollbar should present for the "Manage Hold For Review Reasons Scroll" field of type "TABLE"


  Scenario: Verify that no other Hold for review dropdown reasons are checked when single reason is Unchecked [DEV-70215]
#      Test case:0008_Selecting Reasons from dropdown [DEV-70215]
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value           |
      |Bill Area    |Cardiology      |
      |Svc Site     |Inpatient       |
    And I enter the ICD-10 code "B36.1"
    And I enter the CPT code "86005"
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Reason2           |
      |Reason4           |
      |Reason1           |
      |CustomReason      |
      |Review requested  |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    Then I uncheck the following checkboxes in the "Hold For Review Popup" dropdown
      |Reason2          |
      |Reason1          |
      |CustomReason     |
      |Review requested |
    Then the following should be unchecked
      |Reason2          |
      |Reason1          |
      |CustomReason     |
      |Review Requested |
    And I click the "Close" image


#  Simple test just to see if AutoIt script will run and print output to the Intellij console with Process Builder
#  Scenario: Test AutoIt Practice
#    And I run the Got Here AutoIt test script

