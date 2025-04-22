@HoldForReview
Feature: 5 Hold For Review Reasons Work Flow Edit Scenarios
#  Edit Work Flow Matrix test cases

  Background:
    Given I am logged into the portal with user "HFR1" using the default password
    And I am on the "Admin" tab


  Scenario: Configuring the settings for the HoldForReview reasons and Inactivate all the reasons
    And I am on the manage hold for review page
    And I wait up to "10" seconds for the "Test1 Edit" field of type "BUTTON" to be visible
#  Editing Custom reason Test1
    And I click the "Test1 Edit" button
    And I click the "Hold Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Hold Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles BILLER" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Resolve Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles Admin" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait up to "10" seconds for the "Test2 Edit" field of type "BUTTON" to be visible
#  Editing Custom reason Test2
    And I click the "Test2 Edit" button
    And I click the "Hold Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Hold Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles BILLER" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Resolve Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles Admin" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait up to "10" seconds for the "Test3 Edit" field of type "BUTTON" to be visible
#  Editing Custom reason Test3
    And I click the "Test3 Edit" button
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane if it exists
    And I click the "Resolve Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "no" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
    And I deactivate the following reasons in manage hold for review pane
      |Test1   |
      |Test2   |
      |Test3   |
    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button

  Scenario: Pre-requisite for User to make it as a Reviewing User and uncheck the Reasons
    And I select the "User" subtab
    And I search for the user "HFR3"
    And I select the user "HFR3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "true" from the "Reviewing User" radio list
    And I select "Show, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the manage hold for review page
    And I activate the following reasons in manage hold for review pane
      |Test1|
      |Test2|
      |Test3|
    And I click the "Manage Hold For Review Close" button

  Scenario: Verify the Hold For Review reasons is displayed when there are more than 1 reasons that user can hold for. No reasons are default checked in edit charge screen
#    Test case:Charge Txn is held but user can't interact with held reason(s).There are more than 1 reasons that user can hold for.No default checked
    And I select the "User" subtab
    And I search for the user "HFR3"
    And I select the user "HFR3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "Show, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name      | Value       |
      | Bill Area | /Department |
      | Svc Site  | Inpatient   |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "86000"
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      | Test3            |
      | Test2            |
      | Test1            |
      | Review requested |
    And I click the "Submit" button
    Then the text "Test1, Test2" should appear in the "Charge Detail" pane
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    And I select "the first item" in the "Charges" table
    And I click the "Edit" button in the "Charge Detail" pane
    Then the text "Held for Review: Test1, Test2" should appear in the "Charge Entry" pane
    Then the "Mark As Reviewed WithOut Reasons" "button" should not be visible
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    Then the "Hold For Review Popup" "button" should be visible
    Then I verify the availability of the following checkbox in the "Hold For Review Popup" dropdown
      |Test2            |
      |Test1            |
      |Test3            |
      |Review requested |
    And I click the "Close" image

  Scenario:  Verify the Hold For Review reason checkbox is displayed with default unchecked, when there is 1 reason that user can hold for. No reasons default checked in edit charge screen
#     Test case:Charge Txn is held but user can't interact with held reason(s). There is 1 reason that user can hold for. No default checked.
    And I select the "User" subtab
    And I search for the user "HFR3"
    And I select the user "HFR3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "true" from the "Reviewing User" radio list
    And I select "Hide, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    And I select "Charges" from clinical navigation
    And I select "the first item" in the "Charges" table
    And I click the "Edit" button in the "Charge Detail" pane
    Then the text "Held for Review: Test1, Test2" should appear in the "Charge Entry" pane
    Then the "Mark As Reviewed WithOut Reasons" "button" should not be visible
    Then the "Hold For Review Popup" "pkdropdown" should not be visible
    Then the following should be unchecked in the "Charge Entry" pane
      |Hold For Review |
    And I click the "Close" image

  Scenario: Verify the Hold For Review reasons is displayed when there are 0 reasons that user can hold for. Some reasons are default checked in edit charge screen
