Feature: CC - 8.0 Add Edit Charge Usability and Features

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

  @ChargeCapture
  Scenario: Delete Selected Dx
    When I select "Add Charge" from the "Patient Header Actions" menu
 #And I enter the ICD-9 code "111.0"
    And I enter the ICD-10 codes "B36.0"
    Then the following field should display in the "Charge Entry" pane
      |Name     |Type    |
      |DeleteDX |element |
    When I click the "Delete DX" element in the "Charge Entry" pane
    Then the following field should not display in the "Charge Entry" pane
      |Name     |Type    |
      |DeleteDX |element |
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Delete Selected charge
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I click the "CPT" button
    And I enter the CPT codes "00192"
    Then the following field should display in the "Charge Entry" pane
      |Name      |Type    |
      |Delete CPT |element |
    When I remove the "00192" CPT code
    Then the following field should not display in the "Charge Entry" pane
      |Name      |Type    |
      |Delete CPT |element |
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Validate display CodeEdits
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |Verve            |
      |Billing Prov |USER3, ADDCHARGE |
      |Svc Site     |Inpatient        |
    And I enter the CPT codes "99252"
    And I wait "3" seconds
   #And I enter the ICD-9 code "111.0"
    And I enter the ICD-10 codes "B36.0"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "99252" should appear in the "Charge Entry" pane
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture @Demo
  Scenario: Validate Mod delete
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the CPT codes "99252"
    And I click the "Mod" element in the "Charge Entry" pane
    And I wait up to "5" seconds for the "Mod" field of type "TABLE" in the "Charge Entry" pane to be visible
    Then the "Mod" table should load
    And I wait "5" seconds
    When I click the "GC Mod" element
    And I click the "Close Mod" element
    Then the following field should display in the "Charge Entry" pane
      |Name        |Type    |
      |Delete Mod |element |
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Select Deselect Dx linked to specific charge
    When I select "Add Charge" from the "Patient Header Actions" menu
   #And I enter the ICD-9 code "111.0"
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "99252"
    And I check the "Charge Dx Selector" checkbox
    Then the following should be checked
      |ChargeDxSelector |
    When I uncheck the "Charge Dx Selector" checkbox
    Then the following should be unchecked
      |ChargeDxSelector |
    When I click the "Close" image
    Then the "Charge Entry" pane should close

#    #  [DEV-79243]: https://jira/browse/DEV-79243: Automation : CPT codes not displayed in charges section
  @ChargeCapture @Demo
  Scenario: Validate to Set Favorite Charge [DEV-47939][DEV-79243]
    When I select "Add Charge" from the "Patient Header Actions" menu
    Then I enter the CPT codes "1002F"
    And I make the "1002F" code as favorites in the "Charges" search section
    And I expand the "Favorites" list in the "Charges" search section
    Then the text "1002F" should appear in the "Favorite Charges" section in the "Charge Entry" pane
    And I click the "Close" image

