@PatientListV2
Feature: Patient List Version 2 Revert options
    Setup: Requires patient list for each scenario already exist

    Background:
        Given I am logged into the portal with user "PLV2ADMIN" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        When I use the API to create a patient list named "VerveDel RevertTest" owned by "PLV2ADMIN" with the following parameters
            | Type   | Name            | Value      |
            | Filter | Medical Service | Card Group |
        And I click the "Refresh Patient List" button


    Scenario: Revert Display Configuration
        When I select "VerveDel RevertTest" from the "Patient List" menu
        And I use the API to update the display view for the patient list named "VerveDel RevertTest" owned by "PLV2ADMIN" with the following
            | Patient Name, Age | LOS / Scheduled / Discharge Date |
            | Location, Gender  |                                  |
            | Reason for Visit  |                                  |
        And I click the "Refresh Patient List" button
        Then the visit cell for patient "Molly Darr" in "Patient List" table should contain the following
            | DARR, MOLLY %calcYear:12/22/1938%Y | LOS:4D |
            | 5G.501.A.PKHospital-Central F      |        |
            | Acute MI                           |        |
        And I select "Revert to Default List Settings" from the "Actions" menu
        And I wait up to "10" seconds for the "Revert Display List" field of type "TEXT_FIELD" to be visible
        And I clear and enter "VerveDel RevertTest" in the "Revert Display List" field
        And I select "VerveDel RevertTest" from the "Name (\d)" column in the "Patient List Result Revert" table if it exists
        And I click the "Revert List To Default" button
        Then the "Patient List Revert Settings" pane should load
        And I check the "Revert Display Checkbox" checkbox if it exists
        And I click the "OK Revert" button
        Then the "Patient List Revert Complete" pane should load
        And I click the "Success OK" button
        And I click the "Refresh Patient List" button
        Then the visit cell for patient "Molly Darr" in "Patient List" table should contain the following
            | DARR, MOLLY                 | %calcYear:12/22/1938%Y F LOS:4D |
            | 5G.501.A.PKHospital-Central |                                 |
            | Acute MI                    |                                 |

    Scenario: Revert Time Based Configuration
        When I select "VerveDel RevertTest" from the "Patient List" menu
        And I use the API to update the time criteria for the patient list named "VerveDel RevertTest" owned by "PLV2ADMIN" with the following
            | Action | Name | Add Patients | Remove Patients |
            | Remove | ER   |              |                 |
        And I click the "Refresh Patient List" button
        Then the following patients should not be on "Patient Visit" PatientList
            | BLAZER, ROY |
#            | Smith, Chris |
        And I select "Revert to Default List Settings" from the "Actions" menu
        And I wait up to "10" seconds for the "Revert Display List" field of type "TEXT_FIELD" to be visible
        And I clear and enter "VerveDel RevertTest" in the "Revert Display List" field
        And I select "VerveDel RevertTest" from the "Name (\d)" column in the "Patient List Result Revert" table if it exists
        And I click the "Revert List To Default" button
        Then the "Patient List Revert Settings" pane should load
        And I check the "Revert Time Checkbox" checkbox if it exists
        And I click the "OK Revert" button
        Then the "Patient List Revert Complete" pane should load
        And I click the "Success OK" button
        And I click the "Refresh Patient List" button
        Then the following patients should be on "Patient Visit" PatientList
            | BLAZER, ROY |
#            | Smith, Chris |

    Scenario: Revert Filter Configuration
        When I select "VerveDel RevertTest" from the "Patient List" menu
        Given "Molly Darr" is on the patient list
        And I select "Edit" from the "Actions" menu
        And I select the "Filters" section
        Then the following text should appear in the "Filters" pane
            | Medical Service |
        And I click the "Create Patient List Save" button
        And I click the "Refresh Patient List" button
        And I select "Revert to Default List Settings" from the "Actions" menu
        And I wait up to "10" seconds for the "Revert Display List" field of type "TEXT_FIELD" to be visible
        And I clear and enter "VerveDel RevertTest" in the "Revert Display List" field
        And I select "VerveDel RevertTest" from the "Name (\d)" column in the "Patient List Result Revert" table if it exists
        And I click the "Revert List To Default" button
        Then the "Patient List Revert Settings" pane should load
        And I check the "Revert Filters Checkbox" checkbox if it exists
        And I click the "OK Revert" button
        Then the "Patient List Revert Complete" pane should load
        And I click the "Success OK" button
        And I click the "Refresh Patient List" button
        And I select "Edit" from the "Actions" menu
        And I select the "Filters" section
        Then the text "Medical Service" should not appear in the "Filters" section in the "Filters" pane
        And I use the API to update the filters for the patient list named "VerveDel RevertTest" owned by "PLV2ADMIN" with the following
            | Action | Name            | Value      |
            | Add    | Medical Service | Card Group |
        And I click the "Create Patient List Cancel" button

    Scenario: Revert Permissions Configuration
        When I select "VerveDel RevertTest" from the "Patient List" menu
    #	Given "Molly Darr" is on the patient list
        And I select "Edit" from the "Actions" menu
        And I select the "Permissions" section
        Then "No other users" should be selected in the "View" dropdown
        And "No other users" should be selected in the "Manage" dropdown
        And "No other users" should be selected in the "Add/Remove" dropdown
        And I click the "Create Patient List Save" button
        And I click the "Refresh Patient List" button
        And I select "Revert to Default List Settings" from the "Actions" menu
        And I wait up to "10" seconds for the "Revert Display List" field of type "TEXT_FIELD" to be visible
        And I clear and enter "VerveDel RevertTest" in the "Revert Display List" field
        And I select "VerveDel RevertTest" from the "Name (\d)" column in the "Patient List Result Revert" table if it exists
        And I click the "Revert List To Default" button
        Then the "Patient List Revert Settings" pane should load
        And I check the "Revert Permissions Checkbox" checkbox if it exists
        And I click the "OK Revert" button
        Then the "Patient List Revert Complete" pane should load
        And I click the "Success OK" button
        And I click the "Refresh Patient List" button
        And I select "Edit" from the "Actions" menu
        And I select the "Permissions" section
        Then "All users" should be selected in the "View" dropdown
        And "No other users" should be selected in the "Manage" dropdown
        And "No other users" should be selected in the "Add/Remove" dropdown
        When I select "No other users" from the "View" dropdown
        When I select "No other users" from the "Manage" dropdown
        When I select "No other users" from the "Add/Remove" dropdown
        And I click the "Create Patient List Save" button

    Scenario: Reverting using CheckAll button
        When I select "VerveDel RevertTest" from the "Patient List" menu
      #	checking the patient list names for some options
        Given "Molly Darr" is on the patient list
        Then the following patients should be on "Patient Visit" PatientList
            | BLAZER, ROY |
