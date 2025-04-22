@AutoVisitPLv2 @donotrun
Feature: PLv2 CPOE Off Charge Capture

  Scenario: Pre-requisite - Disable CPOE
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "Site Administration" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    Then I select "false" from the "CPOE" radio list in the "Site Administration" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I save the visits creation date "08/23/2018" for later


  Scenario Outline: plv2u1 CPOE Off - Charge Capture
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
    And I wait "2" seconds
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then the text "<VisitValue>" for PLv2 user ChargeCapture should be selected by default in the "Charge Visit Info" pane
    And I click the "Close" element if it exists

    Examples:
      | PatientName         | IndexValue | VisitValue                                                                                        |
      | Patient01 Avstest   | 1          | %1 day ago MM-dd-yyyy% I Visit (VST.VST1.1.PKHospital)                                            |
      | Patient02 Avstest   | 1          | %1 day ago MM-dd-yyyy% Obs Visit (VST.VST1.1.PKHospital)                                          |
      | Patient03 Avstest   | 1          | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)                                            |
      | Patient04 Avstest   | 1          | %1 day ago MM-dd-yyyy% I Visit (VST.VST1.1.PKHospital)                                            |
      | Patient05 Avstest   | 1          | %2 days ago MM-dd-yyyy% I Visit (Discharged (VST.VST1.1.PKHospital) on %1 day ago MM/dd/yyyy%)    |
      | Patient06 Avstest   | 1          | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)                                            |
      | Patient07 Avstest   | 1          | %1 day ago MM-dd-yyyy% I Visit (VST.VST3.1.PKHospital)                                            |
      | Patient08 Avstest   | 1          | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)                                            |
      | Patient09 Avstest   | 1          | %3 days ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)                                           |
      | Patient10 Avstest   | 1          | %5 days ago MM-dd-yyyy% I Visit (Discharged (VST.VST1.1.PKHospital) on %1 day ago MM/dd/yyyy%)    |
      | Patient11 Avstest   | 1          | %1 day ago MM-dd-yyyy% Pre IP Visit (Discharged (VST.VST3.1.PKHospital) on %1 day ago MM/dd/yyyy%)|


  Scenario Outline: plv2u2 CPOE Off - Charge Capture-Search from Patient Search-Patient
    Given I am logged into the portal with user "plv2u2" using the default password
    And I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I enter "<PatientLastName>" in the "Last" field in the "Patient Search Criteria" pane
    And I enter "<PatientFirstName>" in the "First" field in the "Patient Search Criteria" pane
    And I click the "Search for Patients" button
    Then the "Search Results" pane should load within "5" seconds
    And I click the "Select All" button
    And I select "Add Charge" from the "Actions" menu
    Then the text "<Value>" for PLv2 user ChargeCapture should be selected by default in the "Add Charge Entry" pane
    And I click the "Close" element if it exists

    Examples:
      | PatientFirstName | PatientLastName | Value                                                                 |
      | Patient01        | Avstest         | %1 day ago MM-dd-yyyy% I Visit (VST.VST1.1.PKHospital)                |
      | Patient02        | Avstest         | %1 day ago MM-dd-yyyy% Obs Visit (VST.VST1.1.PKHospital)              |
      | Patient03        | Avstest         | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)                |
      | Patient04        | Avstest         | %1 day ago MM-dd-yyyy% I Visit (VST.VST1.1.PKHospital)                |
      | Patient05        | Avstest         | %2 days ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)               |
      | Patient06        | Avstest         | %2 days ago MM-dd-yyyy% I Visit (VST.VST2.1.PKHospital)               |
      | Patient07        | Avstest         | %1 day ago MM-dd-yyyy% I Visit (VST.VST3.1.PKHospital)                |
      | Patient08        | Avstest         | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)                |
      | Patient09        | Avstest         | %3 days ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)               |
      | Patient10        | Avstest         | %5 days ago MM-dd-yyyy% Pre IP Visit (VST.VST2.1.PKHospital)          |
      | Patient11        | Avstest         | %1 day ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)                |


  Scenario Outline: plv2u2 CPOE Off - Charge Capture-Search from Patient Search-Visit
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
    And I select table row with cell values "<PatientLastName>;<VisitNumber>;<Type>;<Date>" from "Visit Search Results" table with reference to visit creation date
    And I select "Add Charge" from the "Actions" menu
    Then the text "<Value>" for PLv2 user ChargeCapture should be selected by default in the "Add Charge Entry" pane
    And I click the "Close" element if it exists

    Examples:
      | PatientFirstName | PatientLastName | VisitNumber    | Type          | Date                  | Value                                                         |
      | Patient01        | Avstest         | 02286442101    | Inpatient     | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% I Visit (VST.VST1.1.PKHospital)        |
      | Patient02        | Avstest         | 0228644849     | Observation   | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% Obs Visit (VST.VST1.1.PKHospital)      |
      | Patient03        | Avstest         | 0228645253     | ER            | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)        |
      | Patient04        | Avstest         | 0228645455     | Inpatient     | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% I Visit (VST.VST1.1.PKHospital)        |
      | Patient05        | Avstest         | 0228645759     | ER            | %2 day ago MM/dd/yy%  | %2 days ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)       |
      | Patient06        | Avstest         | 0228646062     | Inpatient     | %2 day ago MM/dd/yy%  | %2 days ago MM-dd-yyyy% I Visit (VST.VST2.1.PKHospital)       |
      | Patient07        | Avstest         | 0228646366     | Inpatient     | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% I Visit (VST.VST3.1.PKHospital)        |
      | Patient08        | Avstest         | 02286467101    | ER            | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)        |
      | Patient09        | Avstest         | 02286471101    | ER            | %3 day ago MM/dd/yy%  | %3 days ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)       |
      | Patient10        | Avstest         | 02286474101    | Pre-Admission | %5 day ago MM/dd/yy%  | %5 days ago MM-dd-yyyy% Pre IP Visit (VST.VST2.1.PKHospital)  |
      | Patient11        | Avstest         | 02286477101    | ER            | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)        |

  Scenario Outline: plv2u3 CPOE Off - Charge Capture-Search from Patient Search-Patient
    Given I am logged into the portal with user "plv2u3" using the default password
    And I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I enter "<PatientLastName>" in the "Last" field in the "Patient Search Criteria" pane
    And I enter "<PatientFirstName>" in the "First" field in the "Patient Search Criteria" pane
    And I click the "Search for Patients" button
    Then the "Search Results" pane should load within "5" seconds
    And I click the "Select All" button
    And I select "Add Charge" from the "Actions" menu
    Then the text "<Value>" for PLv2 user ChargeCapture should be selected by default in the "Add Charge Entry" pane
    And I click the "Close" element if it exists

    Examples:
      | PatientFirstName | PatientLastName | Value                                                                 |
      | Patient01        | Avstest         | %1 day ago MM-dd-yyyy% I Visit (VST.VST1.1.PKHospital)                |
      | Patient02        | Avstest         | %1 day ago MM-dd-yyyy% Obs Visit (VST.VST1.1.PKHospital)              |
      | Patient03        | Avstest         | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)                |
      | Patient04        | Avstest         | %1 day ago MM-dd-yyyy% I Visit (VST.VST1.1.PKHospital)                |
      | Patient05        | Avstest         | %2 days ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)               |
      | Patient06        | Avstest         | %2 days ago MM-dd-yyyy% I Visit (VST.VST2.1.PKHospital)               |
      | Patient07        | Avstest         | %1 day ago MM-dd-yyyy% I Visit (VST.VST3.1.PKHospital)                |
      | Patient08        | Avstest         | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)                |
      | Patient09        | Avstest         | %3 days ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)               |
      | Patient10        | Avstest         | %5 days ago MM-dd-yyyy% Pre IP Visit (VST.VST2.1.PKHospital)          |
      | Patient11        | Avstest         | %1 day ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)                |


  Scenario Outline: plv2u3 CPOE Off - Charge Capture-Search from Patient Search-Visit
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
    And I select table row with cell values "<PatientLastName>;<VisitNumber>;<Type>;<Date>" from "Visit Search Results" table with reference to visit creation date
    And I select "Add Charge" from the "Actions" menu
    Then the text "<Value>" for PLv2 user ChargeCapture should be selected by default in the "Add Charge Entry" pane
    And I click the "Close" element if it exists

    Examples:
      | PatientFirstName | PatientLastName | VisitNumber    | Type          | Date                  | Value                                                         |
      | Patient01        | Avstest         | 02286442101    | Inpatient     | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% I Visit (VST.VST1.1.PKHospital)        |
      | Patient02        | Avstest         | 0228644849     | Observation   | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% Obs Visit (VST.VST1.1.PKHospital)      |
      | Patient03        | Avstest         | 0228645253     | ER            | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)        |
      | Patient04        | Avstest         | 0228645455     | Inpatient     | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% I Visit (VST.VST1.1.PKHospital)        |
      | Patient05        | Avstest         | 0228645759     | ER            | %2 day ago MM/dd/yy%  | %2 days ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)       |
      | Patient06        | Avstest         | 0228646062     | Inpatient     | %2 day ago MM/dd/yy%  | %2 days ago MM-dd-yyyy% I Visit (VST.VST2.1.PKHospital)       |
      | Patient07        | Avstest         | 0228646366     | Inpatient     | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% I Visit (VST.VST3.1.PKHospital)        |
      | Patient08        | Avstest         | 02286467101    | ER            | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)        |
      | Patient09        | Avstest         | 02286471101    | ER            | %3 day ago MM/dd/yy%  | %3 days ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)       |
      | Patient10        | Avstest         | 02286474101    | Pre-Admission | %5 day ago MM/dd/yy%  | %5 days ago MM-dd-yyyy% Pre IP Visit (VST.VST2.1.PKHospital)  |
      | Patient11        | Avstest         | 02286477101    | ER            | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)        |


  Scenario Outline: plv2u4 CPOE Off - Charge Capture
    Given I am logged into the portal with user "plv2u4" using the default password
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
  #    And I wait "2" seconds
  #    And I click the "Close" button in the "Add patient(s) to your patient list" pane if it exists
  #    And I wait "2" seconds
  #    And I refresh the patient list
    And I select the patient "<PatientName>" with index "<IndexValue>" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then the text "<VisitValue>" for PLv2 user ChargeCapture should be selected by default in the "Charge Entry" pane
    And I click the "Close" element if it exists

    Examples:
      | PatientName         | IndexValue | VisitValue                                                                                          |
      | Patient01 Avstest   | 1          | %1 day ago MM-dd-yyyy% I Visit (VST.VST1.1.PKHospital)                                              |
      | Patient02 Avstest   | 1          | %1 day ago MM-dd-yyyy% Obs Visit (VST.VST1.1.PKHospital)                                            |
      | Patient03 Avstest   | 1          | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)                                              |
      | Patient04 Avstest   | 1          | %1 day ago MM-dd-yyyy% I Visit (VST.VST1.1.PKHospital)                                              |
      | Patient05 Avstest   | 1          | %2 days ago MM-dd-yyyy% I Visit (Discharged (VST.VST1.1.PKHospital) on %1 day ago MM/dd/yyyy%)      |
      | Patient06 Avstest   | 1          | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)                                              |
      | Patient07 Avstest   | 1          | %1 day ago MM-dd-yyyy% I Visit (VST.VST3.1.PKHospital)                                              |
      | Patient08 Avstest   | 1          | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)                                              |
      | Patient09 Avstest   | 1          | %3 days ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)                                             |
      | Patient10 Avstest   | 1          | %5 days ago MM-dd-yyyy% I Visit (Discharged (VST.VST1.1.PKHospital) on %1 day ago MM/dd/yyyy%)      |
      | Patient11 Avstest   | 1          | %1 day ago MM-dd-yyyy% Pre IP Visit (Discharged (VST.VST3.1.PKHospital) on %1 day ago MM/dd/yyyy%)  |

  Scenario Outline: plv2u5 CPOE Off - Charge Capture
    Given I am logged into the portal with user "plv2u5" using the default password
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
  #    And I wait "2" seconds
  #    And I click the "Close" button in the "Add patient(s) to your patient list" pane if it exists
  #    And I wait "2" seconds
  #    And I refresh the patient list
    And I select the patient "<PatientName>" with index "<IndexValue>" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then the text "<VisitValue>" for PLv2 user ChargeCapture should be selected by default in the "Charge Entry" pane
    And I click the "Close" element if it exists

    Examples:
      | PatientName         | IndexValue | VisitValue                                                                   |
      | Patient01 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |
      | Patient02 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |
      | Patient03 Avstest   | 1          | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)                       |
      | Patient04 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |
      | Patient05 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |
      | Patient06 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |
      | Patient07 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |
      | Patient08 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |
      | Patient09 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |
      | Patient10 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |
      | Patient11 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |


  Scenario Outline: plv2u6 CPOE Off - Charge Capture-Search from Patient Search-Patient
    Given I am logged into the portal with user "plv2u6" using the default password
    And I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I enter "<PatientLastName>" in the "Last" field in the "Patient Search Criteria" pane
    And I enter "<PatientFirstName>" in the "First" field in the "Patient Search Criteria" pane
    And I click the "Search for Patients" button
    Then the "Search Results" pane should load within "5" seconds
    And I click the "Select All" button
    And I select "Add Charge" from the "Actions" menu
    Then the text "<Value>" for PLv2 user ChargeCapture should be selected by default in the "Add Charge Entry" pane
    And I click the "Cancel Add Charge" button if it exists
    And I click the "Close" element if it exists

    Examples:
      | PatientFirstName | PatientLastName | Value                                                                      |
      | Patient01        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |
      | Patient02        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |
      | Patient03        | Avstest         | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)                     |
      | Patient04        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |
      | Patient05        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |
      | Patient06        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |
      | Patient07        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |
      | Patient08        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |
      | Patient09        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |
      | Patient10        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |
      | Patient11        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |


  Scenario Outline: plv2u6 CPOE Off - Charge Capture-Search from Patient Search-Visit
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
      #And I click the "Select All" button
    And I select table row with cell values "<PatientLastName>;<VisitNumber>;<Type>;<Date>" from "Visit Search Results" table with reference to visit creation date
    And I select "Add Charge" from the "Actions" menu
    Then the text "<Value>" for PLv2 user ChargeCapture should be selected by default in the "Add Charge Entry" pane
    And I click the "Cancel Add Charge" button if it exists
    And I click the "Close" element if it exists

    Examples:
      | PatientFirstName | PatientLastName | VisitNumber    | Type          | Date                  | Value                                                         |
      | Patient01        | Avstest         | 02286442101    | Inpatient     | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% I Visit (VST.VST1.1.PKHospital)        |
      | Patient02        | Avstest         | 0228644849     | Observation   | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% Obs Visit (VST.VST1.1.PKHospital)      |
      | Patient03        | Avstest         | 0228645253     | ER            | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)        |
      | Patient04        | Avstest         | 0228645455     | Inpatient     | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% I Visit (VST.VST1.1.PKHospital)        |
      | Patient05        | Avstest         | 0228645759     | ER            | %2 day ago MM/dd/yy%  | %2 days ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)       |
      | Patient06        | Avstest         | 0228646062     | Inpatient     | %2 day ago MM/dd/yy%  | %2 days ago MM-dd-yyyy% I Visit (VST.VST2.1.PKHospital)       |
      | Patient07        | Avstest         | 0228646366     | Inpatient     | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% I Visit (VST.VST3.1.PKHospital)        |
      | Patient08        | Avstest         | 02286467101    | ER            | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)        |
      | Patient09        | Avstest         | 02286471101    | ER            | %3 day ago MM/dd/yy%  | %3 days ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)       |
      | Patient10        | Avstest         | 02286474101    | Pre-Admission | %5 day ago MM/dd/yy%  | %5 days ago MM-dd-yyyy% Pre IP Visit (VST.VST2.1.PKHospital)  |
      | Patient11        | Avstest         | 02286477101    | ER            | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)        |


  Scenario Outline: plv2u7 CPOE Off - Charge Capture-Search from Patient Search-Patient
    Given I am logged into the portal with user "plv2u7" using the default password
    And I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I enter "<PatientLastName>" in the "Last" field in the "Patient Search Criteria" pane
    And I enter "<PatientFirstName>" in the "First" field in the "Patient Search Criteria" pane
    And I click the "Search for Patients" button
    Then the "Search Results" pane should load within "5" seconds
    And I click the "Select All" button
    And I select "Add Charge" from the "Actions" menu
    Then the text "<Value>" for PLv2 user ChargeCapture should be selected by default in the "Add Charge Entry" pane
    And I click the "Cancel Add Charge" button if it exists
    And I click the "Close" element if it exists

    Examples:
      | PatientFirstName | PatientLastName | Value                                                                      |
      | Patient01        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |
      | Patient02        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |
      | Patient03        | Avstest         | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)                     |
      | Patient04        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |
      | Patient05        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |
      | Patient06        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |
      | Patient07        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |
      | Patient08        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |
      | Patient09        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |
      | Patient10        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |
      | Patient11        | Avstest         | Patient has Multiple Visits for the same date. Please select a visit.      |


  Scenario Outline: plv2u7 CPOE Off - Charge Capture-Search from Patient Search-Visit
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
      #And I click the "Select All" button
    And I select table row with cell values "<PatientLastName>;<VisitNumber>;<Type>;<Date>" from "Visit Search Results" table with reference to visit creation date
    And I select "Add Charge" from the "Actions" menu
    Then the text "<Value>" for PLv2 user ChargeCapture should be selected by default in the "Add Charge Entry" pane
    And I click the "Cancel Add Charge" button if it exists
    And I click the "Close" element if it exists

    Examples:
      | PatientFirstName | PatientLastName | VisitNumber    | Type          | Date                  | Value                                                         |
      | Patient01        | Avstest         | 02286442101    | Inpatient     | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% I Visit (VST.VST1.1.PKHospital)        |
      | Patient02        | Avstest         | 0228644849     | Observation   | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% Obs Visit (VST.VST1.1.PKHospital)      |
      | Patient03        | Avstest         | 0228645253     | ER            | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)        |
      | Patient04        | Avstest         | 0228645455     | Inpatient     | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% I Visit (VST.VST1.1.PKHospital)        |
      | Patient05        | Avstest         | 0228645759     | ER            | %2 day ago MM/dd/yy%  | %2 days ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)       |
      | Patient06        | Avstest         | 0228646062     | Inpatient     | %2 day ago MM/dd/yy%  | %2 days ago MM-dd-yyyy% I Visit (VST.VST2.1.PKHospital)       |
      | Patient07        | Avstest         | 0228646366     | Inpatient     | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% I Visit (VST.VST3.1.PKHospital)        |
      | Patient08        | Avstest         | 02262264101    | ER            | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)        |
      | Patient09        | Avstest         | 02286471101    | ER            | %3 days ago MM/dd/yy% | %3 days ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)       |
      | Patient10        | Avstest         | 02286474101    | Pre-Admission | %5 day ago MM/dd/yy%  | %5 days ago MM-dd-yyyy% Pre IP Visit (VST.VST2.1.PKHospital)  |
      | Patient11        | Avstest         | 02286477101    | ER            | %1 day ago MM/dd/yy%  | %1 day ago MM-dd-yyyy% E Visit (VST.VST2.1.PKHospital)        |


  Scenario Outline: plv2u8 CPOE Off - Charge Capture
    Given I am logged into the portal with user "plv2u8" using the default password
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
    And I wait "2" seconds
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then the text "<VisitValue>" for PLv2 user ChargeCapture should be selected by default in the "Charge Entry" pane
    And I click the "Close" element if it exists

    Examples:
      | PatientName         | IndexValue | VisitValue                                                                   |
      | Patient01 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |
      | Patient02 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |
      | Patient03 Avstest   | 1          | %1 day ago MM-dd-yyyy% E Visit (VST.VST1.1.PKHospital)                       |
      | Patient04 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |
      | Patient05 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |
      | Patient06 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |
      | Patient07 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |
      | Patient08 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |
      | Patient09 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |
      | Patient10 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |
      | Patient11 Avstest   | 1          | Patient has Multiple Visits for the same date. Please select a visit.        |


  Scenario: Pre-requisite - Enable CPOE
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "Site Administration" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    Then I select "true" from the "CPOE" radio list in the "Site Administration" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
