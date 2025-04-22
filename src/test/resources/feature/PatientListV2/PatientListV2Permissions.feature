@PatientListV2
Feature: Patient List V2 Patient List Permissions
#TODO: Create unique patient lists, with meaningful names, for each scenario.  This will remove the need for list setup steps in each scenario.
#TODO: Rename _sk users to something more meaningful

#  # In 842:
#  #Almost the entire feature is failing (12 out of 14 tests) due to:
#  #[DEV-79084],  https://jira/browse/DEV-79084, "Labels for Patient List Type and Permissions are incorrect"
#  # -- HIC 3/14/19  (Happy Pi Day!)

  Background:
    Given I am logged into the portal with user "PLV2ADMIN" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized

  Scenario: Check default permissions
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "Test Patient List" in the "Name" field
    And I select the "Permissions" section
    Then the following should be checked
      |Allow Manual Add/Remove Of Patients|
    Then the following fields should display in the "Permissions" pane
      |Name       | Type      |
      |View		  | dropdown  |
      |Manage     | dropdown  |
      |Add/Remove | dropdown  |
    And I click the "Create Patient List Cancel" button

  Scenario: Unfinished Permission selection should throw errors
    When I select "SKPatientList1" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "3" seconds
    And I select the "Permissions" section
    And I uncheck the "Allow Manual Add/Remove Of Patients" checkbox
    And I select "Specific users/departments/facilities..." from the "Manage" dropdown
    And I select the "Overview" section
    Then the following text should appear in the "Permissions" pane
      |Text|
      |Please fix the following errors:|
    And I click the "Create PatientList Cancel" button

  Scenario: View - No Other Users
    When I select "SKPatientList1" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "3" seconds
    And I select the "Permissions" section
    And I uncheck the "Allow Manual Add/Remove Of Patients" checkbox
    And I select "No other users" from the "View" dropdown
    And I select "No other users" from the "Manage" dropdown
    And I click the "Create Patient List Save" button
   #test level 2 user access
    When I am logged into the portal with user "_skl2" using the default password
    And I am on the "Patient List V2" tab
    Then the "Patient List" menu should not have the following options
      |SKPatientList1|
   #test level 3 user access
    When I am logged into the portal with user "_skl3" using the default password
    And I am on the "Patient List V2" tab
    Then the "Patient List" menu should not have the following options
      |SKPatientList1|
    And I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "SKPatientList1" in the "Patient List Search" field
    Then the "Patient List Search Results" table should have "0" rows containing the text "SKPatientList1"

  Scenario: Allow manual add/remove of patients - Checked
    When I select "SKPatientList1" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "3" seconds
    And I select the "Permissions" section
    And I check the "Allow Manual Add/Remove Of Patients" checkbox
    And I select "No other users" from the "View" dropdown
    And I select "No other users" from the "Manage" dropdown
    And I select "All users" from the "Add/Remove" dropdown
    And I click the "Create Patient List Save" button
    And "Mona Angeline" is not on the patient list
   #test level 2 user access
    When I am logged into the portal with user "_skl2" using the default password
   #And I select "SKPatientList1 (PATIENTLISTV2ADMIN, V)" from the "Patient List" menu
    And I refresh the patient list
    And I wait "3" seconds
    And I select "SKPatientList1" from the "Patient List" menu
    And I select "Add Patient(s)" from the "Actions" menu
    Then the "Add Patients To Your Patient List" pane should load
    When I click the "Clear Criteria" button
    And I enter "4" in the "Admit in last N days" field
    And I search for patient "Mona Angeline"
    And I select "the first item" from the "Name (\d)" column in the "Add Patient Search" table
    And I click the "Add" button in the "Add patient(s) to your patient list" pane
   #And I click the "Close Pop Up" button in the "Add Patient Result" pane
    And I wait "6" seconds
    And I click the "Close" button in the "Add patient(s) to your patient list" pane
#    Then patient "Mona Angeline" should be on the patient list
    And "Mona Angeline" is on the patient list
    When I select patient "Mona Angeline" from the patient list
    And I select "Remove Patient" from the "Actions" menu
    And I click the "Yes" button in the "Question" pane
    And I refresh the patient list
    Then patient "Mona Angeline" should not be on the patient list
#    And "Mona Angeline" is not on the patient list
   #test level 3 user access
    When I am logged into the portal with user "_skl3" using the default password
    And I select "SKPatientList1" from the "Patient List" menu
    And I select "Add Patient(s)" from the "Actions" menu
    Then the "Add Patients To Your Patient List" pane should load
    When I click the "Clear Criteria" button
    And I enter "4" in the "Admit in last N days" field
    And I search for patient "Mona Angeline"
    And I select "the first item" from the "Name (\d)" column in the "Add Patient Search" table
    And I click the "Add" button in the "Add patient(s) to your patient list" pane
   #And I click the "Close Pop Up" button in the "Add Patient Result" pane
    And I wait "6" seconds
    And I click the "Close" button in the "Add patient(s) to your patient list" pane
