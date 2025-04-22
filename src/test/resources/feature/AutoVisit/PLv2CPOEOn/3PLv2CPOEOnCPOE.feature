@AutoVisitPLv2
Feature: PLv2 CPOE On CPOE

  Scenario: Pre-requisite - Enable CPOE
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "Site Administration" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    Then I select "true" from the "CPOE" radio list in the "Site Administration" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I save the visits creation date "08/23/2018" for later


  Scenario Outline: plv2u1 CPOE On - CPOE
Given I am logged into the portal with user "plv2u1" using the default password
And I am on the "Patient List V2" tab
And I select "VSTPatientList" from the "Patient List" menu
And "<PatientName>" is on the patient list
#    When I select "Add Patient" from the "Actions" menu
#    And I wait "3" seconds
#    And I click the "Clear Criteria" button
#    And I wait "3" seconds
#    And I check the following checkboxes
#      | Include Cancelled Visits |
#      | Include Past Visits      |
#    And I search for patient "<PatientName>"
#    And I click the "Select All" button in the "Add Patient Search" pane
#    And I click the "Add" button in the "Add patient(s) to your patient list" pane
#    And I wait "2" seconds
#    And I click the "Close" button in the "Add patient(s) to your patient list" pane if it exists
#    And I wait "2" seconds
#    And I refresh the patient list
And I select the patient "<PatientName>" with index "<IndexValue>" from the patient list
      #And I select patient "<Patient>" from the patient list
      #And I select "Clinical Notes" from clinical navigation
And I wait "2" seconds
And I select "Enter Orders" from the "Patient Header Actions" menu
Then the text "<VisitValue>" for PLv2 user CPOE should be selected by default in the "Enter Orders" pane
And I click the "Add Order Cancel" button

Examples:
| PatientName         | IndexValue | VisitValue                                                                               |
| Patient01 Avstest   | 1          | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient02 Avstest   | 1          | %1 day ago MM/dd/yy% Observation Visit (VST.VST1.1.PKHospital)                           |
| Patient03 Avstest   | 1          | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient04 Avstest   | 1          | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient05 Avstest   | 1          | %2 days ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                   |
| Patient06 Avstest   | 1          | %2 days ago MM/dd/yy% Inpatient Visit (VST.VST2.1.PKHospital)                            |
| Patient07 Avstest   | 1          | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST3.1.PKHospital)                             |
| Patient08 Avstest   | 1          | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient09 Avstest   | 1          | %3 days ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                   |
| Patient10 Avstest   | 1          | %5 days ago MM/dd/yy% Pre-Admission Visit (VST.VST2.1.PKHospital)                        |
| Patient11 Avstest   | 1          | %1 day ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                    |


Scenario Outline: plv2u2 CPOE On - CPOE-Search from Patient Search-Patient
Given I am logged into the portal with user "plv2u2" using the default password
And I am on the "Patient Search" tab
And I click the "Clear Criteria" button
And I enter "<PatientLastName>" in the "Last" field in the "Patient Search Criteria" pane
And I enter "<PatientFirstName>" in the "First" field in the "Patient Search Criteria" pane
And I click the "Search for Patients" button
Then the "Search Results" pane should load within "5" seconds
And I click the "Select All" button
And I select "Enter Orders" from the "Actions" menu
Then the text "<Value>" for PLv2 user CPOE should be selected by default in the "CPOE Order Entry" pane
And I click the "Cancel CPOE Order" button

Examples:
| PatientFirstName | PatientLastName | Value                                                                |
| Patient01        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)         |
| Patient02        | Avstest         | %1 day ago MM/dd/yy% Observation Visit (VST.VST1.1.PKHospital)       |
| Patient03        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                |
| Patient04        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)         |
| Patient05        | Avstest         | %2 days ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)               |
| Patient06        | Avstest         | %2 days ago MM/dd/yy% Inpatient Visit (VST.VST2.1.PKHospital)        |
| Patient07        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST3.1.PKHospital)         |
| Patient08        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                |
| Patient09        | Avstest         | %3 days ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)               |
| Patient10        | Avstest         | %5 days ago MM/dd/yy% Pre-Admission Visit (VST.VST2.1.PKHospital)    |
| Patient11        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                |


