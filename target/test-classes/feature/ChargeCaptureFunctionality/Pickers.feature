Feature: CC - 8.0 Pickers
  Background:
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Department" subtab

  @ChargeCapture
  Scenario: Create department picker from Code and description
    And I select the department "Verve"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
    And I wait "3" seconds
   #Then the "DepartmentChargeCaptureSettings" pane should load
    And I click the "Add/Edit Charge Pickers" edit link in the "DepartmentCharge Capture Settings" pane
   #Delete Existing pickers before proceed
    And I wait "3" seconds
    And I click the "Delete All Pickers" button in the "Department Charge Pickers" pane
    And I click the "Yes" button in the "Question" pane
    And I click the "Department Pickers" edit category link in the "Department Charge Pickers" pane
    And I wait "2" seconds
    And I click the "Add Category" button in the "Edit Department Pickers" pane
    And I wait "2" seconds
    And I enter "DeptChargePick" in the "Enter new categoryname" field
    And I click the "OK" button in the "Add Category Contents" pane
    And I click the "Save" button in the "Edit Department Pickers" pane
    Then the "Department Pickers Edit" table should have at least "1" row containing the text "DeptChargePick"
    And I click the "DeptChargePick" edit category link in the "Department Charge Pickers" pane
    And I wait "2" seconds
    And I enter "0001F heart failure composite" in the "Add Code" field in the "Edit Department Pickers" pane
    And I click the "Lookup Values" element in the "Edit Department Pickers" pane
    And I wait "5" seconds
    Then the "Quick Text" table should have "1" rows containing the text "0001F"
    And I click the "Save" button in the "Edit Department Pickers" pane
    Then the "Department Pickers Edit" table should have at least "1" row containing the text "0001F"
    And I click the "Close" button in the "Department Charge Pickers" pane

  @ChargeCapture
  Scenario: Create department picker from text search
    And I select the department "Verve"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
    And I click the "Add/Edit Charge Pickers" edit link in the "Department Charge Capture Settings" pane
    And I wait "2" seconds
    And I click the "DeptChargePick" edit category link in the "Department Charge Pickers" pane
    And I wait "2" seconds
    And I enter "wound" in the "Add Code" field in the "Edit Department Pickers" pane
    And I click the "Lookup Values" element in the "Edit Department Pickers" pane
    And I select "0183T" from the "Code" column in the "Add Code Result List" table
    Then the "Quick Text" table should have "1" row containing the text "0183T"
    And I click the "Save" button in the "Edit Department Pickers" pane
    Then the "Department Pickers Edit" table should have at least "1" row containing the text "0183T"
    And I click the "Close" button in the "Department Charge Pickers" pane

  @ChargeCapture
  Scenario: Create department picker from Code search
    And I select the department "Verve"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
    And I click the "Add/Edit Charge Pickers" edit link in the "Department Charge Capture Settings" pane
    And I wait "2" seconds
    And I click the "DeptChargePick" edit category link in the "Department Charge Pickers" pane
    And I wait "2" seconds
    And I enter "00142" in the "Add Code" field in the "Edit Department Pickers" pane
    And I click the "Lookup Values" element in the "Edit Department Pickers" pane
    Then the "Quick Text" table should have "1" rows containing the text "00142"
    And I click the "Save" button in the "Edit Department Pickers" pane
    Then the "Department Pickers Edit" table should have at least "1" row containing the text "00142"
    And I click the "Close" button in the "Department Charge Pickers" pane

  @ChargeCapture
  Scenario: Create user picker from Code and description
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Preferences" tab
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
    And I enter "00192 anesth facial bone surgery" in the "Add Code" field in the "Edit Pickers" pane
    And I click the "Lookup Values" element in the "Edit Pickers" pane
    Then the "Children Picker" table should have at least "1" row containing the text "00192"
    And I click the "Save" button in the "Edit Pickers" pane
    Then the "My Pickers" table should have at least "1" row containing the text "00192"
    And I click the "Close" button in the "Charge Pickers" pane

  @ChargeCapture
  Scenario: Create user picker from text search term
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Preferences" tab
    And I select "Charge Capture" from the "Edit Settings" dropdown in the "Personal Preference" pane
    And I click the "Add/Edit Charge Pickers" edit link in the "Preference CCSettings" pane
    And I wait "2" seconds
    And I click the "UserChargePick" edit category link in the "Charge Pickers" pane
    And I wait "2" seconds
    And I enter "pain" in the "Add Code" field in the "Edit Pickers" pane
    And I click the "Lookup Values" element in the "Edit Pickers" pane
    And I select "0109T" from the "Code" column in the "AddCode Result List" table
    Then the "Children Picker" table should have at least "1" row containing the text "0109T"
    And I click the "Save" button in the "Edit Pickers" pane
    Then the "My Pickers" table should have at least "1" row containing the text "heat quant sensory test"
    And I click the "Close" button in the "Charge Pickers" pane

  @ChargeCapture
  Scenario: Create user picker from code search term
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Preferences" tab
    And I select "Charge Capture" from the "Edit Settings" dropdown in the "Personal Preference" pane
    And I click the "Add/Edit Charge Pickers" edit link in the "Preference CCSettings" pane
    And I wait "2" seconds
    And I click the "UserChargePick" edit category link in the "Charge Pickers" pane
    And I wait "2" seconds
    And I enter "33315" in the "Add Code" field in the "Edit Pickers" pane
    And I click the "Lookup Values" element in the "Edit Pickers" pane
    Then the "Children Picker" table should have at least "1" rows containing the text "33315"
    And I click the "Save" button in the "Edit Pickers" pane
    Then the "My Pickers" table should have at least "1" row containing the text "33315"
    And I click the "Close" button in the "Charge Pickers" pane