#    Then patient "Mona Angeline" should be on the patient list
    And "Mona Angeline" is on the patient list
    When I select patient "Mona Angeline" from the patient list
    And I select "Remove Patient" from the "Actions" menu
    And I click the "Yes" button in the "Question" pane
    And I refresh the patient list
    Then patient "Mona Angeline" should not be on the patient list
#    And "Mona Angeline" is not on the patient list

  Scenario: Allow manual add/remove of patients - Unchecked - Add
    When I select "SKPatientList1" from the "Patient List" menu
    #And "Edward P Petty" is not on the patient list
    And I select "Edit" from the "Actions" menu
    And I wait "3" seconds
    And I select the "Permissions" section
    And I uncheck the "Allow Manual Add/Remove Of Patients" checkbox
    And I select "No other users" from the "View" dropdown
    And I select "No other users" from the "Manage" dropdown
    And I click the "Create Patient List Save" button
    And I click the logout button
   #test patient list creator's access after uncheck - should not have access
    Given I am logged into the portal with user "PLV2ADMIN" using the default password
    And I am on the "Patient List V2" tab
    Then the "Actions" menu should have the following options disabled
      |Add Patient(s) |

  Scenario: Allow manual add/remove of patients - Unchecked - Remove
    When I select "SKPatientList1" from the "Patient List" menu
    #And "Edward P Petty" is not on the patient list
    And I select "Edit" from the "Actions" menu
    And I wait "5" seconds
    And I select the "Permissions" section
    And I uncheck the "Allow Manual Add/Remove Of Patients" checkbox
    And I select "No other users" from the "View" dropdown
    And I select "No other users" from the "Manage" dropdown
    And I click the "Create Patient List Save" button
   #test patient list creator's access after uncheck - should not have access even when
   #Remove Selected Patient link is disabled
    And I refresh the patient list
    Then the "Actions" menu should have the following options disabled
      |Remove Patient |

  Scenario: View - All Users
    When I select "SKPatientList1" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "3" seconds
    And I select the "Permissions" section
    And I uncheck the "Allow Manual Add/Remove Of Patients" checkbox
    And I select "All users" from the "View" dropdown
    And I select "No other users" from the "Manage" dropdown
    And I click the "Create Patient List Save" button
    And I wait for loading to complete
   #test level 2 user access
    When I am logged into the portal with user "_skl2" using the default password
    And I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "SKPatientList1" in the "Patient List Search" field
    Then the "Patient List Search Results" table should have "1" rows containing the text "SKPatientList1"
    And I favorite the list by clicking the "Patient List Favorite" button in the row with "SKPatientList1" as the value under "Name (\d)" in the "Patient List Search Results" table
#    And the "Edit Favorite" pane should load
    And I click the "Edit Favorite Save" button if it exists
    And I click the "Close Search For Patient List" button
    Then the "Patient List" menu should have the following options
      |SKPatientList1|
   #test level 3 user access
    When I am logged into the portal with user "_skl3" using the default password
    And I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "SKPatientList1" in the "Patient List Search" field
    Then the "Patient List Search Results" table should have "1" rows containing the text "SKPatientList1"
    And I favorite the list by clicking the "Patient List Favorite" button in the row with "SKPatientList1" as the value under "Name (\d)" in the "Patient List Search Results" table
#    And the "Edit Favorite" pane should load
    And I click the "Edit Favorite Save" button if it exists
    And I click the "Close Search For Patient List" button
    Then the "Patient List" menu should have the following options
      |SKPatientList1|
#		Then the "Patient List" menu should have the following options
#			|SKPatientList1 (PATIENTLISTV2ADMIN, V)|

  Scenario: View - Specific Users
    When I select "ESSKAYPL1" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "3" seconds
    And I select the "Permissions" section
    And I uncheck the "Allow Manual Add/Remove Of Patients" checkbox
    And I select "Specific users/departments/facilities..." from the "View" dropdown
    And I enter "esskay" in the "View Search" field
    And I select "No other users" from the "Manage" dropdown
    And I click the "Create Patient List Save" button
    And I wait for loading to complete
   #test specific user's access to the patient list
    When I am logged into the portal with user "esskay" using the default password
    Then the "Patient List" menu should have the following options
      |ESSKAYPL1|
   #test a user who does NOT have access to this patient list
    When I am logged into the portal with user "_sk5l3" using the default password
    Then the "Patient List" menu should not have the following options
      |ESSKAYPL1|

  Scenario: View - Specific Departments
    When I select "SKPatientList1" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "3" seconds
    And I select the "Permissions" section
    And I uncheck the "Allow Manual Add/Remove Of Patients" checkbox
    And I select "Specific users/departments/facilities..." from the "View" dropdown
    And I enter "sk" in the "View Search" field
    And I click the "View Search" button
    And I select "sklabel" from the "Name" column in the "User Department Facility Search" table
    And I select "No other users" from the "Manage" dropdown
    And I click the "Create Patient List Save" button
    And I wait for loading to complete
   #test level 2 user in the department access
    When I am logged into the portal with user "_skl2a" using the default password
    Then the "Patient List" menu should have the following options
      |SKPatientList1 (PATIENTLISTV2ADMIN, V)|
   #test level 2 user out of the department access
    When I am logged into the portal with user "_sk5l3" using the default password
    Then the "Patient List" menu should not have the following options
      |SKPatientList1|

  Scenario: DEV-42651 - Unable to Edit and Save a patient list's user permissions
    When I select "SKPL1" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "3" seconds
    And I select the "Permissions" section
    And I uncheck the "Allow Manual Add/Remove Of Patients" checkbox
    And I select "Specific users/departments/facilities..." from the "Manage" dropdown
    And I enter "sklabel" in the "Manage Search" field
