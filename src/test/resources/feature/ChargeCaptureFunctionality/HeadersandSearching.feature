Feature: CC - 8.0 Add Edit Charge Headers and Searching

  Background:
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "CCList" owned by "addchargeuser3" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I click the "Refresh Patient List" button
    And I select "CCList" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Charges" from clinical navigation

  @ChargeCapture
  Scenario: Display results with partial text entry for Bill Area
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I wait "3" seconds
    When I enter "Ver" in the "Bill Area" field in the "Charge Entry" pane then search list should load with the text "Verve"
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Display results with full entry for Bill Area
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I wait "2" seconds
    When I enter "Verve" in the "Bill Area" field in the "Charge Entry" pane then search list should load with the text "Verve"
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Attempt search for record Bill Area does not exist
    When I select "Add Charge" from the "Patient Header Actions" menu
    When I enter "12345" in the "Bill Area" field in the "Charge Entry" pane then search list should not load with the text "12345"
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Search for record containing special characters for Bill Area
    Given I am logged into the portal with user "pkadmin" using the default password
    When I am on the "Admin" tab
    And I select the "Department" subtab
    And I create the department "/Department"
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I wait "2" seconds
    When I enter "/Department" in the "Bill Area" field in the "Charge Entry" pane then search list should load with the text "/Department"
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Verify Bill Area selection from short list
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Bill Area" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "Fixed" from the "Show Short List" dropdown
    And I check the "Allow Access To FullList" checkbox
    And I click the "Edit Short List" button
    And I click the "SelectAllSelectedValueTable" button
    And I click the "Move Left Button" button if it exists
    And I select "Verve" in the "Non Selected List" table
    And I click the "Move Right Button" button if it exists
    And I click the "OK" button in the "Edit Short List" pane
    #And I select "Most Recent" from the "Show Short List" dropdown
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane
    Given I am logged into the portal with user "addchargeuser3" using the default password
    #Given I am logged into the portal with user "addchargeuser3" and password "123"
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I wait "2" seconds
    And I set the following charge headers
      | Name         | Value            |
      | Bill Area    | Verve            |
      | Billing Prov | USER3, ADDCHARGE |
      | Svc Site     | Inpatient        |
    And I enter the CPT codes "00192"
    #And I enter the ICD-9 code "111.0"
    And I enter the ICD-10 codes "B36.0"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I click the "recent" button in the "Bill Area" header section
    Then the text "Verve" should appear in the "Bill Area" search list
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Verify Bill Area selection from Most Recent Bill Area list
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Bill Area" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "Most Recent" from the "Show Short List" dropdown
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I wait "2" seconds
    And I set the following charge headers
      | Name         | Value            |
      | Bill Area    | Verve            |
      | Billing Prov | USER3, ADDCHARGE |
      | Svc Site     | Inpatient        |
    And I enter the CPT codes "00192"
    #And I enter the ICD-9 code "111.0"
    And I enter the ICD-10 codes "B36.0"
    And I click the "Submit" button
    And I select "Charges" from clinical navigation
    And I refresh the clinical display
    #make sure we're looking at the most recent Bill Area
    And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
    Then the following rows should appear in the "Charges" table
      | Date/Time             | Proc                             | Qty | Diag  |
      | %Current Date MMDDYY% | 00192 anesth facial bone surgery | 1   | B36.0 |
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I click the "recent" button in the "Bill Area" header section
    Then the text "Verve" should appear in the "Bill Area" search list
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Bill Area search when Short List Max setting artificially low
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Bill Area" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "Most Recent" from the "Show Short List" dropdown
    And I enter "1" in the "Short List Max" field
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    #Add charge to get newly added Bill area in Recent Bill Area selection
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I wait "2" seconds
    And I set the following charge headers
      | Name         | Value            |
      | Bill Area    | Hospitalist      |
      | Billing Prov | USER3, ADDCHARGE |
      | Svc Site     | Inpatient        |
    And I enter the CPT code "00192"
    #And I enter the ICD-9 code "111.0"
    And I enter the ICD-10 code "B36.0"
    And I click the "Submit" button in the "Charge Entry" pane
    #This step is added cos next step is getting fail continuously cos of sync.
    And I refresh the clinical display
    #Add charge to get newly added Bill area in Recent Bill Area selection
    When I click the "Charges +" button
    And I wait "2" seconds
    And I set the following charge headers
      | Name         | Value            |
      | Bill Area    | Verve            |
      | Billing Prov | USER3, ADDCHARGE |
      | Svc Site     | Inpatient        |
    And I enter the CPT code "00192"
    #And I enter the ICD-9 code "111.0"
    And I enter the ICD-10 code "B36.0"
    And I click the "Submit" button in the "Charge Entry" pane
    #This step is added cos next step is getting fail continuously cos of sync.
    And I refresh the clinical display
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I click the "recent" button in the "Bill Area" header section
    Then the text "Verve" should appear in the "Bill Area" search list
    When I click the "Close" image
    Then the "Charge Entry" pane should close
    #Revert back the setting
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Bill Area" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "Most Recent" from the "Show Short List" dropdown
    And I enter "10" in the "Short List Max" field
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane

  @ChargeCapture @Demo
  Scenario: Display results with partial text entry for Rendering Provider
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the CPT code "01953"
    When I enter "ADDCHARGE" in the "Rendering Provider" field in the "Charge Entry" pane then search list should load with the text "USER3, ADDCHARGE"
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture @Demo
  Scenario: Display results with full entry for Rendering Provider
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the CPT code "01953"
    When I enter "USER3, ADDCHARGE" in the "Rendering Provider" field in the "Charge Entry" pane then search list should load with the text "USER3, ADDCHARGE"
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Attempt search for record Rendering Provider does not exist
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the CPT code "01953"
    When I enter "lava" in the "Rendering Provider" field in the "Charge Entry" pane then search list should not load with the text "lava, kusha"
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: New charge level header is added to existing txn
    Given I am logged into the portal with user "pkadmin" using the default password
    When I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "Charge Capture" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    #And I click the "Charge Transaction Headers" edit link in the "Charge Capture Settings" pane
    And I click the "Add/Edit Charge Headers" edit link in the "Charge Capture Settings" pane
    And I click the "Add Header" button
    And I wait "2" seconds
    And I select "Text" from the "Type" dropdown
    And I enter "Facility" in the "Header Name" field
    And I click the "Save" button in the "Charge Header Edit Content" pane
    Then the "Charge Transaction Headers" table should have at least "1" row containing the text "Facility"
    And I click the "Close" button in the "Charge Transaction Content" pane
    #Verifying newly added Header appeared on the user level CC settings
    And I launch the charge transaction headers for "addchargeuser3" user
    Then the "Charge Transaction Headers" table should have at least "1" row containing the text "Facility"
    And I click the "Close" button in the "Charge Transaction Content" pane

  @ChargeCapture
  Scenario: Inst-level charge headers vs user-level charge headers
    Given I am logged into the portal with user "pkadmin" using the default password
    #Before changing in the institution level, verifying  header is present in user level
    And I launch the charge transaction headers for "addchargeuser3" user
    Then the "Charge Transaction Headers" table should have at least "1" row containing the text "Facility"
    And I click the "Close" button in the "Charge Transaction Content" pane
    #Now deleting Facility header in  the institution level
    And I select the "Institution" subtab
    And I select "Charge Capture" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    #And I click the "Charge Transaction Headers" edit link in the "Charge Capture Settings" pane
    And I click the "Add/Edit Charge Headers" edit link in the "Charge Capture Settings" pane
    And I wait "2" seconds
    And I select "Facility" in the "Charge Transaction Headers" table
    And I click the "Delete" button in the "Charge Transaction Content" pane
    And I click the "Yes" button in the "Question" pane
    And I wait "2" seconds
    Then the "Charge Transaction Headers" table should have at least "1" row not containing the text "Facility"
    When I click the "Close" button in the "Charge Transaction Content" pane
    #Verify deleted header should not appear in the userlevel settings
    And I launch the charge transaction headers for "addchargeuser3" user
    Then the "Charge Transaction Headers" table should have at least "1" row not containing the text "Facility"
    And I click the "Close" button in the "Charge Transaction Content" pane

  @ChargeCapture
  Scenario: Allow Access to Full List attribute Selected Not fixed list Attribute not available
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Bill Area" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "Fixed" from the "Show Short List" dropdown
    And I check the "Allow Access To FullList" checkbox
    And I click the "Edit Short List" button
    And I wait "2" seconds
    #make the selected short list as empty
    And I click the "SelectAllSelectedValueTable" button
    And I click the "Move Left Button" button
    And I click the "OK" button in the "Edit Short List" pane
    #And I select "Most Recent" from the "Show Short List" dropdown
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I click the "recent" button in the "Bill Area" header section
    Then the text "Filtered Results" should appear in the "Bill Area" search list
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Display results with partial text entry for Billing Provider
    When I select "Add Charge" from the "Patient Header Actions" menu
    When I enter "ADDCHARGE" in the "Billing Prov" field in the "Charge Entry" pane then search list should load with the text "USER3, ADDCHARGE"
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Display results with full entry for Billing Provider
    When I select "Add Charge" from the "Patient Header Actions" menu
    When I enter "USER3, ADDCHARGE" in the "Billing Prov" field in the "Charge Entry" pane then search list should load with the text "USER3, ADDCHARGE"
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Attempt search for record for Billing Provider that does not exist
    When I select "Add Charge" from the "Patient Header Actions" menu
    When I enter "FLASE, PROVIDER" in the "Billing Prov" field in the "Charge Entry" pane then search list should not load
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Search for record containing special characters for Billing Provider
   #Create a Provider with special character in System Management
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Admin" tab
    And I select the "System Management" subtab
    And I click the "Providers" link in the "System Management Navigation" pane
    Given the provider with firstname "PROVIDER" and lastname "$SPECIAL" is in the provider list
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    When I enter "$SPECIAL, PROVIDER" in the "Billing Prov" field in the "Charge Entry" pane then search list should load with the text "$SPECIAL, PROVIDER"
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Verify Billing Provider selection from Most Recent list
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Billing Prov" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "Most Recent" from the "Show Short List" dropdown
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane
    Given I am logged into the portal with user "addchargeuser3" using the default password
    When I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value            |
      | Bill Area    | Verve            |
      | Billing Prov | USER3, ADDCHARGE |
      | Svc Site     | Inpatient        |
    #And I enter the ICD-9 code "111.0" in the "Charge Entry" pane
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "00192"
    And I click the "Submit" button
    And I select "Charges" from clinical navigation
    And I refresh the clinical display
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I click the "recent" button in the "Billing Prov" header section
    Then the text "USER3, ADDCHARGE" should appear in the "Billing Prov" search list
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Verify Billing Provider selection from short list
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Billing Prov" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "Fixed" from the "Show Short List" dropdown
    And I check the "Allow Access To FullList" checkbox
    And I click the "Edit Short List" button
    And I wait "2" seconds
    And I add the following provider to the short list
      | USER3, ADDCHARGE |
   #And I choose "USER3, ADDCHARGE" provider in the edit short list
    #And I select "Most Recent" from the "Show Short List" dropdown
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value            |
      | Bill Area    | Verve            |
      | Billing Prov | USER3, ADDCHARGE |
      | Svc Site     | Inpatient        |
    And I enter the CPT codes "00192"
    #And I enter the ICD-9 code "111.0"
    And I enter the ICD-10 codes "B36.0"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I click the "recent" button in the "Billing Prov" header section
    Then the text "USER3, ADDCHARGE" should appear in the "Billing Prov" search list
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Billing Provider search when Short List Max setting artificially low
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Billing Prov" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "Most Recent" from the "Show Short List" dropdown
   #Set Short List Max as 1
    And I enter "1" in the "Short List Max" field
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value         |
      | Bill Area    | Verve         |
      | Billing Prov | KADMIN, PERRY |
      | Svc Site     | Inpatient     |
   #And I enter the ICD-9 code "111.0"
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "00192"
    And I click the "Submit" button in the "Charge Entry" pane
    And I wait for loading to complete
    And I select patient "Molly Darr" from the patient list
    And I click the "Charges +" button
    And I wait "2" seconds
    And I set the following charge headers
      | Name         | Value            |
      | Bill Area    | Verve            |
      | Billing Prov | USER3, ADDCHARGE |
      | Svc Site     | Inpatient        |
   #And I enter the ICD-9 code "111.0"
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "00192"
    And I click the "Submit" button in the "Charge Entry" pane
    And I wait for loading to complete
   #This step is added cos next step is getting fail continuously cos of sync.
    And I refresh the clinical display
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I click the "recent" button in the "Billing Prov" header section
    Then the text "USER3, ADDCHARGE" should appear in the "Billing Provider" search list
    Then the text "KADMIN, PERRY" should not appear in the "Billing Provider" search list
    When I click the "Close" image
    Then the "Charge Entry" pane should close
   #Revert back the setting
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Billing Prov" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "Most Recent" from the "Show Short List" dropdown
    And I enter "10" in the "Short List Max" field
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane

  @ChargeCapture
  Scenario: Search for record containing special characters for Rendering Provider
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the CPT code "00192"
    When I enter "$SPECIAL, PROVIDER" in the "Rendering Provider" field in the "Charge Entry" pane then search list should load with the text "$SPECIAL, PROVIDER"
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Verify Rendering Provider selection from short list
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Rendering Provider" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "Fixed" from the "Show Short List" dropdown
    And I check the "Allow Access To FullList" checkbox
    And I click the "Edit Short List" button
    And I wait "2" seconds
    And I add the following provider to the short list
      | USER3, ADDCHARGE |
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the CPT code "00192"
    And I click the "recent" button in the "Rendering Provider" header section
    Then the text "USER3, ADDCHARGE" should appear in the "Rendering Provider" search list
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Verify Rendering Provider selection from Most Recent list
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Rendering Provider" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "Most Recent" from the "Show Short List" dropdown
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane
    Given I am logged into the portal with user "addchargeuser3" using the default password
    When I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value         |
      | Bill Area    | Verve         |
      | Billing Prov | KADMIN, PERRY |
      | Svc Site     | Inpatient     |
   #And I enter the ICD-9 code "111.0" in the "Charge Entry" pane
    And I enter the ICD-10 code "B36.0" in the "Charge Entry" pane
    And I enter the CPT code "00192"
    And I set the following charge headers
      | Name               | Value            |
      | Rendering Provider | USER3, ADDCHARGE |
    And I click the "Submit" button
    And I select "Charges" from clinical navigation
    And I refresh the clinical display
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the CPT code "00192"
    And I click the "recent" button in the "Rendering Provider" header section
    Then the text "USER3, ADDCHARGE" should appear in the "Rendering Provider" search list
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Rendering Provider search when Short List Max setting artificially low
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Rendering Provider" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "Most Recent" from the "Show Short List" dropdown
   #Set Short List Max as 1
    And I enter "1" in the "Short List Max" field
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane
   # login with level 3 user
    Given I am logged into the portal with user "addchargeuser3" using the default password
    When I am on the "Patient List V2" tab
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value            |
      | Bill Area    | Verve            |
      | Billing Prov | USER3, ADDCHARGE |
      | Svc Site     | Inpatient        |
   #And I enter the ICD-9 code "111.0" in the "Charge Entry" pane
    And I enter the ICD-10 code "B36.0" in the "Charge Entry" pane
    And I enter the CPT code "00192"
    And I set the following charge headers
      | Name               | Value         |
      | Rendering Provider | KADMIN, PERRY |
    And I click the "Submit" button
   #Repeat the saving charge with different Provider
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then the "Charge Entry" pane should load within "5" seconds
    When I set the following charge headers
      | Name         | Value         |
      | Bill Area    | Verve         |
      | Billing Prov | KADMIN, PERRY |
      | Svc Site     | Inpatient     |
   #And I enter the ICD-9 code "111.0"
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "00192"
    And I set the following charge headers
      | Name               | Value            |
      | Rendering Provider | USER3, ADDCHARGE |
    And I click the "Submit" button
    And I select "Charges" from clinical navigation
    And I refresh the clinical display
    When I click the "Charges +" button
    And I wait "2" seconds
    And I enter the CPT code "00192"
    And I click the "recent" button in the "Rendering Provider" header section
    Then the text "USER3, ADDCHARGE" should appear in the "Rendering Provider" search list
    And the text "KADMIN, PERRY" should not appear in the "Rendering Provider" search list
    When I click the "Close" image
    Then the "Charge Entry" pane should close
   #Revert back the user charge transaction header setting with default value
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Rendering Provider" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "Most Recent" from the "Show Short List" dropdown
    And I enter "10" in the "Short List Max" field
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane

  @ChargeCapture
  Scenario: Fixed List - only returns items in fixed short list
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Billing Prov" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "Fixed" from the "Show Short List" dropdown
    And I uncheck the "Allow Access To FullList" checkbox
    And I click the "Edit Short List" button
    And I wait "2" seconds
    And I add the following providers to the short list
      | KADMIN, PERRY    |
      | USER3, ADDCHARGE |
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I click the "search" button in the "Billing Prov" header section
    Then the text "USER3, ADDCHARGE" should appear in the "Billing Prov" search list
    And the text "KADMIN, PERRY" should appear in the "Billing Prov" search list
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Not Fixed List - Attribute not available
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Billing Prov" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "Fixed" from the "Show Short List" dropdown
    And I uncheck the "Allow Access To FullList" checkbox
    And I click the "Edit Short List" button
    And I wait "2" seconds
    And I remove all the providers from the short list
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I click the "search" button in the "Billing Prov" header section
    Then the "Billing Provider" search list should not load
    When I enter "USER3, ADDCHARGE" in the "Billing Prov" field in the "Charge Entry" pane
    Then the "Billing Provider" search list should not load
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Fixed List when Show Short List is None
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Billing Prov" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "None" from the "Show Short List" dropdown
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I click the "search" button in the "Billing Prov" header section
    Then the "Billing Provider" search list should load
    When I enter "USER3, ADDCHARGE" in the "Billing Prov" field in the "Charge Entry" pane
    Then the text "USER3, ADDCHARGE" should appear in the "Billing Prov" search list
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Display Results with Partial text entry in Referring
    When I select "Add Charge" from the "Patient Header Actions" menu
    When I enter "ADDCHARGE" in the "Referring" field in the "Charge Entry" pane then search list should load with the text "USER3, ADDCHARGE"
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Display Results with Full text entry in Referring
    When I select "Add Charge" from the "Patient Header Actions" menu
    When I enter "USER3, ADDCHARGE" in the "Referring" field in the "Charge Entry" pane then search list should load with the text "USER3, ADDCHARGE"
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Attempt search for record that does not exist in Referring
    When I select "Add Charge" from the "Patient Header Actions" menu
    When I enter "NOREFERRING" in the "Referring" field in the "Charge Entry" pane then search list should not load with the text "NOREFERRING"
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Search for record that contains special character in Referring
    When I select "Add Charge" from the "Patient Header Actions" menu
    When I enter "$SPECIAL, PROVIDER" in the "Referring" field in the "Charge Entry" pane then search list should load with the text "$SPECIAL, PROVIDER"
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Verifying ReferringMD from Most Recent List
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I wait "2" seconds
    And I select "Referring" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "Most Recent" from the "Show Short List" dropdown
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane
    Given I am logged into the portal with user "addchargeuser3" using the default password
    When I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I wait "2" seconds
    And I set the following charge headers
      | Name         | Value            |
      | Bill Area    | Verve            |
      | Referring    | USER3, ADDCHARGE |
      | Svc Site     | Inpatient        |
      | Billing Prov | USER2, ADDCHARGE |
   #And I enter the ICD-9 code "111.0" in the "Charge Entry" pane
    And I enter the ICD-10 code "B36.0" in the "Charge Entry" pane
    And I enter the CPT code "00192"
    And I click the "Submit" button
    And I select "Charges" from clinical navigation
    And I refresh the clinical display
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I click the "recent" button in the "Referring" header section
    Then the text "USER3, ADDCHARGE" should appear in the "Referring" search list
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Verifying ReferringMD selection from short List
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Referring" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "Fixed" from the "Show Short List" dropdown
    And I check the "Allow Access To FullList" checkbox
    And I click the "Edit Short List" button
    And I wait "2" seconds
    And I add the following provider to the short list
      | USER3, ADDCHARGE |
   #And I choose "USER3, ADDCHARGE" provider in the edit short list
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I click the "recent" button in the "Referring" header section
    Then the text "USER3, ADDCHARGE" should appear in the "Referring" search list
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: ReferringMD Selection from ShortList Max Setting
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Referring" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "Most Recent" from the "Show Short List" dropdown
   #Set Short List Max as 1
    And I enter "1" in the "Short List Max" field
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value            |
      | Bill Area    | Verve            |
      | Referring    | USER3, ADDCHARGE |
      | Svc Site     | Inpatient        |
      | Billing Prov | USER2, ADDCHARGE |
   #And I enter the ICD-9 code "111.0"
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "00192"
    And I click the "Submit" button in the "Charge Entry" pane
    And I select patient "Molly Darr" from the patient list
    And I wait "2" seconds
    And I click the "Charges +" button
    And I wait "2" seconds
    And I set the following charge headers
      | Name         | Value            |
      | Bill Area    | Verve            |
      | Referring    | USER3, ADDCHARGE |
      | Svc Site     | Inpatient        |
      | Billing Prov | USER2, ADDCHARGE |
   #And I enter the ICD-9 code "111.0"
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "00192"
    And I click the "Submit" button in the "Charge Entry" pane
    #This step is added cos next step is getting fail continuously cos of sync.
    Then I wait "2" seconds
    And I refresh the clinical display
    Then I wait "2" seconds
    And I click the "Charges +" button
    And I wait "3" seconds
    When I click the "recent" button in the "Referring" header section
    Then the text "USER3, ADDCHARGE" should appear in the "Referring" search list
    And the text "USER2, ADDCHARGE" should not appear in the "Referring" search list
    When I click the "Close" image
    Then the "Charge Entry" pane should close
   #Revert back the setting
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Referring" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I select "Most Recent" from the "Show Short List" dropdown
    And I enter "10" in the "Short List Max" field
    And I click the "Save" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane

  @ChargeCapture @Demo
  Scenario: Show inactive existing diagnosis
    When I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value            |
      | Bill Area    | Verve            |
      | Billing Prov | USER3, ADDCHARGE |
      | Svc Site     | Inpatient        |
    And I enter the CPT code "01250"
   #And I enter the ICD-9 code "720.2"
    And I enter the ICD-10 code "M46.1"
    And I click the "Submit" button
    And I refresh the clinical display
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then the "Charge Entry" pane should load
   #And I "expand" the "Diagnoses" search section
    And I expand the "Existing" list in the "Diagnoses" search section
    Then the text "Sacroiliitis, not elsewhere classified" should appear in the "Charge Entry" pane
