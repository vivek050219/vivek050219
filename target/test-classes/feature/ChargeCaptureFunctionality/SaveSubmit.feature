@savecharge
Feature: Save charge transaction

  Background:
    Given I am logged into the portal with user "submitsaveuser3" using the default password
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "SaveSubmit List" owned by "submitsaveuser3" with the following parameters
      | Type   | Name              | Value      |
      | Filter | Medical Service   | Card Group |
    And I click the "Refresh Patient List" button
    And I select "SaveSubmit List" from the "Patient List" menu


  @savecharge
  Scenario: 1. Pre-Requisite - Copy charge Exclude free text when copying a transaction is set to Yes DEV-49767
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Patient List V2" tab
    #And I turn "off" all codeedits on "server"
    And I execute the "Disable All Code Edits" query
    And I am on the "Admin" tab
    And I open "Charge Capture" settings page for the user "submitsaveuser3"
    And I edit the following user settings and I click save
      | Page           | Name                                     | Type  | Value |
      | Patient List   | Auto select visit during Add activities  | radio | false |
      | Charge Capture | Copy Diagnoses on Copied Transactions    | radio | false |
      | Charge Capture | Copy Modifiers on Copied Transactions    | radio | false |
      | Charge Capture | Exclude Free Text on Copied Transactions | radio | true  |
      | Charge Capture | Allow Free Text Diagnoses                | radio | true  |


  @savecharge
  Scenario: 2. Copy charge Exclude free text when copying a transaction is set to Yes DEV-49767
    Given "SAVE SUBMIT1" is on the patient list
    And I select patient "SAVE SUBMIT1" from the patient list
    And I select "Charges" from clinical navigation
    And I "uncheck" the following checkbox in the "Charges" pane
      | Show Visits |
    And I select "Last 24 Hours" from the "ClinicalTimeframe" menu
    And patient "SAVE SUBMIT1" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value                   |
      | Bill Area    | submitsave              |
      | Billing Prov | SUBMIT3, SAVE           |
      | Svc Site     | Inpatient               |
      | Date         | %Current Date MMDDYYYY% |
#    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button
    And I enter "ffff" in the "Diagnosis Search" field in the "Charge Entry" pane
    And I wait "2" seconds
    And I click the "Add as Free Text" link in the "Diagnoses Search Header Container" section in the "Charge Entry" pane
    And I enter the CPT codes "62200"
    Then the text "62200" should appear in the "Charge List" section in the "Charge Entry" pane
    And the text "ffff" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    When I click the "Submit" button in the "Charge Entry" pane
    Then the text "The charge transaction has been saved as a COMPLETED transaction, but code edits now exist. Choose the next step." should appear in the "Confirm" pane
#    When I click the "Save As Is" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I refresh the clinical display
    And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
    Then rows containing the following should appear in the "Charges" table
      |Date/Time             |Proc         |Diag      |
      |%Current Date MMDDYY% |brain cavity |Free Text |
    When I click the "Copy" button in the "Charge Detail" pane
    Then the following fields should display in the "Charge Entry" pane
      |Name         |Type   |
      |Submit       |button |
      |Submit Draft |button |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button
    And the text "62200" should appear in the "Charge List" section in the "Charge Entry" pane
    And the text "ffff" should not appear in the "Diagnosis List" section in the "Charge Entry" pane
    When I enter the ICD-10 codes "B65.0"
    And the text "B65.0" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    When I click the "Submit" button
    Then rows containing the following should appear in the "Charges" table
      |Date/Time             |Proc         |Diag  |
      |%Current Date MMDDYY% |brain cavity |B65.0 |


  @savecharge
  Scenario: 3. Pre-Requisite - Copy charge Exclude free text when copying a transaction set to No DEV-49767
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I open "Charge Capture" settings page for the user "submitsaveuser3"
    And I edit the following user settings and I click save
      | Page           | Name                                     | Type  | Value |
      | Charge Capture | Exclude Free Text on Copied Transactions | radio | false |
      | Charge Capture | Copy Diagnoses on Copied Transactions    | radio | true  |


  #TODO: Dependent on the above scenario. Radio button in above scenario need to be set before executing this scenario.
  @savecharge
  Scenario: 4. Copy charge Exclude free text when copying a transaction set to No DEV-49767
    When I select patient "SAVE SUBMIT1" from the patient list
    And patient "SAVE SUBMIT1" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value         |
      | Bill Area    | submitsave    |
      | Billing Prov | SUBMIT3, SAVE |
      | Svc Site     | Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button
    And I enter "ppp" in the "Diagnosis Search" field in the "Charge Entry" pane
    And I wait "2" seconds
    And I click the "Add as Free Text" link in the "Diagnoses Search Header Container" section in the "Charge Entry" pane
    And I enter the CPT codes "78000"
    Then the text "ppp" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    When I click the "Submit" button in the "Charge Entry" pane
    Then the text "The charge transaction has been saved as a COMPLETED transaction, but code edits now exist. Choose the next step." should appear in the "Confirm" pane
#    When I click the "Save As Is" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I wait "2" seconds
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    And I click the "Copy" button in the "Charge Detail" pane
    Then the following fields should display in the "Charge Entry" pane
      |Name         |Type                     |
      |Submit       |button                   |
      |Submit Draft |button                   |
      |Date	        |%Current Date MMDDYYYY%  |
#    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    Then the text "ppp" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    When I remove the "ppp" ICD-10 code
    And I enter the ICD-10 codes "S02.0XXA"
    Then the text "S02.0XXA" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    When I click the "Submit" button
    And I wait "2" seconds
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    Then rows containing the following should appear in the "Charges" table
      |Date/Time             |Proc    |Diag     |
      |%Current Date MMDDYY% |thyroid |S02.0XXA |


  @savecharge
  Scenario: 5. Pre-Requisite - Create a New Transaction when the previous transaction has only Flagged Diag codes
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I open "Charge Capture" settings page for the user "submitsaveuser3"
    And I edit the following user settings and I click save
      | Page           | Name                                                | Type     | Value            |
      | Charge Capture | Allow Free Text Diagnoses                           | radio    | true             |
      | Charge Capture | Exclude Flagged Diag Charges on Copied Transactions | radio    | true             |
      | Charge Capture | Copy Diagnoses on New Transaction                   | dropdown | Copy from charge |
      | Charge Capture | Set Charge Desktop View Access                      | dropdown | All Charges      |
      | Charge Capture | Set Patient List Charge View Access                 | dropdown | All Charges      |
      | Charge Capture | Reviewing Provider                                  | radio    | true             |
      | Charge Capture | State of Hold for Review Checkbox                   | dropdown | Show, Unchecked  |
      | Charge Capture | Allow User to Add Edit Charges on Web               | radio    | true             |
      | Charge Capture | Allow Free Text Charges                             | radio    | true             |
      | Charge Capture | Copy Diagnoses on Copied Transactions               | radio    | false            |


  @savecharge
  Scenario: 6. Create a New Transaction when the previous transaction has only Flagged Diag codes
    Given "SAVE SUBMIT5" is on the patient list
    When I select patient "SAVE SUBMIT5" from the patient list
    And patient "SAVE SUBMIT5" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value         |
      | Bill Area    | submitsave    |
      | Billing Prov | SUBMIT3, SAVE |
      | Svc Site     | Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "86000"
    And I enter the ICD-10 codes "3111"
    Then the text "3111" should appear in the "Charge List" section in the "Charge Entry" pane
    Then the text "86000" should appear in the "Charge List" section in the "Charge Entry" pane
    And I click the "Submit" button
    And I wait "2" seconds
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    When I click the "Edit" button in the "Charge Detail" pane
    And I enter the ICD-10 codes "A48.0"
    Then the text "A48.0" should appear in the "Charge List" section in the "Charge Entry" pane
    And the text "86000" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button
    And I wait "2" seconds
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    Then the following text should appear in the "Charge Detail" pane
      |febrile |
      |A48.0   |
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I open "Charge Capture" settings page for the user "submitsaveuser3"
    And I edit the following user settings and I click save
      | Page           | Name                              | Type     | Value |
      | Charge Capture | Copy Diagnoses on New Transaction | dropdown | No    |


  #TODO: Dependent on previous scenarios. ICD-10 code edits should be added prior to the execution of this scenario.
  @savecharge
  Scenario: 7. Continue editing in the charge capture
    When I select patient "SAVE SUBMIT5" from the patient list
    And I select "the first item" in the "Charges" table
    #When I select "120.0" from the "Diag" column in the "Charges" table
    And I click the "Edit" button in the "Charge Detail" pane
    And I wait "2" seconds
    When I remove all the ICD-10 codes
    And I click the "Submit" button in the "Charge Entry" pane
    #Then the "Confirm" pane should load
    And the following text should appear in the "Confirm" pane
      | The charge transaction has been saved as a COMPLETED transaction, but code edits now exist. Choose the next step. |
    And the following fields should display in the "Confirm" pane
      | Name                  | Type   |
      | Continue Editing      | button |
      | Confirm Save as Draft | button |
      | Save As Is            | button |
    When I click the "Continue Editing" button
    When I enter the ICD-10 codes "B65.0"
    And I click the "Submit" button
    And I refresh the clinical display
    Then rows containing the following should appear in the "Charges" table
      | Date/Time             | Proc    | Diag  |
      | %Current Date MMDDYY% | febrile | B65.0 |


  @savecharge
  Scenario Outline: 8. Allow Free Text Diagnoses set to Yes test for level 1, 2 and 3
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I open "Charge Capture" settings page for the user "<UserName>"
    And I edit the following user settings and I click save
      |Page           |Name                      |Type  |Value |
      |Charge Capture |Allow Free Text Diagnoses |radio |true  |
    When I am logged into the portal with user "<UserName>" using the default password
    And I am on the "Patient List V2" tab
    And I select "SaveSubmit List" from the "Patient List" menu
    And "<Patient>" is on the patient list
    And I select patient "<Patient>" from the patient list
    And patient "<Patient>" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value              |
      |Bill Area    |submitsave         |
      |Billing Prov |<Billing Provider> |
      |Svc Site     |Inpatient          |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button
    And I enter "fff" in the "Diagnosis Search" field in the "Charge Entry" pane
    And I wait "2" seconds
    Then the following text should appear in the "Charge Entry" pane
      |Add as Free Text |
    And I click the "Add as Free Text" link in the "Diagnoses Search Header Container" section in the "Charge Entry" pane
    And I enter the CPT codes "62223"
    Then the text "fff" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    When I click the "Submit" button in the "Charge Entry" pane
    #Then the "Confirm" pane should load
    And the following fields should display in the "Confirm" pane
      |Name             |Type   |
      |Continue Editing |button |
      |Save As Is       |button |
    And I click the "Save As Is" button in the "Confirm" pane
    And I refresh the clinical display
    And I wait "2" seconds
    Then rows containing the following should appear in the "Charges" table
      |Date/Time             |Proc         |Diag      |
      |%Current Date MMDDYY% |brain cavity |Free Text |

    Examples:
      | UserName        | Patient      | Billing Provider |
      | submitsaveuser1 | SAVE SUBMIT3 | SUBMIT1, SAVE    |
      | submitsaveuser2 | SAVE SUBMIT2 | SUBMIT2, SAVE    |
      | submitsaveuser3 | SAVE SUBMIT4 | SUBMIT3, SAVE    |


  @savecharge
  Scenario: 9. Pre-Requisite - Create a New Transaction when the previous transaction has both Flagged and Unflagged Diag codes
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I open "Charge Capture" settings page for the user "submitsaveuser3"
    And I edit the following user settings and I click save
      | Page           | Name                                  | Type  | Value |
      | Charge Capture | Copy Diagnoses on Copied Transactions | radio | true  |

  @savecharge
  Scenario: 10. Create a New Transaction when the previous transaction has both Flagged and Unflagged Diag codes
    When "SAVE SUBMIT2" is on the patient list
    And I select patient "SAVE SUBMIT2" from the patient list
    And patient "SAVE SUBMIT2" has no charges
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value         |
      | Bill Area    | submitsave    |
      | Billing Prov | SUBMIT3, SAVE |
      | Svc Site     | Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button
    And I enter the ICD-10 codes "12345"
    And I enter the ICD-10 codes "3111"
    Then the text "12345" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And the text "3111" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And I enter the CPT codes "62294"
    Then the text "62294" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button
    Then rows containing the following should appear in the "Charges" table
      | Date/Time             | Proc               | Diag        |
      | %Current Date MMDDYY% | into spinal artery | 12345 3111  |