#    #  [DEV-79243]: https://jira/browse/DEV-79243: Automation : CPT codes not displayed in charges section
  @ChargeCapture @Demo
  Scenario: Adding Charges Favorites [DEV-47939][DEV-79243]
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I choose the "1002F" code in the "Favorites" list in the "Charges" search section
    And I expand the "Favorites" list in the "Charges" search section
    Then the text "1002F" should appear in the "ChargeList" section in the "Charge Entry" pane
    And I click the "Close" image

  @ChargeCapture
  Scenario: Validate to set favorite Dx
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I make the "R52" code as favorites in the "Diagnoses" search section
   #And I make the "780.96" code as favorites in the "Diagnoses" search section
    And I expand the "Favorites" list in the "Diagnoses" search section
   #Then the text "780.96" should appear in the "Favorite Diagnoses" section in the "Charge Entry" pane
    Then the text "R52" should appear in the "Favorite Diagnoses" section in the "Charge Entry" pane
    And I click the "Close" image

  @ChargeCapture
  Scenario: Validate Adding Dx Favorites
    When I select "Add Charge" from the "Patient Header Actions" menu
   #And I choose the "780.96" code in the "Favorites" list in the "Diagnoses" search section
    And I choose the "R52" code in the "Favorites" list in the "Diagnoses" search section
    And I expand the "Favorites" list in the "Diagnoses" search section
   #Then the text "780.96" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    Then the text "R52" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And I click the "Close" image

  @ChargeCapture
  Scenario: Validate info icon CPT Code [DEV-47939]
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the CPT codes "00192"
    Then the text "anesth facial bone surgery" should appear in the "ChargePopoverContent" pane
    And I click the "Close" image

  @ChargeCapture
  Scenario: Validate Lookup CPT Code Search Line
    When I select "Add Charge" from the "Patient Header Actions" menu
    Then the following field should display in the "Charge Entry" pane
      |Name          |Type |
      |Charge Search |text |
    And I click the "Close" image

  @ChargeCapture @Demo
  Scenario: Validate Adding Search Text For Dx
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I enter "pain" in the "Diagnosis Search" field in the "Charge Entry" pane
   #And I select the "780.96" code in the Diagnoses search list
    And I select the "R52" code in the Diagnoses search list
   #Then the text "780.96 Pain" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    Then the text "R52 Pain" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And I click the "Close" image

  @ChargeCapture
  Scenario: Validate Code Description
    When I select "Add Charge" from the "Patient Header Actions" menu
   #Check added ICD-9 code description
   #And I enter the ICD-9 code "110.9"
    And I enter the ICD-10 codes "B35.9"
    Then the text "B35.9 Dermatophytosis" should appear in the "Diagnosis List" section in the "Charge Entry" pane
   #Check added CPT code description
    When I enter the CPT codes "0001F"
    Then the text "heart failure composite" should appear in the "Charge List" section in the "Charge Entry" pane
    And I click the "Close" image

  @ChargeCapture @Demo
  Scenario: Validate Adding Charge Search test
    When I select "Visits" from clinical navigation
    And I select "Inpatient" from the "Type" column in the "Visits" table
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value         |
      |Bill Area    |Verve         |
      |Billing Prov |KADMIN, PERRY |
      |Svc Site     |Inpatient     |
    And I enter "1002" in the "Charge Search" field in the "Charge Entry" pane
    Then the text "1002F" should appear in the "Charge Search Results" search list
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture @Demo
  Scenario: Validate Favorite Mod - DEV-48555
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the CPT codes "99252"
    And I make the "24" modifier as unfavorite in the modifier list if it exists
    And I click the "Mod" element in the "Charge Entry" pane
    And I click the "Mod" element in the "Charge Entry" pane if it exists
    And I wait up to "5" seconds for the "Mod" field of type "TABLE" in the "Charge Entry" pane to be visible
    Then the "Mod" table should load
    When I enter "24" in the "SearchMod" field
    And I click the "Favorite Mod" element in the "Charge Entry" pane
    And I click the "Close Mod" element
    And I click the "Favorite Mod List" element
    And I wait "2" seconds
    Then the "List of Favorite Mod" table should have at least "1" row containing the text "24"
    And I make the "24" modifier as unfavorite in the modifier list
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Validate Qty Change
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the CPT codes "99252"
#    And I change the Qty by "2"
    And I set the quantity on the CPT code "1" to "2"
    Then the value in the "Qty" field should be "2"
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture @Demo
  Scenario: Check Pt list  button (top right corner)
    When I select "Add Charge" from the "Patient Header Actions" menu
    Then the following fields should display in the "ChargeEntryRightCorner" pane
      |Name           |Type   |
      |Visit Details  |button |
      |Validate       |button |
      |Print          |button |
      |Submit         |button |
      |Submit Draft   |button |
      |Send to Outbox |button |
    And I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture @Demo
  Scenario: Custom Selection Location
    When I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then the "Charge Entry" pane should load
    #And I click the "Settings" button
    #changing to below steps as per new UI in 8.3.1
    And I select "Screen Settings" option from more options menu of charge entry pane
    Then the "Settings" pane should load
    And I click the "CustomSelectionLocTop" button
    Then the "CustomSelectionLocTop" pane should load
    When I click the "CustomSelectionLocBottom" button
    Then the "CustomSelectionLocBottom" pane should load
