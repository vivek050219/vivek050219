Feature: SubmitDraft

  Background:
    Given I am logged into the portal with user "savedraftlevel3" using the default password
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "Draft" owned by "savedraftlevel3" with the following parameters
      | Type   | Name              | Value      |
      | Filter | Medical Service   | Card Group |
    And I click the "Refresh Patient List" button
    And I select "Draft" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Last 24 Hours" from the "ClinicalTimeframe" menu
    And I select "Charges" from clinical navigation

  @savecharge
  Scenario: Add Charge without errors in BCE_Save as Draft
    When I am on the "Charges" tab
    And I select the "Batch Charge Entry" subtab
    And I select "Draft" from the "BatchChargeEntry" menu
    Then I wait up to "5" seconds for the "Visits" field of type "TABLE" to be visible
    And I click the "AddEditCharges" button in the "BatchChargeEntry" pane
    And I wait "5" seconds
    And I enter the ICD-10 code "R52"
    And I click the "CPT" button
    And I enter the CPT code "86000"
    Then the text "86000" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button
    And I wait "5" seconds
    Then the following rows should appear in the "ChargeList" table
      |Charges 				     |Qty |Diagnoses |
      |86000 agglutinins febrile |1   |R52 Pain  |
    When I select "savedraft" from the "Bill Area" tabledropdown in the "Batch Charge Entry" pane
    And I select "Inpatient" from the "Svc Site" tabledropdown in the "Batch Charge Entry" pane
    And I select patient "Molly Darr" from the "Name (\d)" column in the "Visits" table
    And I click the "SaveasDraft" button
    Then the text "You are about to create a charge transaction for 1 patients. Do you wish to proceed?" should appear in the "Question" pane
    When I click the "OK" button in the "Question" pane
    And I wait "10" seconds
    Then the "Checkbox" image should be shown in the following rows in the "Visits" table
      |Displayed  |Name (\d)   |
      |true       |DARR, MOLLY |
    When I click the "Checkbox" element
    Then the text "R52 Pain" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And the text "86000" should appear in the "Charge List" section in the "Charge Entry" pane
    And I click the "Close" image
    #patient is deselected as it will effect nxt testcase
    And I select patient "Molly Darr" from the "Name (\d)" column in the "Visits" table

  @savecharge
  Scenario: Add Charge with errors in BCE_Save as Draft
    When I am on the "Charges" tab
    And I select the "Batch Charge Entry" subtab
    And I select "Draft" from the "BatchChargeEntry" menu
    Then I wait up to "5" seconds for the "Visits" field of type "TABLE" to be visible
    And I click the "AddEditCharges" button in the "BatchChargeEntry" pane
    And I wait "3" seconds
    And I enter the ICD-10 code "R52"
    And I enter the CPT code "86000"
    Then the text "86000" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button
    Then the following rows should appear in the "ChargeList" table
      |Charges 				     |Qty |Diagnoses |
      |86000 agglutinins febrile |1   |R52 Pain  |
    When I select "savedraft" from the "Bill Area" tabledropdown in the "Batch Charge Entry" pane
    And I select "Inpatient" from the "Svc Site" tabledropdown in the "Batch Charge Entry" pane
    And I enter "%1 day from now MMDDYYYY%" in the "BCEDate" field
    And I select patient "Molly Darr" from the "Name (\d)" column in the "Visits" table
    And I click the "SaveasDraft" button
    Then the text "You are about to create a charge transaction for 1 patients. Do you wish to proceed?" should appear in the "Question" pane
    When I click the "OK" button in the "Question" pane
    And I wait "3" seconds
    Then the "Information" pane should load
    And the following text should appear in the "Information" pane
      |The charges have been created, but some charges are in error status.|
      |Please click on the red exclamation to review or edit the individual charges for errors.|
    When I click the "InformationOK" button in the "Information" pane
    When I click the "Exclamation" element
    Then the text "R52 Pain" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And the text "86000" should appear in the "Charge List" section in the "Charge Entry" pane
    And I click the "Close" image

  @savecharge
  Scenario: Save the transaction as a draft
    When I select "86000 agglutinins febrile" from the "Proc" column in the "Charges" table
    And I click the "Edit" button
    And I wait "5" seconds
    And I remove the "86000" CPT code
    And I enter the CPT code "30000"
    And I click the "Submit Draft" button
    And I wait "2" seconds
    And I refresh the clinical display
    And I wait "2" seconds
    Then the following rows should appear in the "Charges" table
      |Proc                          |Diag |
      |30000 drainage of nose lesion |R52  |

  @savecharge
  Scenario: Edit a charge in Draft status and save it as draft until saved normally
    When I select "30000 drainage of nose lesion" from the "Proc" column in the "Charges" table
    And I click the "Edit" button
    And I wait "2" seconds
    Then the following fields should display in the "Charge Entry" pane
      |Name                 |Type   |
      |Print                |button |
      |ChargeEntryDelete    |button |
      |Submit               |button |
      |Submit Draft         |button |
    When I remove the "30000" CPT code
    And I enter the CPT code "0001F"
    And I click the "Submit Draft" button
    And I refresh the clinical display
    And I wait "2" seconds
    And I select "0001F heart failure composite" from the "Proc" column in the "Charges" table
    Then the following fields should display in the "Charge Detail" pane
      |Name                |Type   |
      |Edit                |button |
      |Copy                |button |
      |Delete              |button |
    When I click the "Edit" button
    And I wait "5" seconds
    And I remove the "0001F" CPT code in the "Charge Entry" pane
    And I enter the CPT code "01250"
    And I click the "Submit" button
    And I select "01250 anesth upper leg surgery" from the "Proc" column in the "Charges" table
    Then the following fields should display in the "Charge Detail" pane
      |Name   |Type   |
      |Edit   |button |
      |Copy   |button |
      |Delete |button |

  @savecharge
  Scenario: Edit the draft charge beyond the visit date as level3 user
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "savedraftlevel3"
    And I select the user "savedraftlevel3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I enter "5" in the "DaysBeyondtheVisitEndtoAllowEditingaCharge" field
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "savedraftlevel3" using the default password
    And I am on the "Patient List V2" tab
    And I select patient "Molly Darr" from the patient list
    And I select "Charges" from clinical navigation
    And I select "01250 anesth upper leg surgery" from the "Proc" column in the "Charges" table
    And I click the "Edit" button
    And I wait "2" seconds
    And I enter "%20 days ago MMDDYYYY%" in the "Date" field
    And I click the "DiagnosisSearch" element
    And I click the "Submit" button
    Then the following fields should display in the "Confirm" pane
      |Name                |Type   |
      |Continue Editing    |button |
      |Discard Transaction |button |
    And I click the "Discard Transaction" button
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "savedraftlevel3"
    And I select the user "savedraftlevel3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I enter "50" in the "DaysBeyondtheVisitEndtoAllowEditingaCharge" field
    And I click the "Save" button
    And I click "OK" in the confirmation box

  @savecharge
  Scenario: Edit the draft charge beyond the visit date as level2 user
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "savedraftlevel2"
    And I select the user "savedraftlevel2"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I enter "5" in the "DaysBeyondtheVisitEndtoAllowEditingaCharge" field
    And I click the "Save" button
    And I click "OK" in the confirmation box
    Given I am logged into the portal with user "savedraftlevel2" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Charges" from clinical navigation
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value                   |
      |Bill Area    |Savedraftcheckall       |
      |Billing Prov |LEVEL2, SAVEDRAFT       |
      |Svc Site     |Inpatient               |
      |Date	        |%Current Date MMDDYYYY% |
    And I wait "2" seconds
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "01250"
#    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "Submit Draft" button
    And I wait "2" seconds
    And I select "01250 anesth upper leg surgery" from the "Proc" column in the "Charges" table
    And I click the "Edit" button
    And I wait "2" seconds
    And I enter "%6 days ago MMDDYYYY%" in the "Date" field
    And I click the "DiagnosisSearch" element
    And I click the "Submit" button
    Then the "Confirm" pane should load
    And the following fields should display in the "Confirm" pane
      |Name                |Type   |
      |Continue Editing    |button |
      |Discard Transaction |button |
    When I click the "Discard Transaction" button
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "savedraftlevel2"
    And I select the user "savedraftlevel2"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I enter "50" in the "DaysBeyondtheVisitEndtoAllowEditingaCharge" field
    And I click the "Save" button
    And I click "OK" in the confirmation box

  @savecharge
  Scenario: Edit the draft charge beyond the visit date as level1 user
    Given I am logged into the portal with user "savedraftlevel1" using the default password
    And I am on the "Admin" tab
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "EditPreferencesSettings" dropdown
    And I enter "5" in the "DaysBeyondtheVisitEndtoAllowEditingaCharge" field
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Charges" from clinical navigation
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value             |
      |Bill Area    |Savedraftcheckall |
      |Billing Prov |LEVEL1, SAVEDRAFT |
      |Svc Site     |Inpatient         |
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "01250"
    And I click the "Submit Draft" button
    And I wait "2" seconds
    And I select "01250 anesth upper leg surgery" from the "Proc" column in the "Charges" table
    And I click the "Edit" button
    And I wait "2" seconds
    Then the following fields should display in the "Charge Entry" pane
      |Name           |Type   |
      |Print          |button |
      |Submit         |button |
      |Submit Draft   |button |
    And I enter "%6 days ago MMDDYYYY%" in the "Date" field
    And I click the "DiagnosisSearch" element
    And I click the "Submit" button
    Then the "Confirm" pane should load 
    Then the following fields should display in the "Confirm" pane
      |Name                |Type   |
      |Continue Editing    |button |
      |Save As Is          |button |
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I am on the "Admin" tab
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "EditPreferencesSettings" dropdown
    And I enter "50" in the "DaysBeyondtheVisitEndtoAllowEditingaCharge" field
    And I click the "Save" button
    And I click "OK" in the confirmation box

  @savecharge
  Scenario: Enter the required filed and saving the charge as Draft
    Given I am logged into the portal with user "saveadmin" using the default password
    And I launch the charge transaction headers for "savedraftlevel3" user
    Then the following rows should appear in the "Charge Transaction Headers" table
      |Header Name        |
      |Bill Area          |
      |Billing Prov       |
      |Svc Site           |
      |Referring          |
      |Date               |
      |Rendering Provider |
    And I click the "Close" button in the "Charge Transaction Content" pane
    Given I am logged into the portal with user "savedraftlevel3" using the default password
    And I am on the "Patient List V2" tab
    And I select patient "Molly Darr" from the patient list
    And I select "Charges" from clinical navigation
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value             |
      |Bill Area    |savedraft         |
      |Billing Prov |LEVEL3, SAVEDRAFT |
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "11740"
    And I click the "Submit" button
    Then the text "HEADER :Svc Site is required" should appear in the "Charge Entry" pane
    When I set the following charge headers
      |Name         |Value             |
      |Svc Site     |Inpatient         |
    And I click the "Submit Draft" button
    And I wait "2" seconds
    And I select "the first item" in the "Charges" table
    Then the text "Draft" should appear in the "Charge Detail" pane

  @savecharge
  Scenario: Draft Extension Period to 1 Day user level 3
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value             |
      | Bill Area    | savedraft         |
      | Billing Prov | LEVEL3, SAVEDRAFT |
      | Svc Site     | Inpatient         |
    And I enter "%1 days ago MMDDYYYY%" in the "Date" field
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "11740"
    And I click the "Submit Draft" button
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    Then the text "Draft" should appear in the "Charge Detail" pane

  @savecharge
  Scenario: Verification of Check Validity of Service Date field Inpatient
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value             |
      | Bill Area    | savedraft         |
      | Billing Prov | LEVEL3, SAVEDRAFT |
      | Svc Site     | Inpatient         |
    And I enter "%51 days ago MMDDYYYY%" in the "Date" field
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "11740"
    And I click the "Submit" button
    Then the following text should appear in the "Confirm" pane
      | This charge transaction was NOT SAVED due to errors. Choose the next step. |
      | Please note that if you discard the transaction, all changes will be lost. |
    And the following fields should display in the "Confirm" pane
      | Name                | Type   |
      | Continue Editing    | button |
      | Discard Transaction | button |
    When I click the "Continue Editing" button
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "DiagnosisSearch" element
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "No Errors Found" should appear in the "Charge Entry" pane
    When I click the "Submit Draft" button
    And I select "the first item" in the "Charges" table
    Then the text "Draft" should appear in the "Charge Detail" pane

  @savecharge
  Scenario: Verification of Check Validity of Service Date field Outpatient
    When "TEST CODEEDIT-1", admitted in the last "5" days, is on the patient list
    And patient "TEST CODEEDIT-1" has no charges
    And I select patient "TEST CODEEDIT-1" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value             |
      | Bill Area    | savedraft         |
      | Billing Prov | LEVEL3, SAVEDRAFT |
      | Svc Site     | Outpatient        |
    And I enter "%51 days ago MMDDYYYY%" in the "Date" field
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "11740"
    And I click the "Submit" button
    Then the following text should appear in the "Confirm" pane
      | This charge transaction was NOT SAVED due to errors. Choose the next step. |
      | Please note that if you discard the transaction, all changes will be lost. |
    And the following fields should display in the "Confirm" pane
      | Name                | Type   |
      | Continue Editing    | button |
      | Discard Transaction | button |
    When I click the "Continue Editing" button
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "DiagnosisSearch" element
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "No Errors Found" should appear in the "Charge Entry" pane
    When I click the "Submit Draft" button
    And I select "the first item" in the "Charges" table
    Then the text "Draft" should appear in the "Charge Detail" pane
    And patient "TEST CODEEDIT-1" has no charges

  @savecharge
  Scenario: Verification of Check Validity of Service Date field ER
    When "TEST CODEEDIT-1", admitted in the last "5" days, is on the patient list
    And patient "TEST CODEEDIT-1" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value             |
      | Bill Area    | savedraft         |
      | Billing Prov | LEVEL3, SAVEDRAFT |
      | Svc Site     | ER                |
    And I enter "%51 days ago MMDDYYYY%" in the "Date" field
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "11740"
    And I click the "Submit" button
    Then the following text should appear in the "Confirm" pane
      | This charge transaction was NOT SAVED due to errors. Choose the next step. |
      | Please note that if you discard the transaction, all changes will be lost. |
    And the following fields should display in the "Confirm" pane
      | Name                | Type   |
      | Continue Editing    | button |
      | Discard Transaction | button |
    When I click the "Continue Editing" button
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "DiagnosisSearch" element
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "No Errors Found" should appear in the "Charge Entry" pane
    When I click the "Submit Draft" button
    And I select "the first item" in the "Charges" table
    Then the text "Draft" should appear in the "Charge Detail" pane
     #removing BROOKS ANGELA patientlist
    When patient "TEST CODEEDIT-1" has no charges
    And "TEST CODEEDIT-1" is not on the patient list

  @savecharge
  Scenario: Edit Charge without errors in BCE_Save as Draft
    When I am on the "Charges" tab
    And I select the "Batch Charge Entry" subtab
    And I select "Draft" from the "BatchChargeEntry" menu
    Then I wait up to "5" seconds for the "Visits" field of type "TABLE" to be visible
    And I click the "AddEditCharges" button in the "BatchChargeEntry" pane
    And I wait "5" seconds
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "86000"
    Then the text "86000" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button
    Then the following rows should appear in the "ChargeList" table
      | Charges                   | Qty | Diagnoses        |
      | 86000 agglutinins febrile | 1   | B36.0 Pityriasis |
    When I select "savedraft" from the "Bill Area" tabledropdown in the "Batch Charge Entry" pane
    And I select "Inpatient" from the "Svc Site" tabledropdown in the "Batch Charge Entry" pane
    And I select patient "Molly Darr" from the "Name (\d)" column in the "Visits" table
    And I click the "SaveasDraft" button
    Then the text "You are about to create a charge transaction for 1 patients. Do you wish to proceed?" should appear in the "Question" pane
    When I click the "OK" button in the "Question" pane
    Then the "Checkbox" image should be shown in the following rows in the "Visits" table
      |Displayed |Name (\d)   |
      |true      |DARR, MOLLY |
