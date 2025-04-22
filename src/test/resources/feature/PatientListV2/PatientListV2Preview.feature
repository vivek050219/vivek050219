@PatientListV2
Feature: Patient List V2 Preview Patient List
    Additional test cases to validate the Preview pane in the Patient List Creation/Edit screen.
    Re-uses the 'Sort Test' patient list for some tests.  Does not save changes.

    Background:
        Given I am logged into the portal with user "PLV2LVL3" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized

    Scenario: Validate Preview updates correctly when criteria is added to TBC
        When I select "Preview Test" from the "Patient List" menu
        And I select "Edit" from the "Actions" menu
        And I select the "Time Criteria" section
        And I do the following TimeBasedCriteria settings
            | Type       | Add Patients                  | Remove Patients              |
            | ER         | On Admit Date                 | 3: days after Discharge Date |
            | Inpatient  | On Admit Date                 | 3: days after Discharge Date |
            | Outpatient | 3: days before Scheduled Date | 3: days after Scheduled Date |
        Then the following patients should be on "Preview Tab" PatientList
            | TBCTEST, 01 |
            | TBCTEST, 02 |
            | TBCTEST, 04 |
            | TBCTEST, 06 |
            | TBCTEST, 08 |
            | TBCTEST, 09 |
            | TBCTEST, 11 |
        And I click the "Create Patient List Cancel" button

    Scenario: Validate Preview updates correctly when criteria is removed from TBC
        When I select "Preview Test" from the "Patient List" menu
        And I select "Edit" from the "Actions" menu
        And I select the "Time Criteria" section
        And I do the following TimeBasedCriteria settings
            | Type       | Add Patients  | Remove Patients              |
            | ER         | N/A           | N/A                          |
            | Inpatient  | On Admit Date | 3: days after Discharge Date |
            | Outpatient | N/A           | N/A                          |
        Then the following patients should be on "Preview Tab" PatientList
            | TBCTEST, 01 |
            | TBCTEST, 02 |
            | TBCTEST, 04 |
        And I click the "Create Patient List Cancel" button

    Scenario: Validate Preview updates correctly when criteria is added/removed from FBC
        When I select "Preview Test" from the "Patient List" menu
        And I select "Edit" from the "Actions" menu
        And I select the "Filters" section
        And I click the "Add A Filter" button
        Then the "Filter Criteria" pane should load
        And I select "Visit Type" from the "Filter On" dropdown
        When I enter "Inpatient" in the "Visit Type Filter Search" field
        And I check the "Inpatient Filter" checkbox
        And I click the "Add Filter" button
        Then the "Patient List Preview Tab" pane should load
        And the following patients should be on "Preview Tab" PatientList
            | TBCTEST, 01 |
            | TBCTEST, 02 |
            | TBCTEST, 04 |
        When I click the "Remove Filter" button for the "Visit Type" entry
        Then the "Patient List Preview Tab" pane should load
        Then the following patients should be on "Preview Tab" PatientList
            | TBCTEST, 01 |
            | TBCTEST, 02 |
            | TBCTEST, 04 |
            | TBCTEST, 08 |
            | TBCTEST, 09 |
        And I click the "Create Patient List Cancel" button

    Scenario: Validate Preview matches Default Display configuration
        When I select "Preview Default Display Test" from the "Patient List" menu
        And I select "Edit" from the "Actions" menu
        Then the visit cell for patient "DISPLAY , VERVE D*" in "Preview Tab" table should contain the following
            | DISPLAY, VERVE D*  | %calcYear:03/16/1974%Y M LOS:%calcLOSDate date:07/17/2013 time:09:00% |
            | PKHospital-Central |                                                                       |
            | Display Test       |                                                                       |