#      |                       |                    | 3111        |
    And I refresh the clinical display
    And I wait "3" seconds
    And I select "the first item" in the "Charges" table
    When I click the "Copy" button in the "Charge Detail" pane
    Then the text "12345" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And the text "62294" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button
    Then rows containing the following should appear in the "Charges" table
      |Date/Time             |Proc               |Diag  |
      |%Current Date MMDDYY% |into spinal artery |12345 |


  @savecharge
  Scenario: 11. Pre-Requisite Copy a Transaction having both Free Text and coded Diag Charges DEV-49767
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I open "Charge Capture" settings page for the user "submitsaveuser3"
    And I edit the following user settings and I click save
      | Page           | Name                                     | Type  | Value |
      | Charge Capture | Exclude Free Text on Copied Transactions | radio | false |

  @savecharge
  Scenario: 12. Copy a Transaction having both Free Text and coded Diag Charges DEV-49767
    When I select patient "SAVE SUBMIT1" from the patient list
    And patient "SAVE SUBMIT1" has no charges
    And I select "Charges" from clinical navigation
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value         |
      | Bill Area    | submitsave    |
      | Billing Prov | SUBMIT3, SAVE |
      | Svc Site     | Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button
    And I enter the ICD-10 codes "S02.0XXA"
    And I enter "ssss" in the "Diagnosis Search" field in the "Charge Entry" pane
    And I wait "2" seconds
    Then the following text should appear in the "Charge Entry" pane
      |Add as Free Text |
   When I click the "Add as Free Text" link in the "Diagnoses Search Header Container" section in the "Charge Entry" pane
#    When I click the "Add As Free Text" element in the "Diagnoses Search Header Container" section in the "Charge Entry" pane
    And the text "ssss" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And the text "S02.0XXA" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And I enter the CPT codes "62263"
    Then the text "62263" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button in the "Charge Entry" pane
    Then the following fields should display in the "Confirm" pane
      |Name                |Type   |
      |Continue Editing    |button |
      |Save As Is          |button |
#    When I click the "Save As Is" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I refresh the clinical display
    And I wait "2" seconds
    Then rows containing the following should appear in the "Charges" table
      |Date/Time             |Proc                |Diag      |
      |%Current Date MMDDYY% |lysis mult sessions |Free Text |
    When I refresh the clinical display
    And I wait "3" seconds
    And I select "the first item" in the "Charges" table
    When I click the "Copy" button in the "Charge Detail" pane
    Then the text "ssss" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And the text "S02.0XXA" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And the text "62263" should appear in the "Charge List" section in the "Charge Entry" pane
    And I click the "Close" image

  @savecharge
  Scenario: 13. Pre-Requisite - Copy a Transaction having both Flagged and Unflagged Diagnoses Charges codes
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I open "Charge Capture" settings page for the user "submitsaveuser3"
    When I edit the following user settings and I click save
      | Page           | Name                                                | Type  | Value |
      | Charge Capture | Exclude Flagged Diag Charges on Copied Transactions | radio | false |

  @savecharge
  Scenario: 14. Copy a Transaction having both Flagged and Unflagged Diagnoses Charges codes
    When "SAVE SUBMIT3" is on the patient list
    And patient "SAVE SUBMIT3" has no charges
    And I select patient "SAVE SUBMIT3" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value         |
      | Bill Area    | submitsave    |
      | Billing Prov | SUBMIT3, SAVE |
      | Svc Site     | Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button
    And I enter the ICD-10 codes "12345"
    And I enter the ICD-10 codes "3111"
    Then the text "12345" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And the text "3111" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And I enter the CPT codes "41110"
    And I enter the CPT codes "62264"
    Then the text "41110" should appear in the "Charge List" section in the "Charge Entry" pane
    And the text "62264" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button
    And I refresh the clinical display
    And I wait "2" seconds
    And I select "the first item" in the "Charges" table
    When I click the "Copy" button in the "Charge Detail" pane
    Then the text "12345" should appear in the "Charge List" section in the "Charge Entry" pane
    And the text "3111" should appear in the "Charge List" section in the "Charge Entry" pane
    And the text "62264" should appear in the "Charge List" section in the "Charge Entry" pane
    And the text "41110" should appear in the "Charge List" section in the "Charge Entry" pane
    And I click the "Close" image

  @savecharge
  Scenario: 15. Create a New Transaction when the previous transaction has both Flagged and Un flagged Diag codes
    When "SAVE SUBMIT1" is on the patient list
    And patient "SAVE SUBMIT1" has no charges
    When I select patient "SAVE SUBMIT1" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value         |
      | Bill Area    | submitsave    |
      | Billing Prov | SUBMIT3, SAVE |
      | Svc Site     | Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button
    And I enter the ICD-10 codes "12345" in the "Charge Entry" pane
    And I enter the ICD-10 codes "3111" in the "Charge Entry" pane
    Then the text "12345" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And the text "3111" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And I enter the CPT codes "62267"
    Then the text "62267" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button
    And I click the "Save As Is" button if it exists
    And I refresh the clinical display
    And I wait "2" seconds
    And I select "the first item" in the "Charges" table
    And I click the "Edit" button in the "Charge Detail" pane
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button
    Then the following text should appear in the "Charge Entry" pane
      |Charges                         |
      |12345                           |
      |3111                            |
    And I enter "62268" in the "Charge Search" field in the "Charge Entry" pane
    And I click the "Submit" button
    And I wait "2" seconds

  #No: 16
  @savecharge
  Scenario: 16. Level 3 user message flag for hold for review
    When patient "SAVE SUBMIT3" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value         |
      |Bill Area    |submitsave    |
      |Billing Prov |SUBMIT3, SAVE |
      |Svc Site     |Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "86001"
    And I enter the ICD-10 codes "A95.0"
    Then the text "A95.0" should appear in the "Charge List" section in the "Charge Entry" pane
    Then the text "86001" should appear in the "Charge List" section in the "Charge Entry" pane
    When I "check" the following checkbox in the "Charge Entry" pane
      |Hold For Review|
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Then rows containing the following should appear in the "Charges" table
      |Diag  |
      |A95.0 |
    When I am on the "Charges" tab
    And I select the "Worklist" subtab
    And I click the "Reset Criteria" button in the "Worklist" pane
    And I select "Today" from the "Timeframe" dropdown in the "Worklist" pane
    And I select "Held for Review" from the "Filter" dropdown in the "Worklist" pane
    And I check the "My Charges Only" checkbox in the "Worklist" pane
    And I click the "Refresh Worklist" button in the "Worklist" pane
    Then rows containing the following should appear in the "Worklist" table
      |Patient        |Date                  |Edits           |Diag  |
      | SUBMIT3, SAVE | %Current Date MMDDYY% | Held for Review | A95.0 |


  #No: 17
  @savecharge
  Scenario: 17. Setup testcase to turn on all codeedits on user server
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Patient List V2" tab
    #And I turn "on" all codeedits on "server"
    And I execute the "Enable All Code Edits" query


  #No: 18 - Obsolete.  'Allow FreeText Error to go To Outbox' is no longer available to level 3 users.
  @savecharge @donotrun
  Scenario: 18. Types of Charges Sent to Holding Bin Errors only DEV-51476 [DEV-53615] [AUTO-191]
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    When I select "Charge Capture" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I select "true" from the "Allow Free Text Errors To Go To Outbox" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "2" seconds
    And I open "Charge Capture" settings page for the user "savesubmitlevel3"
    And I edit the following user settings and I click save
      | Page           | Name                                                                           | Type  | Value |
      | Charge Capture | Send All Transactions to Holding Bin                                           | radio | false |
      | Charge Capture | Send Transactions with Validity Errors or Non-Forced Code Edits to Holding Bin | radio | false |
      | Charge Capture | Send Transactions with Free Text to Holding Bin                                | radio | false |
      | Charge Capture | Send Transactions with Comments to Holding Bin                                 | radio | false |
      | Charge Capture | Send Imported Transactions to Holding Bin                                      | radio | false |
    And I click the "Save" button
    And I click "OK" in the confirmation box
    When I select the "Department" subtab
    And I select the department "savecheckall"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
    And I edit the following user settings and I click save
      | Page           | Name                                                                           | Type  | Value |
      | Charge Capture | Send All Transactions to Holding Bin                                           | radio | false |
      | Charge Capture | Send Transactions with Validity Errors or Non-Forced Code Edits to Holding Bin | radio | true  |
      | Charge Capture | Send Transactions with Free Text to Holding Bin                                | radio | false |
      | Charge Capture | Send Transactions with Comments to Holding Bin                                 | radio | false |
      | Charge Capture | Send Imported Transactions to Holding Bin                                      | radio | false |
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "2" seconds
    When I select the "System Management" subtab
    And I click the "Misc" link in the "System Management Navigation" pane
    And I click the "ClearWebSessionCaches" button
    And I click the "OK" button in the "Information" pane
    And I click the "PurgeMobilizerCache" button
    And I click the "OK" button in the "Information" pane
    Given I am logged into the portal with user "savesubmitlevel3" using the default password
    And I am on the "Patient List V2" tab
    And I select "SaveSubmit List" from the "Patient List" menu
    And "Molly Darr", admitted in the last "" days, is on the patient list
    And patient "Molly Darr" has no charges
    And I select patient "Molly Darr" from the patient list
    And I select "Last 24 Hours" from the "ClinicalTimeframe" menu
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value        |
      |Bill Area    |savecheckall |
      |Billing Prov |SUBMIT, SAVE |
      |Svc Site     |Inpatient    |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "86000"
    And I enter the ICD-10 codes "M46.1"
    Then the text "M46.1" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    When I click the "Submit" button
    And I click the "SaveAsIs" button if it exists
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    Then the text "Outbox" should appear in the "Charge Detail" pane
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the ICD-10 codes "M46.1"
    And I enter the CPT codes "11451"
    And I enter the CPT codes "11451"
    Then the text "M46.1" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    When I click the "Submit" button in the "Charge Entry" pane
    #Then the "Confirm" pane should load
    And I click the "ConfirmYes" button if it exists
    And I click the "SaveAsIs" button if it exists
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    Then the text "Holding Bin" should appear in the "Charge Detail" pane
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I enter "fever" in the "Diagnosis Search" field in the "Charge Entry" pane
    And I wait "2" seconds
    And I click the "Add as Free Text" link in the "Diagnoses Search Header Container" section in the "Charge Entry" pane
    And I enter the CPT codes "86001"
    Then the text "fever" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    When I click the "Submit" button
    And I click the "SaveAsIs" button if it exists
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    Then the text "Holding Bin" should appear in the "Charge Detail" pane



  #No: 19
  #TODO: Added the last step of confirming whether the pane is getting loaded or not.
  @savecharge
  Scenario:  19. Post-Requisite
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    When I select "Charge Capture" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I select "false" from the "AllowFreeTextErrorsToGoToOutbox" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box
    Then the "Institution Settings" pane should load


  #No: 20
  #TODO: Error: "Then the "Confirm" pane should load" step is failing. Confirm pane is not displayed and hence have commented the same. Test Case passing after commenting the step.
  @savecharge
  Scenario: 20. Types of Charges Sent to Holding Bin Free Text only
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Department" subtab
    And I select the department "savecheckall"
    And I click the "Edit" button in the "Quick Details" pane
    Then the text "Edit Department:" should appear in the "Edit Department" pane
    And I select "Charge Capture" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
    And I edit the following user settings and I click save
      | Page           | Name                                                                           | Type  | Value |
      | Charge Capture | Send All Transactions to Holding Bin                                           | radio | false |
      | Charge Capture | Send Transactions with Validity Errors or Non-Forced Code Edits to Holding Bin | radio | false |
      | Charge Capture | Send Transactions with Free Text to Holding Bin                                | radio | true  |
      | Charge Capture | Send Transactions with Comments to Holding Bin                                 | radio | false |
      | Charge Capture | Send Imported Transactions to Holding Bin                                      | radio | false |
    And I click the "Save" button
    And I click "OK" in the confirmation box
