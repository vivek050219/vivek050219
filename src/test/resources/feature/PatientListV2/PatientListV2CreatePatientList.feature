@PatientListV2
Feature: Patient List V2 Patient List Creation
  Validation of various patient list creation workflows in Patient List V2

  Background:
    Given I am logged into the portal with user "PLV2LVL3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized

  Scenario: Create a TBC Patient List
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel TBC Testing" in the "Name" field
    And I enter "Description" in the "Description" field
   #Time based Criteria Setting
    And I select the "TimeCriteria" section
    And I do the following TimeBasedCriteria settings
      | Type       | Add Patients                  | Remove Patients              |
      | ER         | On Admit Date                 | 3: days after Discharge Date |
      | Inpatient  | On Admit Date                 | 3: days after Discharge Date |
      | Outpatient | 3: days before Scheduled Date | 3: days after Scheduled Date |
      #Filter based Criteria Setting
    And I select the "Filters" section
    Then I click the "Delete Filter" icon if it exists
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load within "10" seconds
    When I select "Medical Service" from the "Filter On" dropdown
    Then the "Medical Service" pane should load
    When I enter "PLM2Test-TBC" in the "Filter Search" field
    And I check the "PLM2Test-TBC" checkbox
    And I click the "Add Filter" button
    Then the "Patient List Preview Tab" pane should load
    #Then the number of patients should be displayed
    And the following patients should be on "Preview Tab" PatientList
      | TBCTEST, 01 |
      | TBCTEST, 02 |
      | TBCTEST, 04 |
      | TBCTEST, 06 |
      | TBCTEST, 08 |
      | TBCTEST, 09 |
      | TBCTEST, 11 |
    And I click the "Create Patient List Create My List" button
    And I click the "Refresh Patient List" button
    When I select "VerveDel TBC Testing" from the "Patient List" menu
    Then the following patients should be on "Patient Visit" PatientList
      | TBCTEST, 01 |
      | TBCTEST, 02 |
      | TBCTEST, 04 |
      | TBCTEST, 06 |
      | TBCTEST, 08 |
      | TBCTEST, 09 |
      | TBCTEST, 11 |

  Scenario: Create a AutoDischarge1 Patient List
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel AutoDischarge1" in the "Name" field
    And I enter "Auto Discharge" in the "Description" field
    #Time based Criteria Setting
    And I select the "Time Criteria" section
    And I do the following TimeBasedCriteria settings
      | Type             | Add Patients  | Remove Patients              |
      | ER               | On Admit Date | 3: days after Discharge Date |
      | ER2              | N/A           | N/A                          |
      | ERAutoDisch24h   | On Admit Date | 3: days after Discharge Date |
      | ERAutoDisch36h   | On Admit Date | 3: days after Discharge Date |
      | ERAutoDisch48h   | On Admit Date | 3: days after Discharge Date |
      | ERAutoDisch60h   | On Admit Date | 3: days after Discharge Date |
      | ERAutoDisch72h   | On Admit Date | 3: days after Discharge Date |
      | ERAutoDischNextD | On Admit Date | 3: days after Discharge Date |
      | Inpatient        | N/A           | N/A                          |
      | Outpatient       | N/A           | N/A                          |
    #Filter based Criteria Setting
    And I select the "Filters" section
    Then I click the "Delete Filter" icon if it exists
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load within "10" seconds
    When I select "Medical Service" from the "Filter On" dropdown
    Then the "Medical Service" pane should load
    When I enter "PLM2Test-AD" in the "Filter Search" field
    And I check the "PLM2Test-AD" checkbox
    And I click the "Add Filter" button
    Then the "Patient List Preview Tab" pane should load
    #Then the number of patients should be displayed
    And the following patients should be on "Preview Tab" PatientList
      | AUTODCTEST, 01 |
      | AUTODCTEST, 05 |
      | AUTODCTEST, 09 |
      | AUTODCTEST, 13 |
      | AUTODCTEST, 17 |
      | AUTODCTEST, 21 |
      | AUTODCTEST, 25 |
    And I click the "Create Patient List Create My List" button
    When I select "VerveDel AutoDischarge1" from the "Patient List" menu
    Then the following patients should be on "Patient Visit" PatientList
      | AUTODCTEST, 01 |
      | AUTODCTEST, 05 |
      | AUTODCTEST, 09 |
      | AUTODCTEST, 13 |
      | AUTODCTEST, 17 |
      | AUTODCTEST, 21 |
      | AUTODCTEST, 25 |

  Scenario: Create a AutoDischarge2 Patient List
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel AutoDischarge2" in the "Name" field
    And I enter "Auto Discharge" in the "Description" field
   #Time based Criteria Setting
    And I select the "Time Criteria" section
    And I do the following TimeBasedCriteria settings
      | Type             | Add Patients  | Remove Patients              |
      | ER               | N/A           | N/A                          |
      | ER2              | N/A           | N/A                          |
      | ERAutoDisch24h   | On Admit Date | 3: days after Discharge Date |
      | ERAutoDisch36h   | On Admit Date | 3: days after Discharge Date |
      | ERAutoDisch48h   | On Admit Date | 3: days after Discharge Date |
      | ERAutoDisch60h   | On Admit Date | 3: days after Discharge Date |
      | ERAutoDisch72h   | On Admit Date | 3: days after Discharge Date |
      | ERAutoDischNextD | On Admit Date | 3: days after Discharge Date |
      | Inpatient        | N/A           | N/A                          |
      | Outpatient       | N/A           | N/A                          |
   #Filter based Criteria Setting
    And I select the "Filters" section
    Then I click the "Delete Filter" icon if it exists
    And I click the "Add A Filter" button
    And I wait "5" seconds
    Then the "Filter Criteria" pane should load within "10" seconds
    When I select "Medical Service" from the "Filter On" dropdown
    Then the "Medical Service" pane should load
    When I enter "PLM2Test-AD2" in the "Filter Search" field
    And I check the "PLM2Test-AD2" checkbox
    And I click the "Add Filter" button
    Then the "Patient List Preview Tab" pane should load
   #Then the number of patients should be displayed
    And the following patients should be on "Preview Tab" PatientList
      | AUTODCTEST, 24H-08AM |
      | AUTODCTEST, 24H-7PM  |
      | AUTODCTEST, 36H-08AM |
      | AUTODCTEST, 36H-7PM  |
      | AUTODCTEST, 48H-08AM |
      | AUTODCTEST, 48H-7PM  |
      | AUTODCTEST, 60H-08AM |
      | AUTODCTEST, 60H-7PM  |
      | AUTODCTEST, 72H-08AM |
      | AUTODCTEST, 72H-7PM  |
    And I click the "Create Patient List Create My List" button
    When I select "VerveDel AutoDischarge2" from the "Patient List" menu
    Then the following patients should be on "Patient Visit" PatientList
      | AUTODCTEST, 24H-08AM |
      | AUTODCTEST, 24H-7PM  |
      | AUTODCTEST, 36H-08AM |
      | AUTODCTEST, 36H-7PM  |
      | AUTODCTEST, 48H-08AM |
      | AUTODCTEST, 48H-7PM  |
      | AUTODCTEST, 60H-08AM |
      | AUTODCTEST, 60H-7PM  |
      | AUTODCTEST, 72H-08AM |
      | AUTODCTEST, 72H-7PM  |

  Scenario: Create Master Assignment List
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel MasterList" in the "Name" field
    And I enter "Assignment List Description" in the "Description" field
    And I select "ASSIGNMENT" from the "Type" radio list
    Then the "Assignment Sub List" pane should load
    And I add the following Assignment Sub List
      |VerveDel Alpha|
      |VerveDel Beta |
      |VerveDel Gamma|
    And I select the "Filters" section
    Then I click the "Delete Filter" icon if it exists
    And I click the "Add A Filter" button