#            | DISPLAY, VERVE D*  | %calcYear:03/25/1974%Y M LOS:%calcLOSDate date:07/17/2013 time:09:00% |
        And I click the "Create Patient List Cancel" button

    Scenario: Validate Preview updates correctly when Display configuration is changed
        When I select "Preview Display Test List" from the "Patient List" menu
        And I select "Edit" from the "Actions" menu
        And I select the "Display" section
        When I drag and drop the settings for the "Display" Section as follows
            | Patient Name     | Age, Gender, LOS / Scheduled / Discharge Date |
            | Location         | Account Number, Admit / Scheduled Date        |
            | Reason for Visit |                                               |
        Then the "Patient List Preview Tab" pane should load
        And I wait "1" seconds
        Then the visit cell for patient "DISPLAY , VERVE D*" in "Preview Tab" table should contain the following
            | DISPLAY, VERVE D*  | %calcYear:03/16/1974%Y M LOS:%calcLOSDate date:07/17/2013 time:09:00% |
            | PKHospital-Central | 6546237350 07/17/13                                                   |
            | Display Test       |                                                                       |
        And I click the "Create Patient List Save" button

 #TODO: Need to add Ordering provider to a SimPK patient.  Maybe 'Heath, Neil'?
    @donotrun
    Scenario: Validate Preview updates correctly when Display configuration - Ordering is added  (DEV-37848)
        When I select "Preview Display Test List - Ordering (PATIENTLISTV" from the "Patient List" menu
        And I select "Edit" from the "Actions" menu
        And I select the "Display" section
        When I drag and drop the settings for the "Display" Section as follows
            | Patient Name     | Age, Gender, LOS / Scheduled / Discharge Date |
            | Location         | Ordering        							   |
            | Reason for Visit |                                        	   |
        Then the "Patient List Preview Tab" pane should load
        And I wait "1" seconds
        Then the visit cell for patient "KIMBERLY MOSLEY" in "Preview Tab" table should contain the following
            | MOSLEY, KIMBERLY    | 70Y F 04/16/17 |
            | ClinGO.GHDOHospital |                |
            | RFV 2               |                |
        And I click the "Create Patient List Save" button

    Scenario: Validate Preview updates correctly when Display sort order is updated to Patient Name-Ascending
        When I select "Patient Name Sort" from the "Patient List" menu
        And I select "Edit" from the "Actions" menu
        And I select the "Display" section
        And I select "" from the "Secondary Sort On" dropdown
        And I select "Patient Name" from the "Sort On" dropdown
        And I wait "1" second
        And I select "A to Z" from the "Sort Order" dropdown
        Then the "Preview Tab" should be sorted by "Patient Name" in "Ascending" order
        And I click the "Create Patient List Cancel" button

    Scenario: Validate Preview updates correctly when Display sort order is updated to Patient Name-Descending
        When I select "Patient Name Sort" from the "Patient List" menu
        And I select "Edit" from the "Actions" menu
        And I select the "Display" section
        And I select "" from the "Secondary Sort On" dropdown
        And I select "Patient Name" from the "Sort On" dropdown
        And I wait "1" second
        And I select "Z to A" from the "Sort Order" dropdown
        Then the "Preview Tab" should be sorted by "Patient Name" in "Descending" order
        And I click the "Create Patient List Cancel" button

    Scenario: Validate Preview updates correctly when Display sort order is updated to Attending-Ascending
        When I select "Sort Test" from the "Patient List" menu
        And I select "Edit" from the "Actions" menu
        And I select the "Display" section
        And I select "Attending" from the "Sort On" dropdown
        And I wait "1" second
        And I select "A to Z" from the "Sort Order" dropdown
        Then the "Preview Tab" should be sorted by "Attending" in "Ascending" order
        And I click the "Create Patient List Cancel" button

    Scenario: Validate Preview updates correctly when Display sort order is updated to Attending-Descending
        When I select "Sort Test" from the "Patient List" menu
        And I select "Edit" from the "Actions" menu
        And I select the "Display" section
        And I select "Attending" from the "Sort On" dropdown
        And I wait "1" second
        And I select "Z to A" from the "Sort Order" dropdown
        Then the "Preview Tab" should be sorted by "Attending" in "Descending" order
        And I click the "Create Patient List Cancel" button