#    And I click the "Settings" button
    When I click the "DiagnosesSecTop" button
    Then the "DiagnosesSectionTop" pane should load
    When I click the "DiagnosesSecBottom" button
    Then the "DiagnosesSectionBottom" pane should load
   #revert back the setting
    And I click the "DiagnosesSecTop" button
    And I click the "Close Settings" button
    When I click the "Close" image
    Then the "Charge Entry" pane should close


  @ChargeCapture @Demo
  Scenario: Show Charges/Diagnoses as split view
    When I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then the "Charge Entry" pane should load
    #And I click the "Settings" button
    #changing to below steps as per new UI in 8.3.1
    And I select "Screen Settings" option from more options menu of charge entry pane
    Then the "Settings" pane should load
    And I click the "ShowChargesDiasplitview" button
    Then the "SplitPaneDivider" pane should load
    And I click the "Close Settings" button
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture @Demo
  Scenario: Pick a Diagnosis that has a secondary
    Given I am logged into the portal with user "addchargeuser1" using the default password
    And I am on the "Admin" tab
    And I open "Problem List" settings page for the user "addchargeuser3"
    And I edit the following user settings and I click save
      |Page         |Name                       |Type     |Value                |
      |Problem List |Select Secondary Diagnoses |dropdown |Automatically Include|
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I wait up to "10" seconds for the "Diagnosis Search" field of type "TEXT_FIELD" in the "Charge Entry" pane to be visible
   #And I enter the ICD-9 code "707.06"
   #And I enter the ICD-10 code "L89.509"
    And I enter "Fever as manifestation of blood transfusion reaction" in the "Diagnosis Search" field in the "Charge Entry" pane
    And I select the "T80.89XA" code in the Diagnoses search list
    And I wait "2" seconds
    And I click the "Secondary Diagnoses" element
    Then the "Secondary Dx" pane should load
    And I click the "Close Secondary Dxs" button
    When I click the "Close" image
    Then the "Charge Entry" pane should close


  @ChargeCapture @Demo
  Scenario: Set Display sec diagnoses automatically setting to no
    Given I am logged into the portal with user "addchargeuser1" using the default password
    And I am on the "Admin" tab
    And I open "Problem List" settings page for the user "addchargeuser3"
    And I edit the following user settings and I click save
      |Page         |Name                      |Type     |Value                 |
      |Problem List |Select Secondary Diagnoses|dropdown |Automatically Include |

   @ChargeCapture
  Scenario: Allow the GC modifier prompt to be suppressed for certain CPT codes [DEV-45912] [AUTO-187]
    Given I am logged into the portal with user "pkadmin" using the default password
    Given I am on the "Admin" tab
    And I select the "Institution" subtab
    Then the "InstitutionSettings" pane should load
    And I select "Charge Capture" from the "EditInstitutionSettings" dropdown in the "InstitutionSettings" pane
    Then the "ChargeCaptureSettings" pane should load
    When I click the "CPTs Exempt from GC Modifier" edit link in the "ChargeCaptureSettings" pane
    And I wait "2" seconds
    Then the "ExemptCPTs" pane should load
    And I enter "99026" in the "CPT:" field in the "ExemptCPTs" pane
    And I click on the text "99026:in-hospital on call service" in the "CPTLists" pane
    And I click the "SaveCptList" button in the "ExemptCPTs" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I select the "User" subtab
    And I open "Charge Capture" settings page for the user "addchargeuser3"
    And I edit the following user settings and I click save
        |Page           |Name                  |Type     |Value |
        |Charge Capture |Configure GC Modifier |dropdown |Yes   |
    And I click the "Save" button
    And I click "OK" in the confirmation box
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And I select patient "Molly Darr" from the patient list
    And I select "Charges" from clinical navigation
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then the "ChargeEntry" pane should load
    And I set the following charge headers
    |Name              |Value            |
    |Bill Area         |Verve            |
    |Billing Prov      |USER3, ADDCHARGE |
    |Svc Site          |Inpatient        |
    And I enter the CPT code "99026"
    And Text exact "GC" should not appear in the "ChargeList" section in the "Charge Entry" pane
    And I click the "Submit" button
    And I wait "2" seconds
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I wait for loading to complete
    And I enter the CPT code "99000"
    And Text exact "GC" should appear in the "ChargeList" section in the "Charge Entry" pane
    And I click the "Close" image

  @ChargeCapture
  Scenario: Reverting the GC Modifier setting [DEV-45912] [AUTO-187]
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I open "Charge Capture" settings page for the user "addchargeuser3"
    And I edit the following user settings and I click save
    |Page           |Name                  |Type     |Value |
    |Charge Capture |Configure GC Modifier |dropdown |No    |

  @ChargeCapture
  Scenario: Diagnosis Searching: Offer step down search method on user by user basis [DEV-51681] [AUTO-188]
    When I am on the "Preferences" tab
    And I select "Problem List" from the "Edit Settings" dropdown in the "Personal Preference" pane
    And I select "false" from the "Allow non specific diagnose" radio list
    And I click the "Save" button in the "Personal Preference Bottom" pane
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And I select patient "Molly Darr" from the patient list
    And I select "Charges" from clinical navigation
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I enter "R50.9" in the "Diagnosis Search" field in the "Charge Entry" pane
    And I wait "2" seconds
    Then the "Step Down" pane should load
    And the following fields should display in the "Step Down" pane
      |Name           |Type |
      |StepDown       |radio |
    And I click on the text "drug-induced" in the "Step Down" pane
    Then the text "Drug-induced fever" should appear in the "DiagnosisList" section in the "ChargeEntry" pane
    And I click the "Close" image

  @ChargeCapture
  Scenario: Revert backing the setting [DEV-51681] [AUTO-188]
    Given I am logged into the portal with user "addchargeuser3" using the default password
    When I am on the "Preferences" tab
    And I select "Problem List" from the "Edit Settings" dropdown in the "Personal Preference" pane
    And I select "true" from the "Allow non specific diagnose" radio list
    And I click the "Save" button in the "Personal Preference Bottom" pane
    And I click "OK" in the confirmation box