#    And I wait "4" seconds
    When I select the "System Management" subtab
    And I click the "Misc" link in the "System Management Navigation" pane
    And I click the "ClearWebSessionCaches" button
    And I click the "OK" button in the "Information" pane
    And I click the "PurgeMobilizerCache" button
    And I click the "OK" button in the "Information" pane
#    And I wait "2" seconds
    Given I am logged into the portal with user "savesubmitlevel3" using the default password
    And I am on the "PatientList V2" tab
    And I select "SaveSubmit List" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And patient "Molly Darr" has no charges
    And I select patient "Molly Darr" from the patient list
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value        |
      |Bill Area    |savecheckall |
      |Billing Prov |SUBMIT, SAVE |
      |Svc Site     |Inpatient    |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "86003"
    And I enter the ICD-10 codes "R61"
    Then the text "86003" should appear in the "Charge List" section in the "Charge Entry" pane
    And the text "R61" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    When I click the "Submit" button
#    Then the "Confirm" pane should load
    And I click the "ConfirmNo" button if it exists
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    Then the text "Outbox" should appear in the "Charge Detail" pane
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the ICD-10 codes "R68.89"
    And I enter the CPT codes "11451"
    And I enter the CPT codes "11451"
    Then the text "R68.89" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    When I click the "Submit" button
    And I click the "ConfirmNo" button if it exists
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    Then the text "Outbox" should appear in the "Charge Detail" pane
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I wait "2" seconds
    And I enter "fff" in the "Diagnosis Search" field in the "Charge Entry" pane
    And I wait "3" seconds
    And I click the "Add as Free Text" link in the "Diagnoses Search Header Container" section in the "Charge Entry" pane
    And I enter the CPT codes "86021"
    Then the text "fff" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    When I click the "Submit" button
    And I click the "ConfirmYes" button if it exists
#    And I click the "SaveAsIs" button if it exists
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    Then the text "Holding Bin" should appear in the "Charge Detail" pane


  #No: 21
  @savecharge
  Scenario: 21. Types of Charges Sent to Holding Bin Errors & Free Text
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Department" subtab
    And I select the department "savecheckall"
    And I click the "Edit" button in the "Quick Details" pane
    Then the text "Edit Department:" should appear in the "Edit Department" pane
    And I select "Charge Capture" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
    And I edit the following user settings and I click save
      | Page           | Name                                                                           | Type  | Value |
      | Charge Capture | Send All Transactions to Holding Bin                                           | radio | false |
      | Charge Capture | Send Transactions with Validity Errors or Non-Forced Code Edits to Holding Bin | radio | true  |
      | Charge Capture | Send Transactions with Free Text to Holding Bin                                | radio | true  |
      | Charge Capture | Send Transactions with Comments to Holding Bin                                 | radio | false |
      | Charge Capture | Send Imported Transactions to Holding Bin                                      | radio | false |
    And I click the "Save" button
    And I click "OK" in the confirmation box
#    And I wait "2" seconds
    When I select the "System Management" subtab
    And I click the "Misc" link in the "System Management Navigation" pane
    And I click the "ClearWebSessionCaches" button
    And I click the "OK" button in the "Information" pane
    And I click the "PurgeMobilizerCache" button
    And I click the "OK" button in the "Information" pane
    Given I am logged into the portal with user "savesubmitlevel3" using the default password
    And I am on the "Patient List V2" tab
    And I select "SaveSubmit List" from the "Patient List" menu
    When patient "Molly Darr" has no charges
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value        |
      |Bill Area    |savecheckall |
      |Billing Prov |SUBMIT, SAVE |
      |Svc Site     |Inpatient    |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "86005"
    And I enter the ICD-10 codes "R56.00"
    Then the text "R56.00" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    When I click the "Submit" button
    And I click the "ConfirmNo" button if it exists
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    Then the text "Outbox" should appear in the "Charge Detail" pane
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the ICD-10 codes "R56.00"
    And I enter the CPT codes "11451"
    And I enter the CPT codes "11451"
    Then the text "R56.00" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    When I click the "Submit" button
#    And I click the "ConfirmYes" button if it exists
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    Then the text "Holding Bin" should appear in the "Charge Detail" pane
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I enter "fever" in the "Diagnosis Search" field in the "Charge Entry" pane
    And I wait "2" seconds
    When I click the "Add As Free Text" element in the "Diagnoses Search Header Container" section in the "Charge Entry" pane
    And I enter the CPT codes "86023"
    Then the text "fever" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    When I click the "Submit" button