#    And I wait "5" seconds
    When I click the "Checkbox" element
    Then the text "B36.0 Pityriasis" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And the text "86000" should appear in the "Charge List" section in the "Charge Entry" pane
    When I enter the CPT code "99221"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "No Errors Found" should appear in the "Charge Entry" pane
    And I click the "Submit Draft" button

  @savecharge
  Scenario: Edit Charge with errors in BCE_Save as Draft
   #Enable code edits
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Patient List V2" tab
    #And I turn "on" all codeedits on "server"
    And I execute the "Enable All Code Edits" query
    Given I am logged into the portal with user "savedraftlevel3" using the default password
    When I am on the "Charges" tab
    And I select the "Batch Charge Entry" subtab
    And I select "Draft" from the "BatchChargeEntry" menu
    Then I wait up to "5" seconds for the "Visits" field of type "TABLE" to be visible
    And I click the "AddEditCharges" button in the "BatchChargeEntry" pane
    And I wait "3" seconds
    And I enter the ICD-10 code "R52"
    And I enter the CPT code "86000"
    Then the text "86000" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button
    Then the following rows should appear in the "ChargeList" table
      |Charges 				     |Qty |Diagnoses |
      |86000 agglutinins febrile |1   |R52 Pain  |
    When I select "savedraft" from the "Bill Area" tabledropdown in the "Batch Charge Entry" pane
    And I select "Inpatient" from the "Svc Site" tabledropdown in the "Batch Charge Entry" pane
    And I enter "%1 day from now MMDDYY%" in the "BCE Date" field
    And I select patient "Molly Darr" from the "Name (\d)" column in the "Visits" table
    And I click the "SaveasDraft" button
    Then the text "You are about to create a charge transaction for 1 patients. Do you wish to proceed?" should appear in the "Question" pane
    When I click the "OK" button in the "Question" pane
    Then the "Information" pane should load
    And the following text should appear in the "Information" pane
      |The charges have been created, but some charges are in error status.|
      |Please click on the red exclamation to review or edit the individual charges for errors.|
    And I click the "Information OK" button in the "Information" pane