Scenario Outline: plv2u2 CPOE On - CPOE-Search from Patient Search-Visit
Given I am logged into the portal with user "plv2u2" using the default password
And I am on the "Patient Search" tab
And I click the "Clear Criteria" button
And I check the following checkboxes
| Include Cancelled Visits |
| Include Past Visits      |
And I enter "<PatientLastName>" in the "Last" field in the "Patient Search Criteria" pane
And I enter "<PatientFirstName>" in the "First" field in the "Patient Search Criteria" pane
And I click the "Search for Visits" button
Then the "Search Results" pane should load within "5" seconds
And I click the "Select All" button
And I select "Enter Orders" from the "Actions" menu
Then the text "<Value>" for PLv2 user CPOE should be selected by default in the "CPOE Order Entry" pane
And I click the "Cancel CPOE Order" button

Examples:
| PatientFirstName | PatientLastName | Value                                                                                    |
| Patient01        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient02        | Avstest         | %1 day ago MM/dd/yy% Observation Visit (VST.VST1.1.PKHospital)                           |
| Patient03        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient04        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient05        | Avstest         | %2 days ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                   |
| Patient06        | Avstest         | %2 days ago MM/dd/yy% Inpatient Visit (VST.VST2.1.PKHospital)                            |
| Patient07        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST3.1.PKHospital)                             |
| Patient08        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient09        | Avstest         | %3 days ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                   |
| Patient10        | Avstest         | %5 days ago MM/dd/yy% Pre-Admission Visit (VST.VST2.1.PKHospital)                        |
| Patient11        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                    |


Scenario Outline: plv2u3 CPOE On - CPOE-Search from Patient Search-Patient
Given I am logged into the portal with user "plv2u3" using the default password
And I am on the "Patient Search" tab
And I click the "Clear Criteria" button
And I enter "<PatientLastName>" in the "Last" field in the "Patient Search Criteria" pane
And I enter "<PatientFirstName>" in the "First" field in the "Patient Search Criteria" pane
And I click the "Search for Patients" button
Then the "Search Results" pane should load within "5" seconds
And I click the "Select All" button
And I select "Enter Orders" from the "Actions" menu
Then the text "<Value>" for PLv2 user CPOE should be selected by default in the "CPOE Order Entry" pane
And I click the "Cancel CPOE Order" button

Examples:
| PatientFirstName | PatientLastName | Value                                                                                    |
| Patient01        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient02        | Avstest         | %1 day ago MM/dd/yy% Observation Visit (VST.VST1.1.PKHospital)                           |
| Patient03        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient04        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient05        | Avstest         | %2 days ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                   |
| Patient06        | Avstest         | %2 days ago MM/dd/yy% Inpatient Visit (VST.VST2.1.PKHospital)                            |
| Patient07        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST3.1.PKHospital)                             |
| Patient08        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient09        | Avstest         | %3 days ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                   |
| Patient10        | Avstest         | %5 days ago MM/dd/yy% Pre-Admission Visit (VST.VST2.1.PKHospital)                        |
| Patient11        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                    |


Scenario Outline: plv2u3 CPOE On - CPOE-Search from Patient Search-Visit
Given I am logged into the portal with user "plv2u3" using the default password
And I am on the "Patient Search" tab
And I click the "Clear Criteria" button
And I check the following checkboxes
| Include Cancelled Visits |
| Include Past Visits      |
And I enter "<PatientLastName>" in the "Last" field in the "Patient Search Criteria" pane
And I enter "<PatientFirstName>" in the "First" field in the "Patient Search Criteria" pane
And I click the "Search for Visits" button
Then the "Search Results" pane should load within "5" seconds
And I click the "Select All" button
And I select "Enter Orders" from the "Actions" menu
Then the text "<Value>" for PLv2 user CPOE should be selected by default in the "CPOE Order Entry" pane
And I click the "Cancel CPOE Order" button

Examples:
| PatientFirstName | PatientLastName | Value                                                                                    |
| Patient01        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient02        | Avstest         | %1 day ago MM/dd/yy% Observation Visit (VST.VST1.1.PKHospital)                           |
| Patient03        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient04        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient05        | Avstest         | %2 days ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                   |
| Patient06        | Avstest         | %2 days ago MM/dd/yy% Inpatient Visit (VST.VST2.1.PKHospital)                            |
| Patient07        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST3.1.PKHospital)                             |
| Patient08        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient09        | Avstest         | %3 days ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                   |
| Patient10        | Avstest         | %5 days ago MM/dd/yy% Pre-Admission Visit (VST.VST2.1.PKHospital)                        |
| Patient11        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                    |