#    And I click the "SaveAsIs" button if it exists
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    When I select "Free Text" from the "Diag" column in the "Charges" table
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    Then the text "Holding Bin" should appear in the "Charge Detail" pane


  #No: 22
  @savecharge
  Scenario: 22. Pre-Requisite - Edit the Holding bin charge beyond the visit date as level3 user
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Patient List V2" tab
    #When I turn "off" all codeedits on "server"
    And I execute the "Disable All Code Edits" query
    And I am on the "Admin" tab
    And I open "Charge Capture" settings page for the user "submitsaveuser3"
    And I enter "5" in the "DaysBeyondtheVisitEndtoAllowEditingaCharge" field
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "2" seconds
    Then the "User Preferences" pane should load
    And I click the logout button

  #No: 23
  @savecharge
  Scenario: 23. Edit the Holding bin charge beyond the visit date as level3 user
    When "SAVE SUBMIT4" is on the patient list
    And I select patient "SAVE SUBMIT4" from the patient list
    And patient "SAVE SUBMIT4" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value         |
      | Bill Area    | submitsave    |
      | Billing Prov | SUBMIT3, SAVE |
      | Svc Site     | Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "01250"
    And I enter the ICD-10 codes "B36.0"
    And I click the "Submit" button
    And I wait "2" seconds
    And I select "01250 anesth upper leg surgery" from the "Proc" column in the "Charges" table
    And I click the "Edit" button
    And I wait "2" seconds
    And I enter "%56 days ago MMDDYYYY%" in the "Date" field
    And I click the "DiagnosisSearch" element
    And I click the "Submit" button in the "Charge Entry" pane
    Then the following fields should display in the "Confirm" pane
      |Name                |Type   |
      |Continue Editing    |button |
    And I click the "Continue Editing" button
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "DiagnosisSearch" element
    And I click the "Submit" button
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    Then the text "Holding Bin" should appear in the "Charge Detail" pane
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "submitsaveuser3"
    And I select the user "submitsaveuser3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I enter "50" in the "DaysBeyondtheVisitEndtoAllowEditingaCharge" field
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "2" seconds


  #No: 24
  #TODO: Added "And I enter "%Current Date MMDDYYYY%" in the "Date" field"
  @savecharge
  Scenario: 24. Edit the Holding bin charge beyond the visit date as level2 user
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I open "Charge Capture" settings page for the user "submitsaveuser2"
    And I enter "5" in the "DaysBeyondtheVisitEndtoAllowEditingaCharge" field
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "2" seconds
    Given I am logged into the portal with user "submitsaveuser2" using the default password
    And I am on the "Patient List V2" tab
    And I select "SaveSubmit List" from the "Patient List" menu
    And "SAVE SUBMIT1" is on the patient list
    And I select patient "SAVE SUBMIT1" from the patient list
    And I select "Charges" from clinical navigation
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value         |
      | Bill Area    | submitsave    |
      | Billing Prov | SUBMIT2, SAVE |
      | Svc Site     | Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "01250"
    And I enter the ICD-10 codes "B36.0"
    And I click the "Submit" button
    And I wait "2" seconds
    And I select "01250 anesth upper leg surgery" from the "Proc" column in the "Charges" table
    And I click the "Edit" button
    And I wait "2" seconds
    And I enter "%66 days ago MMDDYYYY%" in the "Date" field
    And I click the "DiagnosisSearch" element
    And I click the "Submit" button
    And I wait "3" seconds
    Then the following fields should display in the "Confirm" pane
      |Name                |Type   |
      |Continue Editing    |button |
      |ConfirmSaveasDraft  |button |
      |Save As Is          |button |
    And I click the "Continue Editing" button
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "DiagnosisSearch" element
    And I click the "Submit" button
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    Then the text "Holding Bin" should appear in the "Charge Detail" pane
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "submitsaveuser2"
    And I select the user "submitsaveuser2"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I enter "50" in the "DaysBeyondtheVisitEndtoAllowEditingaCharge" field
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "2" seconds


  #No: 25
  @savecharge
  Scenario: 25. Edit the Holding bin charge beyond the visit date  as level1 user
    Given I am logged into the portal with user "submitsaveuser1" using the default password
    And I am on the "Admin" tab
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "EditPreferencesSettings" dropdown
    And I enter "5" in the "DaysBeyondtheVisitEndtoAllowEditingaCharge" field
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And I select "SaveSubmit List" from the "Patient List" menu
    And "SAVE SUBMIT1" is on the patient list
    And I select patient "SAVE SUBMIT1" from the patient list
