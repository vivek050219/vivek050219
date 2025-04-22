@HoldForReview
Feature: 7 Hold For Review Reasons Add Edit Charge Screen

  Background:
    Given I am logged into the portal with user "HFR1" using the default password
    And I am on the "Admin" tab

  Scenario: Pre-requisite to activate the Reasons under Manage Hold For Review
#  Admin > Institution > Edit Settings dropdown: "Charge Capture" >
#    Charge Entry heading > next to Enable Hold For Review label click the "Manage Link"
    And I am on the manage hold for review page
    And I wait for loading to complete
    Then the "Manage Hold For Review Reasons" pane should load
    And I activate the following reasons in manage hold for review pane
      |AddReason1   |
    And I click the "Add Reason1 Edit" button
    And I wait for loading to complete
    And I click the "Hold Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Hold Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Resolve Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
#    This btn keeps failing when run in Chrome.
#    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
#    This X btn works in ie11 and Chrome
    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box


  Scenario: Verify the Hold For Review Reasons Display in Charge Detail Window
   # Test Case: 13_Hold For Review Reasons Display
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    And patient "Neil Heath" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I click the "Submit" button
    Then the "Charges" table should load with the following columns
      |Hold Reason|
    And I select "the first item" in the "Charges" table
    Then the text "Held for Review" should appear in the "Charge Detail" pane
    Then the text "AddReason1" should appear in the "Charge Detail" pane

  Scenario: Verify the Availability of Hold For Review filters
    # Test Case: 14_Availability of Hold Fr Review Reasons filters
    And I am on the "Charges" tab
    And I select the "Holding Bin" subtab
    And I click the "Hold Reason LookUp" image
    Then rows starting with the following should appear in the "Hold Reasons" table
      |Reason Name      |
      |Review requested |
      |Comment Review   |
    And I select the "Search" subtab
    And the following fields should display in the "Search" pane
      |Name                  |Type |
      |HoldReasonReportField |check|
    And I click the "Hold Reason LookUp" image in the "Search" pane
    And I wait "5" seconds
    Then rows starting with the following should appear in the "Hold Reasons" table
      |Reason Name     |
      |Review requested|
      |Comment Review  |

  Scenario:Verify the Add Charge Screen_Hold for review button with only one reason
   # Test Case: 14_Add Charge Screen_Hold for review button with only one reason
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "Edit User Settings" dropdown
    And I select "Hide, Unchecked" from the "State of Hold for Review Checkbox" dropdown in the "Personal Preferences Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    And I am logged into the portal with user "HFR1" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then the following should be checked
      | HoldForReview |
    And I click the "Close" image

  Scenario: Pre-requisite: Activate the Add Reasons under Manage Hold For Review and Provider Reason Settings
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "Edit User Settings" dropdown
    And I select "Show, Checked" from the "State of Hold for Review Checkbox" dropdown in the "Personal Preferences Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the manage hold for review page
    And I wait for loading to complete
    Then the "Manage Hold For Review Reasons" pane should load
    And I activate the following reasons in manage hold for review pane
      |AddReason2     |
      |AddReason3     |
    And I click the "Add Reason2 Edit" button
    And I wait for loading to complete
    And I click the "Hold Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Hold Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Resolve Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
    And I click the "Add Reason3 Edit" button
    And I wait for loading to complete
    And I click the "Hold Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Hold Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Resolve Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
#    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box

  Scenario:Verify the Add Charge Screen_Hold For Review Button with multiple reasons
      # Test Case: 15_Add Charge Screen_Hold For Review Button with multiple reasons
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And patient "Neil Heath" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    And I click the "Close" image

  Scenario: Verify Add Charge Screen Hold for review Button Reasons
    #Test Case: 16_Add Charge Screen_Hold for review Button_Reasons
    And I am on the manage hold for review page
    And I wait for loading to complete
    And I click the "Add Reason1 Edit" button
    And I wait for loading to complete
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "no" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
#    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    And I am logged into the portal with user "HFR1" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    And I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      | Review requested |
    Then the following should be unchecked
      | AddReason1 |
    And I click the "Cancel Add Charge" button

  Scenario: Verify Add Charge When Screen Hold For Review Custom Reason Role mapping is Show and Checked
    #Test Case: 0018_Add Charge Screen_Hold For Review  Custom Reason Role mapping_Show Checked
    And I am on the manage hold for review page
    And I wait for loading to complete
    And I click the "Add Reason1 Edit" button
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
#    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Review requested |
    Then the following should be checked
      |AddReason1|
    And I click the "Cancel Add Charge" button

  Scenario: Verify Add Charge Screen When Hold For Review Custom Reason Role mapping is Show and Unchecked
    #Test Case: 19_Add Charge Screen_Hold For Review  Custom Reason Role mapping_Show Unchecked
    And I am on the manage hold for review page
    And I wait for loading to complete
    And I click the "Add Reason1 Edit" button
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "no" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
#    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Review requested |
    Then the following should be unchecked
      |AddReason1|
    And I click the "Cancel Add Charge" button

  Scenario: Verify Add Charge Screen When Hold For Review Custom Reason Role mapping is Hide and Checked
    #Test Case: 0020_Add Charge Screen_Hold For Review  Custom Reason Role mapping_Hide  Checked
    And I am on the manage hold for review page
    And I wait for loading to complete
    And I click the "Add Reason1 Edit" button
    And I select "no" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
#    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And patient "Neil Heath" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I uncheck the following checkboxes in the "Hold For Review Popup" dropdown
      |AddReason2      |
      |AddReason3      |
      |Review requested|
    Then The following fields should not display in the "Hold For Review Reasons" pane
      |Name        |Type |
      |AddReason1  |check|
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I click the "Submit" button
    Then the "Charges" table should load with the following columns
      |Hold Reason|
    And I select "the first item" in the "Charges" table
    Then the text "Held for Review" should appear in the "Charge Detail" pane
    Then the text "AddReason1" should appear in the "Charge Detail" pane

  Scenario: Verify Add Charge Screen Hold For Review with Custom Reason Role mapping When Hide and Unchecked
    #Test Case: 21_Add Charge Screen_Hold For Review  Custom Reason Role mapping_Hide Unchecked
    And I am on the manage hold for review page
    And I wait for loading to complete
    And I click the "Add Reason1 Edit" button
    And I select "no" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "no" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