# This test must stay here until the issue with the test never ending is fixed.  I thought this was an issue
#  with AutoIt not releasing its handle on the window, but the same thing is now happening with Robot. Commented out
#  new Robot step and reverted back to AutoIt method. -- HIC 4/18/19
  @ChargeCapture
  Scenario: Exporting Tab-Delimited Files - Reviewer Name and Date Populate[DEV-77390][DEV-78127]
# #Verify that the name of the reviewer and the review date fields are populated when a charge held for review
#  #is marked as reviewed and exported as a Tab-delimited file (using the Export Tabs btn).
    Given I am logged into the portal with user "hfr1" using the default password
    When I am on the "Patient List V2" tab
    Then I select "HFR" from the "Patient List" menu
    When "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    Then I select "Charges" from clinical navigation
    And I select "Add Charge" from the "Patient Header Actions" menu
    #    #Charge code for Anesthesia Facial Bone Surgery
    And I enter the CPT code "00192"
    And I check the "Hold For Review" checkbox
    Then I click the "Submit" button
    And I click the "Save As Is" button in the "Charges Search" pane
    Then I select "Charges" from clinical navigation
    And I uncheck the "Show Visits" checkbox
    And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
    Then I select "the first item" in the "Charges" table
    And I click the "MarkAsReviewed" button
    And the following text should appear in the "Charge Detail" pane
      |Reviewer Name		  |
      |FORREVIEW, HOLD		  |
      |Review Date			  |
      |%Current Date MMDDYY%  |
    Then I am on the "Charges" tab
    And I select the "Search" subtab
    Then I click the "Back To Criteria" button if it exists
    And I click the "Reset Criteria" button in the "Charge Search" pane
    And I select "Today" from the "Timeframe" dropdown in the "Charge Search" pane
    Then I "check" the following checkbox in the "ChargeSearch" pane
      | ValidityErrors  |
    And I click the "Show Charges" button in the "Charge Search" pane
    And I sort the "Charge Search Results" table chronologically by the "Date" column in "Descending" order
    Then the 1st row of the "Charge Search Results" table should have the text "FORREVIEW, HOLD" in the "Reviewing Provider" column
    And the 1st row of the "Charge Search Results" table should have the text "%Current Date MMDDYY%" in the "Reviewed Date/Time" column
    #Delete any prior dl'd zip file if it exists before dl'ing the new zip file
    Then I delete the "export" ".zip" file
    #Delete any prior unzipped file if it exists before unzipping the new file
    And I delete the "export" ".txt" file
    Then I click the "Export Tabs" export button and then the IE browser prompt save file button if it exists
#    Then I mouse over and click the "Export Tabs" button
#    When I use Robot to click the IE Save file button if it exists
    And I unzip the "export" file
    And I read the "export" text file and verify that "FORREVIEW, HOLD" is listed under the "Reviewing Provider" column
    Then I read the "export" text file and verify that "%Current Date MMDDYY%" is listed under the "Reviewed Date/Time" column