#      Test case:Chtx is held but user can't interact with held reason(s). There are more than 0 reasons that user can hold for. Some default checked.
    And I select the "User" subtab
    And I search for the user "HFR3"
    And I select the user "HFR3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "Show, Checked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the manage hold for review page
    And I click the "Test3 Edit" button
    Then the "Edit Reason Roles Mapping" pane should load
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "yes" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
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
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Test3            |
      |Test2            |
      |Test1            |
      |Review requested |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    Then I uncheck the following checkbox in the "Hold For Review Popup" dropdown
      |Test3  |
    And I click the "Submit" button
    Then the text "Test1, Test2" should appear in the "Charge Detail" pane
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    And I select "Charges" from clinical navigation
    And I select "the first item" in the "Charges" table
    And I click the "Edit" button in the "Charge Detail" pane
    Then the text "Held for Review: Test1, Test2" should appear in the "Charge Entry" pane
    Then the "Mark As Reviewed WithOut Reasons" "button" should not be visible
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    Then the "Hold For Review Popup" "button" should be visible
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Test3            |
      |Test2            |
      |Test1            |
      |Review requested |

  Scenario: Verify the Hold For Review reasons is displayed when there are no reasons that user can hold for in edit charge screen.
#     Test case: Chtx is held but user can't interact with held reason(s). There are no reasons that user can hold this chtx for .
    And I am on the manage hold for review page
    And I deactivate the following reasons in manage hold for review pane
      |Test3     |
    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I select the "User" subtab
    And I search for the user "HFR3"
    And I select the user "HFR3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "Hide, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
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
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Test2            |
      |Test1            |
      |Review requested |
    And I click the "Submit" button
    Then the text "Test1, Test2" should appear in the "Charge Detail" pane
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    And I select "the first item" in the "Charges" table
    And I click the "Edit" button in the "Charge Detail" pane
    Then the text "Held for Review: Test1, Test2" should appear in the "Charge Entry" pane
    Then the "Mark As Reviewed With Reasons" "button" should not be visible
    Then the "Hold For Review Popup" "pkdropdown" should not be visible
    Then the "Hold For Review Popup" "button" should not be visible
    And I click the "Close" image

  Scenario: Verify the Hold For Review reasons is not displayed when no more reasons that user can hold for to display in edit charge screen
#      Test case:Chtx is held for 1 reason and user can resolve this reason. No more reasons that user can hold for to display.
    And I am on the manage hold for review page
    And I deactivate the following reasons in manage hold for review pane
      |Test1   |
      |Test2   |
    And I activate the following reasons in manage hold for review pane
      |Test3   |
    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
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
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Test3            |
      |Review requested |
    And I click the "Submit" button
    Then the text "Test3" should appear in the "Charge Detail" pane
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    And I select "the first item" in the "Charges" table
    And I click the "Edit" button in the "Charge Detail" pane
    Then the text "Held for Review: Test3" should appear in the "Charge Entry" pane
    Then the "Mark As Reviewed WithOut Reasons" "button" should be visible
    Then the "Hold For Review Popup" "pkdropdown" should not be visible
    Then the "Hold For Review Popup" "button" should not be visible
    And I click the "Mark As Reviewed WithOut Reasons" button
    Then rows containing the following should appear in the "Charges" table
      |Date/Time             |Hold Reason  |
      |%Current Date MMDDYY% |             |

  Scenario: Verify the Hold For Review reasons is not displayed when there are 0 reasons that user can hold for. Some reasons are default checked in edit charge screen
#      Test case:Chtx is held for one or multiple reasons that user can resolve. There are more than 0 reasons the user can hold for.
    And I am on the manage hold for review page
    And I activate the following reasons in manage hold for review pane
      |Test1   |
      |Test2   |
    And I click the "Test1 Edit" button
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane
    And I click the "Resolve Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
#      Editing Custom reason Test2
    And I wait up to "10" seconds for the "Test2 Edit" field of type "BUTTON" to be visible
    And I click the "Test2 Edit" button
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane
    And I click the "Resolve Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I select the "User" subtab
    And I search for the user "HFR3"
    And I select the user "HFR3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "true" from the "Reviewing User" radio list
    And I select "Show, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
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
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Test3            |
      |Test2            |
      |Test1            |
      |Review requested |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    Then I uncheck the following checkbox in the "Hold For Review Popup" dropdown
      |Test3            |
    And I click the "Submit" button
    Then the text "Test1, Test2" should appear in the "Charge Detail" pane
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    And I select "the first item" in the "Charges" table
    And I click the "Edit" button in the "Charge Detail" pane
    Then the text "Held for Review: Test1, Test2" should appear in the "Charge Entry" pane
    Then the "Mark As Review Popup" "pkdropdown" should be visible
    Then the "Mark As Reviewed With Reasons" "button" should be visible
    Then the "Hold For Review Popup" "pkdropdown" should not be visible
    Then the "Hold For Review Popup" "button" should not be visible
    And I wait "5" seconds
    And I click the "Mark As Reviewed With Reasons" button in the "Charge Entry" pane
    And I wait up to "10" seconds for the "Charges" field of type "TABLE" to be visible
    Then rows containing the following should appear in the "Charges" table
      |Date/Time             |Hold Reason  |
      |%Current Date MMDDYY% |             |

  Scenario: Verify the Hold For Review reasons is displayed when there multiple reasons that user can hold for.