#    #  [DEV-79243]: https://jira/browse/DEV-79243: Automation : CPT & Picker codes not displayed in charges section
 #Physician uses pickers on Add/Edit
  @ChargeCapture @Demo
  Scenario: Use dept-picker from code search term[DEV-79243]
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And I select "CCList" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I wait "2" seconds
    And I click the "Pickers" button
    And I choose the "0001F" code in the "DeptChargePick" picker list in the "Charges" search section
    Then the text "0001F" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Close" image
    Then the "Charge Entry" pane should close

#    #  [DEV-79243]: https://jira/browse/DEV-79243: Automation : CPT & Picker codes not displayed in charges section
  @ChargeCapture @Demo
  Scenario: Use dept picker from text search term[DEV-79243]
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And I select "CCList" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then the "Charge Entry" pane should load
    And I choose the "heart failure composite" code description in the "DeptChargePick" picker list in the "Charges" search section
    Then the text "heart failure composite" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture @Demo
  Scenario: Use user-picker from code search term
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Preferences" tab
    And I select "Charge Capture" from the "Edit Settings" dropdown in the "Personal Preference" pane
    And I click the "Add/Edit Charge Pickers" edit link in the "Preference CCSettings" pane
    And I click the "Reset User Pickers" button
    And I click the "Cancel" button in the "Question" pane
    When I click the "My Pickers" edit category link in the "Charge Pickers" pane
    And I wait "2" seconds
    And I click the "Add Category" button in the "Edit Pickers" pane
    And I wait "2" seconds
    And I enter "UserChargePick" in the "Enter new categoryname" field
    And I click the "OK" button in the "AddCategoryContents" pane
    And I click the "Save" button in the "Edit Pickers" pane
    Then the "My Pickers" table should have at least "1" row containing the text "UserChargePick"
    And I click the "UserChargePick" edit category link in the "Charge Pickers" pane
    And I wait "2" seconds
    And I enter "00192 anesth facial bone surgery" in the "Add Code" field in the "Edit Pickers" pane
    And I click the "Lookup Values" element in the "Edit Pickers" pane
    And I enter "0109T heat quant sensory test" in the "Add Code" field in the "Edit Pickers" pane
    And I click the "Lookup Values" element in the "Edit Pickers" pane
    Then the "Children Picker" table should have at least "1" row containing the text "00192"
    And I click the "Save" button in the "Edit Pickers" pane
    Then the "My Pickers" table should have at least "1" row containing the text "00192"
    And I click the "Close" button in the "Charge Pickers" pane
    And I am on the "Patient List V2" tab
    And I select "CCList" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then the "Charge Entry" pane should load within "10" seconds
    When I choose the "00192" code in the "UserChargePick" picker list in the "Charges" search section
    And I choose the "heat quant sensory test" code description in the "UserChargePick" list in the "Charges" search section in the "ChargeEntry" pane
    Then the text "00192" should appear in the "Charge List" section in the "Charge Entry" pane
    And the text "heat quant sensory test" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @donotrun
  Scenario: Use user picker from text search term
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And I select "CCList" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I wait "3" seconds
    And I "expand" the "Charges" search section
    And I expand the "UserChargePick" list in the "Charges" search section
    And I choose the "anesth facial bone surgery" code description in the "UserChargePick" list in the "Charges" search section in the "ChargeEntry" pane
    Then the text "anesth facial bone surgery" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture
  Scenario: Editing picker at Department level
    And I select the department "Verve"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
    And I click the "Add/Edit Charge Pickers" edit link in the "Department Charge Capture Settings" pane
    And I wait "5" seconds
    And I click the "DeptChargePick" edit category link in the "Department Charge Pickers" pane
    And I wait "5" seconds
    And I enter "NewDeptChargePicker" in the "Picker Name" field in the "Edit Department Pickers" pane
    And I click the "Save" button in the "Edit Department Pickers" pane
    Then the "Department Pickers Edit" table should have at least "1" row containing the text "NewDeptChargePicker"
    And the "Department Pickers Edit" table should have at least "1" row not containing the text "DeptChargePick"
    And I click the "Close" button in the "Department Charge Pickers" pane

  @ChargeCapture
  Scenario: Deleting picker at Department level
    And I select the department "Verve"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
    And I click the "Add/Edit Charge Pickers" edit link in the "Department Charge Capture Settings" pane
    And I wait "2" seconds
    And I click the "NewDeptChargePicker" edit category link in the "Department Charge Pickers" pane
    And I wait "2" seconds
    And I click the "Delete" button in the "Edit Department Pickers" pane
    Then the "Department Pickers Edit" table should have at least "1" row not containing the text "NewDeptChargePicker"
    And I click the "Close" button in the "Department Charge Pickers" pane

  @ChargeCapture
  Scenario: Delete All Pickers at Department level
    And I select the department "Verve"
    And I click the "Edit" button in the "Quick Details" pane
    And I wait "2" seconds
    And I select "Charge Capture" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
    And I click the "Add/Edit Charge Pickers" edit link in the "Department Charge Capture Settings" pane
    And I wait "3" seconds
    And I click the "Delete All Pickers" button in the "Department Charge Pickers" pane
    And I click the "Yes" button in the "Question" pane
    Then the "Department Pickers Edit" table should have "1" row
    And I click the "Close" button in the "Department Charge Pickers" pane

  @ChargeCapture @Demo
  Scenario: Filtering pickers by Visit type PK at user level
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Preferences" tab
    And I select "Charge Capture" from the "Edit Settings" dropdown in the "Personal Preference" pane
    And I click the "Add/Edit Charge Pickers" edit link in the "Preference CCSettings" pane
    And I wait "2" seconds
    And I click the "My Pickers" edit category link in the "Charge Pickers" pane
    And I wait "2" seconds
    And I click the "Add Category" button in the "Edit Pickers" pane
    And I wait "2" seconds
    And I enter "PKChargePicker" in the "Enter new category name" field
    And I click the "OK" button in the "Add Category Contents" pane
    And I click the "Save" button in the "Edit Pickers" pane
    Then the "My Pickers" table should have at least "1" row containing the text "PKChargePicker"
    And I select "PK" from the "VisitType" radio list in the "Charge Pickers" pane
    And I wait "5" seconds
    And I select "Inpatient" from the "PKVisit" dropdown
    And I wait "5" seconds
    And I click the "PKChargePicker" edit category link in the "Charge Pickers" pane
    And I wait "5" seconds
    And I select "PK" from the "Include Visit Type" radio list in the "Edit Pickers" pane
    And I check the "Inpatient" checkbox in the "Edit Pickers" pane
    And I enter "01250" in the "Add Code" field in the "Edit Pickers" pane
    And I click the "Lookup Values" element in the "Edit Pickers" pane
    Then the "Children Picker" table should have at least "1" rows containing the text "01250"
    And I click the "Save" button in the "Edit Pickers" pane
    And the "My Pickers" table should have at least "1" row containing the text "PKChargePicker"
    Then the "My Pickers" table should have at least "1" row containing the text "01250"
    And I click the "Close" button in the "Charge Pickers" pane

  @ChargeCapture @Demo
  Scenario: Filtering pickers by Visit type ADT at user level
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Preferences" tab
    And I select "Charge Capture" from the "Edit Settings" dropdown in the "Personal Preference" pane
    And I click the "Add/Edit Charge Pickers" edit link in the "Preference CCSettings" pane
    And I wait "2" seconds
    And I click the "My Pickers" edit category link in the "Charge Pickers" pane
    And I click the "Add Category" button in the "Edit Pickers" pane
    And I wait "2" seconds
    And I enter "ADTChargePicker" in the "Enter new categoryname" field
    And I click the "OK" button in the "AddCategoryContents" pane
    And I click the "Save" button in the "Edit Pickers" pane
    Then the "My Pickers" table should have at least "1" row containing the text "ADTChargePicker"
    And I select "ADT" from the "VisitType" radio list in the "Charge Pickers" pane
    And I select "I: SIMHOSPITAL" from the "ADTVisit" dropdown
    And I wait "5" seconds
    And I click the "ADTChargePicker" edit category link in the "Charge Pickers" pane
    And I wait "5" seconds
    And I select "ADT" from the "IncludeVisitType" radio list in the "Edit Pickers" pane
    And I check the "ISimhospital" checkbox in the "Edit Pickers" pane
    And I enter "01810" in the "Add Code" field in the "Edit Pickers" pane
    And I click the "Lookup Values" element in the "Edit Pickers" pane
    Then the "Children Picker" table should have at least "1" rows containing the text "01810"
    And I click the "Save" button in the "Edit Pickers" pane
    Then the "My Pickers" table should have at least "1" row containing the text "ADTChargePicker"
    And the "My Pickers" table should have at least "1" row containing the text "01810"
    And the "My Pickers" table should have at least "1" row not containing the text "PKChargePicker"
    And I click the "Close" button in the "Charge Pickers" pane

  @ChargeCapture
  Scenario: Nothing default selection Filtering at user level
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Preferences" tab
    And I select "Charge Capture" from the "Edit Settings" dropdown in the "Personal Preference" pane
    And I click the "Add/Edit Charge Pickers" edit link in the "Preference CCSettings" pane
    And I wait "2" seconds
   #Default Visit Type selection be All and should list all pickers
    Then the "My Pickers" table should have at least "1" row containing the text "UserChargePick"
    And the "My Pickers" table should have at least "1" row containing the text "PKChargePicker"
    And the "My Pickers" table should have at least "1" row containing the text "ADTChargePicker"
    And I click the "Close" button in the "Charge Pickers" pane

  @ChargeCapture
  Scenario: Editing picker at user level
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Preferences" tab
    And I select "Charge Capture" from the "Edit Settings" dropdown in the "Personal Preference" pane
    And I click the "Add/Edit Charge Pickers" edit link in the "Preference CCSettings" pane
    And I wait "2" seconds
    And I click the "UserChargePick" edit category link in the "Charge Pickers" pane
    And I wait "2" seconds
    And I enter "NewChargePicker" in the "Picker Name" field in the "Edit Pickers" pane
    And I click the "Save" button in the "Edit Pickers" pane
    Then the "My Pickers" table should have at least "1" row containing the text "NewChargePicker"
    And the "My Pickers" table should have at least "1" row not containing the text "UserChargePick"
    And I click the "Close" button in the "Charge Pickers" pane

  @ChargeCapture
  Scenario: Deleting picker at user level
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Preferences" tab
    And I select "Charge Capture" from the "Edit Settings" dropdown in the "Personal Preference" pane
    And I click the "Add/Edit Charge Pickers" edit link in the "Preference CCSettings" pane
    And I wait "2" seconds
    And I click the "PKChargePicker" edit category link in the "Charge Pickers" pane
    And I wait "2" seconds
    And I click the "Delete" button in the "Edit Pickers" pane
    Then the "My Pickers" table should have at least "1" row not containing the text "PKChargePicker"
    And I click the "Close" button in the "Charge Pickers" pane

  @ChargeCapture
  Scenario: Delete All User Pickers at user level
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Preferences" tab
    And I select "Charge Capture" from the "Edit Settings" dropdown in the "Personal Preference" pane
    And I click the "Add/Edit Charge Pickers" edit link in the "Preference CCSettings" pane
    And I click the "Reset User Pickers" button
    And I click the "Delete All" button in the "Question" pane
    And I wait up to "5" seconds for the "Charge Pickers Loading Icon" field of type "MISC_ELEMENT" to be invisible