#            | Smith, Chris |
        And I use the API to update the display view for the patient list named "VerveDel RevertTest" owned by "PLV2ADMIN" with the following
            | Patient Name, Age | LOS / Scheduled / Discharge Date |
            | Location, Gender  |                                  |
            | Reason for Visit  |                                  |
      #	Making adjustments for TimeCriteria option
        And I use the API to update the time criteria for the patient list named "VerveDel RevertTest" owned by "PLV2ADMIN" with the following
            | Action | Name | Add Patients | Remove Patients |
            | Remove | ER   |              |                 |
      #	Making adjustments for Filters option
        And I click the "Refresh Patient List" button
        And I select "Edit" from the "Actions" menu
        And I select the "Filters" section
        Then the following text should appear in the "Filters" pane
            | Medical Service |
      #	Making adjustments for Permissions option
        And I select the "Permissions" section
        Then "No other users" should be selected in the "View" dropdown
        And "No other users" should be selected in the "Manage" dropdown
        And "No other users" should be selected in the "Add/Remove" dropdown
        And I click the "Create Patient List Save" button
        And I click the "Refresh Patient List" button
        Then the visit cell for patient "Molly Darr" in "Patient List" table should contain the following
            | DARR, MOLLY %calcYear:12/22/1938%Y | LOS:4D |
            | 5G.501.A.PKHospital-Central F      |        |
            | Acute MI                           |        |
        Then the following patients should not be on "Patient Visit" PatientList
            | BLAZER, ROY |
#            | Smith, Chris |
        And I select "Revert to Default List Settings" from the "Actions" menu
        And I wait up to "10" seconds for the "Revert Display List" field of type "TEXT_FIELD" to be visible
        And I clear and enter "VerveDel RevertTest" in the "Revert Display List" field
        And I select "VerveDel RevertTest" from the "Name (\d)" column in the "Patient List Result Revert" table if it exists
        And I click the "Revert List To Default" button
        Then the "Patient List Revert Settings" pane should load
        And I click the "check all" link in the "Check All" pane
        And I click the "OK Revert" button
        Then the "Patient List Revert Complete" pane should load
        And I click the "Success OK" button
      #	Verfying the results for the tabs individually
        And I click the "Refresh Patient List" button
      #	For time criteria tab
        Then the following patients should be on "Patient Visit" PatientList
            | BLAZER, ROY |
#            | Smith, Chris |
        And I select "Edit" from the "Actions" menu
        And I select the "Filters" section
      #	For filter tab
        Then the text "Medical Service" should not appear in the "Filters" section in the "Filters" pane
      #	For Permissions tab
        And I select the "Permissions" section
        Then "All users" should be selected in the "View" dropdown
        And "No other users" should be selected in the "Manage" dropdown
        And "No other users" should be selected in the "Add/Remove" dropdown
        And I click the "Create Patient List Cancel" button
      # setting up filter tab values
        And I use the API to update the filters for the patient list named "VerveDel RevertTest" owned by "PLV2ADMIN" with the following
            | Action | Name            | Value      |
            | Add    | Medical Service | Card Group |
        And I click the "Refresh Patient List" button
      #	For Display tab verification
        Then the visit cell for patient "Molly Darr" in "Patient List" table should contain the following
            | DARR, MOLLY                 | %calcYear:12/22/1938%Y F LOS:4D |
            | 5G.501.A.PKHospital-Central |                                 |
            | Acute MI                    |                                 |
        #Set the Permissions tab value to default
        And I select "Edit" from the "Actions" menu
        And I select the "Permissions" section
        Then I select "No other users" from the "View" dropdown
        Then I select "No other users" from the "Manage" dropdown
        Then I select "No other users" from the "Add/Remove" dropdown
        And I click the "Create Patient List Save" button