Scenario Outline: plv2u4 CPOE On - CPOE
Given I am logged into the portal with user "plv2u4" using the default password
And I am on the "Patient List V2" tab
And I select "VSTPatientList" from the "Patient List" menu
And "<PatientName>" is on the patient list
#    When I select "Add Patient" from the "Actions" menu
#    And I wait "3" seconds
#    And I click the "Clear Criteria" button
#    And I wait "3" seconds
#    And I check the following checkboxes
#      | Include Cancelled Visits |
#      | Include Past Visits      |
#    And I search for patient "<PatientName>"
#    And I click the "Select All" button in the "Add Patient Search" pane
#    And I click the "Add" button in the "Add patient(s) to your patient list" pane
#    And I wait "2" seconds
#    And I click the "Close" button in the "Add patient(s) to your patient list" pane if it exists
#    And I wait "2" seconds
#    And I refresh the patient list
And I select the patient "<PatientName>" with index "<IndexValue>" from the patient list
   #And I select patient "<Patient>" from the patient list
    #And I select "Clinical Notes" from clinical navigation
And I wait "2" seconds
And I select "Enter Orders" from the "Patient Header Actions" menu
Then the text "<VisitValue>" for PLv2 user CPOE should be selected by default in the "Enter Orders" pane
And I click the "Add Order Cancel" button

Examples:
| PatientName         | IndexValue | VisitValue                                                                               |
| Patient01 Avstest   | 1          | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient02 Avstest   | 1          | %1 day ago MM/dd/yy% Observation Visit (VST.VST1.1.PKHospital)                           |
| Patient03 Avstest   | 1          | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient04 Avstest   | 1          | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient05 Avstest   | 1          | %2 days ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                   |
| Patient06 Avstest   | 1          | %2 days ago MM/dd/yy% Inpatient Visit (VST.VST2.1.PKHospital)                            |
| Patient07 Avstest   | 1          | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST3.1.PKHospital)                             |
| Patient08 Avstest   | 1          | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient09 Avstest   | 1          | %3 days ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                   |
| Patient10 Avstest   | 1          | %5 days ago MM/dd/yy% Pre-Admission Visit (VST.VST2.1.PKHospital)                        |
| Patient11 Avstest   | 1          | %1 day ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                    |


Scenario Outline: plv2u5 CPOE On - CPOE
Given I am logged into the portal with user "plv2u5" using the default password
And I am on the "Patient List V2" tab
And I select "VSTPatientList" from the "Patient List" menu
And "<PatientName>" is on the patient list
#    When I select "Add Patient" from the "Actions" menu
#    And I wait "3" seconds
#    And I click the "Clear Criteria" button
#    And I wait "3" seconds
#    And I check the following checkboxes
#      | Include Cancelled Visits |
#      | Include Past Visits      |
#    And I search for patient "<PatientName>"
#    And I click the "Select All" button in the "Add Patient Search" pane
#    And I click the "Add" button in the "Add patient(s) to your patient list" pane
#    And I wait "2" seconds
#    And I click the "Close" button in the "Add patient(s) to your patient list" pane if it exists
#    And I wait "2" seconds
#    And I refresh the patient list
And I select the patient "<PatientName>" with index "<IndexValue>" from the patient list
   #And I select patient "<Patient>" from the patient list
    #And I select "Clinical Notes" from clinical navigation
And I wait "2" seconds
And I select "Enter Orders" from the "Patient Header Actions" menu
Then the text "<VisitValue>" for PLv2 user CPOE should be selected by default in the "Enter Orders" pane
And I click the "Add Order Cancel" button

Examples:
| PatientName         | IndexValue | VisitValue                                                                               |
| Patient01 Avstest   | 1          | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient02 Avstest   | 1          | %1 day ago MM/dd/yy% Observation Visit (VST.VST1.1.PKHospital)                           |
| Patient03 Avstest   | 1          | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient04 Avstest   | 1          | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient05 Avstest   | 1          | %2 days ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                   |
| Patient06 Avstest   | 1          | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient07 Avstest   | 1          | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST2.1.PKHospital)                             |
| Patient08 Avstest   | 1          | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient09 Avstest   | 1          | %1 day ago MM/dd/yy% ER2 Visit (VST.VST1.1.PKHospital)                                   |
| Patient10 Avstest   | 1          | %5 days ago MM/dd/yy% Pre-Admission Visit (VST.VST2.1.PKHospital)                        |
| Patient11 Avstest   | 1          | %1 day ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                    |