#    Then the "Filter Criteria" pane should load within "10" seconds
    Then the "Filter Criteria" pane should load within "4" seconds
    When I select "Medical Service" from the "Filter On" dropdown
    Then the "Medical Service" pane should load
    When I enter "PLM2Test-TBC" in the "Filter Search" field
    And I check the "PLM2Test-TBC" checkbox
    And I click the "Add Filter" button
    And I select the "Time Criteria" section
    And I do the following TimeBasedCriteria settings
      | Type       | Add Patients      | Remove Patients              |
      | ER         | On Admit Date     | 3: days after Discharge Date |
      | Inpatient  | On Admit Date     | 3: days after Discharge Date |
      | Outpatient | On Scheduled Date | 3: days after Scheduled Date |
    Then the "Patient List Preview Tab" pane should load
    And I click the "Create Patient List Create My List" button
    Then I wait "6" seconds
#    And I refresh the patient list
    When I select "VerveDel MasterList" from the "Patient List" menu
    Then the following patients should be on "Patient Visit" PatientList
      | TBCTEST, 01 |
      | TBCTEST, 02 |
      | TBCTEST, 04 |
      | TBCTEST, 06 |
      | TBCTEST, 08 |
      | TBCTEST, 11 |
    When I select "Unassigned - VerveDel MasterList" from the "Patient List" menu
    Then the following patients should be on "Patient Visit" PatientList
      | TBCTEST, 01 |
      | TBCTEST, 02 |
      | TBCTEST, 04 |
      | TBCTEST, 06 |
      | TBCTEST, 08 |
      | TBCTEST, 11 |
    When I select "VerveDel Alpha" from the "Patient List" menu
    Then the text "No patients meet the current patient list criteria." should appear in the "Patient Visit" pane
    When I select "VerveDel Beta" from the "Patient List" menu
    Then the text "No patients meet the current patient list criteria." should appear in the "Patient Visit" pane

  Scenario: Patients that meet TBC added Manually to MasterList, check If only gets added to unassigned by default
    When I select "VerveDel MasterList" from the "Patient List" menu
    And "02 TBCTest" is not on the patient list
    And I refresh the patient list
    When I select "Add Patient(s)" from the "Actions" menu
    Then the "Add Patients To Your Patient List" pane should load
    And I click the "Clear Criteria" button
    And I enter "12" in the "D/C in last N days" field
    And I "check" the following
      |Include Cancelled Visits|
      |Include Past Visits     |
    And I search for patient "02 TBCTest"
    And I select "the first item" from the "Name (\d)" column in the "Add Patient Search" table
    And I click the "Add" button in the "Add patient(s) to your patient list" pane
    And I wait "1" seconds
    And I click the "Close" button in the "Add patient(s) to your patient list" pane
    Then "02 TBCTest" is on the patient list
    When I select "Unassigned - VerveDel MasterList" from the "Patient List" menu
    Then "02 TBCTest" is on the patient list
    When I select "VerveDel Alpha" from the "Patient List" menu
    Then patient "02 TBCTEST" should not be on the patient list
    And the text "No patients meet the current patient list criteria." should appear in the "Patient Visit" pane
    When I select "VerveDel Beta" from the "Patient List" menu
    Then patient "02 TBCTEST" should not be on the patient list
    And the text "No patients meet the current patient list criteria." should appear in the "Patient Visit" pane

  Scenario: Patients removed manually from the List
    When I select "VerveDel MasterList" from the "Patient List" menu
    And "04 TBCTest" is not on the patient list
    And I refresh the patient list
    When I select "Unassigned - VerveDel MasterList" from the "Patient List" menu
    Then patient "04 TBCTEST" should not be on the patient list
    Then the "Actions" menu should have the following options disabled
      | Remove Patient |

  Scenario: Patients added Manually to SubList, check If added patients present in Master List by default (DEV-42424,DEV-43757)
    When I select "VerveDel MasterList" from the "Patient List" menu