#    And I "uncheck" the following
    And I "uncheck" the following checkbox in the "Charges" pane
      | Show Visits |
    And I select "Charges" from clinical navigation
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value         |
      | Bill Area    | submitsave    |
      | Billing Prov | SUBMIT1, SAVE |
      | Svc Site     | Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "01250" in the "Charge Entry" pane
    And I enter the ICD-10 codes "B36.0" in the "Charge Entry" pane
    And I click the "Submit" button
    And I wait "2" seconds
    And I select "01250 anesth upper leg surgery" from the "Proc" column in the "Charges" table
    And I click the "Edit" button
    And I wait "2" seconds
    And I enter "%66 days ago MMDDYYYY%" in the "Date" field
    And I click the "DiagnosisSearch" element
    And I click the "Submit" button in the "Charge Entry" pane
    #Then the "Confirm" pane should load
    And the following fields should display in the "Confirm" pane
      |Name             |Type   |
      |Continue Editing |button |
    And I click the "Continue Editing" button
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "DiagnosisSearch" element
    And I click the "Submit" button
    And I refresh the clinical display
    And I select "the first item" in the "Charges" table
    Then the text "Holding Bin" should appear in the "Charge Detail" pane
    And I am on the "Admin" tab
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "EditPreferencesSettings" dropdown
    And I enter "50" in the "DaysBeyondtheVisitEndtoAllowEditingaCharge" field
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "2" seconds


  #No: 26
  @savecharge
  Scenario: 26. Pre-Requisite
    Given I am logged into the portal with user "saveadmin" using the default password
    When I am on the "Admin" tab
    And I open "Charge Capture" settings page for the user "submitsaveuser3"
    And I wait "3" seconds
    And I edit the following user settings and I click save
      | Page           | Name                                                | Type     | Value                        |
      | Charge Capture | Copy Diagnoses on Copied Transactions               | radio    | true                         |
      | Charge Capture | Allow Free Text Diagnoses                           | radio    | false                        |
      | Charge Capture | Exclude Flagged Diag Charges on Copied Transactions | radio    | true                         |
      | Charge Capture | Copy Diagnoses on New Transaction                   | dropdown | No                           |
      | Charge Capture | Set Charge Desktop View Access                      | dropdown | Within the User's Department |
      | Charge Capture | Set Patient List Charge View Access                 | dropdown | Within the User's Department |
      | Charge Capture | Allow User to Add Edit Charges on Web               | radio    | true                         |
      | Charge Capture | Allow Free Text Charges                             | radio    | false                        |
      | Charge Capture | Reviewing Provider                                  | radio    | true                         |
      | Charge Capture | State of Hold for Review Checkbox                   | dropdown | Show, Unchecked              |


  #No: 27
  @savecharge
  Scenario: 27. Add Charge to This visit_Save a transaction as Hold for review
    When patient "SAVE SUBMIT1" has no charges
    And I select "Visits" from clinical navigation
    And I wait "2" seconds
    And I select "Inpatient" from the "Type" column in the "Visits" table
    And I click the "Add Charge to this Visit" button in the "Visit Detail" pane
    And I wait "3" seconds
    Then the following should be unchecked in the "Charge Entry" pane
      |Hold For Review |
    When I "check" the following checkbox in the "Charge Entry" pane
      |Hold For Review   |
    And I set the following charge headers
      |Name         |Value         |
      |Bill Area    |submitsave    |
      |Billing Prov |SUBMIT3, SAVE |
      |Svc Site     |Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "31050"
    And I enter the ICD-10 codes "K56.1"
    And I click the "Submit" button
    And I select "Charges" from clinical navigation
    And I select "the first item" in the "Charges" table
    Then the following text should appear in the "Charge Detail" pane
      |Status |Holding Bin |


  #No: 28
  @savecharge
  Scenario: 28. Saving if Diagnoses and CPT are added from search
    When patient "SAVE SUBMIT1" has no charges
    And I select "Visits" from clinical navigation
    And I wait "2" seconds
    And I select "Inpatient" from the "Type" column in the "Visits" table
    And I click the "Add Charge to this Visit" button in the "Visit Detail" pane
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value         |
      |Bill Area    |submitsave    |
      |Billing Prov |SUBMIT3, SAVE |
      |Svc Site     |Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "31040"
    And I enter the ICD-10 codes "B65.0"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I select "Charges" from clinical navigation
    Then the "Charges" table should have at least "1" row containing the text "B65.0"
    When I select "B65.0" from the "Diag" column in the "Charges" table
    Then the following text should appear in the "Charge Detail" pane
      |Charges                             |
      |31040 exploration behind upper jaw  |


  #No: 29
  #TODO: Added first three steps and two steps at last.
  @savecharge
  Scenario: 29. Require MRN Yes MRN entered
    And "SAVE SUBMIT1" is on the patient list
    And I select patient "SAVE SUBMIT1" from the patient list
    When I select "Patient Detail" from clinical navigation
    Then the following text should appear in the "Patient Detail" pane
      | MRN | 02615199 |
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value         |
      | Bill Area    | submitsave    |
      | Billing Prov | SUBMIT3, SAVE |
      | Svc Site     | Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "12001"
    And I enter the ICD-10 codes "B65.0"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I select "Charges" from clinical navigation
    And I select "the first item" in the "Charges" table
    Then the following text should appear in the "Charge Detail" pane
      |Charges                           |
      |12001 repair superficial wound(s)  |


  #No: 30
  @savecharge
  Scenario: 30. Saving a charge transaction with the macro
    When I am on the "Preferences" tab
    And I select "Charge Capture" from the "Edit Settings" dropdown in the "Personal Preference" pane
    And I click the "Add/Edit Charge Pickers" edit link in the "Preference CCSettings" pane
   #Delete existing pickers before proceed
    And I click the "Reset User Pickers" button
    And I click the "Delete All" button in the "Question" pane
    And I click the "My Pickers" edit category link in the "Charge Pickers" pane
    And I wait "2" seconds
    And I click the "Add Category" button in the "Edit Pickers" pane
    And I wait "2" seconds
    And I enter "UserChargePick" in the "Enter new categoryname" field
    And I click the "OK" button in the "AddCategoryContents" pane
    And I click the "Save" button in the "Edit Pickers" pane
    Then the "My Pickers" table should have at least "1" row containing the text "UserChargePick"
    And I click the "UserChargePick" edit category link in the "Charge Pickers" pane
    And I wait "2" seconds
    And I enter "32853 lung transplant double " in the "Add Code" field in the "Edit Pickers" pane
    And I click the "Lookup Values" element in the "Edit Pickers" pane
    Then the "Children Picker" table should have at least "1" row containing the text "32853"
    And I click the "Save" button in the "Edit Pickers" pane
    Then the "My Pickers" table should have at least "1" row containing the text "32853"
    When I click the "Close" button in the "Charge Pickers" pane
    And I am on the "Patient List V2" tab
    And patient "SAVE SUBMIT1" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value         |
      |Bill Area    |submitsave    |
      |Billing Prov |SUBMIT3, SAVE |
      |Svc Site     |Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button
    And I enter the ICD-10 codes "B67.0"
    And I click the "Pickers" button
    And I choose the "32853" code in the "UserChargePick" list in the "Charges" search section in the "ChargeEntry" pane
    And I click the "Submit" button
    Then the following text should appear in the "Charge Detail" pane
      |32853 |
      |B67.0 |
    When I am on the "Preferences" tab
    And I select "Charge Capture" from the "Edit Settings" dropdown in the "Personal Preference" pane
    And I click the "Add/Edit Charge Pickers" edit link in the "Preference CCSettings" pane
    And I click the "Reset User Pickers" button
    And I click the "Delete All" button in the "Question" pane
    Then the "My Pickers" table should have at least "1" row
    When I click the "Close" button in the "Charge Pickers" pane


  #No: 31
  # TODO: Modified patient name in "And I select patient "SAVE SUBMIT3" from the "Name" column in the "Visit Search Results" table" to "SAVE SUBMIT1", as in sync with the previous steps.
  # TODO: Also, added the step (second from last) "And I select "the first item" in the "Charges" table" to click on the item, as if not clicked, charge details pane was showing empty.
  @savecharge
  Scenario: 31. Add a charge from the Patients details
    When I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I "uncheck" the following
      |Include Cancelled Visits|
      |Include Past Visits|
    And I fill in the following fields
      |Name  |Type |Value   |
      |Last  |text |submit1 |
      |First |text |save    |
    And I click the "Search for Visits" button
    And I select patient "SAVE SUBMIT1" from the "Name" column in the "Visit Search Results" table
    And I click the "View Detail" button
    And I wait "2" seconds
    Then the "Patient Details" pane should load
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I wait "3" seconds
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button
    When I set the following charge headers
      |Name         |Value         |
      |Bill Area    |submitsave    |
      |Billing Prov |SUBMIT3, SAVE |
      |Svc Site     |Inpatient     |
    And I enter the ICD-10 codes "C15.4"
    And I click the "CPT" button in the "Charge Entry" pane
    And I enter the CPT codes "63301"
    And I wait "5" seconds
    And I click the "Submit" button in the "Charge Entry" pane
    And I wait "3" seconds
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I wait "3" seconds
    And I click the "Close" button in the "PatientDetails" pane
    And I am on the "Patient List V2" tab
    And I select patient "SAVE SUBMIT1" from the patient list
    And I select "Charges" from clinical navigation
    Then rows containing the following should appear in the "Charges" table
      |Date/Time                  |Proc                      |Diag  |
      |%Current Date MMDDYY% |removal of vertebral body |C15.4 |
    And I select "the first item" in the "Charges" table
    When the following text should appear in the "Charge Detail" pane
      |63301 removal of vertebral body |
      |C15.4                           |


  #No: 32
  @savecharge
  Scenario: 32. Pre-Requisite View Free Text in Existing tab of a Charge Transaction DEV-49767
    Given I am logged into the portal with user "saveadmin" using the default password
    When I am on the "Admin" tab
    And I select the "User" subtab
    And I open "Charge Capture" settings page for the user "submitsaveuser3"
    And I edit the following user settings and I click save
      | Page           | Name                               | Type  | Value |
      | Charge Capture | Exclude Free Text on Existing List | radio | false |
      | Charge Capture | Allow Free Text Diagnoses          | radio | true  |
      | Charge Capture | Allow Free Text Charges            | radio | true  |


  #No: 33
  #TODO: Did not find use of the step "When I enter "fever" in the "Diagnosis Search" field in the "Charge Entry" pane" and hence commented the same. Also, this step was leading to error.
  #TODO: Did not find use of the step "And I "expand" the "Charges" search section" and hence commented the same to save execution time.
  #TODO: Billing Prov was set to "SUBMIT3, SAVE" and during verification in Charge Details pane, "SUBMIT1, SAVE" was searched for Billing Prov value, which led to error. Changed the verification value to "SUBMIT3, SAVE".
  @savecharge
  Scenario: 33. View Free Text in Existing tab of a Charge Transaction DEV-49767 DEV[59771] DEV[AUTO-190]
    Given I select patient "SAVE SUBMIT1" from the patient list
    And patient "SAVE SUBMIT1" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I wait "2" seconds
    And I set the following charge headers
      | Name         | Value         |
      | Bill Area    | submitsave    |
      | Billing Prov | SUBMIT3, SAVE |
      | Svc Site     | Inpatient     |
      | Referring    | Duffy, Duck   |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button
    And I enter "chest" in the "Diagnosis Search" field in the "Charge Entry" pane
    Then the following text should appear in the "Charge Entry" pane
      |Add as Free Text |
    And I wait "2" seconds
    When I click the "Add as Free Text" link in the "Diagnoses Search Header Container" section in the "Charge Entry" pane
    And I wait "2" seconds
    Then the text "chest" should appear in the "Diagnosis List" section in the "Charge Entry" pane

    #And I "expand" the "Charges" search section
    #When I enter "fever" in the "Diagnosis Search" field in the "Charge Entry" pane
   #above step is required because it will activate the class name, if we don't include this step then class will be same for both daignoses search and charge search.

    And I enter "hhhh" in the "Charge Search" field in the "Charge Entry" pane
    And I wait "3" seconds
    When I click the "AddasFreeTextChargeSearch" element in the "Charge Entry" pane
    Then the text "hhhh" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button in the "Charge Entry" pane
    #Then the "Confirm" pane should load
    Then the following fields should display in the "Confirm" pane
      |Name                |Type   |
      |Continue Editing    |button |
      |Save As Is          |button |
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I refresh the clinical display
    And I select "Free Text" from the "Diag" column in the "Charges" table

#    Then the following text should appear in the "Charge Detail" pane
#      |Status      |Service Date          |Service Site |Billing Provider |Billing Area |
#      |Holding Bin |%Current Date MMDDYY% |Inpatient    |SUBMIT1, SAVE    |submitsave   |

    Then the following text should appear in the "Charge Detail" pane
      |Status      |Service Date          |Service Site |Billing Provider |Billing Area |
      |Holding Bin |%Current Date MMDDYY% |Inpatient    |SUBMIT3, SAVE    |submitsave   |
    When I click the "Copy" button in the "Charge Detail" pane
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button
    And I expand the "Existing" list in the "Diagnoses" search section
    Then the text "chest" should appear in the "Existing Diagnoses" section in the "Charge Entry" pane
    When I enter the ICD-10 codes "S02.0XXA"
    And I enter the CPT codes "62256"
    Then the text "S02.0XXA" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And the text "62256" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I refresh the clinical display
    Then rows containing the following should appear in the "Charges" table
      |Date/Time             |Diag    |
      |%Current Date MMDDYY% |S02.0XXA |


  #No: 34
  @savecharge
  Scenario: 34. Save a transaction with maximum allowed ICD 9
    Given I select patient "SAVE SUBMIT1" from the patient list
#    And I "check" the following
    And I "check" the following checkbox in the "Charges" pane
      |Show Visits|
    And I click the "Add" link in the "Charges" pane
    And I wait "2" seconds
    And I set the following charge headers
      |Name         |Value         |
      |Bill Area    |submitsave    |
      |Billing Prov |SUBMIT3, SAVE |
      |Svc Site     |Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "62280"
    And I enter the ICD-10 codes "B36.0;A27.0;R52"
    Then the following text should appear in the "Charge Entry" pane
      |Charges |
      |B36.0   |
      |A27.0   |
      |R52     |
      |62280   |
    When I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
