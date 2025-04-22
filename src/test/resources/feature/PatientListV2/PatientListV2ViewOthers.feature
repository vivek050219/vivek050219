@PatientListV2
Feature: Patient List V2 View Patient Lists of Other Users
  Test the View Patient List functionality available from the Find Patient List screen

  Background:
    Given I am logged into the portal with user "PLV2ADMIN" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized

  Scenario: View list for other user(PLV2LVL3): TBC Test
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "View Others TBC Test" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I click the "Patients" button in the row with "View Others TBC Test" as the value under "NAME (\d)" in the "Patient List Search Results" table
    Then the "Patient List Preview" pane should load
    And the "Patient List Preview" pane title should be "View Others TBC Test"
    And the following patients should be on "Patient List Preview List" PatientList
      | TBCTEST, 01 |
      | TBCTEST, 02 |
      | TBCTEST, 04 |
      | TBCTEST, 06 |
      | TBCTEST, 08 |
      | TBCTEST, 09 |
      | TBCTEST, 11 |
    And I click the "OK Patient List" button
    And I click the "Close Search For Patient List" button

  Scenario: View list for other user(PLV2LVL3): FBC Test
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "View Others FBC Test" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I click the "Patients" button in the row with "View Others FBC Test" as the value under "NAME (\d)" in the "Patient List Search Results" table
    Then the "Patient List Preview" pane should load
    And the "Patient List Preview" pane title should be "View Others FBC Test"
    And the following patients should be on "Patient List Preview List" PatientList
      | AUTODCTEST, 01 |
      | AUTODCTEST, 05 |
      | AUTODCTEST, 09 |
      | AUTODCTEST, 13 |
      | AUTODCTEST, 17 |
      | AUTODCTEST, 21 |
      | AUTODCTEST, 25 |
    And I click the "OK Patient List" button
    And I click the "Close Search For Patient List" button

  Scenario: View Relationship to Me based list for user PLV2PROV4
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "Prov4 Adm Rel To Me" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I click the "Patients" button in the row with "Prov4 Adm Rel To Me" as the value under "NAME (\d)" in the "Patient List Search Results" table
    Then the "Patient List Preview" pane should load
    And the "Patient List Preview" pane title should be "Prov4 Adm Rel To Me"
    And the following patients should be on "Patient List Preview List" PatientList
      | FBCTEST, 01 |
      | FBCTEST, 04 |
      | FBCTEST, 07 |
      | FBCTEST, 10 |
      | FBCTEST, 13 |
      | FBCTEST, 16 |
      | FBCTEST, 19 |
      | FBCTEST, 22 |
      | FBCTEST, 25 |
    And I click the "OK Patient List" button
    And I click the "Close Search For Patient List" button

  Scenario: View Relationship to Me based list for user PLV2PROV2
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "Prov2 Adm Rel To Me" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I click the "Patients" button in the row with "Prov2 Adm Rel To Me" as the value under "NAME (\d)" in the "Patient List Search Results" table
    Then the "Patient List Preview" pane should load
    And the "Patient List Preview" pane title should be "Prov2 Adm Rel To Me"
    And the following patients should be on "Patient List Preview List" PatientList
      | FBCTEST, 28 |
      | FBCTEST, 31 |
      | FBCTEST, 34 |
      | FBCTEST, 37 |
      | FBCTEST, 40 |
      | FBCTEST, 43 |
      | FBCTEST, 46 |
      | FBCTEST, 49 |
      | FBCTEST, 52 |
    And I click the "OK Patient List" button
    And I click the "Close Search For Patient List" button

  Scenario: View Relationship to Me based list for user PLV2PROV3
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "Prov3 Adm Rel To Me" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I click the "Patients" button in the row with "Prov3 Adm Rel To Me" as the value under "NAME (\d)" in the "Patient List Search Results" table
    Then the "Patient List Preview" pane should load
    And the "Patient List Preview" pane title should be "Prov3 Adm Rel To Me"
    And the following patients should be on "Patient List Preview List" PatientList
      | FBCTEST, 55 |
      | FBCTEST, 58 |
      | FBCTEST, 61 |
      | FBCTEST, 64 |
      | FBCTEST, 67 |
      | FBCTEST, 70 |
      | FBCTEST, 73 |
      | FBCTEST, 76 |
      | FBCTEST, 79 |
    And I click the "OK Patient List" button
    And I click the "Close Search For Patient List" button

  Scenario: View list for other user(PLV2LVL3): Display All Test
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "Display All" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I click the "Patients" button in the row with "Display All" as the value under "NAME (\d)" in the "Patient List Search Results" table
    Then the "Patient List Preview" pane should load
    And the "Patient List Preview" pane title should be "Display All"
    Then the visit cell for patient "DISPLAY , VERVE D*" in "PatientListPreviewTable" table should contain the following
      | DISPLAY, VERVE D*  | %calcYear:03/16/1974%Y M LOS:%calcLOSDate date:07/17/2013 time:09:00% |
      | PKHospital-Central | 6546237350 07/17/13                                                   |
      | Display Test       |                                                                       |
      |                    | Inpatient Card Group                                                  |
      | 03/16/1974         | ADKINS, LEO RICE, DONNA                                               |
      | 5346353453         | Medicare                                                              |
      | JONES, WILLIAM     | BEST, CLARA BEASLEY, LOUISE                                           |
      | FINCH, ERIN        | VICK, FRANKLIN                                                        |
      | BLACKBURN, MIRIAM  | BlueCross BlueShield                                                  |
    And I click the "OK Patient List" button
    And I click the "Close Search For Patient List" button

  Scenario: View list for other user(PLV2LVL3): Display Cell Containing Multiple Items, One Blank
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "Display Blank Cell Test" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I click the "Patients" button in the row with "Display Blank Cell Test" as the value under "NAME (\d)" in the "Patient List Search Results" table
    Then the "Patient List Preview" pane should load
    And the "Patient List Preview" pane title should be "Display Blank Cell Test"
    Then the visit cell for patient "DARR, MOLLY" in "PatientListPreviewTable" table should contain the following
      | DARR, MOLLY                 |%calcYear:12/22/1938%Y F LOS:4D |
      | 5G.501.A.PKHospital-Central | Card Group                     |
      | Acute MI                    |                                |
    And I click the "OK Patient List" button
    And I click the "Close Search For Patient List" button

  Scenario: View list for other user(PLV2LVL3): sort by Patient Name Descending
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "View Others Patient Name Descending" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I click the "Patients" button in the row with "View Others Patient Name Descending" as the value under "NAME (\d)" in the "Patient List Search Results" table
    Then the "Patient List Preview" pane should load
    And the "Patient List Preview" pane title should be "View Others Patient Name Descending"
    Then the "Patient List Preview Table" should be sorted by "Patient Name" in "Descending" order
    And I click the "OK Patient List" button
    And I click the "Close Search For Patient List" button

  Scenario: View list for other user(PLV2LVL3): sort by Admitting Ascending
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "View Others Admitting Ascending" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I click the "Patients" button in the row with "View Others Admitting Ascending" as the value under "NAME (\d)" in the "Patient List Search Results" table
    Then the "Patient List Preview" pane should load
    And the "Patient List Preview" pane title should be "View Others Admitting Ascending"
    Then the "PatientListPreviewTable" should be sorted by "Admitting" in "Ascending" order
    And I click the "OK Patient List" button
    And I click the "Close Search For Patient List" button

  Scenario: View list for other user(PLV2LVL3): Default Display Test
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "Default Display" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I click the "Patients" button in the row with "Default Display" as the value under "NAME (\d)" in the "Patient List Search Results" table
    Then the "Patient List Preview" pane should load
    And the "Patient List Preview" pane title should be "Default Display"
    Then the visit cell for patient "MOLLY DARR" in "PatientListPreviewTable" table should contain the following
      | DARR, MOLLY                 |%calcYear:12/22/1938%Y F LOS:4D |
      | 5G.501.A.PKHospital-Central |                                |
      | Acute MI                    |                                |
    And I click the "OK Patient List" button
    And I click the "Close Search For Patient List" button