#      Test case: Chtx is not held currently and there are multiple reasons for holding (checked and unchecked).
    And I select the "User" subtab
    And I search for the user "HFR3"
    And I select the user "HFR3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "true" from the "Reviewing User" radio list
    And I select "Show, Checked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the manage hold for review page
    And I wait for loading to complete
    And I click the "Test1 Edit" button
    And I select "no" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "no" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I click the "Test2 Edit" button
    And I select "yes" from the "Default State" radio list in the "Edit Reason Roles Mapping" pane
    And I select "no" from the "Default Value" radio list in the "Edit Reason Roles Mapping" pane
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait for loading to complete
    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
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
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Test3            |
      |Test2            |
      |Review requested |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    Then I uncheck the following checkbox in the "Hold For Review Popup" dropdown
      |Test3            |
    And I click the "Submit" button
    Then rows containing the following should appear in the "Charges" table
      |Date/Time             |Hold Reason  |
      |%Current Date MMDDYY% |             |
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    And I select "the first item" in the "Charges" table
    And I click the "Edit" button in the "Charge Detail" pane
    Then the "Mark As Reviewed With Reasons" "button" should not be visible
    Then the "Hold For Review Popup" "pkdropdown" should be visible
    Then the "Hold For Review Popup" "button" should be visible
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Test3            |
      |Review requested |
    And I click the "Close" image

  Scenario:  Verify the Hold For Review reason checkbox with checked state there is only 1 reason that user can hold for which is default checked.
#      Test case:Chtx is not held currently and there is only 1 reason that user can hold for which is default checked.
    And I am on the manage hold for review page
    And I deactivate the following reasons in manage hold for review pane
      |Test1|
      |Test2|
      |Test3|
    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
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
    And I click the "Submit" button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    And I select "the first item" in the "Charges" table
    And I click the "Edit" button in the "Charge Detail" pane
    Then the "Mark As Reviewed With Reasons" "button" should not be visible
    Then the "Hold For Review Popup" "pkdropdown" should not be visible
    Then the "Hold For Review Popup" "button" should not be visible
    Then the following should be checked in the "Charge Entry" pane
      |Hold For Review |
    And I click the "Close" image


  Scenario: Verify the Hold For Review reason checkbox with unchecked state there is only 1 reason that user can hold for which is default unchecked.
#       Test case:Chtx is not held currently and there is only 1 reason that user can hold for which is default unchecked.
    And I select the "User" subtab
    And I search for the user "HFR3"
    And I select the user "HFR3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "true" from the "Reviewing User" radio list
    And I select "Hide, Unchecked" from the "State of Hold for Review Checkbox" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the manage hold for review page
    And I click the "Test3 Edit" button
    And I click the "Resolve Roles Delete" image in the "Edit Reason Roles Mapping" pane
    And I click the "Resolve Roles Lookup" element in the "Edit Reason Roles Mapping" pane
    And I check the "Roles User" checkbox in the "Roles" pane
    And I click the "Roles Ok" button in the "Roles" pane
    And I check the "active" checkbox
    And I click the "Save Edit Reason" button in the "Edit Reason Roles Mapping" pane
    And I wait up to "20" seconds for the "Manage Hold For Review Close" field of type "BUTTON" to be visible
    And I click the "Manage Hold For Review Close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
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
    Then I verify the availability of the following checkboxes in the "Hold For Review Popup" dropdown
      |Test3            |
      |Review requested |
    And I click the "Submit" button
    Given I am logged into the portal with user "HFR3" using the default password
    And I am on the "Patient List V2" tab
    And I select "HFR" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    And I select "the first item" in the "Charges" table
    And I click the "Edit" button in the "Charge Detail" pane
    Then the "Mark As Reviewed With Reasons" "button" should not be visible
    Then the "Hold For Review Popup" "pkdropdown" should not be visible
    Then the "Hold For Review Popup" "button" should not be visible
    Then the following should be unchecked in the "Charge Entry" pane
      |Hold For Review |
    And I click the "Close" image
    And I am on the "Patient List V2" tab
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    And patient "Neil Heath" has no charges

  Scenario: Deactivate all the Test reasons in the manage Hold for review reasons page
    And I am on the manage hold for review page
    And I deactivate the following reasons in manage hold for review pane
      |Test1|
      |Test2|
      |Test3|
    And I click the "Manage Hold For Review Close" button
    And I click the logout button