Scenario Outline: plv2u6 CPOE On - CPOE-Search from Patient Search-Visit
Given I am logged into the portal with user "plv2u6" using the default password
And I am on the "Patient Search" tab
And I click the "Clear Criteria" button
And I check the following checkboxes
| Include Cancelled Visits |
| Include Past Visits      |
And I enter "<PatientLastName>" in the "Last" field in the "Patient Search Criteria" pane
And I enter "<PatientFirstName>" in the "First" field in the "Patient Search Criteria" pane
And I click the "Search for Visits" button
Then the "Search Results" pane should load within "5" seconds
And I click the "Select All" button
And I select "Enter Orders" from the "Actions" menu
Then the text "<Value>" for PLv2 user CPOE should be selected by default in the "CPOE Order Entry" pane
And I click the "Cancel CPOE Order" button

Examples:
| PatientFirstName | PatientLastName | Value                                                                                    |
| Patient01        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient02        | Avstest         | %1 day ago MM/dd/yy% Observation Visit (VST.VST1.1.PKHospital)                           |
| Patient03        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient04        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient05        | Avstest         | %2 days ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                   |
| Patient06        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient07        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST3.1.PKHospital)                             |
| Patient08        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient09        | Avstest         | %1 day ago MM/dd/yy% ER2 Visit (VST.VST1.1.PKHospital)                                   |
| Patient10        | Avstest         | %5 days ago MM/dd/yy% Pre-Admission Visit (VST.VST2.1.PKHospital)                        |
| Patient11        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                    |


Scenario Outline: plv2u6 CPOE On - CPOE-Search from Patient Search-Patient
Given I am logged into the portal with user "plv2u6" using the default password
And I am on the "Patient Search" tab
And I click the "Clear Criteria" button
And I enter "<PatientLastName>" in the "Last" field in the "Patient Search Criteria" pane
And I enter "<PatientFirstName>" in the "First" field in the "Patient Search Criteria" pane
And I click the "Search for Patients" button
Then the "Search Results" pane should load within "5" seconds
And I click the "Select All" button
And I select "Enter Orders" from the "Actions" menu
Then the text "<Value>" for PLv2 user CPOE should be selected by default in the "CPOE Order Entry" pane
And I click the "Cancel CPOE Order" button

Examples:
| PatientFirstName | PatientLastName | Value                                                                                    |
| Patient01        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient02        | Avstest         | %1 day ago MM/dd/yy% Observation Visit (VST.VST1.1.PKHospital)                           |
| Patient03        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient04        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient05        | Avstest         | %2 days ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                   |
| Patient06        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient07        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST2.1.PKHospital)                             |
| Patient08        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient09        | Avstest         | %1 day ago MM/dd/yy% ER2 Visit (VST.VST1.1.PKHospital)                                   |
| Patient10        | Avstest         | %5 days ago MM/dd/yy% Pre-Admission Visit (VST.VST2.1.PKHospital)                        |
| Patient11        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                    |

Scenario Outline: plv2u7 CPOE On - CPOE-Search from Patient Search-Patient
Given I am logged into the portal with user "plv2u7" using the default password
And I am on the "Patient Search" tab
And I click the "Clear Criteria" button
And I enter "<PatientLastName>" in the "Last" field in the "Patient Search Criteria" pane
And I enter "<PatientFirstName>" in the "First" field in the "Patient Search Criteria" pane
And I click the "Search for Patients" button
Then the "Search Results" pane should load within "5" seconds
And I click the "Select All" button
And I select "Enter Orders" from the "Actions" menu
Then the text "<Value>" for PLv2 user CPOE should be selected by default in the "CPOE Order Entry" pane
And I click the "Cancel CPOE Order" button