#    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And patient "Neil Heath" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I uncheck the following checkboxes in the "Hold For Review Popup" dropdown
      |AddReason2       |
      |AddReason3       |
      |Review requested |
    Then The following fields should not display in the "Hold For Review Reasons" pane
      |Name        |Type |
      |AddReason1  |check|
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I click the "Submit" button
    Then the "Charges" table should load with the following columns
      |Hold Reason|
    And I select "the first item" in the "Charges" table
    Then the text "Held for Review" should appear in the "Charge Detail" pane
    Then the text "No" should appear in the "Charge Detail" pane

  Scenario: Verify Add Charge Screen,Hold For Review Reasons and Provider Review When User Pref is Show and Checked
    # Test Case: 22A_Add Charge Screen_Hold For Review Reasons_Provider Review, User Pref Show Checked
    And I am on the "Admin" tab
    And I am on the manage hold for review page
    And I wait for loading to complete
    And I click the "Add Reason1 Edit" button
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
#    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "Edit Preferences Settings" dropdown
    And I select "Show, Checked" from the "State of Hold for Review Checkbox" dropdown in the "Charge Capture Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Review requested|
    Then the following should be checked
      |Review Requested |
    And I click the "Cancel Add Charge" button

  Scenario: Verify Add Charge Screen_Hold For Review Reasons and Provider Review When User Pref is Show Unchecked
    #Test Case: 22B_Add Charge Screen_Hold For Review Reasons_Provider Review, User Pref Show Unchecked
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "Edit Preferences Settings" dropdown
    And I select "Show, Unchecked" from the "State of Hold for Review Checkbox" dropdown in the "Charge Capture Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    And I am logged into the portal with user "HFR1" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      | Review requested |
    Then the following should be unchecked
      | Review Requested |
    And I click the "Cancel Add Charge" button

  Scenario: Verify Add Charge Screen_Hold For Review Reasons and Provider Review When User Pref is Hide Checked
    # Test Case: 0022C_Add Charge Screen_Hold For Review Reasons_Provider Review, User Pref Hide Checked
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "Edit Preferences Settings" dropdown
    And I select "Hide, Checked" from the "State of Hold for Review Checkbox" dropdown in the "Charge Capture Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And patient "Neil Heath" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I uncheck the following checkboxes in the "Hold For Review Popup" dropdown
      |AddReason1      |
      |AddReason2      |
      |AddReason3      |
    Then The following fields should not display in the "Hold For Review Reasons" pane
      |Name              |Type |
      |Review Requested  |check|
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I click the "Submit" button
    Then the "Charges" table should load with the following columns
      |Hold Reason|
    And I select "the first item" in the "Charges" table
    Then the text "Held for Review" should appear in the "Charge Detail" pane
    Then the text "Review requested" should appear in the "Charge Detail" pane

  Scenario: Verify Add Charge Screen_Hold For Review Reasons and Provider Review When User Pref is Hide UnChecked
    #Test Case: 22D_Add Charge Screen_Hold For Review Reasons_Provider Review, User Pref Hide Unchecked
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "Edit Preferences Settings" dropdown
    And I select "Hide, Unchecked" from the "State of Hold for Review Checkbox" dropdown in the "Charge Capture Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And patient "Neil Heath" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I uncheck the following checkboxes in the "Hold For Review Popup" dropdown
      |AddReason1      |
      |AddReason2      |
      |AddReason3      |
    Then The following fields should not display in the "Hold For Review Reasons" pane
      |Name              |Type |
      |Review Requested  |check|
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I click the "Submit" button
    Then the "Charges" table should load with the following columns
      |Hold Reason|
    And I select "the first item" in the "Charges" table
    Then the text "Held for Review" should appear in the "Charge Detail" pane
    Then the text "No" should appear in the "Charge Detail" pane

  Scenario: Verify Editing a transaction where Provider Review Unchecked and Current User state of held is Show Checked
    #Test Case: 22E_Editing a transaction where Provider Review Unchecked_Current User state of held, Show Checked or Hide Checked
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "Edit Preferences Settings" dropdown
    And I select "Show, Unchecked" from the "State of Hold for Review Checkbox" dropdown in the "Charge Capture Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And patient "Neil Heath" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I click the "Submit" button
    And I wait for loading to complete
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I click the "Search" button in the "Quick Details" pane
    And I enter "HFR3" in the "Search For User" field
    And I click the "Search" button
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown
    And I select "true" from the "Reviewing User" radio list in the "Personal Preferences Settings" pane
    And I select "Show, Checked" from the "State of Hold for Review Checkbox" dropdown in the "Personal Preferences Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Charges" from clinical navigation
    And I select "the first item" in the "Charges" table
    And I click the "Edit" button in the "Charge Detail" pane
    And I verify the availability of the following checkbox in the "Mark As Review Popup" dropdown
      |Review requested |
    Then the following should be checked
      |Review Requested|
    And I click the "Cancel Add Charge" button

  Scenario: Verify Editing a transaction where Provider Review Unchecked and Current User state of held is Hide Checked
    #Test Case: 22E_Editing a transaction where Provider Review Unchecked_Current User state of held, Show Checked or Hide Checked
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "Edit Preferences Settings" dropdown
    And I select "Show, Unchecked" from the "State of Hold for Review Checkbox" dropdown in the "Charge Capture Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I wait "3" seconds
    And I click the "Search" button in the "Quick Details" pane
    And I enter "HFR3" in the "Search For User" field
    And I click the "Search" button
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown
    And I wait "3" seconds
    And I select "true" from the "Reviewing User" radio list in the "Personal Preferences Settings" pane
    And I select "Hide, Checked" from the "State of Hold for Review Checkbox" dropdown in the "Personal Preferences Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And patient "Neil Heath" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I click the "Submit" button
    And I select "the first item" in the "Charges" table
    And I click the "Edit" button in the "Charge Detail" pane
    And I verify the availability of the following checkbox in the "Mark As Review Popup" dropdown
      |Review requested |
    Then the following should be checked
      |Review Requested |
    And I click the "Cancel Add Charge" button

  Scenario: Verify Edititng a transaction where Provider Review Checked and Current User state of held is Show Unchecked
    #Test Case: 22F_Edititng a transaction where Provider Review Checked_Current User state of held,  Show Unchecked or Hide Unchecked
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "Edit Preferences Settings" dropdown
    And I select "Show, Checked" from the "State of Hold for Review Checkbox" dropdown in the "Charge Capture Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And patient "Neil Heath" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I click the "Submit" button
    And I wait for loading to complete
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I wait "3" seconds
    And I click the "Search" button in the "Quick Details" pane
    And I enter "HFR3" in the "Search For User" field
    And I click the "Search" button
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown
    And I select "true" from the "Reviewing User" radio list in the "Personal Preferences Settings" pane
    And I select "Show, Unchecked" from the "State of Hold for Review Checkbox" dropdown in the "Personal Preferences Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "the first item" in the "Charges" table
    And I click the "Edit" button in the "Charge Detail" pane
    And I verify the availability of the following checkbox in the "Mark As Review Popup" dropdown
      |Review requested |
    Then the following should be checked
      |Review Requested |
    And I click the "Cancel Add Charge" button

  Scenario: Verify Edititng a transaction where Provider Review Checked and Current User state of held is Hide Unchecked
    #Test Case: 22F_Edititng a transaction where Provider Review Checked_Current User state of held,  Show Unchecked or Hide Unchecked
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "Edit Preferences Settings" dropdown
    And I select "Show, Checked" from the "State of Hold for Review Checkbox" dropdown in the "Charge Capture Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And patient "Neil Heath" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I click the "Submit" button
    And I wait for loading to complete
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I click the "Search" button in the "Quick Details" pane
    And I enter "HFR3" in the "Search For User" field
    And I click the "Search" button
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown
    And I select "true" from the "Reviewing User" radio list in the "Personal Preferences Settings" pane
    And I select "Hide, Unchecked" from the "State of Hold for Review Checkbox" dropdown in the "Personal Preferences Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Charges" from clinical navigation
    And I select "the first item" in the "Charges" table
    And I click the "Edit" button in the "Charge Detail" pane
    And I verify the availability of the following checkbox in the "Mark As Review Popup" dropdown
      |Review requested|
    Then the following should be checked
      |Review Requested |
    And I click the "Cancel Add Charge" button

  Scenario: Verify that Comment reasons are never displayed in the hold for review dropdown when adding a new charge
    #Test Case: 23_Add Charge Screen_Hold For Review Reasons_Standard Reasons_Comment Review on new charge
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "Edit Preferences Settings" dropdown
    And I select "Show, Checked" from the "State of Hold for Review Checkbox" dropdown in the "Charge Capture Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |AddReason1 |
    Then The following fields should not display in the "Hold For Review Reasons" pane
      |Name             |Type |
      |Comment Review   |check|
    And I click the "Cancel Add Charge" button

  Scenario: Verify Hold For Review Standard Reasons When user preferences for comment charges set to Yes and Prompt
    #Test Case: 23_Add Charge Screen_Hold For Review Reasons_Standard Reasons_Comment Review_User Pref for comment charges_Prompt
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "Edit Preferences Settings" dropdown
    And I select "true" from the "Reviewing User" radio list in the "Personal Preferences Settings" pane
    And I select "Show, Checked" from the "State of Hold for Review Checkbox" dropdown in the "Charge Capture Settings" pane
    And I select "2" from the "Hold Charge For Review Comment" radio list in the "Personal Preferences Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    And I am logged into the portal with user "HFR1" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And patient "Neil Heath" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      | AddReason2 |
    Then The following fields should not display in the "Hold For Review Reasons" pane
      | Name           | Type  |
      | Comment Review | check |
    And I uncheck the following checkboxes in the "Hold For Review Popup" dropdown
      | AddReason2       |
      | AddReason3       |
      | AddReason1       |
      | Review requested |
    And I wait "2" seconds
    And I click the "Comments" element
    And I enter "Comment" in the "Add Charge Comments" field
    And I set the following charge headers
      | Name      | Value       |
      | Bill Area | /Department |
      | Svc Site  | Inpatient   |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I click the "Submit" button
    And I click the "ConfirmYes" button in the "Confirm" pane
    And I wait for loading to complete
    And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
    And I select "the first item" in the "Charges" table
    Then the text "Held for Review" should appear in the "Charge Detail" pane
    Then the text "Comment Review" should appear in the "Charge Detail" pane
    And I click the "Edit" button in the "Charge Detail" pane
    And I verify the availability of the following checkbox in the "Mark As Review Popup" dropdown
      |Comment Review |
    And the following should be checked
      |Comment Review|
    And I click the "Cancel Add Charge" button

  Scenario: Verify Hold For Review Standard Reasons When user preferences for comment charges set to No and Prompt
    #Test Case: 23_Add Charge Screen_Hold For Review Reasons_Standard Reasons_Comment Review_User Pref for comment charges_Prompt
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "Edit Preferences Settings" dropdown
    And I select "true" from the "Reviewing User" radio list in the "Personal Preferences Settings" pane
    And I select "Show, Checked" from the "State of Hold for Review Checkbox" dropdown in the "Charge Capture Settings" pane
    And I select "2" from the "Hold Charge For Review Comment" radio list in the "Personal Preferences Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And patient "Neil Heath" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |AddReason2 |
    Then The following fields should not display in the "Hold For Review Reasons" pane
      |Name             |Type |
      |Comment Review   |check|
    And I uncheck the following checkboxes in the "Hold For Review Popup" dropdown
      |AddReason2       |
      |AddReason3       |
      |AddReason1       |
      |Review requested |
    And I click the "Comments" element
    And I enter "Comment" in the "Add Charge Comments" field
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I click the "Submit" button
    And I click the "ConfirmNo" button in the "Confirm" pane
    And I wait for loading to complete
    And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
    And I select "the first item" in the "Charges" table
    Then the text "Held for Review" should appear in the "Charge Detail" pane
    Then the text "No" should appear in the "Charge Detail" pane

  Scenario: Verify Hold For Review Standard Reasons When user preferences for comment charges set to YES
    #Test Case: 23A_Add Charge Screen_Hold For Review Reasons_Standard Reasons_Comment Review_User Pref for comment charges_Yes
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "Edit Preferences Settings" dropdown
    And I select "true" from the "Reviewing User" radio list in the "Personal Preferences Settings" pane
    And I select "Show, Checked" from the "State of Hold for Review Checkbox" dropdown in the "Charge Capture Settings" pane
    And I select "0" from the "Hold Charge For Review Comment" radio list in the "Personal Preferences Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    And I am logged into the portal with user "HFR1" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And patient "Neil Heath" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      | AddReason2 |
    Then The following fields should not display in the "Hold For Review Reasons" pane
      | Name           | Type  |
      |Comment Review   |check|
    And I uncheck the following checkboxes in the "Hold For Review Popup" dropdown
      |AddReason2       |
      |AddReason3       |
      |AddReason1       |
      |Review requested |
    And I click the "Comments" element
    And I enter "Comment" in the "Add Charge Comments" field
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I click the "Submit" button
    And I wait for loading to complete
    And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
    And I select "the first item" in the "Charges" table
    Then the text "Held for Review" should appear in the "Charge Detail" pane
    Then the text "Comment Review" should appear in the "Charge Detail" pane
    And I click the "Edit" button in the "Charge Detail" pane
    And I verify the availability of the following checkbox in the "Mark As Review Popup" dropdown
      |Comment Review |
    And the following should be checked
      |Comment Review|
    And I click the "Cancel Add Charge" button

  Scenario: Verify Hold For Review Standard Reasons When user preferences for comment charges set to NO
    #Test Case: 23B_Add Charge Screen_Hold For Review Reasons_Standard Reasons_Comment Review_User Pref for comment charges_No
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "Edit Preferences Settings" dropdown
    And I select "true" from the "Reviewing User" radio list in the "Personal Preferences Settings" pane
    And I select "Show, Checked" from the "State of Hold for Review Checkbox" dropdown in the "Charge Capture Settings" pane
    And I select "1" from the "Hold Charge For Review Comment" radio list in the "Personal Preferences Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And patient "Neil Heath" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |AddReason2 |
    Then The following fields should not display in the "Hold For Review Reasons" pane
      |Name             |Type |
      |Comment Review   |check|
    And I uncheck the following checkboxes in the "Hold For Review Popup" dropdown
      |AddReason2       |
      |AddReason3       |
      |AddReason1       |
      |Review requested |
    And I click the "Comments" element
    And I enter "Comment" in the "Add Charge Comments" field
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I click the "Submit" button
    And I wait for loading to complete
    And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
    And I select "the first item" in the "Charges" table
    Then the text "Held for Review" should appear in the "Charge Detail" pane
    Then the text "No" should appear in the "Charge Detail" pane

  Scenario: Verify that no of reasons indicated in the Hold For Review Button
    #Test Case: 0024_Add Charge Screen_Hold For Review Reason_Icon for Charge being held for review
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And patient "Neil Heath" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then The "Hold For Review" button should appear with the text "Hold For Review (4)" in the "Hold For Review Reasons" pane
    And I click the "Cancel Add Charge" button

  Scenario: Pre-requisite: Verify that Editing Provider A's charge with reasons current user can not control
    And I am on the manage hold for review page
    And I wait for loading to complete
    And I click the "Add Reason1 Edit" button
    And I click the "Hold Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Hold Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles Admin" checkbox in the "Roles" pane
    And I click the "Roles Ok" button
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Resolve Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles Admin" checkbox in the "Roles" pane
    And I click the "OkSection" button
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
    And I click the "Add Reason2 Edit" button
    And I click the "Hold Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Hold Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles Admin" checkbox in the "Roles" pane
    And I click the "Roles Ok" button
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Resolve Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles Admin" checkbox in the "Roles" pane
    And I click the "OkSection" button
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
    And I click the "Add Reason3 Edit" button
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "no" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
#    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane
    And I select the "User" subtab
    And I wait "3" seconds
    And I click the "Search" button in the "Quick Details" pane
    And I enter "HFR3" in the "Search For User" field
    And I click the "Search" button
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown
    And I select "true" from the "Reviewing User" radio list in the "Personal Preferences Settings" pane
    And I select "Show, Checked" from the "State of Hold for Review Checkbox" dropdown in the "Personal Preferences Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I select "User Permissions" from the "Edit User Settings" dropdown
    And I select "yes" from the "Can Edit Other Users Charges" radio list in the "Personal Preferences Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And patient "Neil Heath" has no charges
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I click the "Submit" button
    And I wait for loading to complete
    And I click the logout button

  Scenario: Verify that Editing Provider A's charge with reasons current user can not control
    #Test Case: 24A_Hold For Review Custom  Reason_Editing Provider A's charge with reasons current user cannot control
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Charges" from clinical navigation
    And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
    And I select "the first item" in the "Charges" table
    And I click the "Edit" button in the "Charge Detail" pane
    And I verify the availability of the following checkbox in the "Mark As Review Popup" dropdown
      |AddReason1 |
      |AddReason2 |
    And the following fields should be disabled in the "Hold For Review Reasons" pane
      |Name        |Type  |
      |AddReason_1 |check |
      |AddReason_2 |check |
    And I click the "Cancel Add Charge" button

  Scenario: Pre-requisite: Verify that Editing Provider A's charge with reasons current user can control
    And I am on the manage hold for review page
    And I wait for loading to complete
    And I click the "AddReason1 Edit" button
    And I click the "Hold Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
    And I click the "AddReason2 Edit" button
    And I click the "Hold Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
