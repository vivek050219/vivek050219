Feature: CC - 8.0 Add Edit Charge and Portal Facelift
 #Test user Setup
  #Patient List settings -> Enable Patient Search Tab, Enable Patient Visit Edit option
  #NoteWriter Settings -> Associate Note templates (History and Physical, Progress Note)

  Background:
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "CCList" owned by "addchargeuser3" with the following parameters
      | Type   | Name              | Value      |
      | Filter | Medical Service   | Card Group |
    And I click the "Refresh Patient List" button
    And I select "CCList" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Charges" from clinical navigation
    And I "uncheck" the following
      |Show Visits|
    And I "uncheck" the following
      |My Charges Only|
    And I select "Last 24 Hours" from the "ClinicalTimeframe" menu


  @ChargeCapture
  Scenario: Setup testcase to turn off all codeedits on user server
    Given I am logged into the portal with user "pkadmin" using the default password
    #And I turn "off" all codeedits on "server"
    And I execute the "Disable All Code Edits" query

  @ChargeCapture
  Scenario: Setup testcase to delete existing charges
    And patient "Molly Darr" has no charges

  @ChargeCapture @Demo
  Scenario: Validate AddCharge Actions Menu
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |Verve            |
      |Billing Prov |USER3, ADDCHARGE |
      |Svc Site     |Inpatient        |
    And I enter the ICD-10 codes "B36.0"
    And I click the "CPT" button
    And I enter the CPT codes "00192"
    And I click the "Submit" button
    And I wait for loading to complete
   #make sure we're looking at the most recent
    And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
    Then the following rows should appear in the "Charges" table
      |Date/Time             |Proc                             |Diag  |
      |%Current Date MMDDYY% |00192 anesth facial bone surgery |B36.0 |

  @ChargeCapture @Demo
  Scenario: Validate AddCharge Charges(+)
    When I click the "Charges +" button
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |Verve            |
      |Billing Prov |USER3, ADDCHARGE |
      |Svc Site     |Inpatient        |
    #And I enter the ICD-9 code "111.0"
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "0005F"
    And I click the "Submit" button
    And I wait for loading to complete
    #make sure we're looking at the most recent
    And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
    Then the following rows should appear in the "Charges" table
      |Date/Time             |Proc                           |Diag  |
      #|%Current Date MMDDYY% |0005F osteoarthritis composite |111.0 |
      |%Current Date MMDDYY% |0005F osteoarthritis composite |B36.0 |

  @ChargeCapture
  Scenario: Validate Add Charge From Visits Add Charge to this Visit button
    When I select "Visits" from clinical navigation
    And I wait "2" seconds
    And I select "Inpatient" from the "Type" column in the "Visits" table
    And I click the "Add Charge to this Visit" button
    And I wait "2" seconds
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |Verve            |
      |Billing Prov |USER3, ADDCHARGE |
      |Svc Site     |Inpatient        |
    #And I enter the ICD-9 code "111.0"
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "0109T"
    And I click the "Submit" button
    And I wait for loading to complete
    And I select "Charges" from clinical navigation
    And I refresh the clinical display
    And I wait for loading to complete
    #make sure we're looking at the most recent
    And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
    Then the following rows should appear in the "Charges" table
      |Date/Time             |Proc                          |Diag  |
      #|%Current Date MMDDYY% |0109T heat quant sensory test |111.0 |
      |%Current Date MMDDYY% |0109T heat quant sensory test |B36.0 |

  @ChargeCapture
  Scenario: Validate Add Charge From Visits Edit Visit and Save visit and Add Charge button
    When I select "Visits" from clinical navigation
    And I wait "2" seconds
    And I select "Inpatient" from the "Type" column in the "Visits" table
    And I click the "Edit Visit" button
    And I click the "Save and Add Charge" button
    And I wait "2" seconds
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |Verve            |
      |Billing Prov |USER3, ADDCHARGE |
      |Svc Site     |Inpatient        |
    #And I enter the ICD-9 code "100.0"
    And I enter the ICD-10 codes "A27.0"
    And I enter the CPT codes "00800"
    And I click the "Submit" button
    And I wait for loading to complete
    And I select "Charges" from clinical navigation
    And I refresh the clinical display
    And I wait for loading to complete
    #make sure we're looking at the most recent
    And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
    Then the following rows should appear in the "Charges" table
      |Date/Time             |Proc                             |Diag  |
      #|%Current Date MMDDYY% |00800 anesth abdominal wall surg |100.0 |
      |%Current Date MMDDYY% |00800 anesth abdominal wall surg |A27.0 |


  @ChargeCapture @Demo
  Scenario: Validate copy charge from PL
  #make sure we're looking at the most recent
    When I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
    And I select "00192 anesth facial bone surgery" from the "Proc" column in the "Charges" table
    And I wait "2" seconds
    And I click the "Copy" button
    And I wait "2" seconds
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |Verve            |
      |Billing Prov |USER3, ADDCHARGE |
      |Svc Site     |Inpatient        |
    When I remove the "00192" CPT code
    And I enter the CPT codes "00103"
    And I enter the ICD-10 codes "B36.0"
    And I click the "Submit" button
    And I wait for loading to complete
    #make sure we're looking at the most recent
    And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
    Then the following rows should appear in the "Charges" table
      |Date/Time             |Proc                         |Diag  |
      |%Current Date MMDDYY% |00103 anesth blepharoplasty |B36.0 |

  @ChargeCapture @Demo
  Scenario: Validate Edit Charge Charge(+) Shows the existing Charge
    When I select "0005F osteoarthritis composite" from the "Proc" column in the "Charges" table
    And I click the "Edit" button
    And I wait "2" seconds
    And I remove the "0005F" CPT code
    And I enter the CPT codes "30000"
    And I click the "Submit" button
    And I wait for loading to complete
    #make sure we're looking at the most recent
    And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
    Then the following rows should appear in the "Charges" table
      |Date/Time             |Proc                          |Diag  |
      #|%Current Date MMDDYY% |30000 drainage of nose lesion |111.0 |
      |%Current Date MMDDYY% |30000 drainage of nose lesion |B36.0 |

  @ChargeCapture
  Scenario: Add a charge to the patient who does not belong to the patient list
    Given "Molly Darr" is not on the patient list
    And I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I "uncheck" the following
      |Include Cancelled Visits|
    And I "uncheck" the following
      |Include Past Visits|
    And I fill in the following fields
      |Name  |Type |Value |
      |Last  |text |DARR  |
      |First |text |MOLLY |
    And I click the "Search for Visits" button
    And I wait "2" seconds
    And I select patient "Molly Darr" from the "Name (\d+)" column in the "Visit Search Results" table
    And I select "Add Charge" from the "Actions" menu
    And I set the following charge headers in the "PatientSearchChargeEntry" pane
      |Name         |Value            |
      |Bill Area    |Verve            |
      |Billing Prov |USER3, ADDCHARGE |
      |Svc Site     |Inpatient        |
    And I enter the ICD-10 codes "B36.0" in the "PatientSearchChargeEntry" pane
    And I enter the CPT codes "1002F" in the "PatientSearchChargeEntry" pane
    And I click the "Submit" button in the "PatientSearchChargeEntry" pane
   # Validate Charge get added in the patient detail page
    And I select patient "Molly Darr" from the "Name (\d+)" column in the "Visit Search Results" table
    And I click the "View Detail" button
    Then the "PatientDetails" pane should load within "5" seconds
    When I select "Charges" from clinical navigation in the "PatientClinicalNavigation" pane
     ##make sure we're looking at the most recent
    And I sort the "Patient Detail Charges" table chronologically by the "Date/Time" column in "Descending" order
    Then the following rows should appear in the "Patient Detail Charges" table
      |Date/Time             |Proc                               |Diag  |
      |%Current Date MMDDYY% |1002F assess anginal symptom/level |B36.0 |
    And I click the "Close" button in the "PatientDetails" pane

  @ChargeCapture @Demo
  Scenario: Add a charge from patient search
    When I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I "uncheck" the following
      |Include Cancelled Visits|
    And I "uncheck" the following
      |Include Past Visits|
    And I enter "5" in the "Admit in last N days" field
    And I fill in the following fields
      |Name  |Type |Value |
      |Last  |text |DARR  |
      |First |text |MOLLY |
    And I click the "Search for Visits" button
    And I select patient "Molly Darr" from the "Name (\d+)" column in the "Visit Search Results" table
    And I select "Add Charge" from the "Actions" menu
    And I set the following charge headers in the "PatientSearchChargeEntry" pane
      |Name         |Value            |
      |Bill Area    |Verve            |
      |Billing Prov |USER3, ADDCHARGE |
      |Svc Site     |Inpatient        |
    And I enter the ICD-10 codes "B36.0" in the "PatientSearchChargeEntry" pane
    And I enter the CPT codes "00103" in the "PatientSearchChargeEntry" pane
    And I click the "Submit" button in the "PatientSearchChargeEntry" pane
    And I am on the "Patient List V2" tab
    And I select "Charges" from clinical navigation
    And I wait for loading to complete
    #make sure we're looking at the most recent
    And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
    Then the following rows should appear in the "Charges" table
      |Date/Time             |Proc                        |Diag  |
      |%Current Date MMDDYY% |00103 anesth blepharoplasty |B36.0 |

  @ChargeCapture
  Scenario: Validate AddCharge Worklist
    When I am on the "Charges" tab
    And I select the "Worklist" subtab
    And I click the "Reset Criteria" button in the "Worklist" pane
    And I select "Today" from the "Timeframe" dropdown in the "Worklist" pane
    And I check the "My Charges Only" checkbox in the "Worklist" pane
    And I check the "Include Charges with No Edits" checkbox in the "Worklist" pane
    And I click the "Refresh Worklist" button in the "Worklist" pane
    #make sure we're looking at the most recent
    And I sort the "Worklist" table chronologically by the "Date" column in "Descending" order
    Then rows containing the following should appear in the "Worklist" table
      |Patient     |Date                  |Edits |Proc  |
      |DARR, MOLLY |%Current Date MMDDYY% |None  |0109T |

  @ChargeCapture
  Scenario: Validate Add Edit Delete Copy Print
    When I select "Add Charge" from the "Patient Header Actions" menu
    Then the following fields should display in the "Charge Entry" pane
      |Name           |Type   |
      |Visit Details  |button |
      |Validate       |button |
      |Print          |button |
      |Submit         |button |
      |Submit Draft   |button |
      |Send to Outbox |button |
    And I click the "Close" image
    And I select "the first item" in the "Charges" table
    And I click the "Edit.." button in the "Charge Detail.." pane
    And I wait for loading to complete
    Then the following fields should display in the "Charge Entry" pane
      |Name                 |Type   |
      |Visit Details        |button |
      |Validate             |button |
      |Print                |button |
      |ChargeEntryDelete    |button |
      |Submit               |button |
      |Submit Draft         |button |
      |Send to Outbox       |button |
    And I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Pre-requisite : Validate Add Charge Clinical Actions Write Note - DEV-46951
    Given I am logged into the portal with user "pkadmin" using the default password
    And the "Progress Note" template is loaded
    And the "History and Physical" template is loaded
    When I select the "Department" subtab
    And I select the department "Verve"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "NoteWriter" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
    And I click the "Note Pickers" edit link in the "Note Writer Settings" pane
    And the following note pickers should be available for the "Verve" department
      |Progress Note        |
      |History and Physical |
    And I click the "Close" button in the "Department Note Pickers" pane

  @ChargeCapture
  Scenario: Validate Add Charge Clinical Actions Write Note - DEV-46951
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Add Charge" section
    And I wait "4" seconds
    And I set the following charge headers in the "NoteWriterChargeEntry" pane
      |Name         |Value            |
      |Bill Area    |Verve            |
      |Billing Prov |USER3, ADDCHARGE |
      |Svc Site     |Inpatient        |
    #And I enter the ICD-9 code "111.0" in the "NoteWriterChargeEntry" pane
    And I enter the ICD-10 codes "B36.0" in the "NoteWriterChargeEntry" pane
    And I enter the CPT codes "30020" in the "NoteWriterChargeEntry" pane
    And I select the note "A/P" section
    And I select "High" from the "LevelOfDecision" dropdown
    And I click the "NoteWriterSign/Submit" button in the "NoteWriter Main" pane
    #And I click the "Yes" button in the "Sign/Submit" pane
    #And I sign/submit the note
    And I click the "Warning OK" button in the "Warning Message" pane
    Then I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I click the "SaveAsIs" button if it exists
    And I click the "OK" button in the "SubmitNote" pane
    And I select "Charges" from clinical navigation
    #make sure we're looking at the most recent
    And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
    Then the following rows should appear in the "Charges" table
      |Date/Time             |Prov/Team        |Proc                          |Diag  |
      |%Current Date MMDDYY% |USER3, ADDCHARGE |30020 drainage of nose lesion |B36.0 |

  @ChargeCapture
  Scenario: Validate AddCharge Search
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |Verve            |
      |Billing Prov |USER3, ADDCHARGE |
      |Svc Site     |Inpatient        |
    And I enter the CPT codes "01462"
    #And I enter the ICD-10 code "111.0"
    And I enter the ICD-10 codes "B36.0"
    And I click the "Submit" button
    And I wait for loading to complete
    And I am on the "Charges" tab
    And I select the "Search" subtab
    And I click the "Back To Criteria" button if it exists
    And I click the "Reset Criteria" button in the "ChargeSearch" pane
    And I select "Today" from the "Timeframe" dropdown in the "Charge Search" pane
    And I wait "2" seconds
    And I check the "My Charges Only" checkbox in the "Charge Search" pane
    And I click the "Show Charges" button in the "Charge Search" pane
    #make sure we're looking at the most recent
    And I wait "2" seconds
    And I sort the "Charge Search Results" table chronologically by the "Date" column in "Descending" order
    Then rows containing the following should appear in the "Charge Search Results" table
      |Patient     |Date                  |Edits |Proc  |
      |DARR, MOLLY |%Current Date MMDDYY% |None  |01462 |

  @ChargeCapture @Demo
  Scenario: Validate EditCharge In HoldingBin
  #Login as Level2 user, since Level 3 user cannot access Holding Bin tab
    Given I am logged into the portal with user "addchargeuser2" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Charges" from clinical navigation
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |Verve            |
      |Billing Prov |USER2, ADDCHARGE |
      |Svc Site     |Inpatient        |
    And I enter the CPT codes "01462"
    #And I enter the ICD-9 code "111.0"
    And I enter the ICD-10 codes "B36.0"
    And I click the "Submit" button
    And I wait for loading to complete
    And I am on the "Charges" tab
    And I select the "Holding Bin" subtab
    And I click the "Reset Criteria" button in the "Holding Bin" pane
    And I select "Today" from the "Timeframe" dropdown in the "Holding Bin" pane
    And I check the "My Charges Only" checkbox in the "Holding Bin" pane
    And I click the "Show Charges" button in the "Holding Bin" pane
    #make sure we're looking at the most recent
    And I sort the "Holding Bin" table chronologically by the "Date" column in "Descending" order
    Then rows containing the following should appear in the "Holding Bin" table
      |Patient     |Date                  |Edits |Proc  |
      |DARR, MOLLY |%Current Date MMDDYY% |None  |01462 |
    When I click the "None" link in the "Holding Bin Results" pane
    And I wait "2" seconds
    And I remove the "01462" CPT code
    And I enter the CPT codes "30000"
   #And I remove the "111.0" ICD-9 code
    And I remove the "B36.0" ICD-10 code
   #And I enter the ICD-9 code "111.0"
    And I enter the ICD-10 codes "B36.0"
    And I click the "Submit" button
    And I wait for loading to complete
    Then rows containing the following should appear in the "Holding Bin" table
      |Patient     |Date                  |Edits |Proc  |
      |DARR, MOLLY |%Current Date MMDDYY% |None  |30000 |

  @ChargeCapture @Demo
  Scenario: Add Time with Patient, Injury Date, Injury Type
    When I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I wait for loading to complete
    And I enter "8" in the "TimewithPatient" field
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |Verve            |
      |Billing Prov |USER3, ADDCHARGE |
      |Svc Site     |Inpatient        |
      |Injury Type  |MVA              |
    And I enter "%Current Date MMDDYYYY%" in the "InjuryDate" field
   #When I enter the ICD-9 code "780.96"
    When I enter the ICD-10 codes "R52"
    Then the text "R52" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    When I enter the CPT codes "86000"
    Then the text "86000" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button
    And I wait for loading to complete
    Then the following rows should appear in the "Charges" table
      |Proc                      |Qty |Diag |
      |86000 agglutinins febrile |1   |R52  |

  @ChargeCapture @Demo
  Scenario: Submit draft
    When I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |Verve            |
      |Billing Prov |USER3, ADDCHARGE |
      |Svc Site     |Inpatient        |
    And I enter the CPT codes "01250"
    And I click the "SubmitDraft" button
    And I wait for loading to complete
    #make sure we're looking at the most recent
    And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
    And I select "the first item" in the "Charges" table
    Then the text "Draft" should appear in the "ChargeDetail.." pane