Examples:
| PatientFirstName | PatientLastName | Value                                                                                    |
| Patient01        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient02        | Avstest         | %1 day ago MM/dd/yy% Observation Visit (VST.VST1.1.PKHospital)                           |
| Patient03        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient04        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient05        | Avstest         | %2 days ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                   |
| Patient06        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient07        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST2.1.PKHospital)                             |
| Patient08        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient09        | Avstest         | %1 day ago MM/dd/yy% ER2 Visit (VST.VST1.1.PKHospital)                                   |
| Patient10        | Avstest         | %5 days ago MM/dd/yy% Pre-Admission Visit (VST.VST2.1.PKHospital)                        |
| Patient11        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                    |


Scenario Outline: plv2u7 CPOE On - CPOE-Search from Patient Search-Visit
Given I am logged into the portal with user "plv2u7" using the default password
And I am on the "Patient Search" tab
And I click the "Clear Criteria" button
And I check the following checkboxes
| Include Cancelled Visits |
| Include Past Visits      |
And I enter "<PatientLastName>" in the "Last" field in the "Patient Search Criteria" pane
And I enter "<PatientFirstName>" in the "First" field in the "Patient Search Criteria" pane
And I click the "Search for Visits" button
Then the "Search Results" pane should load within "5" seconds
And I click the "Select All" button
And I select "Enter Orders" from the "Actions" menu
Then the text "<Value>" for PLv2 user CPOE should be selected by default in the "CPOE Order Entry" pane
And I click the "Cancel CPOE Order" button

Examples:
| PatientFirstName | PatientLastName | Value                                                                                    |
| Patient01        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient02        | Avstest         | %1 day ago MM/dd/yy% Observation Visit (VST.VST1.1.PKHospital)                           |
| Patient03        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient04        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient05        | Avstest         | %2 days ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                   |
| Patient06        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient07        | Avstest         | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST2.1.PKHospital)                             |
| Patient08        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient09        | Avstest         | %1 day ago MM/dd/yy% ER2 Visit (VST.VST1.1.PKHospital)                                   |
| Patient10        | Avstest         | %5 days ago MM/dd/yy% Pre-Admission Visit (VST.VST2.1.PKHospital)                        |
| Patient11        | Avstest         | %1 day ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                    |


Scenario Outline: plv2u8 CPOE On - CPOE
Given I am logged into the portal with user "plv2u8" using the default password
And I am on the "Patient List V2" tab
And I select "VSTPatientList" from the "Patient List" menu
And "<PatientName>" is on the patient list
#    When I select "Add Patient" from the "Actions" menu
#    And I click the "Clear Criteria" button
#    And I check the following checkboxes
#      | Include Cancelled Visits |
#      | Include Past Visits      |
#    And I search for patient "<PatientName>"
#    And I click the "Select All" button in the "Add Patient Search" pane
#    And I click the "Add" button in the "Add patient(s) to your patient list" pane
#    And I click the "Close" button in the "Add patient(s) to your patient list" pane if it exists
#    And I wait "2" seconds
#    And I refresh the patient list
And I select the patient "<PatientName>" with index "<IndexValue>" from the patient list
And I select "Enter Orders" from the "Patient Header Actions" menu
Then the text "<VisitValue>" for PLv2 user CPOE should be selected by default in the "Enter Orders" pane
And I click the "Add Order Cancel" button

Examples:
| PatientName         | IndexValue | VisitValue                                                                               |
| Patient01 Avstest   | 1          | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient02 Avstest   | 1          | %1 day ago MM/dd/yy% Observation Visit (VST.VST1.1.PKHospital)                           |
| Patient03 Avstest   | 1          | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient04 Avstest   | 1          | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST1.1.PKHospital)                             |
| Patient05 Avstest   | 1          | %2 days ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                   |
| Patient06 Avstest   | 1          | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient07 Avstest   | 1          | %1 day ago MM/dd/yy% Inpatient Visit (VST.VST2.1.PKHospital)                             |
| Patient08 Avstest   | 1          | %1 day ago MM/dd/yy% ER Visit (VST.VST1.1.PKHospital)                                    |
| Patient09 Avstest   | 1          | %1 day ago MM/dd/yy% ER2 Visit (VST.VST1.1.PKHospital)                                   |
| Patient10 Avstest   | 1          | %5 days ago MM/dd/yy% Pre-Admission Visit (VST.VST2.1.PKHospital)                        |
| Patient11 Avstest   | 1          | %1 day ago MM/dd/yy% ER Visit (VST.VST2.1.PKHospital)                                    |