#    And I "uncheck" the following
    And I "uncheck" the following checkbox in the "Charges" pane
      |Show Visits|
    Then the following text should appear in the "Charges" pane
      |%Current Date MMDDYY% |treat spinal cord lesion |


  #No: 35
  @savecharge
  Scenario Outline: 35. Pre-Requisite
    Given I am logged into the portal with user "saveadmin" using the default password
    When I am on the "Admin" tab
    And I select the "User" subtab
    And I open "Charge Capture" settings page for the user "<UserName>"
    And I edit the following user settings and I click save
      | Page           | Name                                     | Type  | Value |
      | Charge Capture | Allow Free Text Diagnoses                | radio | false |
      | Charge Capture | Allow Free Text Charges                  | radio | true  |
      | Charge Capture | Exclude Free Text on Copied Transactions | radio | true  |
      | Charge Capture | Copy Diagnoses on Copied Transactions    | radio | false |

  Examples:
    |UserName        |
    |submitsaveuser1 |
    |submitsaveuser2 |
    |submitsaveuser3 |


  #No: 36
  @savecharge
  Scenario Outline: 36. Allow Free Text Diagnoses set to No and test with all level users
    Given I am logged into the portal with user "<UserName>" using the default password
    When I am on the "Patient List V2" tab
    And I select "SaveSubmit List" from the "Patient List" menu
    And I select patient "<Patient>" from the patient list
    And I "uncheck" the following checkbox in the "Charges" pane
      |Show Visits|
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value       |
      |Bill Area    |submitsave  |
      |Billing Prov |<Bill Prov> |
      |Svc Site     |Inpatient   |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button
    And I enter "fever" in the "Diagnosis Search" field in the "Charge Entry" pane
    And I wait "2" seconds
    And the text "Add as Free Text" should not appear in the "Diagnoses Search Container" section in the "Charge Entry" pane
    When I click the "Close" image

    Examples:
      | UserName        | Patient      | Bill Prov     |
      | submitsaveuser1 | SAVE SUBMIT1 | SUBMIT1, SAVE |
      | submitsaveuser2 | SAVE SUBMIT2 | SUBMIT2, SAVE |
      | submitsaveuser3 | SAVE SUBMIT3 | SUBMIT3, SAVE |


  #No: 37
  #TODO: Did not find use of the step "And I enter "pain" in the "Diagnosis Search" field in the "Charge Entry" pane" and hence commented the same. Also, this step was leading to error.
  #TODO: In the last step, checking the text "Free Text fever". However, the initial steps sets the text as "ppp". Hence the verification should be for "Free Text ppp". Changed step accordingly.
  @savecharge
  Scenario Outline: 37. Allow Free Text Charges set to Yes and test with all level users
    Given I am logged into the portal with user "<UserName>" using the default password
    When I am on the "Patient List V2" tab
    And I select "SaveSubmit List" from the "Patient List" menu
    And I select patient "<Patient>" from the patient list
    When patient "<Patient>" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value       |
      |Bill Area    |submitsave  |
      |Billing Prov |<Bill Prov> |
      |Svc Site     |Inpatient   |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button
    And I enter the ICD-10 codes "L84"
    And I "expand" the "Charges" search section

    #And I enter "pain" in the "Diagnosis Search" field in the "Charge Entry" pane
#above step is required because it'l activate the class name, if we don't include this step then class will be same for both daignoses search and charge search.

    And I enter "ppp" in the "Charge Search" field in the "Charge Entry" pane
    And I wait "2" seconds
    Then the following text should appear in the "Charge Entry" pane
      |Add as Free Text |
    And I wait "3" seconds
    When I click the "AddasFreeTextChargeSearch" element in the "Charge Entry" pane
    Then the text "ppp" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button in the "Charge Entry" pane
    #Then the "Confirm" pane should load
    And the following fields should display in the "Confirm" pane
      |Name                |Type   |
      |Continue Editing    |button |
      |Save As Is          |button |
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I refresh the clinical display
    Then the "Charges" table should have at least "1" row containing the text "L84"
    When I select "L84" from the "Diag" column in the "Charges" table
#    Then the following text should appear in the "Charge Detail" pane
#      |Charges         |Diagnoses |
#      |Free Text fever |L84       |
    Then the following text should appear in the "Charge Detail" pane
      |Charges         |Diagnoses  |
      |Free Text ppp   |L84        |

    Examples:
      | UserName        | Patient      | Bill Prov     |
      | submitsaveuser1 | SAVE SUBMIT1 | SUBMIT1, SAVE |
      | submitsaveuser2 | SAVE SUBMIT2 | SUBMIT2, SAVE |
      | submitsaveuser3 | SAVE SUBMIT3 | SUBMIT3, SAVE |


  #No: 38
  @savecharge
  Scenario Outline: 38. Pre-Requisite
    Given I am logged into the portal with user "saveadmin" using the default password
    When I am on the "Admin" tab
    And I select the "User" subtab
    And I open "Charge Capture" settings page for the user "<UserName>"
    And I edit the following user settings and I click save
      | Page           | Name                                     | Type  | Value |
      | Charge Capture | Allow Free Text Diagnoses                | radio | true  |
      | Charge Capture | Exclude Free Text on Copied Transactions | radio | true  |

  Examples:
    |UserName        |
    |submitsaveuser1 |
    |submitsaveuser2 |
    |submitsaveuser3 |


  #No: 39
  #TODO: Did not find use of the step "When I enter "fever" in the "Diagnosis Search" field in the "Charge Entry" pane" and hence commented the same. Also, this step was leading to error.
  @savecharge
  Scenario: 39. Copy a Transaction is having only Free Text Diags and Charges DEV[49767]
    When I select patient "SAVE SUBMIT1" from the patient list
    And patient "SAVE SUBMIT1" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then the "Charge Entry" pane should load
    When I set the following charge headers
      | Name         | Value         |
      | Bill Area    | submitsave    |
      | Billing Prov | SUBMIT3, SAVE |
      | Svc Site     | Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button
    And I enter "ssss" in the "Diagnosis Search" field in the "Charge Entry" pane
    Then the following text should appear in the "Charge Entry" pane
      |Add as Free Text |
    And I wait "2" seconds
    When I click the "Add As Free Text" element in the "Diagnoses Search Header Container" section in the "Charge Entry" pane
    Then the text "ssss" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And I "expand" the "Charges" search section
    #When I enter "fever" in the "Diagnosis Search" field in the "Charge Entry" pane
   #above step is required because it'l activate the class name, if we don't include this step then class will be same for both daignoses search and charge search.
    And I enter "ppp" in the "Charge Search" field in the "Charge Entry" pane
    Then the following text should appear in the "Charge Entry" pane
      |Add as Free Text |
    And I wait "3" seconds
    When I click the "AddasFreeTextChargeSearch" element in the "Charge Entry" pane
    Then the text "ppp" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button in the "Charge Entry" pane
    #Then the "Confirm" pane should load
    And the following fields should display in the "Confirm" pane
      |Name                |Type   |
      |Continue Editing    |button |
      |Save As Is          |button |
    And I click the "Save As Is" button in the "Confirm" pane
    And I refresh the clinical display
    And I wait "2" seconds
    Then the "Charges" table should have at least "1" row containing the text "Free Text"
    When I select "the first item" in the "Charges" table
    And I click the "Copy" button in the "Charge Detail" pane
    Then the text "ssss" should not appear in the "Charge Lists" section in the "Charge Entry" pane
    And the text "pain" should not appear in the "Charge Lists" section in the "Charge Entry" pane
    And I click the "Close" image

  #No: 40
  @savecharge
  Scenario: 40. Pre-Requisite Resolving free text errors Free Text Error in Edits
    Given I am logged into the portal with user "saveadmin" using the default password
    When I am on the "Admin" tab
    And I select the "Institution" subtab
    And I wait "5" seconds
    And I select "Charge Capture" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I select "true" from the "Allow Free Text Errors To Go To Outbox" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "2" seconds


  #No: 41
  #TODO: Did not find use of the step "When I enter "fever" in the "Diagnosis Search" field in the "Charge Entry" pane" and hence commented the same. Also, this step was leading to error.
  #TODO: Checking the text "Free Text cold". However, the initial steps sets the text as "ppp". Hence the verification should be for "Free Text ppp". Changed step accordingly.
  @savecharge
  Scenario: 41. Resolving free text errors Free Text Error in Edits
    When I select patient "SAVE SUBMIT3" from the patient list
    And patient "SAVE SUBMIT3" has no charges
    #And I check the "Show Visits" checkbox
#    And I "check" the following
    And I "check" the following checkbox in the "Charges" pane
      | Show Visits |
    And I click the "Add" link in the "Charges" pane
    And I wait "5" seconds
    And I set the following charge headers
      | Name         | Value         |
      | Bill Area    | submitsave    |
      | Billing Prov | SUBMIT3, SAVE |
      | Svc Site     | Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button
    And I enter the ICD-10 codes "L90.6"
    #When I enter "fever" in the "Diagnosis Search" field in the "Charge Entry" pane
   #above step is required because it'l activate the class name, if we don't include this step then class will be same for both daignoses search and charge search.
    And I enter "ppp" in the "Charge Search" field in the "Charge Entry" pane
    Then the following text should appear in the "Charge Entry" pane
      |Add as Free Text |
    And I wait "3" seconds
    When I click the "AddasFreeTextChargeSearch" element in the "Charge Entry" pane
    Then the text "ppp" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Submit" button in the "Charge Entry" pane
    #Then the "Confirm" pane should load
    And the following fields should display in the "Confirm" pane
      |Name                |Type   |
      |Continue Editing    |button |
      |Save As Is          |button |
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I refresh the clinical display
    #And I uncheck the "Show Visits" checkbox
    And I "uncheck" the following
      |Show Visits|
    Then the "Charges" table should have at least "1" row containing the text "L90.6"
    When I select "L90.6" from the "Diag" column in the "Charges" table
