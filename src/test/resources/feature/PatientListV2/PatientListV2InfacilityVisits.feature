@PatientListV2
Feature: Patient List V2 Infacility Visits suits
    Test patient list Infacility Visits

    Background:
        Given I am logged into the portal with user "PLV2LVL3" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized

    Scenario: 0001_Update_Message_Displays_more recent InFacility visit displays on Patient List
        When I select "Create a Patient List" from the "Actions" menu
        And I click the "System Default List" button in the "Choose Template" pane if it exists
        And I click the "OK Template" button in the "Choose Template" pane if it exists
        And I enter "VerveDel InfacilityTest1" in the "Name" field
        And I enter "Infacility List Description" in the "Description" field
        And I select the "Filters" section
        And I click the "Add A Filter" button
        Then the "Filter Criteria" pane should load within "10" seconds
        When I select "Location" from the "Filter On" dropdown
        Then the "Location" pane should load
        And I click the "PKHospital" element in the "Location" pane
        And I click the "Add Filter" button
        And I select the "Time Criteria" section
        And I click the "Inpatient Summary" element
        And I click the "Outpatient Summary" element
        Then I click the "Create Patient List Create My List" button
        And I click the "Refresh Patient List" button
        When I select "VerveDel InfacilityTest1" from the "Patient List" menu
        Given "2E2 MVTEST" is on the patient list
        And I select patient "2E2 MVTEST" from the patient list
        And I select "Visits" from clinical navigation
        And I select "ER" from the "Patient Header Actions" menu
        When I fill in the following fields
            | Name                 | Type     | Value                 |
            | Add Facility1        | dropdown | PKHospital-Alliance   |
            | Unit1                | dropdown | 2G                    |
            | Room1                | dropdown | 208                   |
            | Admit DateTime-Date1 | text     | %Current Date MMDDYY% |
            | Admit DateTime-Time1 | text     | %Current Time HHMM%   |
        And I click the "Save Visit" button
        And I wait "5" second
        And I select "Inpatient" from the "Patient Header Actions" menu
        When I fill in the following fields
            | Name                 | Type     | Value                 |
            | Add Facility1        | dropdown | PKHospital-Alliance   |
            | Unit1                | dropdown | 2G                    |
            | Room1                | dropdown | 208                   |
            | Admit DateTime-Date1 | text     | %Current Date MMDDYY% |
            | Admit DateTime-Time1 | text     | %Current Time HHMM%   |
        And I click the "Save Visit" button
        And I wait "5" second
        And I click the "Refresh Patient List" button
        When I select "VerveDel InfacilityTest1" from the "Patient List" menu
        And I select patient "2E2 MVTEST" from the patient list
        And I select "Why Patient Is On This List" from the "Actions" menu
        And I wait "5" second
        Then the "Compare Patient To List" pane should load
        Then the "Compare Patient To List" pane should appear with the text "The selected visit is on this patient list"
        Then I click the "OK Compare" button in the "Compare Patient To List" pane

    Scenario: 0001_Patient List_Most Recent Infacility Discharged_Another InfacilityVisitNonDischarged_with same account number
        When I use the API to create a patient list named "VerveDel InfacilityTest2" owned by "PLV2LVL3" with the following parameters
            | Type   | Name            | Value      |
            | Filter | Medical Service | Card Group |
        And I click the "Refresh Patient List" button
        When I select "VerveDel InfacilityTest2" from the "Patient List" menu
        And I select "Edit" from the "Actions" menu
        And I select the "Display" section
        When I drag and drop the settings for the "Display" Section as follows
            | Patient Name | LOS / Scheduled / Discharge Date |
            | Location     |                                  |
        And I click the "Create Patient List Save" button
        And I wait "1" second
        And I select "VerveDel InfacilityTest2" from the "Patient List" menu
        And I select "Add Patient" from the "Actions" menu
        And I wait "3" second
        And I click the "Clear Criteria" button
        And I check the "Include Cancelled Visits" checkbox
        And I check the "Include Past Visits" checkbox
        And I search for patient "SUSAANE LEON", admitted in the last "10" days
        And I select "the first item" from the "Name (\d)" column in the "Add Patient Search" table
        And I click the "Add" button in the "Add patient(s) to your patient list" pane
        And I wait "3" seconds
        And I click the "Close" button in the "Add patient(s) to your patient list" pane
        And I wait "1" second
        Then patient "SUSAANE LEON" should be on the patient list
        And I select patient "SUSAANE LEON" from the patient list
        And I select "Visits" from clinical navigation
        And I select "Inpatient" from the "Patient Header Actions" menu
        When I fill in the following fields
            | Name                     | Type     | Value               |
            | Add Facility1            | dropdown | PKHospital-Alliance |
            | Unit1                    | dropdown | 2G                  |
            | Room1                    | dropdown | 208                 |
            | Admit DateTime-Date1     | text     | %5 day ago MMDDYY%  |
            | Admit DateTime-Time1     | text     | %Current Time HHMM% |
            | Discharge DateTime-Date1 | text     | %1 day ago MMDDYY%  |
            | Discharge DateTime-Time1 | text     | %Current Time HHMM% |
            | Account Number           | text     | 555555              |
        And I click the "Save Visit" button
        And I wait "1" second
        And I select "Inpatient" from the "Patient Header Actions" menu
        When I fill in the following fields
            | Name                 | Type     | Value               |
            | Add Facility1        | dropdown | Mercy               |
            | Unit1                | dropdown | 5R                  |
            | Room1                | dropdown | 517                 |
            | Admit DateTime-Date1 | text     | %6 day ago MMDDYY%  |
            | Admit DateTime-Time1 | text     | %Current Time HHMM% |
            | Account Number       | text     | 555555              |
        And I click the "Save Visit" button
        And I click the "Refresh Patient List" button
        Then the visit cell for patient "LEON, SUSAANE" in "Patient List" table should contain the following
            | LEON, SUSAANE | LOS:6D |
            | 5R.517.Mercy  |        |
            |               |        |


    Scenario: 0002_Patient List_Most Recent Infacility Discharged_Multiple_InfacilityVisitsNonDischarged_with same account number
        When I select "VerveDel InfacilityTest2" from the "Patient List" menu
        And I select "Add Patient" from the "Actions" menu
        And I wait "3" second
        And I click the "Clear Criteria" button
        And I check the "Include Cancelled Visits" checkbox
        And I check the "Include Past Visits" checkbox
        And I search for patient "SUSAN AMARAL"
        And I select "the first item" from the "Name (\d)" column in the "Add Patient Search" table
        And I click the "Add" button in the "Add patient(s) to your patient list" pane
        And I wait "3" seconds
        And I click the "Close" button in the "Add patient(s) to your patient list" pane
        And I wait "1" second
        Then patient "SUSAN AMARAL" should be on the patient list
        And I select patient "SUSAN AMARAL" from the patient list
        And I select "Visits" from clinical navigation
        And I select "Inpatient" from the "Patient Header Actions" menu
        When I fill in the following fields
            | Name                     | Type     | Value               |
            | Add Facility1            | dropdown | PKHospital-Alliance |
            | Unit1                    | dropdown | 2G                  |
            | Room1                    | dropdown | 208                 |
            | Admit DateTime-Date1     | text     | %5 day ago MMDDYY%  |
            | Admit DateTime-Time1     | text     | %Current Time HHMM% |
            | Discharge DateTime-Date1 | text     | %1 day ago MMDDYY%  |
            | Discharge DateTime-Time1 | text     | %Current Time HHMM% |
            | Account Number           | text     | 555555              |
        And I click the "Save Visit" button
        And I wait "1" second
        And I select "Inpatient" from the "Patient Header Actions" menu
        When I fill in the following fields
            | Name                 | Type     | Value               |
            | Add Facility1        | dropdown | Mercy               |
            | Unit1                | dropdown | 5R                  |
            | Room1                | dropdown | 517                 |
            | Admit DateTime-Date1 | text     | %4 day ago MMDDYY%  |
            | Admit DateTime-Time1 | text     | %Current Time HHMM% |
            | Account Number       | text     | 555555              |
        And I click the "Save Visit" button
        And I wait "1" second
        And I select "Inpatient" from the "Patient Header Actions" menu
        When I fill in the following fields
            | Name                 | Type     | Value               |
            | Add Facility1        | dropdown | PKHospital          |
            | Unit1                | dropdown | 5R                  |
            | Room1                | dropdown | 565                 |
            | Admit DateTime-Date1 | text     | %3 day ago MMDDYY%  |
            | Admit DateTime-Time1 | text     | %Current Time HHMM% |
            | Account Number       | text     | 555555              |
        And I click the "Save Visit" button