#    And I wait "5" seconds
    Then the "My Pickers" table should have "1" row
    And I click the "Close" button in the "Charge Pickers" pane

  @ChargeCapture @Demo
  Scenario: Create a diagnoses picker and select from a Diagnoses Picker list
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Preferences" tab
    And I select "Problem List" from the "Edit Settings" dropdown in the "Personal Preference" pane
    And I click the "Diagnosis Pickers" edit link in the "Preference CCSettings" pane
    #Delete existing pickers before proceed
    And I click the "Reset User Pickers" button
    And I click the "Delete All" button in the "Question" pane
    And I click the "My Pickers" edit category link in the "Charge Pickers" pane
    And I wait "2" seconds
    And I click the "Add Category" button in the "Edit Pickers" pane
    And I wait "2" seconds
    And I enter "UserDxPick" in the "Enter new categoryname" field
    And I click the "OK" button in the "AddCategoryContents" pane
    And I click the "Save" button in the "Edit Pickers" pane
    Then the "My Pickers" table should have at least "1" row containing the text "UserDxPick"
    And I click the "UserDxPick" edit category link in the "Charge Pickers" pane
    And I wait "2" seconds
    And I enter "Pityriasis versicolor" in the "Add Code" field in the "Edit Pickers" pane
    And I click the "Lookup Values" element in the "Edit Pickers" pane
    Then the "Children Picker" table should load
    Then the "Children Picker" table should have at least "1" row containing the text "B36.0"
    When I click the "Save" button in the "Edit Pickers" pane
    Then the "My Pickers" table should have at least "1" row containing the text "111.0 / B36.0"
    When I click the "Close" button in the "Charge Pickers" pane
    And I am on the "Patient List V2" tab
    And I select "CCList" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then the "Charge Entry" pane should load within "10" seconds
    And I expand the "UserDxPick" picker list in the "Diagnoses" search section
    And I choose the "B36.0" code in the "UserDxPick" picker list in the "Diagnoses" search section
    Then the text "B36.0" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    And the text "Pityriasis versicolor" should appear in the "Diagnosis List" section in the "Charge Entry" pane
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture @Demo
  Scenario: Create a Macro
    Given I am logged into the portal with user "addchargeuser1" using the default password
    And I am on the "Admin" tab
    And I select the "Department" subtab
    And I select the department "/Department"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
    And I click the "Add/Edit Department Macros" edit link in the "Department Charge Capture Settings" pane
    And I click the "New Macro" button
    And I click the "New Charge" button
    And I click the "MacroCharge" button
    And I wait "3" seconds
    And I enter "00192" in the "SearchCPT" field
    And I click the "Search..CPT" button
    Then the text "00192: anesth facial bone surgery" should appear in the "Department Macro" pane
    And I click the "Save" button in the "Department Macro" pane
    And I wait "3" seconds
    When I enter "macronew" in the "MacroLabel" field
    And I click the "Save" button in the "Quick Details" pane
    And I wait "2" seconds
    When I click the "Return to Charge Capture Settings" link in the "Department Settings" pane
    And I click the "Add/Edit Charge Pickers" edit link in the "Department Charge Capture Settings" pane
    And I wait "3" seconds
    And I click the "Department Pickers" edit category link in the "Department Charge Pickers" pane
    And I wait "3" seconds
    And I click the "AddMacros" button
    And I wait "2" seconds
    And I select "the first item" in the "AddMacros" table
    And I click the "Add" button in the "AddMacros" pane
    And I click the "Save" button in the "Edit Department Pickers" pane
    And I wait "2" seconds
    And I click the "Close" button in the "Department Charge Pickers" pane

  @ChargeCapture @Demo
  Scenario: Pick a Macro
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And I select "CCList" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    When I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    Then the "Charge Entry" pane should load within "10" seconds
    And I expand the "Custom (Uncategorized)" list in the "Charges" search section
    And I choose the "macronew" code description in the "Custom (Uncategorized)" list in the "Charges" search section in the "ChargeEntry" pane
    Then the text "00192" should appear in the "Charge List" section in the "Charge Entry" pane
    And the text "anesth facial bone surgery" should appear in the "Charge List" section in the "Charge Entry" pane
    When I click the "Close" image
    Then the "Charge Entry" pane should close

  @ChargeCapture @Demo
  Scenario: Deleting macros at Department level
    When I select the department "/Department"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
    And I click the "Add/Edit Department Macros" edit link in the "Department Charge Capture Settings" pane
    And I wait "2" seconds
    And I click the "Delete" button in the "Quick Details" pane if it exists
    And I click "OK" in the confirmation box