#    Then the following text should appear in the "Charge Detail" pane
#      |Charges        |Diagnoses               |
#      |Free Text cold |L90.6 Striae atrophicae |
    Then the following text should appear in the "Charge Detail" pane
      |Charges         |Diagnoses               |
      |Free Text ppp   |L90.6 Striae atrophicae |
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "Charge Capture" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I select "false" from the "Allow Free Text Errors To Go To Outbox" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "2" seconds


  #No: 42
  @savecharge
  Scenario Outline: 42. Post-Requisite
    Given I am logged into the portal with user "saveadmin" using the default password
    When I am on the "Admin" tab
    And I select the "User" subtab
    And I open "Charge Capture" settings page for the user "<UserName>"
    And I edit the following user settings and I click save
      | Page           | Name                                     | Type  | Value |
      | Charge Capture | Allow Free Text Diagnoses                | radio | false |
      | Charge Capture | Allow Free Text Charges                  | radio | false |
      | Charge Capture | Exclude Free Text on Copied Transactions | radio | false |

  Examples:
    |UserName        |
    |submitsaveuser1 |
    |submitsaveuser2 |
    |submitsaveuser3 |


  #No: 43
  @savecharge
  Scenario Outline: 43. Allow Free Text Charges set to No and test with all level users
    Given I am logged into the portal with user "<UserName>" using the default password
    And I am on the "Patient List V2" tab
    And I select "SaveSubmit List" from the "Patient List" menu
    And I select patient "<Patient>" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value       |
      |Bill Area    |submitsave  |
      |Billing Prov |<Bill Prov> |
      |Svc Site     |Inpatient   |
    And I enter the ICD-10 codes "L83"
    And I enter "fever" in the "Charge Search" field in the "Charge Entry" pane
    Then the text "Add as Free Text Charge Search" should not appear in the "Charge Entry" pane
    When I click the "Close" image

    Examples:
      | UserName        | Patient      | Bill Prov     |
      | submitsaveuser1 | SAVE SUBMIT1 | SUBMIT1, SAVE |
      | submitsaveuser2 | SAVE SUBMIT2 | SUBMIT2, SAVE |
      | submitsaveuser3 | SAVE SUBMIT3 | SUBMIT3, SAVE |


  #No: 44
  #TODO: Text "Service Date" is not displayed in Charge Entry pane. Hence, changed "Service Date" to "Date".
  @savecharge
  Scenario: 44. Enter the required filed and saving the charge as Draft
    Given I am logged into the portal with user "submitsaveuser3" using the default password
    And I am on the "Patient List V2" tab
    And I select "SaveSubmit List" from the "Patient List" menu
    #And I uncheck the "ShowVisits" checkbox
#    And I "uncheck" the following
    And I "uncheck" the following checkbox in the "Charges" pane
      | Show Visits |
    And I select patient "SAVE SUBMIT1" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