#    And "06 TBCTest" is not on the patient list
    And I refresh the patient list
    And I select "VerveDel Alpha" from the "Patient List" menu
    When I select "Add Patient(s)" from the "Actions" menu
    Then the "Add Patients To Your Patient List" pane should load
    When I click the "Clear Criteria" button
    And I enter "5" in the "Admit in last N days" field
    And I "check" the following
      |Include Cancelled Visits|
      |Include Past Visits     |
    And I search for patient "06 TBCTest"
    And I select "the first item" from the "Name (\d)" column in the "Add Patient Search" table
#    And I click the "Select A Patient List" button
#    And I enter "VerveDel Alpha" in the "Patient List Filter Search" field
    And I click the "Add" button in the "Add patient(s) to your patient list" pane
    And I wait "1" seconds
    And I click the "Close" button in the "Add patient(s) to your patient list" pane
    Then "06 TBCTest" is on the patient list
    When I select "Unassigned - VerveDel MasterList" from the "Patient List" menu
    And "06 TBCTEST" is not on the patient list
    When I select "VerveDel Alpha" from the "Patient List" menu
    Then "06 TBCTest" is on the patient list
    When I select "VerveDel Beta" from the "Patient List" menu
    Then patient "06 TBCTEST" should not be on the patient list
    And the text "No patients meet the current patient list criteria." should appear in the "Patient Visit" pane
    # No visits found for the below scenario
  @donotrun
  Scenario: Patient is discharged and then undischarged
    When I use the API to create a patient list named "VerveDel Discharge Test" owned by "PLV2the2nd" with the following parameters
      | Type   | Name            | Value       |
      | Filter | Medical Service | CHF Service |
    And I use the API to update the time criteria for the patient list named "VerveDel Discharge Test" owned by "PLV2the2nd" with the following
      | Action | Name      | Add Patients | Remove Patients |
      | Update |Inpatient  | Admit Date    | Immediately    |
    Given I am logged into the portal with user "PLV2ADMIN" using the default password
    When I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I enter "5" in the "Admit in last N days" field
    And I enter "Yalies" in the "Last" field
    And I enter "Clyde" in the "First" field
    And I click the "Search for Visits" button
    And I select "YALIES, CLYDE" from the "Name (\d)" column in the "Visit Search Results" table
    And I click the "Edit" button
    And I wait "1" seconds
    And I enter "%1 day ago MMDDYYYY%" in the "Discharge Date Time-Date" field
    And I enter "2:00pm" in the "Discharge Date Time-Time" field
    And I save the form entry
    When I am logged into the portal with user "PLV2the2nd" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "VerveDel Discharge Test" from the "Patient List" menu
    And "Yalies, Clyde" is not on the patient list
    Given I am logged into the portal with user "PLV2ADMIN" using the default password
    When I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I "check" the following
      |Include Cancelled Visits|
      |Include Past Visits     |
    And I enter "5" in the "Admit in last N days" field
    And I enter "Yalies" in the "Last" field
    And I enter "Clyde" in the "First" field
    And I click the "Search for Visits" button
    And I select patient "YALIES, CLYDE" from the "Name (\d)" column in the "Visit Search Results" table
    And I click the "Edit" button
    And I wait "1" seconds
    And I enter "" in the "Discharge Date Time-Date" field
    And I save the form entry
    When I am logged into the portal with user "PLV2the2nd" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "VerveDel Discharge Test" from the "Patient List" menu
    Then "Yalies, Clyde" is on the patient list

  @donotrun
  Scenario: Patient's location is updated
    Given I am logged into the portal with user "PLV2the2nd" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "PLV2the2nd Master List" from the "Patient List" menu
    Then patient "Witt,Deborah A" should be on the patient list
    Given I am logged into the portal with user "PLV2ADMIN" using the default password
    When I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I "check" the following
      |Include Cancelled Visits|
      |Include Past Visits     |
    And I select "Inpatient" from the "Visit Type" dropdown
    And I enter "1" in the "Admit in last N days" field
    And I search for patient "Witt, Deborah"
    And I select patient "Witt, Deborah A" from the "Name (\d)" column in the "Visit Search Results" table
    And I click the "Edit" button
    And I select "PKHospital-West" from the "Facility" dropdown
    And I save the form entry
    When I am logged into the portal with user "PLV2the2nd" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "PLV2the2nd Master List" from the "Patient List" menu
    Then patient "Witt,Deborah" should not be on the patient list
    And I select "Unassigned" from the "Patient List" menu
    Then patient "Witt,Deborah" should not be on the patient list
    Given I am logged into the portal with user "PLV2ADMIN" using the default password
    When I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I "check" the following
      |Include Cancelled Visits|
      |Include Past Visits     |
    And I select "Inpatient" from the "Visit Type" dropdown
    And I enter "1" in the "Admit in last N days" field
    And I search for patient "Witt, Deborah"
    And I select patient "Witt, Deborah A" from the "Name (\d)" column in the "Visit Search Results" table
    And I click the "Edit" button
    And I select "PKHospital-Alliance" from the "Facility" dropdown
    And I save the form entry
    When I am logged into the portal with user "PLV2the2nd" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "PLV2the2nd Master List" from the "Patient List" menu
    Then patient "Witt,Deborah A" should not be on the patient list
    And I select "Unassigned" from the "Patient List" menu
    Then patient "Witt,Deborah A" should be on the patient list

  @donotrun
  Scenario: Patient's visit type is updated
    Given I am logged into the portal with user "PLV2the2nd" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "PLV2the2nd Master List" from the "Patient List" menu
    Then patient "Witt,Deborah E" should be on the patient list
    Given I am logged into the portal with user "PLV2ADMIN" using the default password
    When I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I "check" the following
      |Include Cancelled Visits|
      |Include Past Visits     |
    And I select "Inpatient" from the "Visit Type" dropdown
    And I enter "1" in the "Admit in last N days" field
    And I search for patient "Witt, Deborah"
    And I select patient "Witt, Deborah E" from the "Name (\d)" column in the "Visit Search Results" table
    And I click the "Edit" button
    And I select "O" from the "Visit Type" dropdown
    And I save the form entry
    When I am logged into the portal with user "PLV2the2nd" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "PLV2the2nd Master List" from the "Patient List" menu
    Then patient "Witt,Deborah E" should not be on the patient list
    And I select "Unassigned" from the "Patient List" menu
    Then patient "Witt,Deborah E" should not be on the patient list
    Given I am logged into the portal with user "PLV2ADMIN" using the default password
    When I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I "check" the following
      |Include Cancelled Visits|
      |Include Past Visits     |
    And I select "Inpatient" from the "Visit Type" dropdown
    And I enter "1" in the "Admit in last N days" field
    And I search for patient "Witt, Deborah"
    And I select patient "Witt, Deborah A" from the "Name (\d)" column in the "Visit Search Results" table
    And I click the "Edit" button
    And I select "I" from the "Visit Type" dropdown
    And I save the form entry
    When I am logged into the portal with user "PLV2the2nd" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "PLV2the2nd Master List" from the "Patient List" menu
    Then patient "Witt,Deborah E" should not be on the patient list
    And I select "Unassigned" from the "Patient List" menu
    Then patient "Witt,Deborah E" should be on the patient list

  Scenario: Error Scenario - TBC Time left blank
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel TBC Error Test" in the "Name" field
    And I enter "Description" in the "Description" field
   #Time based Criteria Setting
    And I select the "Time Criteria" section
    And I do the following TimeBasedCriteria settings
      | Type       | Add Patients                  | Remove Patients                 |
      | Outpatient | 3: days before Scheduled Date | NULL: days after Scheduled Date |
   #Check for error text
    Then the text "days after Scheduled Date requires a valid number of days" should appear in the "Time Criteria" pane
    And I click the "Create Patient List Cancel" button