#    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And patient "Neil Heath" has no charges
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I click the "Submit" button
    And I click the logout button

  Scenario: Verify that Editing Provider A's charge with reasons current user can control
    #Test Case: 25_Hold For Review Custom  Reason_Editing Provider A's charge with reasons current user can control
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Charges" from clinical navigation
    And I select "the first item" in the "Charges" table
    And I click the "Edit Charge" button
    And I verify the availability of the following checkboxes in the "Mark As Review Popup" dropdown
      |AddReason1 |
      |AddReason2 |
    And The following fields should be enabled in the "Hold For Review Reasons" pane
      |Name       |Type |
      |AddReason_1|check|
      |AddReason_2|check|
    And I click the "Cancel Add Charge" button

  Scenario: Verify that on copy charge also there are same Hold for review reasons as in the original charge
    #Test Case: 26_Copy Charge
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And patient "Neil Heath" has no charges
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Review requested |
    And I uncheck the following checkboxes in the "Hold For Review Popup" dropdown
      |Review requested|
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I click the "Submit" button
    And I wait for loading to complete
    And I select "the first item" in the "Charges" table
    Then the text "AddReason1, AddReason2" should appear in the "Charge Detail" pane
    And I click the "CopyCharge" button
    And I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |AddReason1 |
      |AddReason2 |
    And the following should be checked
      |AddReason1|
      |AddReason2|
    And I click the "Cancel Add Charge" button

  Scenario: Verify If there are checked reasons already then the charge will be saved for those reasons
    #Test Case: 27_Click on Hold for review reasons button
    And I select the "User" subtab
    And I click the "Search" button in the "Quick Details" pane
    And I enter "HFR3" in the "Search For User" field
    And I click the "Search" button
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown
    And I wait "3" seconds
    And I select "Show, Unchecked" from the "State of Hold for Review Checkbox" dropdown in the "Personal Preferences Settings" pane
    And I select "1" from the "Hold Charge For Review Comment" radio list in the "Personal Preferences Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I click the "Edits" button
    And The following fields should display in the "Held For Review Edits Reasons" pane
      |Name              |Type   |
      |EditsCustomReasons|element|
    And I click the "Cancel Add Charge" button

  Scenario: Verify If there are no reasons checked but Provider Review reason is available then it should save for the same
    #Test Case: 27_Click on Hold for review reasons button
    And I select the "User" subtab
    And I click the "Search" button in the "Quick Details" pane
    And I enter "HFR3" in the "Search For User" field
    And I click the "Search" button
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown
    And I select "Show, Unchecked" from the "State of Hold for Review Checkbox" dropdown in the "Personal Preferences Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And patient "Neil Heath" has no charges
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |AddReason1 |
      |AddReason2 |
    And I uncheck the following checkboxes in the "Hold For Review Popup" dropdown
      |AddReason1|
      |AddReason2|
    And I click the "Hold For Review" button
    And I click the "Edits" button
    And The following fields should display in the "Held For Review Edits Reasons" pane
      |Name                         |Type   |
      |Edits Review Requested Reason|element|
    And I click the "Cancel Add Charge" button

  Scenario:  Verify If no reasons checked and Provider Review is not available then the prompt asking to select reason
    #Test Case: 27_Click on Hold for review reasons button
    And I select the "User" subtab
    And I click the "Search" button in the "Quick Details" pane
    And I enter "HFR3" in the "Search For User" field
    And I click the "Search" button
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown
    And I select "Hide, Unchecked" from the "State of Hold for Review Checkbox" dropdown in the "Personal Preferences Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |AddReason1 |
      |AddReason2 |
    And I uncheck the following checkboxes in the "Hold For Review Popup" dropdown
      |AddReason1|
      |AddReason2|
    And I click the "Hold For Review" button
    Then There should be an alert with the text "Please select hold for review reason"
    And I handle the alert
    And I click the "Cancel Add Charge" button

  Scenario: Verify unchecking custom reasons and then click on Hold for review button to get warning message
    #Test Case: 27_Click on Hold for review reasons button
    And I select the "User" subtab
    And I click the "Search" button in the "Quick Details" pane
    And I enter "HFR3" in the "Search For User" field
    And I click the "Search" button
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown
    And I wait "3" seconds
    And I select "Hide, Unchecked" from the "State of Hold for Review Checkbox" dropdown in the "Personal Preferences Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |AddReason1 |
      |AddReason2 |
    And I uncheck the following checkboxes in the "Hold For Review Popup" dropdown
      |AddReason1|
      |AddReason2|
    And I click the "Hold For Review" button
    Then There should be an alert with the text "Please select hold for review reason"
    And I handle the alert
    And I click the "Cancel Add Charge" button

  Scenario: Verify that all the charges that are added/copied to selected multi-day dates  are saved with Hold for review
    #Test Case: 28_Hold for review_multiday
    And I select the "User" subtab
    And I click the "Search" button in the "Quick Details" pane
    And I enter "HFR3" in the "Search For User" field
    And I click the "Search" button
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown
    And I select "yes" from the "Allow Multiple Days Charge Creation" radio list in the "Personal Preferences Settings" pane
    And I select "Show, Checked" from the "State of Hold for Review Checkbox" dropdown in the "Personal Preferences Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I move the mouse over the "Additional Dates" element in the "Charge Details" pane
    And I wait "2" seconds
    And I click the "Add Date Range" element in the "Add Multi Date Charge" pane
    And I enter "%Current Date MMDDYYYY%" in the "Additional Dates Start Date" field
    And I enter "%1 days from now MMDDYYYY%" in the "Additional Dates End Date" field
    And I wait "5" seconds
    And I click the "Submit" button
    And I wait for loading to complete
    Then rows starting with the following should appear in the "Hold For Review Multi Day Charges" table
      |Sent to Holding Bin with Errors|
      |Held for Review                |
    And I click the "Finish" button

  Scenario: Verify all the charges added via Multiday are saved with Comment Review Reason When Hold charge for Comment Review-Yes
      #Multiday and BCE scenarios
      #Test case:0028A_Hold For Review_MultiDay_Comment Review_Automatically Hold -Yes
    And I select the "User" subtab
    And I search for the user "HFR3"
    And I select the user "HFR3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "Show, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I select "0" from the "HoldChargeForReviewComment" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And patient "MOLLY DARR" has no charges
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00120"
    And I move the mouse over the "Additional Dates" element in the "Charge Details" pane
    And I wait "2" seconds
    And I click the "Add Date Range" element in the "Add Multi Date Charge" pane
    And I enter "%1 day ago MMDDYYYY%" in the "Additional Dates Start Date" field
    And I enter "%Current Date MMDDYYYY%" in the "Additional Dates End Date" field
    And I click the "Comments" element
    And I enter "Verified" in the "Add Charge Comments" field
    And I click the "Submit" button
    And I wait for loading to complete
    Then rows starting with the following should appear in the "Hold For Review Multi Day Charges" table
      |Sent to Holding Bin with Errors|
      |Held for Review                |
    And I click the "Finish" button
    Then the following rows should appear in the "Charges" table
      | Date/Time              | Proc                     | Diag  |
      | %Current Date MMDDYY%  | 00120 Anesth Ear Surgery | B36.0 |
      | %1 day ago MMDDYY%     | 00120 Anesth Ear Surgery | B36.0 |
    And I select "the first item" in the "Charges" table
    Then the text "AddReason1, AddReason2, Comment Review" should appear in the "Charge Detail" pane

  Scenario: Verify all the charges added via Multiday are saved with Comment Review Reason When Hold charge for Comment Review- Prompt User
     #Test case: 0028B_Hold For Review_Multiday_Comment Review_Auto Hold_Prompt
    And I select the "User" subtab
    And I search for the user "HFR3"
    And I select the user "HFR3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "2" from the "HoldChargeForReviewComment" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And patient "MOLLY DARR" has no charges
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00120"
    And I move the mouse over the "Additional Dates" element in the "Charge Details" pane
    And I wait "2" seconds
    And I click the "Add Date Range" element in the "Add Multi Date Charge" pane
    And I enter "%2 days ago MMDDYYYY%" in the "Additional Dates Start Date" field
    And I enter "%Current Date MMDDYYYY%" in the "Additional Dates End Date" field
    And I click the "Comments" element
    And I enter "Verified" in the "Add Charge Comments" field
    And I click the "Submit" button
    And the following text should appear in the "Confirm" pane
      |You have entered a comment. Hold charge for review?|
    And I click the "ConfirmYes" button in the "Confirm" pane
    And I wait for loading to complete
    Then rows starting with the following should appear in the "Hold For Review Multi Day Charges" table
      |Sent to Holding Bin with Errors|
      |Held for Review                |
    And I click the "Finish" button
    Then the following rows should appear in the "Charges" table
      | Date/Time              | Proc                     | Diag  |
      | %Current Date MMDDYY%  | 00120 Anesth Ear Surgery | B36.0 |
      | %1 day ago MMDDYY%     | 00120 Anesth Ear Surgery | B36.0 |
      | %2 days ago MMDDYY%     | 00120 Anesth Ear Surgery | B36.0 |
    And I select "the first item" in the "Charges" table
    Then the text "AddReason1, AddReason2, Comment Review" should appear in the "Charge Detail" pane

  Scenario: Verify all the charges added via Multiday are saved with Comment Review Reason When Hold charge for Comment Review- No
     #Test case: 0028C_Hold For Review_Multiday_Comment Review_No
    And I select the "User" subtab
    And I search for the user "HFR3"
    And I select the user "HFR3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "1" from the "HoldChargeForReviewComment" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And patient "MOLLY DARR" has no charges
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00140"
    And I move the mouse over the "Additional Dates" element in the "Charge Details" pane
    And I wait "2" seconds
    And I click the "Add Date Range" element in the "Add Multi Date Charge" pane
    And I enter "%1 day ago MMDDYYYY%" in the "Additional Dates Start Date" field
    And I enter "%Current Date MMDDYYYY%" in the "Additional Dates End Date" field
    And I click the "Comments" element
    And I enter "Verified" in the "Add Charge Comments" field
    And I click the "Submit" button
    Then rows starting with the following should appear in the "Hold For Review Multi Day Charges" table
      |Sent to Holding Bin with Errors|
      |Held for Review                |
    And I click the "Finish" button
    Then the following rows should appear in the "Charges" table
      | Date/Time              | Proc                           | Diag  |
      | %Current Date MMDDYY%  | 00140 Anesth Procedures On Eye | B36.0 |
      | %1 day ago MMDDYY%     | 00140 Anesth Procedures On Eye | B36.0 |
    And I select "the first item" in the "Charges" table
    Then the text "AddReason1, AddReason2" should appear in the "Charge Detail" pane
    And patient "MOLLY DARR" has no charges

  Scenario: Verify all the charges added added/copied via Multiday are saved with Hold for review Provider Review Reason [Show,checked]
     #Test case:0029_Hold For Review_Multiday_Provider Review
    And I am on the manage hold for review page
    #Editing Custom reason Add Reason3 Edit
    And I click the "Add Reason3 Edit" button
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
#    And I click the "Manage Hold For Review Close" button
    And I click the "X-close" button
    And I select the "User" subtab
    And I search for the user "HFR3"
    And I select the user "HFR3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "1" from the "HoldChargeForReviewComment" radio list
    And I select "Show, Checked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    And patient "Neil Heath" has no charges
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00140"
    And I move the mouse over the "Additional Dates" element in the "Charge Details" pane
    And I wait "2" seconds
    And I click the "Add Date Range" element in the "Add Multi Date Charge" pane
    And I enter "%1 day ago MMDDYYYY%" in the "Additional Dates Start Date" field
    And I enter "%Current Date MMDDYYYY%" in the "Additional Dates End Date" field
    And I click the "Comments" element
    And I enter "Verified" in the "Add Charge Comments" field
    And I click the "Submit" button
    Then rows starting with the following should appear in the "Hold For Review Multi Day Charges" table
      |Sent to Holding Bin with Errors|
      |Held for Review                |
    And I click the "Finish" button
    Then the following rows should appear in the "Charges" table
      | Date/Time              | Proc                           | Diag  |
      | %Current Date MMDDYY%  | 00140 Anesth Procedures On Eye | B36.0 |
      | %1 day ago MMDDYY%     | 00140 Anesth Procedures On Eye | B36.0 |
    And I select "the first item" in the "Charges" table
    Then the text "AddReason1, AddReason2, AddReason3, Review requested" should appear in the "Charge Detail" pane

  Scenario: Verify all the charges added added/copied via Multiday are saved with Hold for review Provider Review Reason [Hide,checked]
     #Test case:0029_Hold For Review_Multiday_Provider Review
    And I select the "User" subtab
    And I search for the user "HFR3"
    And I select the user "HFR3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "Hide, Checked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    And patient "Neil Heath" has no charges
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00140"
    And I move the mouse over the "Additional Dates" element in the "Charge Details" pane
    And I wait "2" seconds
    And I click the "Add Date Range" element in the "Add Multi Date Charge" pane
    And I enter "%1 day ago MMDDYYYY%" in the "Additional Dates Start Date" field
    And I enter "%Current Date MMDDYYYY%" in the "Additional Dates End Date" field
    And I click the "Comments" element
    And I enter "Verified" in the "Add Charge Comments" field
    And I click the "Submit" button
    Then rows starting with the following should appear in the "Hold For Review Multi Day Charges" table
      |Sent to Holding Bin with Errors|
      |Held for Review                |
    And I click the "Finish" button
    Then the following rows should appear in the "Charges" table
      | Date/Time              | Proc                           | Diag  |
      | %Current Date MMDDYY%  | 00140 Anesth Procedures On Eye | B36.0 |
      | %1 day ago MMDDYY%     | 00140 Anesth Procedures On Eye | B36.0 |
    And I select "the first item" in the "Charges" table
    Then the text "AddReason1, AddReason2, AddReason3, Review requested" should appear in the "Charge Detail" pane

  Scenario: Verify all the charges added added/copied via Multiday are saved with Hold for review Provider Review Reason [Hide,Unchecked]
      #Test case:0029_Hold For Review_Multiday_Provider Review
    And I select the "User" subtab
    And I search for the user "HFR3"
    And I select the user "HFR3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "Hide, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    And patient "Neil Heath" has no charges
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |/Department        |
      |Svc Site     |Inpatient          |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00140"
    And I move the mouse over the "Additional Dates" element in the "Charge Details" pane
    And I wait "2" seconds
    And I click the "Add Date Range" element in the "Add Multi Date Charge" pane
    And I enter "%1 day ago MMDDYYYY%" in the "Additional Dates Start Date" field
    And I enter "%Current Date MMDDYYYY%" in the "Additional Dates End Date" field
    And I click the "Comments" element
    And I enter "Verified" in the "Add Charge Comments" field
    And I click the "Submit" button
    Then rows starting with the following should appear in the "Hold For Review Multi Day Charges" table
      |Sent to Holding Bin with Errors|
      |Held for Review                |
    And I click the "Finish" button
    Then the following rows should appear in the "Charges" table
      | Date/Time              | Proc                           | Diag  |
      | %Current Date MMDDYY%  | 00140 Anesth Procedures On Eye | B36.0 |
      | %1 day ago MMDDYY%     | 00140 Anesth Procedures On Eye | B36.0 |
    And I select "the first item" in the "Charges" table
    Then the text "AddReason1, AddReason2, AddReason3" should appear in the "Charge Detail" pane
    And patient "Neil Heath" has no charges
    And I click the logout button

  Scenario: Verify the customs reasons that are displayed under Charge detail pane which are submitted via BCE- Provider review [Show,checked]
     #Test case: 0017A_BCE_Hold for Review Charges_Reasons in Charges
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "EditPreferencesSettings" dropdown
    And I select "Show, Checked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Charges" tab
    And I select the "Batch Charge Entry" subtab
    Then the "BCE Hold For Review Popup" "pkdropdown" should be visible
    Then I verify the availability of the following checkbox in the "BCE Hold For Review Popup" dropdown
      |AddReason1        |
      |AddReason2        |
      |AddReason3        |
      |Review requested  |
    And I select patient "Molly Darr" from the "Name (\d)" column in the "Visits" table
    And I select patient "HEATH, NEIL" from the "Name (\d)" column in the "Visits" table
    When I select "/Department" from the "Bill Area" tabledropdown in the "Batch Charge Entry" pane
    And I select "Inpatient" from the "Svc Site" tabledropdown in the "Batch Charge Entry" pane
    And I click the "AddEditCharges" button in the "BatchChargeEntry" pane
    And I wait "5" seconds
    And I enter the ICD-10 code "R52"
    And I click the "CPT" button
    And I enter the CPT code "86000"
    Then the text "86000" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button
    And I wait "5" seconds
    Then the following rows should appear in the "ChargeList" table
      |Charges 				             |Qty |Diagnoses |
      |86000 Agglutinins Febrile Antigen |1   |R52 Pain  |
    And I click the "SaveCharges" button
    Then the text "You are about to create a charge transaction for 2 patients. Do you wish to proceed?" should appear in the "Question" pane
    When I click the "OK" button in the "Question" pane
    And I wait "5" seconds
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "the first item" in the "Charges" table
    Then the text "AddReason1, AddReason2, AddReason3, Review requested" should appear in the "Charge Detail" pane
    And patient "MOLLY DARR" has no charges
    And I select patient "HEATH, NEIL" from the patient list
    And I select "the first item" in the "Charges" table
    Then the text "AddReason1, AddReason2, AddReason3, Review requested" should appear in the "Charge Detail" pane
    And patient "Neil Heath" has no charges
    And I click the logout button

  Scenario: Verify the customs reasons that are displayed under Charge detail pane which are submitted via BCE- Provider review [Show,Unchecked]
     #Test case: 0017A_BCE_Hold for Review Charges_Reasons in Charges
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "EditPreferencesSettings" dropdown
    And I select "Show, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And patient "Molly Darr" has no charges
    And I select patient "Neil Heath" from the patient list
    And patient "Neil Heath" has no charges
    And I am on the "Charges" tab
    And I select the "Batch Charge Entry" subtab
    Then the "BCE Hold For Review Popup" "pkdropdown" should be visible
    Then I verify the availability of the following checkbox in the "BCE Hold For Review Popup" dropdown
      |AddReason1        |
      |AddReason2        |
      |AddReason3        |
      |Review requested  |
    And I select patient "DARR, MOLLY" from the "Name (\d)" column in the "Visits" table
    And I select patient "HEATH, NEIL" from the "Name (\d)" column in the "Visits" table
    When I select "/Department" from the "Bill Area" tabledropdown in the "Batch Charge Entry" pane
    And I select "Inpatient" from the "Svc Site" tabledropdown in the "Batch Charge Entry" pane
    And I click the "AddEditCharges" button in the "BatchChargeEntry" pane
    And I wait "5" seconds
    And I enter the ICD-10 code "R52"
    And I click the "CPT" button
    And I enter the CPT code "86000"
    Then the text "86000" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button
    And I wait "5" seconds
    Then the following rows should appear in the "ChargeList" table
      |Charges 				             |Qty |Diagnoses |
      |86000 Agglutinins Febrile Antigen |1   |R52 Pain  |
    And I click the "SaveCharges" button
    Then the text "You are about to create a charge transaction for 2 patients. Do you wish to proceed?" should appear in the "Question" pane
    When I click the "OK" button in the "Question" pane
    And I wait "5" seconds
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    And I select "the first item" in the "Charges" table
    Then the text "AddReason1, AddReason2, AddReason3" should appear in the "Charge Detail" pane
    And I select patient "HEATH, NEIL" from the patient list
    And I select "the first item" in the "Charges" table
    Then the text "AddReason1, AddReason2, AddReason3" should appear in the "Charge Detail" pane
    And patient "DARR, MOLLY" has no charges
    And I click the logout button

  Scenario: Verify the customs reasons that are displayed under Charge detail pane which are submitted via BCE- Provider review [Hide,Checked]
     #Test case: 0017A_BCE_Hold for Review Charges_Reasons in Charges
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "EditPreferencesSettings" dropdown
    And I select "Hide, Checked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And patient "MOLLY DARR" has no charges
    And I select patient "Neil Heath" from the patient list
    And patient "Neil Heath" has no charges
    And I am on the "Charges" tab
    And I select the "Batch Charge Entry" subtab
    Then the "BCE Hold For Review Popup" "pkdropdown" should be visible
    Then I verify the availability of the following checkbox in the "BCE Hold For Review Popup" dropdown
      |AddReason1        |
      |AddReason2        |
      |AddReason3        |
    And I select patient "Molly Darr" from the "Name (\d)" column in the "Visits" table
    And I select patient "HEATH, NEIL" from the "Name (\d)" column in the "Visits" table
    When I select "/Department" from the "Bill Area" tabledropdown in the "Batch Charge Entry" pane
    And I select "Inpatient" from the "Svc Site" tabledropdown in the "Batch Charge Entry" pane
    And I click the "AddEditCharges" button in the "BatchChargeEntry" pane
    And I wait "5" seconds
    And I enter the ICD-10 code "R52"
    And I click the "CPT" button
    And I enter the CPT code "86000"
    Then the text "86000" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button
    And I wait "5" seconds
    Then the following rows should appear in the "ChargeList" table
      |Charges 				             |Qty |Diagnoses |
      |86000 Agglutinins Febrile Antigen |1   |R52 Pain  |
    And I click the "SaveCharges" button
    Then the text "You are about to create a charge transaction for 2 patients. Do you wish to proceed?" should appear in the "Question" pane
    When I click the "OK" button in the "Question" pane
    And I wait "5" seconds
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "the first item" in the "Charges" table
    Then the text "AddReason1, AddReason2, AddReason3, Review requested" should appear in the "Charge Detail" pane
    And I select patient "HEATH, NEIL" from the patient list
    And I select "the first item" in the "Charges" table
    Then the text "AddReason1, AddReason2, AddReason3, Review requested" should appear in the "Charge Detail" pane
    And patient "MOLLY DARR" has no charges
    And patient "Neil Heath" has no charges
    And I click the logout button

  Scenario: Verify the customs reasons that are displayed under Charge detail pane which are submitted via BCE- Provider review [Hide,UnChecked]
     # Test case: 0017A_BCE_Hold for Review Charges_Reasons in Charges
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "EditPreferencesSettings" dropdown
    And I select "Hide, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And patient "MOLLY DARR" has no charges
    And I select patient "Neil Heath" from the patient list
    And patient "Neil Heath" has no charges
    And I am on the "Charges" tab
    And I select the "Batch Charge Entry" subtab
    Then the "BCE Hold For Review Popup" "pkdropdown" should be visible
    Then I verify the availability of the following checkbox in the "BCE Hold For Review Popup" dropdown
      |AddReason1        |
      |AddReason2        |
      |AddReason3        |
    And I select patient "Molly Darr" from the "Name (\d)" column in the "Visits" table
    And I select patient "HEATH, NEIL" from the "Name (\d)" column in the "Visits" table
    When I select "/Department" from the "Bill Area" tabledropdown in the "Batch Charge Entry" pane
    And I select "Inpatient" from the "Svc Site" tabledropdown in the "Batch Charge Entry" pane
    And I click the "AddEditCharges" button in the "BatchChargeEntry" pane
    And I wait "5" seconds
    And I enter the ICD-10 code "R52"
    And I click the "CPT" button
    And I enter the CPT code "86000"
    Then the text "86000" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button
    And I wait "5" seconds
    Then the following rows should appear in the "ChargeList" table
      |Charges 				             |Qty |Diagnoses |
      |86000 Agglutinins Febrile Antigen |1   |R52 Pain  |
    And I click the "SaveCharges" button
    Then the text "You are about to create a charge transaction for 2 patients. Do you wish to proceed?" should appear in the "Question" pane
    When I click the "OK" button in the "Question" pane
    And I wait "5" seconds
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "the first item" in the "Charges" table
    Then the text "AddReason1, AddReason2, AddReason3" should appear in the "Charge Detail" pane
    Then the text "Review requested" should not appear in the "Charge Detail" pane
    And I select patient "HEATH, NEIL" from the patient list
    And I select "the first item" in the "Charges" table
    Then the text "AddReason1, AddReason2, AddReason3" should appear in the "Charge Detail" pane
    Then the text "Review requested" should not appear in the "Charge Detail" pane
    And I click the logout button

  Scenario:8.4.1. DEV-77277- Holding Bin Mark as Reviewed
    When I am on the "Patient List V2" tab
    Then I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
       |Name         |Value           |
       |Bill Area    |/Department     |
       |Svc Site     |Inpatient       |
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "86005"
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
       |AddReason1        |
       |AddReason2        |
       |AddReason3        |
    And I click the "Submit" button
    Then the text "AddReason1, AddReason2, AddReason3" should appear in the "Charge Detail" pane
    And I am on the "Charges" tab
    When I select the "Holding Bin" subtab
    And I click the "Reset Criteria" button in the "Holding Bin" pane
    And I select "Current Week" from the "Timeframe" dropdown in the "Holding Bin" pane
    And I select "Held for Review" from the "Error Type" dropdown in the "Holding Bin" pane
    Then I click the "Show Charges" button in the "Holding Bin" pane
    When I select the "Held for Review" link in the row with "HEATH, NEIL" as the value under "Patient" in the "Holding Bin" table
    Then the "Held For Review Charge" pane should load
    Then the text "Held for Review: AddReason1, AddReason2, AddReason3" should appear in the "Charge Entry" pane
    And I click the "Mark As Reviewed With Reasons" button in the "Charge Entry" pane
    And I wait "3" seconds
    And I select "- All -" from the "Error Type" dropdown in the "Holding Bin" pane
    Then I click the "Show Charges" button in the "Holding Bin" pane
    And I select patient "HEATH, NEIL" from the "Patient" column in the "Holding Bin" table
    Then I click the "View Patient Details" icon
    And the "Patient Detail" pane should load
    Then I click the "Charges Left Nav" element
    And I uncheck the "Show Visits" checkbox