#    And the following text should appear in the "Charge Entry" pane
#      |Service Date |
#      |Billing Prov |
#      |Bill Area    |
#      |Svc Site     |
#      |Referring    |
#      |Injury Date  |
#      |Injury Type  |
    And the following text should appear in the "Charge Entry" pane
      |Date |
      |Billing Prov |
      |Bill Area    |
      |Svc Site     |
      |Referring    |
      |Injury Date  |
      |Injury Type  |
    And I set the following charge headers
      |Name         |Value       |
      |Bill Area    |            |
      |Billing Prov |            |
      |Svc Site     |            |
    And I enter the ICD-10 codes "A75.0"
    And I click the "CPT" button
    And I enter the CPT codes "62121"
    And I click the "Submit" button
    Then the following text should appear in the "Charge Entry" pane
      |HEADER :Billing Prov is required |
      |HEADER :Bill Area is required    |
      |HEADER :Svc Site is required     |
    When I click the "Submit Draft" button
    Then the following text should appear in the "Charge Entry" pane
      |HEADER :Billing Prov is required |
      |HEADER :Bill Area is required    |
      |HEADER :Svc Site is required     |
    When I set the following charge headers
      |Name         |Value         |
      |Bill Area    |submitsave    |
      |Billing Prov |SUBMIT1, SAVE |
      |Svc Site     |Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "DiagnosisSearch" element
    And I click the "Submit Draft" button
    #And I uncheck the "Show Visits" checkbox in the "Charges" pane
    When I "uncheck" the following checkbox in the "Charges" pane
      |Show Visits      |
    And I select "the first item" in the "Charges" table
    Then rows containing the following should appear in the "Charges" table
      |Diag |
      |A75.0  |
    And the following text should appear in the "Charge Detail" pane
      |Status |Service Date          |Service Site |Billing Provider |Billing Area |
      |Draft  |%Current Date MMDDYY% |Inpatient    |SUBMIT1, SAVE    |submitsave   |


  #No: 45
  @savecharge
  Scenario: 45. Save a transaction with maximum allowed CPT codes
    When patient "SAVE SUBMIT1" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value         |
      |Bill Area    |submitsave    |
      |Billing Prov |SUBMIT3, SAVE |
      |Svc Site     |Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I click the "CPT" button
    And I enter the ICD-10 codes "A75.2"
    And I click the "Submit" button
    Then the following text should appear in the "Charge Entry" pane
      |Minimum number of charges needed on transaction is 1 |
    And I wait "3" seconds
    And I click the "CPT" button
    When I enter the CPT codes "31000;31000;31000;31000;31000;31000;31000;31000;31000;31000;31000"
    Then the "Confirm" pane should load
    When I click the "CodeEditErrorOk" button
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Then the following text should appear in the "Charge Detail" pane
      |Charges                          |
      |31000 irrigation maxillary sinus |
      |31000 irrigation maxillary sinus |
      |31000 irrigation maxillary sinus |
      |31000 irrigation maxillary sinus |
      |31000 irrigation maxillary sinus |
      |31000 irrigation maxillary sinus |
      |31000 irrigation maxillary sinus |
      |31000 irrigation maxillary sinus |
      |31000 irrigation maxillary sinus |
      |31000 irrigation maxillary sinus |


  #No: 46
  #TODO: Changed step "And The following fields should be enabled in the "Holding Bin" pane" to "And The following fields should be enabled in the "Holding Bin Results" pane". (Changed pane name).
  @savecharge
  Scenario: 46. Allow Free Text Errors to go to Outbox Yes
    Given I am logged into the portal with user "saveadmin" using the default password
    When I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "Charge Capture" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "5" seconds
    And I select "true" from the "Allow Free Text Errors To Go To Outbox" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "2" seconds
    And I select the "User" subtab
    And I search for the user "submitsaveuser2"
    And I select the user "submitsaveuser2"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "true" from the "Allow Free Text Errors To Go Outbox" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "2" seconds
    Given I am logged into the portal with user "submitsaveuser2" using the default password
    And I am on the "Patient List V2" tab
    And I select "SaveSubmit List" from the "Patient List" menu
    And "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And patient "SAVE SUBMIT1" has no charges
    And patient "SAVE SUBMIT2" has no charges
    And patient "SAVE SUBMIT3" has no charges
    And patient "SAVE SUBMIT4" has no charges
    And patient "MOLLY DARR" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value         |
      | Bill Area    | submitsave    |
      | Billing Prov | SUBMIT3, SAVE |
      | Svc Site     | Inpatient     |
      | Referring    | Duffy, Duck   |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "92070"
    And I enter the ICD-10 codes "S15.009A"
    And I click the "Submit" button
    Then the following fields should display in the "Confirm" pane
      |Name                |Type   |
      |Continue Editing    |button |
      |Save As Is          |button |
    And I click the "Save As Is" button in the "Confirm" pane
    And I wait "2" seconds
    And I am on the "Charges" tab
    And I select the "Holding Bin" subtab
    And I click the "Reset Criteria" button in the "Holding Bin" pane
    And I select "Today" from the "Timeframe" dropdown in the "Holding Bin" pane
    And I select "Free Text Errors" from the "Filter" dropdown in the "Holding Bin" pane
    And I click the "Show Charges" button in the "Holding Bin" pane
    Then the "Holding Bin" table should have at least "1" row containing the text "Free Text Error"
    And I select "the first item" in the "Holding Bin" table
    And The following fields should be enabled in the "Holding Bin Results" pane
      |Name                |Type   |
      |Send to Outbox      |button |
    When I click the "Send to Outbox" button in the "Holding Bin Results" pane
    And I click the "Send all Eligible Transactions" button
    Then the "Confirm Send to Outbox" pane should close
    And the following text should appear in the "Holding Bin Results" pane
      |There are no transactions matching the specified criteria. |


  #No: 47
  @savecharge
  Scenario: 47. Allow Free Text Errors to go to Outbox set to No
    Given I am logged into the portal with user "saveadmin" using the default password
    When I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "Charge Capture" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "5" seconds
    And I select "false" from the "Allow Free Text Errors To Go To Outbox" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "2" seconds
    And I select the "User" subtab
    And I search for the user "submitsaveuser2"
    And I select the user "submitsaveuser2"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "true" from the "Allow Free Text Errors To Go Outbox" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "2" seconds
    Given I am logged into the portal with user "submitsaveuser2" using the default password
    And I am on the "Patient List V2" tab
    And I select "SaveSubmit List" from the "Patient List" menu
    And "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    When patient "MOLLY DARR" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value         |
      |Bill Area    |submitsave    |
      |Billing Prov |SUBMIT3, SAVE |
      |Svc Site     |Inpatient     |
      |Referring    |Duffy, Duck   |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "92070"
    And I enter the ICD-10 codes "S15.009A"
    And I click the "Submit" button in the "Charge Entry" pane
    Then the following fields should display in the "Confirm" pane
      |Name                |Type   |
      |Continue Editing    |button |
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I wait "2" seconds
    And I am on the "Charges" tab
    And I select the "Holding Bin" subtab
    And I click the "Reset Criteria" button in the "Holding Bin" pane
    And I select "Current Month" from the "Timeframe" dropdown in the "Holding Bin" pane
    And I select "Free Text Errors" from the "Filter" dropdown in the "Holding Bin" pane
    And I click the "Show Charges" button in the "Holding Bin" pane
    Then the "Holding Bin" table should have at least "1" row containing the text "Free Text Error"
    And The following field should be disabled in the "Holding Bin Results" pane
      |Name                |Type   |
      |Send to Outbox    |button |


  #No: 48
  #TODO: Changed the last step. Pane name earlier was "Charge Detail". Changed it to "Holding Bin Results".
  #TODO: Added step "And I click the "Show Charges" button in the "Holding Bin" pane", as results were not getting displayed before clicking theShow Charges button.
  @savecharge
  Scenario: 48. Referring Provider Header Free text
    Given I am logged into the portal with user "saveadmin" using the default password
    When I launch the charge transaction headers for "submitsaveuser2" user
    And I select "Referring" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    #And I check the "Allow Free Text" checkbox in the "Charge Header Edit Content" pane
    And I "check" the following checkbox in the "Charge Header Edit Content" pane
      |Allow Free Text|
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I wait "2" seconds
    And I click the "Close" button in the "Charge Transaction Content" pane
    Given I am logged into the portal with user "submitsaveuser2" using the default password
    And I am on the "Patient List V2" tab
    And I select "SaveSubmit List" from the "Patient List" menu
    And I select patient "SAVE SUBMIT1" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value         |
      |Bill Area    |submitsave    |
      |Referring    |Duffy, Duck   |
      |Billing Prov |SUBMIT1, SAVE |
      |Svc Site     |Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "32550"
    And I enter the ICD-10 codes "A77.1"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I am on the "Charges" tab
    And I select the "Holding Bin" subtab
    And I click the "Reset Criteria" button in the "Holding Bin" pane
    And I select "Today" from the "Timeframe" dropdown in the "Holding Bin" pane
    And I click the "Show Charges" button in the "Holding Bin" pane
    #Then the following text should appear in the "Charge Detail" pane
    Then the following text should appear in the "Holding Bin Results" pane
      |Diag |A77.1 |


  #No: 49
  #TODO: Changed the last step. Pane name earlier was "Charge Detail". Changed it to "Holding Bin Results".
  #TODO: Added step "And I click the "Show Charges" button in the "Holding Bin" pane", as results were not getting displayed before clicking theShow Charges button.
  #TODO: Changed the Referring and Billing Prov values in the step "And I set the following charge headers".
  @savecharge
  Scenario: 49. Billing Provider Header Free text
    Given I am logged into the portal with user "saveadmin" using the default password
    When I launch the charge transaction headers for "submitsaveuser2" user
    And I select "Billing Prov" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I "check" the following checkbox in the "Charge Header Edit Content" pane
      |Allow Free Text|
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I wait "2" seconds
    And I click the "Close" button in the "Charge Transaction Content" pane
    Given I am logged into the portal with user "submitsaveuser2" using the default password
    And I am on the "Patient List V2" tab
    And I select "SaveSubmit List" from the "Patient List" menu
    And I select patient "SAVE SUBMIT1" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value          |
      |Bill Area    |submitsave     |
      |Billing Prov |SUBMIT1, SAVE  |
      |Referring    |Duffy, Duck    |
      |Svc Site     |Inpatient      |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "32551"
    And I enter the ICD-10 codes "A77.2"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I wait "3" seconds
    And I am on the "Charges" tab
    And I select the "Holding Bin" subtab
    And I click the "Reset Criteria" button in the "Holding Bin" pane
    And I select "Today" from the "Timeframe" dropdown in the "Holding Bin" pane
    And I click the "Show Charges" button in the "Holding Bin" pane
    Then the following text should appear in the "Holding Bin Results" pane
      |Diag |A77.2 |


  #No: 50
  #TODO: Changed the third from last step "And I click the "Submit" button" to "And I click the "Submit Draft" button", because after clicking the Submit button, "There are no transactions matching the specified criteria." message was displayed instead of the required message.
  @savecharge
  Scenario: 50. Edits column Edit Draft Transaction to Save Level 2 user
    Given I am logged into the portal with user "submitsaveuser2" using the default password
    When I am on the "Patient List V2" tab
    And I select "SaveSubmit List" from the "Patient List" menu
    And I select patient "SAVE SUBMIT1" from the patient list
    And patient "SAVE SUBMIT1" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value         |
      | Bill Area    | submitsave    |
      | Billing Prov | SUBMIT2, SAVE |
      | Referring    | Duffy, Duck   |
      | Svc Site     | Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "32553"
    And I enter the ICD-10 codes "A77.40"
    And I click the "Submit Draft" button
    And I wait "2" seconds
    And I am on the "Charges" tab
    And I select the "Search" subtab
    And I click the "Back To Criteria" button if it exists
    And I click the "Reset Criteria" button in the "ChargeSearch" pane
    And I select "Current Month" from the "Timeframe" dropdown in the "Charge Search" pane
    #And I check the "Draft" checkbox in the "Charge Search" pane
    And I "check" the following checkbox in the "Charge Search" pane
      |Draft|
    And I click the "Show Charges" button in the "Charge Search" pane
    And I wait "3" seconds
    And I sort the "Charge Search Results" table alphabetically by the "Status" column in "Descending" order
    Then the "Charge Search Results" table should have at least "1" row containing the text "Draft"
    When I click the "Free Text Error" link in the "ChargeResults" pane
    And I wait "2" seconds
    And I set the following charge headers
      |Name         |Value      |
      |Bill Area    |submitsave |
      |Referring    |           |
    #And I click the "Submit" button
    And I click the "Submit Draft" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Then the following text should appear in the "ChargeResults" pane
      |Draft |


  #No: 51
  #TODO: Added "And I select "the first item" in the "Charges" table" as the second last step as the item was not getting selected and hence no data was displayed in Charges Details table.
  @savecharge
  Scenario: 51. Add charge with multiple code edits for the next patient in the list of Code edit displays if multiple E and M codes
    Given I am logged into the portal with user "saveadmin" using the default password
    And I am on the "Patient List V2" tab
    #When I turn "on" all codeedits on "server"
    And I execute the "Enable All Code Edits" query
    Given I am logged into the portal with user "submitsaveuser2" using the default password
    And I am on the "Patient List V2" tab
    And I select "SaveSubmit List" from the "Patient List" menu
    And I select patient "SAVE SUBMIT1" from the patient list
    And patient "SAVE SUBMIT1" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I wait "3" seconds
    And I set the following charge headers
      | Name         | Value         |
      | Bill Area    | submitsave    |
      | Billing Prov | SUBMIT2, SAVE |
      | Svc Site     | Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "99221"
    And I enter the CPT codes "99223"
    And I enter the ICD-10 codes "A77.9"
    And I click the "Submit" button in the "Charge Entry" pane
    Then the following text should appear in the "Charge Entry" pane
      |The charge transaction has been saved as a COMPLETED transaction, but code edits now exist. Choose the next step. |
    When I click the "Continue Editing" button
    And I click the "Close" image
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I wait "2" seconds
    And I set the following charge headers
      |Name         |Value         |
      |Bill Area    |submitsave    |
      |Billing Prov |SUBMIT2, SAVE |
      |Svc Site     |Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "99221"
    And I enter the CPT codes "99223"
    And I enter the ICD-10 codes "12345" in the "Charge Entry" pane
    And I click the "Submit" button in the "Charge Entry" pane
    Then the following text should appear in the "Charge Entry" pane
      |The charge transaction has been saved as a COMPLETED transaction, but code edits now exist. Choose the next step. |
    And the "Confirm" pane should load
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I select "the first item" in the "Charges" table
    Then the following text should appear in the "Charge Detail" pane
      |Charges |
      |99221   |
      |99223   |


  #No: 52
  #TODO: Changed the message displayed in Confirm pane.
  @savecharge
  Scenario: 52. Allow Saving Charges Forced Code Edits set to No
    Given I am logged into the portal with user "submitsaveuser1" using the default password
    When I am on the "Admin" tab
    And I select the "Preferences" subtab
    And I select "Charge Capture" from the "Edit Preferences Settings" dropdown in the "Personal Preferences" pane
    And I wait "2" seconds
    And I select "false" from the "Allow Saving Charges Forced Code Edits" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "2" seconds
    And I am on the "Patient List V2" tab
    And I select "SaveSubmit List" from the "Patient List" menu
    And I select patient "SAVE SUBMIT1" from the patient list
    And I select "Charges" from clinical navigation
    #And I uncheck the "Show Visits" checkbox in the "Charges" pane
    And I "uncheck" the following checkbox in the "Charges" pane
      | Show Visits |
    And patient "SAVE SUBMIT1" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value         |
      | Bill Area    | submitsave    |
      | Billing Prov | SUBMIT3, SAVE |
      | Svc Site     | Inpatient     |
    And I enter "%Current Date MMDDYYYY%" in the "Date" field
    And I enter the CPT codes "97811"
    And I enter the ICD-10 codes "L91.0"
    Then the text "97811" should appear in the "Charge List" section in the "Charge Entry" pane
    And the text "L91.0" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    When I click the "Submit" button in the "Charge Entry" pane
    #Then the "Confirm" pane should load
#    And the following text should appear in the "Confirm" pane
#      |This charge transaction has been saved as a DRAFT due to errors. Choose the next step. |
    And the following text should appear in the "Confirm" pane
      |This charge transaction was NOT SAVED due to errors. Choose the next step. |
    And the following fields should display in the "Confirm" pane
      |Name                |Type   |
      |Continue Editing    |button |
      |Discard Transaction |button |
    When I click the "Continue Editing" button
    And I wait "2" seconds
    And I click the "Submit" button in the "Charge Entry" pane
    And I wait "2" seconds
    #Then the "Confirm" pane should load
#    And the following text should appear in the "Confirm" pane
#      |This charge transaction has been saved as a DRAFT due to errors. Choose the next step. |
    And the following text should appear in the "Confirm" pane
      |This charge transaction was NOT SAVED due to errors. Choose the next step. |
    And the following fields should display in the "Confirm" pane
      |Name                |Type   |
      |Continue Editing    |button |
      |Discard Transaction |button |
    And I wait "2" seconds
    When I click the "DiscardTransactionButton" button in the "Confirm" pane
    And I refresh the clinical display
    Then the text "No data found" should appear in the "Charges" pane
    #And I turn "off" all codeedits on "server"
    And I execute the "Disable All Code Edits" query