#        And I wait "1" second
#        And I select "Inpatient" from the "Patient Header Actions" menu
#        When I fill in the following fields
#            | Name                 | Type     | Value               |
#            | Add Facility1        | dropdown | PKHospital-Central  |
#            | Unit1                | dropdown | 5G                  |
#            | Room1                | dropdown | 517                 |
#            | Admit DateTime-Date1 | text     | %2 day ago MMDDYY%  |
#            | Admit DateTime-Time1 | text     | %Current Time HHMM% |
#            | Account Number       | text     | 555555              |
#        And I click the "Save Visit" button
        And I click the "Refresh Patient List" button
        Then the visit cell for patient "AMARAL, SUSAN" in "Patient List" table should contain the following
            | AMARAL, SUSAN     | LOS:3D |
            | 5R.565.PKHospital |        |
            |                   |        |


    Scenario: 0003_Patient List_Most Recent Infacility Discharged_Multiple_InfacilityVisitsAlsoDischarged_with same account number
        When I select "VerveDel InfacilityTest2" from the "Patient List" menu
        And I select "Add Patient" from the "Actions" menu
        And I wait "3" second
        And I click the "Clear Criteria" button
        And I check the "Include Cancelled Visits" checkbox
        And I check the "Include Past Visits" checkbox
        And I search for patient "Ricky Rony", admitted in the last "10" days
        And I select "the first item" from the "Name (\d)" column in the "Add Patient Search" table
        And I click the "Add" button in the "Add patient(s) to your patient list" pane
        And I wait "3" seconds
        And I click the "Close" button in the "Add patient(s) to your patient list" pane
        And I wait "1" second
        Then patient "Ricky Rony" should be on the patient list
        And I select patient "Ricky Rony" from the patient list
        And I select "Visits" from clinical navigation
        And I select "Inpatient" from the "Patient Header Actions" menu
        When I fill in the following fields
            | Name                     | Type     | Value               |
            | Add Facility1            | dropdown | PKHospital-Alliance |
            | Unit1                    | dropdown | 2G                  |
            | Room1                    | dropdown | 208                 |
            | Admit DateTime-Date1     | text     | %5 day ago MMDDYY%  |
            | Admit DateTime-Time1     | text     | %Current Time HHMM% |
            | Discharge DateTime-Date1 | text     | %1 day ago MMDDYY%  |
            | Discharge DateTime-Time1 | text     | %Current Time HHMM% |
            | Account Number           | text     | 555555              |
        And I click the "Save Visit" button
        And I wait "1" second
        And I select "Inpatient" from the "Patient Header Actions" menu
        When I fill in the following fields
            | Name                     | Type     | Value                 |
            | Add Facility1            | dropdown | Mercy                 |
            | Unit1                    | dropdown | 5R                    |
            | Room1                    | dropdown | 517                   |
            | Admit DateTime-Date1     | text     | %1 day ago MMDDYY%    |
            | Admit DateTime-Time1     | text     | %Current Time HHMM%   |
            | Discharge DateTime-Date1 | text     | %Current Date MMDDYY% |
            | Discharge DateTime-Time1 | text     | %Current Time HHMM%   |
            | Account Number           | text     | 555555                |
        And I click the "Save Visit" button
        And I click the "Refresh Patient List" button
        Then the visit cell for patient "RONY, RICKY" in "Patient List" table should contain the following
            | RONY, RICKY  | %Current Date MMDDYY% |
            | 5R.517.Mercy |                       |
            |              |                       |

    Scenario: 0004_Patient List_Most Recent Infacility Non Discharged_another_InfacilityVisitsNonDischarged_with same account number
        When I select "VerveDel InfacilityTest2" from the "Patient List" menu
        And I select "Add Patient" from the "Actions" menu
        And I wait "3" second
        And I click the "Clear Criteria" button
        And I check the "Include Cancelled Visits" checkbox
        And I check the "Include Past Visits" checkbox
        And I search for patient "ROBINSON ZEE"
        And I select "the first item" from the "Name (\d)" column in the "Add Patient Search" table
        And I click the "Add" button in the "Add patient(s) to your patient list" pane
        And I wait "3" seconds
        And I click the "Close" button in the "Add patient(s) to your patient list" pane
        And I wait "1" second
        Then patient "ROBINSON ZEE" should be on the patient list
        And I select patient "ROBINSON ZEE" from the patient list
        And I select "Visits" from clinical navigation
        And I select "Inpatient" from the "Patient Header Actions" menu
        When I fill in the following fields
            | Name                 | Type     | Value               |
            | Add Facility1        | dropdown | PKHospital-Alliance |
            | Unit1                | dropdown | 2G                  |
            | Room1                | dropdown | 208                 |
            | Admit DateTime-Date1 | text     | %2 day ago MMDDYY%  |
            | Admit DateTime-Time1 | text     | %Current Time HHMM% |
            | Account Number       | text     | 555555              |
        And I click the "Save Visit" button
        And I wait "1" second
        And I select "Inpatient" from the "Patient Header Actions" menu
        When I fill in the following fields
            | Name                 | Type     | Value               |
            | Add Facility1        | dropdown | Mercy               |
            | Unit1                | dropdown | 5R                  |
            | Room1                | dropdown | 517                 |
            | Admit DateTime-Date1 | text     | %2 day ago MMDDYY%  |
            | Admit DateTime-Time1 | text     | %Current Time HHMM% |
            | Account Number       | text     | 555555              |
        And I click the "Save Visit" button
        And I click the "Refresh Patient List" button
        Then the visit cell for patient "ZEE, ROBINSON" in "Patient List" table should contain the following
            | ZEE, ROBINSON | LOS:2D |
            | 5R.517.Mercy  |        |
            |               |        |

    Scenario: 0005_Patient List_Most Recent Infacility Discharged_Another InfacilityVisitNonDischarged_with different account number
        When I select "VerveDel InfacilityTest2" from the "Patient List" menu
        And I select "Add Patient" from the "Actions" menu
        And I wait "3" second
        And I click the "Clear Criteria" button
        And I check the "Include Cancelled Visits" checkbox
        And I check the "Include Past Visits" checkbox
        And I search for patient "MARK NEILSON"
        And I select "the first item" from the "Name (\d)" column in the "Add Patient Search" table
        And I click the "Add" button in the "Add patient(s) to your patient list" pane
        And I wait "3" seconds
        And I click the "Close" button in the "Add patient(s) to your patient list" pane
        And I wait "1" second
        Then patient "MARK NEILSON" should be on the patient list
        And I select patient "MARK NEILSON" from the patient list
        And I select "Visits" from clinical navigation
        And I select "Inpatient" from the "Patient Header Actions" menu
        When I fill in the following fields
            | Name                 | Type     | Value               |
            | Add Facility1        | dropdown | PKHospital-Alliance |
            | Unit1                | dropdown | 3G                  |
            | Room1                | dropdown | 307                 |
            | Admit DateTime-Date1 | text     | %2 day ago MMDDYY%  |
            | Admit DateTime-Time1 | text     | %Current Time HHMM% |
            | Account Number       | text     | 451244              |
        And I click the "Save Visit" button
        And I wait "1" second
        And I select "Inpatient" from the "Patient Header Actions" menu
        When I fill in the following fields
            | Name                     | Type     | Value                 |
            | Add Facility1            | dropdown | PKHospital-Central    |
            | Unit1                    | dropdown | 2G                    |
            | Room1                    | dropdown | 208                   |
            | Admit DateTime-Date1     | text     | %1 day ago MMDDYY%    |
            | Admit DateTime-Time1     | text     | %Current Time HHMM%   |
            | Discharge DateTime-Date1 | text     | %Current Date MMDDYY% |
            | Discharge DateTime-Time1 | text     | %Current Time HHMM%   |
            | Account Number           | text     | 78458855              |
        And I click the "Save Visit" button
        And I click the "Refresh Patient List" button
        Then the visit cell for patient "NEILSON, MARK" in "Patient List" table should contain the following Discharged status
            | NEILSON, MARK             | %Current Date MMDDYY% |
            | 2G.208.PKHospital-Central |                       |
            |                           |                       |

    Scenario: 0001_Patient List_Most Recent Infacility Non Discharged_Another InfacilityVisit NonDischarged_with Future date
        When I select "VerveDel InfacilityTest2" from the "Patient List" menu
        And I select "Add Patient" from the "Actions" menu
        And I wait "3" second
        And I click the "Clear Criteria" button
        And I check the "Include Cancelled Visits" checkbox
        And I check the "Include Past Visits" checkbox
        And I search for patient "DEMORE KITE", admitted in the last "10" days
        And I select "the first item" from the "Name (\d)" column in the "Add Patient Search" table
        And I click the "Add" button in the "Add patient(s) to your patient list" pane
        And I wait "3" seconds
        And I click the "Close" button in the "Add patient(s) to your patient list" pane
        And I wait "1" second
        Then patient "DEMORE KITE" should be on the patient list
        And I select patient "DEMORE KITE" from the patient list
        And I select "Visits" from clinical navigation
        And I select "Inpatient" from the "Patient Header Actions" menu
        When I fill in the following fields
            | Name                 | Type     | Value               |
            | Add Facility1        | dropdown | PKHospital-Alliance |
            | Unit1                | dropdown | 3G                  |
            | Room1                | dropdown | 307                 |
            | Admit DateTime-Date1 | text     | %3 day ago MMDDYY%  |
            | Admit DateTime-Time1 | text     | %Current Time HHMM% |
        And I click the "Save Visit" button
        And I wait "1" second
        And I select "Inpatient" from the "Patient Header Actions" menu
        When I fill in the following fields
            | Name                 | Type     | Value                   |
            | Add Facility1        | dropdown | PKHospital-Central      |
            | Unit1                | dropdown | 2G                      |
            | Room1                | dropdown | 208                     |
            | Admit DateTime-Date1 | text     | %3 day from now MMDDYY% |
            | Admit DateTime-Time1 | text     | %Current Time HHMM%     |
        And I click the "Save Visit" button
        And I click the "Refresh Patient List" button
        Then the visit cell for patient "KITE, DEMORE" in "Patient List" table should contain the following
            | KITE, DEMORE               | LOS:3D |
            | 3G.307.PKHospital-Alliance |        |
            |                            |        |