#    And I wait "5" seconds
    When I click the "Exclamation" element
    Then the text "R52 Pain" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And the text "86000" should appear in the "Charge List" section in the "Charge Entry" pane
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    When I enter the CPT code "15860"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "DX : This diagnosis R52 has already been used as a primary diagnosis for this date within the same Department." should appear in the "Charge Entry" pane
    And I click the "Submit Draft" button

  @savecharge
  Scenario: Add a Charge Save as Draft No Edits and Edits
    Given I am logged into the portal with user "savedraftlevel3" using the default password
    And I am on the "Patient List V2" tab
    Given patient "Molly Darr" has no charges
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value             |
      |Bill Area    |Savedraftcheckall |
      |Billing Prov |LEVEL3, SAVEDRAFT |
      |Svc Site     |Inpatient         |
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "01250"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "No Errors Found" should appear in the "Charge Entry" pane
    When I click the "Submit Draft" button
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    Then the text "Draft" should appear in the "Charge Detail" pane
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value             |
      |Bill Area    |savedraft         |
      |Billing Prov |LEVEL3, SAVEDRAFT |
      |Svc Site     |Inpatient         |
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "97811"
    And I click the "Submit" button
    Then the "Confirm" pane should load
    And the text "This charge transaction has been saved as a DRAFT due to errors. Choose the next step." should appear in the "Confirm" pane
    And the following fields should display in the "Confirm" pane
      |Name             |Type   |
      |Continue Editing |button |
      |Save As Is       |button |
    And I click the "Save As Is" button in the "Confirm" pane
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    Then the text "Draft" should appear in the "Charge Detail" pane

  @savecharge
  Scenario: Edit and Save as draft when code edit or validity error occurs
    When I select patient "Molly Darr" from the patient list
    And I select "01250 anesth upper leg surgery" from the "Proc" column in the "Charges" table
    And I click the "Edit" button
    And I wait "2" seconds
    And I enter the CPT code "92960"
    And I click the "Submit" button
    Then the text "The charge transaction has been saved as a COMPLETED transaction, but code edits now exist. Choose the next step." should appear in the "Confirm" pane
    And the following fields should display in the "Confirm" pane
      |Name                    |Type   |
      |Continue Editing        |button |
      |Save As Is              |button |
      |Code Edit Save as Draft |button |
    When I click the "Code Edit Save as Draft" button
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    Then the text "Draft" should appear in the "Charge Detail" pane

  @savecharge
  Scenario: Allow Saving Charges with Forced Code Edits As Draft
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "savedraftlevel3"
    And I select the user "savedraftlevel3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "true" from the "AllowUsertoSaveasDraft" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box
    Given I am logged into the portal with user "savedraftlevel3" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value             |
      |Bill Area    |savedraft         |
      |Billing Prov |LEVEL3, SAVEDRAFT |
      |Svc Site     |Inpatient         |
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "97811"
    And I click the "Submit" button
    And the text "This charge transaction has been saved as a DRAFT due to errors. Choose the next step." should appear in the "Confirm" pane
    And the following fields should display in the "Confirm" pane
      |Name             |Type   |
      |Continue Editing |button |
      |Save As Is       |button |
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I select "Charges" from clinical navigation
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    Then the text "Draft" should appear in the "Charge Detail" pane
   #deleting all charges
    And patient "Molly Darr" has no charges
   #Setup testcase to turn off all codeedits on user server
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Patient List V2" tab
    #And I turn "off" all codeedits on "server"
    And I execute the "Disable All Code Edits" query

  @savecharge
  Scenario: Verify the fields in CC screen by using free text followed by Regular CPT of Charges/Holding Bin [DEV-74311]
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I open "Charge Capture" settings page for the user "saveadmin"
    And I edit the following user settings and I click save
      | Page           | Name                             | Type  | Value |
      | Charge Capture | Allow Free Text Charges          | radio | true  |
    And I am on the "Patient List V2" tab
    And I select "SaveSubmit List" from the "Patient List" menu
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    And I select "Last 24 Hours" from the "ClinicalTimeframe" menu
    And patient "Neil Heath" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value         |
      |Bill Area    |submitsave    |
      |Svc Site     |Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button in the "Charge Entry" pane
    And I enter the ICD-10 codes "B36.0"
    And I enter "cccc" in the "Charge Search" field in the "Charge Entry" pane
    And I wait "2" seconds
    And I click the "Add as Free Text" link in the "Charges Free Text" section in the "Charge Entry" pane
    And the text "cccc" should appear in the "Charge List" section in the "Charge Entry" pane
    And I enter the CPT codes "86000"
    When I click the "Submit" button in the "Charge Entry" pane
    And I click the "SaveAsIs" button in the "Confirm" pane
    And I select "the first item" in the "Charges" table
    Then the text "Holding Bin" should appear in the "Charge Detail" pane
    And I am on the "Charges" tab
    And I select the "Holding Bin" subtab
    And I click the "Reset Criteria" button in the "Holding Bin" pane
    And I select "Last 30 Days" from the "Timeframe" dropdown in the "Holding Bin" pane
    And I select "submitsave" from the "Dept" dropdown in the "Holding Bin" pane
    And I click the "Show Charges" button in the "Holding Bin" pane
    When I select the "Free Text Error" link in the row with "HEATH, NEIL" as the value under "Patient" in the "Holding Bin" table
    Then the text "Free text charge." should appear in the "Charge Entry" pane
    Then the "Submit" "Button" should be visible
    Then the "Send To Outbox Holding Bin" "Button" should be visible
    Then the "Submit Draft" "Button" should be visible
    And I click the "Close" image
    Then the "Charge Entry" pane should close

  @savecharge
  Scenario: Verify the fields in CC screen by using Regular CPT followed by free text of Charges/Holding Bin [DEV-74311]
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Patient List V2" tab
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value         |
      |Bill Area    |submitsave    |
      |Svc Site     |Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button in the "Charge Entry" pane
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "86000"
    And I enter "free text" in the "Charge Search" field in the "Charge Entry" pane
    And I wait "2" seconds
    And I click the "Add as Free Text" link in the "Charges Free Text" section in the "Charge Entry" pane
    And the text "free text" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button in the "Charge Entry" pane
    And I click the "SaveAsIs" button in the "Confirm" pane
    And I select "the first item" in the "Charges" table
    Then the text "Holding Bin" should appear in the "Charge Detail" pane
    When I am on the "Charges" tab
    And I select the "Holding Bin" subtab
    And I click the "Reset Criteria" button in the "Holding Bin" pane
    And I select "Last 30 Days" from the "Timeframe" dropdown in the "Holding Bin" pane
    And I select "submitsave" from the "Dept" dropdown in the "Holding Bin" pane
    And I click the "Show Charges" button in the "Holding Bin" pane
    When I select the "Free Text Error" link in the row with "HEATH, NEIL" as the value under "Patient" in the "Holding Bin" table
    And I wait "3" seconds
    Then the text "Free text charge." should appear in the "Charge Entry" pane
    Then the "Submit" "Button" should be visible
    Then the "Send To Outbox Holding Bin" "Button" should be visible
    Then the "Submit Draft" "Button" should be visible
    And I click the "Close" image
    Then the "Charge Entry" pane should close
    #Reverting the settings back
    And I am on the "Admin" tab
    And I open "Charge Capture" settings page for the user "saveadmin"
    And I edit the following user settings and I click save
      | Page           | Name                             | Type  | Value |
      | Charge Capture | Allow Free Text Charges          | radio | false |
    And I am on the "Patient List V2" tab