#     in the "Patient Detail Charges" pane
    Then the "Charge Detail" pane should load
    Then the following text should appear in the "Charge Detail" pane
       |Reason Name            |
       |AddReason1             |
       |Reviewer Name		   |
       |FORREVIEW, HOLD	       |
       |Review Date			   |
       |%Current Date MMDDYY%  |

       |Reason Name            |
       |AddReason2             |
       |Reviewer Name		   |
       |FORREVIEW, HOLD	       |
       |Review Date			   |
       |%Current Date MMDDYY%  |

       |Reason Name            |
       |AddReason3             |
       |Reviewer Name		   |
       |FORREVIEW, HOLD	       |
       |Review Date			   |
       |%Current Date MMDDYY%  |
    And I click the "Patient Detail Close" button

  Scenario: Verify HFR charge as reviewed in charge detail pane.[DEV-77660]
    When I am on the "Patient List V2" tab
    Then I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
       |Name         |Value           |
       |Bill Area    |/Department     |
       |Svc Site     |Inpatient       |
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "86005"
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
       |AddReason1        |
       |AddReason2        |
       |AddReason3        |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    Then I uncheck the following checkbox in the "Hold For Review Popup" dropdown
       |AddReason3            |
    And I click the "Submit" button
    Then the text "AddReason1, AddReason2" should appear in the "Charge Detail" pane
    And I click the logout button
    Given I am logged into the portal with user "HFR2" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    And I select "the first item" in the "Charges" table
    And I click the "Edit Charge" button
    And I verify the availability of the following checkboxes in the "Mark As Review Popup" dropdown
       |AddReason1 |
       |AddReason2 |
       |AddReason3 |
       |Review requested |
    Then I check the following checkbox in the "Mark As Review Popup" dropdown
       |Review requested |
    And I click the "Submit" button
    Then the text "AddReason1, AddReason2, AddReason3, Review requested" should appear in the "Charge Detail" pane
    And I click the "Mark As Reviewed Charge Detail" button in the "Charge Detail" pane
    Then the following text should appear in the "Charge Detail" pane
       |Reason Name            |
       |AddReason1             |
       |Reviewer Name		   |
       |FORREVIEW2, HOLD	   |
       |Review Date			   |
       |%Current Date MMDDYY%  |

       |Reason Name            |
       |AddReason2             |
       |Reviewer Name		   |
       |FORREVIEW2, HOLD	   |
       |Review Date			   |
       |%Current Date MMDDYY%  |

       |Reason Name            |
       |AddReason3             |
       |Reviewer Name		   |
       |FORREVIEW2, HOLD	   |
       |Review Date			   |
       |%Current Date MMDDYY%  |

       |Reason Name            |
       |Review requested       |
       |Reviewer Name		   |
       |FORREVIEW2, HOLD	   |
       |Review Date			   |
       |%Current Date MMDDYY%  |

  Scenario: Reverting the settings for HFR custom reason
    And I am on the manage hold for review page
    #Editing Custom reason Add Reason3 Edit
    And I click the "Add Reason3 Edit" button
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "no" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
#    And I click the "Manage Hold For Review Close" button
    And I click the "X-close" button
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "EditPreferencesSettings" dropdown
    And I select "Show, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab

  Scenario: Deactivate the Reasons under Manage Hold For Review and Provider Review Settings
    And I am on the manage hold for review page
    And I wait for loading to complete
    Then the "Manage Hold For Review Reasons" pane should load
    And I deactivate the following reasons in manage hold for review pane
      |AddReason1   |
      |AddReason2   |
      |AddReason3   |
#    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "Edit User Settings" dropdown
    And I select "Show, Checked" from the "State of Hold for Review Checkbox" dropdown in the "Personal Preferences Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box


