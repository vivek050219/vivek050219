@MergePatientsAndVisits
Feature: Merge 2 Patients and Merge 2 Visits
  Merge two of the same patient added manually and then merge 2 visits

  Scenario Outline: Merge 2 of the Same Patient Then Merge 2 of the Same Visit[DEV-77628][DEV-78032][DEV-78124][DEV-79297][CI-15427]
    Given I am logged into the portal with user "patientmerge1" using the default password
    And I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I check the "Include Cancelled Visits" checkbox
    And I check the "Include Past Visits" checkbox
    Then I enter "MergeTest" in the "Last" field in the "Patient Search Criteria" pane
    Then I enter "Patient" in the "First" field in the "Patient Search Criteria" pane
    And I click the "Search for Patients" button
#		#And I click the "Create a new Patient from the search criteria" link in the "Search Results" pane
    Then I click the "Add Patient" button
    Then the "Add Patient Content" pane should load
    And I enter "ONE" in the "Middle Name" field in the "Add Patient Content" pane
    And I enter "123456789" in the "MRN textbox" field in the "Add Patient Content" pane
    Then I click the "Save" button in the "Add Patient Content" pane
    And I click the "Yes" button if it exists
    And I select patient "MERGETEST, PATIENT ONE*" from the "Name (\d)" column in the "Patient Search Results" table
    Then I click the "Create Visit" button
    And I select "Inpatient" from the "Create Visit" menu
    And I select "PKHospital" from the "AddFacility" dropdown
    And I enter "%Current Date MMDDYY%" in the "AdmitDateTime-Date" field
    And I enter "%Current Time HHMM%" in the "AdmitDateTime-Time" field
    Then I click the "Add and Save" button
    Then I click the "Add Patient" button
    Then the "Add Patient Content" pane should load
    And I enter "O" in the "Middle Name" field in the "Add Patient Content" pane
    And I enter "123456789" in the "MRN textbox" field in the "Add Patient Content" pane
    Then I click the "Save" button in the "Add Patient Content" pane
    And I click the "Yes" button if it exists
    And I select patient "MERGETEST, PATIENT O*" from the "Name (\d)" column in the "Patient Search Results" table
    Then I click the "Create Visit" button
    And I select "Inpatient" from the "Create Visit" menu
    And I select "PKHospital" from the "AddFacility" dropdown
    And I enter "%Current Date MMDDYY%" in the "AdmitDateTime-Date" field
    And I enter "%Current Time HHMM%" in the "AdmitDateTime-Time" field
    Then I click the "Add and Save" button
    And I click the "Search for Visits" button
    And I sort the "Visit Search Results" table chronologically by the "Admit/Appt" column in "Descending" order
    Then I select the "Merge" link in the row with "MERGETEST, PATIENT O*" as the value under "Name (\d)" in the "Visit Search Results" table
    And I click the "Merge Patients" button
    And I select patient "MERGETEST, PATIENT ONE*" from the "Name (\d)" column in the "Merge Patients" table
    Then I click the "Resolve" button
    And the "Visit Search Results" table should have "0" rows containing the text "MERGETEST, PATIENT O*"
    And the "Visit Search Results" table should have at least "2" rows containing the text "MERGETEST, PATIENT ONE*"
    And I sort the "Visit Search Results" table chronologically by the "Admit/Appt" column in "Descending" order
    Then I select the "Merge" link in the row with "MERGETEST, PATIENT ONE*" as the value under "Name (\d)" in the "Visit Search Results" table
    And I click the "Merge Visits" button
    And I sort the "Merge Visits" table chronologically by the "Admit/Appt" column in "Descending" order
    And I select patient "MERGETEST, PATIENT ONE*" from the "Name (\d)" column in the "Merge Visits" table
    Then I click the "Resolve" button
		#		#Per Umesh, if the merge visits doesn't work the 1st time, it should work on trying it again. -- HIC 01/14/19
    Then if the "Error Dialog" pane appears try to merge the visits again
    And the "Error Dialog" pane should not appear with the text "Based on your system settings, you cannot merge these visits. Cannot merge visits from two separate patients"
    Then the "Visit Search Results" table should have at least "1" row containing the text "MERGETEST, PATIENT ONE*"
    And I select patient "MERGETEST, PATIENT ONE*" from the "Name (\d)" column in the "Visit Search Results" table
    And I click the "Edit" button
    And I enter "X" in the "Middle Name" field in the "Add Patient Content" pane
    And I click the "Save" button in the "Add Patient Content" pane

#   #Run the scenario above x50 times
    Examples:
      | nope |
      |      |
      |      |
      |      |
      |      |
      |      |
      |      |
      |      |
      |      |
      |      |
      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
#      |      |
