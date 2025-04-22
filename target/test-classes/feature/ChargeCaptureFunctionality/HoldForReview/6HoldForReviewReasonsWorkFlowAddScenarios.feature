@HoldForReview
Feature: 6 Hold For Review Reasons Work Flow Add Scenarios
#  Add Work Flow Matrix test cases

  Background:
    Given I am logged into the portal with user "HFR1" using the default password
    And I am on the "Admin" tab

  Scenario: Verify the Hold For Review reasons when there are multiple reasons for holding. At least one is checked in add charge screen.
#     Test case: There are multiple reasons for holding. At least one is checked.
    And I select the "User" subtab
    And I search for the user "HFR3"
    And I select the user "HFR3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "false" from the "Reviewing User" radio list
    And I select "Show, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the manage hold for review page
    Then the "Manage Hold For Review Reasons" pane should load
    And I activate the following reasons in manage hold for review pane
      |Test1   |
      |Test2   |
      |Test3   |
    # Editing Custom reason Test1 Hold Roles
    And I click the "Test1 Edit" button
    And I click the "Hold Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Hold Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
 #  Editing Custom reason Test2 Hold Roles
    And I click the "Test2 Edit" button
    And I click the "Hold Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Hold Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value           |
      |Bill Area    |/Department     |
      |Svc Site     |Inpatient       |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "86000"
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    Then the "Hold For Review Popup" "button" should be visible
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Test3            |
      |Test2            |
      |Test1            |
      |Review requested |
    And I click the "Submit" button
    Then the text "Test1, Test2" should appear in the "Charge Detail" pane

  Scenario: Verify the Hold For Review reasons when there are multiple reasons for holding. No reasons are checked in add charge screen.
#     Test case: There are multiple reasons for holding. Nothing checked.
    And I am on the manage hold for review page
#    # Editing Custom reason Test1 Hold Roles
    And I click the "Test1 Edit" button
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "no" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
# #  Editing Custom reason Test2 Hold Roles
    And I wait up to "10" seconds for the "Test2 Edit" field of type "BUTTON" to be visible
    And I click the "Test2 Edit" button
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "no" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value           |
      |Bill Area    |/Department     |
      |Svc Site     |Inpatient       |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "86000"
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    Then the "Hold For Review Popup" "button" should be visible
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Test3            |
      |Test2            |
      |Test1            |
      |Review requested |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    Then I check the following checkbox in the "Hold For Review Popup" dropdown
      |Test3            |
    And I click the "Submit" button
    Then the text "Test3" should appear in the "Charge Detail" pane

  Scenario: Verify the Hold For Review reasons when there are multiple reasons for holding,One reason is default checked and Others default unchecked in add charge screen.
#    Test case: There are multiple reasons for holding. One is default checked. Others default unchecked.
    And I am on the manage hold for review page
    #  Editing Custom reason Test2 Hold Roles
    And I click the "Test2 Edit" button
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value           |
      |Bill Area    |/Department     |
      |Svc Site     |Inpatient       |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "86000"
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    Then the "Hold For Review Popup" "button" should be visible
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Test3            |
      |Test2            |
      |Test1            |
      |Review requested |
    And I click the "Submit" button
    Then the text "Test2" should appear in the "Charge Detail" pane

  Scenario:Verify the Hold For Review reasons when there is only 1 reason that user can hold for which is default checked.
#     Test case:There is only 1 reason that user can hold for which is default checked.
    And I select the "User" subtab
    And I search for the user "HFR3"
    And I select the user "HFR3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "Hide, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the manage hold for review page
    Then the "Manage Hold For Review Reasons" pane should load
    And I deactivate the following reasons in manage hold for review pane
      |Test1   |
      |Test3   |
    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value           |
      |Bill Area    |/Department     |
      |Svc Site     |Inpatient       |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "86000"
    Then the "Hold For Review Popup" "pkdropdown" should not be visible
    Then the "Hold For Review Popup" "button" should not be visible
    Then the following should be checked in the "Charge Entry" pane
      |Hold For Review |
    And I click the "Submit" button
    Then the text "Test2" should appear in the "Charge Detail" pane

  Scenario: Verify the Hold For Review reasons checkbox when there is only 1 reason that user can hold for which is default unchecked.
#     Test case: there is only 1 reason that user can hold for which is default unchecked.
    And I am on the manage hold for review page
    And I deactivate the following reasons in manage hold for review pane
      |Test2   |
      |Test3   |
    And I activate the following reasons in manage hold for review pane
      |Test1   |
    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value           |
      |Bill Area    |/Department     |
      |Svc Site     |Inpatient       |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "86000"
    Then the "Hold For Review Popup" "pkdropdown" should not be visible
    Then the "Hold For Review Popup" "button" should not be visible
    Then the following should be unchecked in the "Charge Entry" pane
      |Hold For Review |
    And I click the "Close" image

  Scenario: Verify the Hold For Review reason checkbox when there are no reason that user can hold.
#      Test case:no reasons this user can hold chtx for
    And I am on the manage hold for review page
    And I deactivate the following reasons in manage hold for review pane
      |Test1   |
    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then the "Hold For Review Popup" "pkdropdown" should not be visible
    Then the "Hold For Review Popup" "button" should not be visible
    Then the "Hold For Review" "checkbox" should not be visible
    And I click the "Close" image

  Scenario: Deactivate all the reasons Under Manage Hold For Review Reasons
    And I am on the manage hold for review page
    And I deactivate the following reasons in manage hold for review pane
      |Test1           |
      |Test2           |
      |Test3           |
      |CustomReason    |
      |Reason1         |
      |Reason2         |
      |Reason3         |
      |Reason4         |
    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button