#    commented below steps as "sklabel" gets autoselected on entering
#    And I click the "Manage Search" button
#    And I select "sklabel" in the "User Department Facility Manage Search" table
    And I select the "Summary" section
    And I click the "Show Permission Details" link in the "Summary" pane
    Then the following rows should appear in the "Permissions" table
      |Name    |Type       |Access |
      |sklabel |DEPARTMENT |MANAGE |
    And I click the "Create Patient List Cancel" button

  @donotrun
  Scenario: View - Specific Facilities

  Scenario: Manage - No Other Users  and can't Add/Remove
    When I select "SKPatientList1" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "3" seconds
    And I select the "Permissions" section
    And I uncheck the "Allow Manual Add/Remove Of Patients" checkbox
    And I select "No other users" from the "Manage" dropdown
    And I select "No other users" from the "View" dropdown
    And I click the "Create Patient List Save" button
    When I am logged into the portal with user "_skl2" using the default password
    And I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "SKPatientList1" in the "Patient List Search" field
    Then the "Patient List Search Results" table should have "0" rows containing the text "SKPatientList1"

  Scenario: Manage - All Users  and can't Add/Remove
    When I select "SKPL1" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "3" seconds
    And I select the "Permissions" section
    And I uncheck the "Allow Manual Add/Remove Of Patients" checkbox
    And I select "No other users" from the "View" dropdown
    And I select "All users" from the "Manage" dropdown
    And I click the "Create Patient List Save" button
   #level 2 user should have access as the access
    When I am logged into the portal with user "_skl2" using the default password
    And I select "Find a Patient List" from the "Actions" menu
    And I enter "SKPL1" in the "Patient List Search" field
    Then the "Patient List Search Results" table should have "1" rows containing the text "SKPL1"
    And I favorite the list by clicking the "Patient List Favorite" button in the row with "SKPL1" as the value under "Name (\d)" in the "Patient List Search Results" table
#    And the "Edit Favorite" pane should load
    And I click the "Edit Favorite Save" button if it exists
    And I click the "Close Search For Patient List" button
    Then the "Patient List" menu should have the following options
      |SKPL1|

  Scenario: Manage - Specific Users and can't Add/Remove
    When I select "SKPL1" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "3" seconds
    And I select the "Permissions" section
    And I uncheck the "Allow Manual Add/Remove Of Patients" checkbox
    And I select "No other users" from the "View" dropdown
    And I select "Specific users/departments/facilities..." from the "Manage" dropdown
    And I enter "ess" in the "Manage Search" field
    And I click the "Manage Search" button
    And I select "KAY6" from the "Last Name" column in the "User Department Facility Manage Search" table
    And I click the "Create Patient List Save" button
   #level 2 user should have access
    When I am logged into the portal with user "_skl2a" using the default password
    And I select "Find a Patient List" from the "Actions" menu
    And I enter "SKPL1" in the "Patient List Search" field
    Then the "Patient List Search Results" table should have "1" rows containing the text "SKPL1"
    And I favorite the list by clicking the "Patient List Favorite" button in the row with "SKPL1" as the value under "Name (\d)" in the "Patient List Search Results" table
#    And the "Edit Favorite" pane should load
    And I click the "Edit Favorite Save" button if it exists
    And I click the "Close Search For Patient List" button
    Then the "Patient List" menu should have the following options
      |SKPL1|

  @Demo
  Scenario: Reassign Patient is disabled
    When I select "TBC Patient List" from the "Patient List" menu
#    And "Mona Angeline" is on the patient list
#    And I select patient "Mona Angeline" from the patient list
    And "01 TBCTEST" is on the patient list
    And I select patient "01 TBCTEST" from the patient list
    Then the "Actions" menu should have the following options disabled
      |Reassign Patient |

  @donotrun
  Scenario: Manage - Specific Departments

  @donotrun
  Scenario: Manage - Specific Facilities

  @donotrun
  Scenario: Add/Remove - No Other Users

  @donotrun
  Scenario: Add/Remove - All Users

  @donotrun
  Scenario: Add/Remove - Specific Users

  @donotrun
  Scenario: Add/Remove - Specific Departments

  @donotrun
  Scenario: Add/Remove - Specific Facilities

#	Test these combos:
#		Manage, can't Add/remove
#		View, can't manage
#		View, can't add/remove
#		Add/remove, can't manage
#
#	Specific Users/Departments/Facilities
#		Don't worry so much about combinations
#		Department - try with a few users in department, few out
#		Facility - try with a few in facility, a few out
#		Users - try a few users