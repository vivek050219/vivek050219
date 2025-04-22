@MedRec
Feature: Medication Reconciliation


#  Scenario: Setup
  Background:
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "MedRecPLV2" owned by "medrecuser3" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I use the API to favorite patient list "MedRecPLV2" for user "medrecuser3" owned by "medrecuser3"
    And I click the "Refresh Patient List" button
    And I select "MedRecPLV2" from the "Patient List" menu
    And there should not be any unfinished orders


  @PatientSafety
  Scenario: 1. Disable all in User Pref and Location
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "medrecuser3"
    And I select the user "medrecuser3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "CPOE" from the "Edit User Settings" dropdown
    And I wait "3" seconds
    And I edit the following user settings and I click save
      | Page | Name                     | Type  | Value |
      | CPOE | Can Enter Orders         | radio | false |
      | CPOE | Enable Admission Med Rec | radio | false |
      | CPOE | Enable Discharge Med Rec | radio | false |
      | CPOE | Add Home Medications     | radio | false |
      | CPOE | Continue Home Meds       | radio | false |
    And I select the "Location" subtab
    And I wait "2" seconds
    And I select the "PKHospital-Verve" facility
    And I wait "2" seconds
    And I click the "Edit Location" button
    And I wait "2" seconds
    And the "Edit Location Prefs" pane should load
    And I select "true" from the "CPOEEnabled" radio list
    And I uncheck the "Admission" checkbox
    And I wait "2" seconds
    And I uncheck the "Discharge" checkbox
           # Disable Allow Hold for Admission
    And I select "false" from the "Allow Hold for Admission" radio list
    And I select "false" from the "Enable Continue Home Meds" radio list
    And I wait "3" seconds
    And I click the "Save Edit Location Pref" button
    When I am logged into the portal with user "medrecuser3" using the default password
    Then I am on the "Patient List V2" tab
    And I select "MedRecPLV2" from the "Patient List" menu
    And "MEDREC PATIENT2" is on the patient list
    And I select patient "MEDREC PATIENT2" from the patient list
    And I select "Orders" from clinical navigation
    Then the following field should not display in the "Orders" pane
      | Name               | Type   |
      | Adm Med Rec        | button |
      | Discharge Med Rec  | button |
      | Enter Orders       | button |
      | Continue Home Meds | button |
    When I select "Home Meds" from clinical navigation
    Then the following field should not display in the "Home Medications" pane
      | Name               | Type   |
      | Adm Med Rec        | button |
      | Discharge Med Rec  | button |
      | Continue Home Meds | button |


  @PatientSafety
  Scenario: 2. Enable AMR and Enter Orders only
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "medrecuser3"
    And I select the user "medrecuser3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "CPOE" from the "Edit User Settings" dropdown
    And I edit the following user settings and I click save
      | Page | Name                     | Type  | Value |
      | CPOE | Can Enter Orders         | radio | true  |
      | CPOE | Enable Admission Med Rec | radio | true  |
      | CPOE | Enable Discharge Med Rec | radio | false |
      | CPOE | Add Home Medications     | radio | false |
      | CPOE | Continue Home Meds       | radio | false |
    And I select the "Location" subtab
    And I select the "PKHospital-Verve" facility
    And I wait "2" seconds
    And I click the "Edit Location" button
    And I wait "2" seconds
    And the "Edit Location Prefs" pane should load
    And I select "true" from the "CPOEEnabled" radio list
    And I check the "Admission" checkbox
    And I wait "2" seconds
    And I uncheck the "Discharge" checkbox
    And I select "false" from the "Enable Continue Home Meds" radio list
    And I wait "3" seconds
    And I click the "Save Edit Location Pref" button
#
    When I am logged into the portal with user "medrecuser3" using the default password
    Then I am on the "Patient List V2" tab
    And I select "MedRecPLV2" from the "Patient List" menu
    When "MEDREC PATIENT2" is on the patient list
    Then I select patient "MEDREC PATIENT2" from the patient list
    And I select "Orders" from clinical navigation
    Then the following field should display in the "Orders" pane
      | Name         | Type   |
      | Adm Med Rec  | button |
      | Enter Orders | button |
    And the following field should not display in the "Orders" pane
      | Name               | Type   |
      | Discharge Med Rec  | button |
      | Continue Home Meds | button |
    When I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load within "5" seconds
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane
     #Then the "Admission Medication Reconciliation" pane should close
    When I select "Home Meds" from clinical navigation
    Then the following field should display in the "Home Medications" pane
      | Name        | Type   |
      | Adm Med Rec | button |
    And the following field should not display in the "Home Medications" pane
      | Name               | Type   |
      | Discharge Med Rec  | button |
      | Continue Home Meds | button |
    When I click the "Adm Med Rec" button in the "Home Medications" pane
    And the "Admission Medication Reconciliation" pane should load within "5" seconds
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane

  @PatientSafety
  Scenario: 3. Enable DMR and Enter Orders only
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "medrecuser3"
    And I select the user "medrecuser3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "CPOE" from the "Edit User Settings" dropdown
#    in the "User Preferences" pane
    And I edit the following user settings and I click save
      | Page | Name                     | Type  | Value |
      | CPOE | Can Enter Orders         | radio | true  |
      | CPOE | Enable Admission Med Rec | radio | false |
      | CPOE | Enable Discharge Med Rec | radio | true  |
      | CPOE | Add Home Medications     | radio | false |
      | CPOE | Continue Home Meds       | radio | false |
    And I select the "Location" subtab
    And I wait "2" seconds
    And I select the "PKHospital-Verve" facility
    And I wait "2" seconds
    And I click the "Edit Location" button
    And I wait "2" seconds
    And the "Edit Location Prefs" pane should load
    And I select "true" from the "CPOEEnabled" radio list
    And I uncheck the "Admission" checkbox
    And I wait "2" seconds
    And I check the "Discharge" checkbox
    And I select "false" from the "Enable Continue Home Meds" radio list
    And I wait "3" seconds
    And I click the "Save Edit Location Pref" button
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And I select "MedRecPLV2" from the "Patient List" menu
    And "MEDREC PATIENT2" is on the patient list
    And I select patient "MEDREC PATIENT2" from the patient list
    And I select "Orders" from clinical navigation
    Then the following field should display in the "Orders" pane
      | Name              | Type   |
      | Discharge Med Rec | button |
      | Enter Orders      | button |
    And the following field should not display in the "Orders" pane
      | Name               | Type   |
      | Adm Med Rec        | button |
      | Continue Home Meds | button |
    When I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load within "5" seconds
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane
    And I wait "2" seconds
    Then the "Discharge Medication Reconciliation" pane should close
    When I select "Home Meds" from clinical navigation
    Then the following field should display in the "Home Medications" pane
      | Name              | Type   |
      | Discharge Med Rec | button |
    And the following field should not display in the "Home Medications" pane
      | Name               | Type   |
      | Adm Med Rec        | button |
      | Continue Home Meds | button |
    When I click the "Discharge Med Rec" button in the "Home Medications" pane
    Then the "Discharge Medication Reconciliation" pane should load within "5" seconds
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane
    And I wait "2" seconds
    Then the "Discharge Medication Reconciliation" pane should close
    When I select "Discharge Orders" from clinical navigation
    Then the "Discharge Orders" pane should load within "5" seconds
    Then the following field should display in the "Discharge Orders" pane
      | Name              | Type   |
      | Discharge Med Rec | button |
    When I click the "Discharge Med Rec" button in the "Discharge Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load within "5" seconds
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane

  @PatientSafety
  Scenario: 4. Enable CHM and Enter Orders only
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "medrecuser3"
    And I select the user "medrecuser3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "CPOE" from the "Edit User Settings" dropdown
    And I edit the following user settings and I click save
      | Page | Name                     | Type  | Value |
      | CPOE | Can Enter Orders         | radio | true  |
      | CPOE | Enable Admission Med Rec | radio | false |
      | CPOE | Enable Discharge Med Rec | radio | false |
      | CPOE | Add Home Medications     | radio | false |
      | CPOE | Continue Home Meds       | radio | true  |
    And I select the "Location" subtab
    And I select the "PKHospital-Verve" facility
    And I wait "2" seconds
    And I click the "Edit Location" button
    And I wait "2" seconds
    And the "Edit Location Prefs" pane should load
    And I select "true" from the "CPOEEnabled" radio list
    And I uncheck the "Admission" checkbox
    And I wait "2" seconds
    And I uncheck the "Discharge" checkbox
    And I select "true" from the "Enable Continue Home Meds" radio list
    And I wait "3" seconds
    And I click the "Save Edit Location Pref" button
#
    When I am logged into the portal with user "medrecuser3" using the default password
    Then I am on the "Patient List V2" tab
    And I select "MedRecPLV2" from the "Patient List" menu
    And "MEDREC PATIENT2" is on the patient list
    And I select patient "MEDREC PATIENT2" from the patient list
    And I select "Orders" from clinical navigation
    And I wait "2" seconds
    Then the following field should display in the "Orders" pane
      | Name               | Type   |
      | Enter Orders       | button |
      | Continue Home Meds | button |
    And the following field should not display in the "Orders" pane
      | Name              | Type   |
      | Adm Med Rec       | button |
      | Discharge Med Rec | button |
    When I click the "Continue Home Meds" button in the "Orders" pane
    Then the "Continue Home Medication" pane should load within "5" seconds
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button
     #Then the "Continue Home Medication" pane should close
    When I select "Home Meds" from clinical navigation
    Then the following field should display in the "Home Medications" pane
      | Name               | Type   |
      | Continue Home Meds | button |
    When I click the "Continue Home Meds" button in the "Home Medications" pane
    Then the "Continue Home Medication" pane should load within "5" seconds
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button


#    DEV-84514 -- Edit Facility Group Utilities Settings pane can take more than 10 - 20 seconds to load, Intermittent issue
  @PatientSafety
  Scenario: 5. Enable All Med Rec Settings for Level 3 User
    Given I am logged into the portal with user "pkadminv2" using the default password
    Then I enable interaction display alerts
    And I revert prevent ordering of redundant lab tests
    And I disable the medication duplicate display interaction checking option
    And I select the "User" subtab
    And I search for the user "medrecuser3"
    And I select the user "medrecuser3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "CPOE" from the "Edit User Settings" dropdown
    And I edit the following user settings and I click save
      | Page | Name                     | Type  | Value |
      | CPOE | Can Enter Orders         | radio | true  |
      | CPOE | Enable Admission Med Rec | radio | true  |
      | CPOE | Enable Discharge Med Rec | radio | true  |
      | CPOE | Add Home Medications     | radio | true  |
      | CPOE | Continue Home Meds       | radio | true  |
    And I select the "Location" subtab
    And I wait "2" seconds
    And I select the "PKHospital-Verve" facility
    And I click the "Edit Location" button
    And I wait "2" seconds
    And the "Edit Location Prefs" pane should load
    And I select "true" from the "CPOEEnabled" radio list
    And I check the "Admission" checkbox
    And I wait "2" seconds
    And I check the "Discharge" checkbox
    And I select "true" from the "Enable Continue Home Meds" radio list
    And I click the "Delete Order Definition" image if it exists
    And I wait "3" seconds
    And I click the "Save Edit Location Pref" button
##
    When I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And I select "MedRecPLV2" from the "Patient List" menu
    Then "MEDREC PATIENT2" is on the patient list
    And I select patient "MEDREC PATIENT2" from the patient list
    And I select "Orders" from clinical navigation
    Then the following field should display in the "Orders" pane
      | Name               | Type   |
      | Enter Orders       | button |
      | Continue Home Meds | button |
      | Adm Med Rec        | button |
      | Discharge Med Rec  | button |
    When I click the "Enter Orders" button in the "Orders" pane
    Then the "Enter Orders" pane should load within "5" seconds
    When I click the "Add Order Cancel" button in the "Order Submission" pane
    Then the "Enter Orders" pane should close
    And I wait "5" seconds
    When I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load within "5" seconds
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button
     #Then the "Admission Medication Reconciliation" pane should close
    When I click the "Continue Home Meds" button in the "Orders" pane
    Then the "Continue Home Medication" pane should load within "5" seconds
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button
    And I wait "2" seconds
    Then the "Continue Home Medication" pane should close
    When I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load within "5" seconds
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button
    And I wait "2" seconds
    Then the "Discharge Medication Reconciliation" pane should close
    When I select "Home Meds" from clinical navigation
    Then the following field should display in the "Home Medications" pane
      | Name               | Type   |
      | Continue Home Meds | button |
      | Adm Med Rec        | button |
      | Discharge Med Rec  | button |
    When I click the "Adm Med Rec" button in the "Home Medications" pane
    Then the "Admission Medication Reconciliation" pane should load within "5" seconds
    When I click the "Med Rec Cancel" button
    And I wait "2" seconds
    And I click the "Yes" button
    And I wait "2" seconds
    Then the "Admission Medication Reconciliation" pane should close
    When I click the "Continue Home Meds" button in the "Home Medications" pane
    Then the "Continue Home Medication" pane should load within "5" seconds
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button
    And I wait "2" seconds
    Then the "Continue Home Medication" pane should close
    When I click the "Discharge Med Rec" button in the "Home Medications" pane
    Then the "Discharge Medication Reconciliation" pane should load within "5" seconds
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button
    And I wait "2" seconds
    Then the "Discharge Medication Reconciliation" pane should close
    When I select "Discharge Orders" from clinical navigation
    Then the following field should display in the "Discharge Orders" pane
      | Name              | Type   |
      | Discharge Med Rec | button |
    When I click the "Discharge Med Rec" button in the "Discharge Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load within "5" seconds
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button


  Scenario: 6. Verify the MedRec links in Admission Med Rec page
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Admission Med Rec" from the "Patient Header Actions" menu
    Then the "Admission Medication Reconciliation" pane should load within "5" seconds
    And the following fields should display in the "Admission Medication Reconciliation" pane
      | Name                 | Type     |
      | Med Rec Visits       | dropdown |
      | Show Clinical Data   | button   |
      | Reconcile and Submit | button   |
      | Med Rec Cancel       | button   |
      | here                 | link     |
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "norflox" in the "Search for order" field in the "Search for order" pane
    And I select "Noroxin tablet (norfloxacin) 400MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then the "Medication Reconciliation" table should load with the following columns
      | Home Medications*          |
      | Action for Hospitalization |
      | Hospital Orders*           |
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 7. Admission Med Rec window from Home Meds
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Home Meds" from clinical navigation
    And I click the "Adm Med Rec" button in the "Home Medications" pane
    Then the "Admission Medication Reconciliation" pane should load within "5" seconds
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "norflox" in the "Search for order" field in the "Search for order" pane
    And I select "Noroxin tablet (norfloxacin) 400MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then the "Medication Reconciliation" table should load with the following columns
      | Home Medications*          |
      | Action for Hospitalization |
      | Hospital Orders*           |
    And the following fields should display in the "Admission Medication Reconciliation" pane
      | Name                 | Type     |
      | Med Rec Visits       | dropdown |
      | Show Clinical Data   | button   |
      | Reconcile and Submit | button   |
      | Med Rec Cancel       | button   |
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 8. Adm Med Rec access through Patient Search
    When I am on the "Patient Search" tab
    And I wait "2" seconds
    And I click the "Clear Criteria" button
    And I uncheck the "Include Cancelled Visits" checkbox
    And I uncheck the "Include Past Visits" checkbox
    And I enter "PATIENT1" in the "Last" field in the "Patient Search Criteria" pane
    And I enter "MEDREC" in the "First" field in the "Patient Search Criteria" pane
    And I select "PKHospital-Verve" from the "Facility" dropdown in the "Patient Search Criteria" pane
    And I click the "Search for Visits" button
    And I select patient "MEDREC PATIENT1" from the "Name (\d)" column in the "Visit Search Results" table
    And I select "Admission Med Rec" from the "Actions" menu
    And I wait "5" seconds
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "norflox" in the "Search for order" field in the "Search for order" pane
    And I select "Noroxin tablet (norfloxacin) 400MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then the "Medication Reconciliation" table should load with the following columns
      | Home Medications*          |
      | Action for Hospitalization |
      | Hospital Orders*           |
    And the following fields should display in the "Admission Medication Reconciliation" pane
      | Name                 | Type     |
      | Med Rec Visits       | dropdown |
      | Show Clinical Data   | button   |
      | Reconcile and Submit | button   |
      | Med Rec Cancel       | button   |
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane

  @PatientSafety
  Scenario: 9. Setup-Med Rec Enable in User Preferences
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "medrecuser3"
    And I select the user "medrecuser3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "CPOE" from the "Edit User Settings" dropdown
    And I edit the following user settings and I click save
      | Page | Name                     | Type  | Value |
      | CPOE | Can Enter Orders         | radio | true  |
      | CPOE | Enable Admission Med Rec | radio | true  |
      | CPOE | Add Home Medications     | radio | true  |
      | CPOE | Continue Home Meds       | radio | true  |


  Scenario: 10. Verify the MedRec buttons on Orders link
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Orders" from clinical navigation
    Then the "Orders" pane should load within "5" seconds
    And the following fields should display in the "Orders" pane
      | Name        | Type   |
      | Adm Med Rec | button |
    When I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load within "5" seconds
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane
  #Then the "Admission Medication Reconciliation" pane should close


  Scenario: 11. Problems and Allergies display in Admission MedRec
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Orders" from clinical navigation
    Then the "Orders" pane should load within "5" seconds
    When I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load within "5" seconds
    And the text "Allergies:" should appear in the "Admission Medication Reconciliation" pane
    And the text "Problems:" should appear in the "Admission Medication Reconciliation" pane
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button
        #Then the "Admission Medication Reconciliation" pane should close


  @PatientSafety
  Scenario: 12. Stop the home medication which has no matched hospital order
    Given "MEDREC PATIENT1" is on the patient list
    Then I select patient "MEDREC PATIENT1" from the patient list
    And I select "Home Meds" from clinical navigation
    And I click the "Adm Med Rec" button in the "Home Medications" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load
    When I enter "Benicar" in the "Search for order" field in the "Search for order" pane
    And I wait "2" seconds
#    And I select "Benicar 20 mg tablet Oral" from the "Searched Combined Med Orders" list in the search results
    And I select "Benicar tablet (olmesartan) 20MG Oral" from the "Searched Combined Med Orders" list in the search results
#    And I select "Benicar tablet (olmesartan) 20MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                 | Action for Hospitalization | Hospital Orders* |
#      | New: Benicar tablet (olmesartan) 20 mg Daily | Stop Continue / Change     |                  |
      | New: Benicar tablet (olmesartan) 20 mg Oral Daily | Stop Continue / Change     |                  |
    When I select the "Stop" radio in the row with "New: Benicar tablet (olmesartan) 20 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
     #Mouse-out of radio button area to display the changes
    And I move the mouse over the "New: Benicar tablet (olmesartan) 20 mg Oral Daily" text in the row with "New: Benicar tablet (olmesartan) 20 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                 | Action for Hospitalization | Hospital Orders* |
      | New: Benicar tablet (olmesartan) 20 mg Oral Daily | Stop                       | Stopped          |
    And I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button


  Scenario: 13. Stop the home med which has matched hospital order
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I click the "OK" button in the "Warning" pane if it exists
    Then the "Enter Orders" pane should load within "5" seconds
    When I enter "nebivolol" in the "Add Order" field in the "Enter Orders" pane
    And I select "Bystolic tablet (nebivolol) 5MG" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
   #		And I click the "Sign/Submit" button in the "Order Submission" pane
    And I Submit the Orders
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*                     | Start          | Status    |
      | Bystolic tablet (nebivolol) (test order) | %Current Date% | Submitted |
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "nebivolol" in the "Search for order" field in the "Search for order" pane
    And I select "Bystolic tablet (nebivolol) 5MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                               | Action for Hospitalization | Hospital Orders*                                   |
      | New: Bystolic tablet (nebivolol) 5MG Oral Daily | Continue / Change          | Existing: Bystolic tablet (nebivolol) (test order) |
    When I mouse over the "AMRContinueChange" element and click the "STOP" radio of the row with text "New: Bystolic tablet (nebivolol) 5MG Oral Daily" under the "Home Medications*" column in the "Medication Reconciliation" table
#        When I move the mouse over the "Continue / Change" text in the row with "New: Bystolic tablet (nebivolol) 5MG Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
#        And I select the "Stop" radio in the row with "New: Bystolic tablet (nebivolol) 5MG Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then the "Question" pane should load within "5" seconds
    And the text "Stopping the home med will also discontinue the active Hospital Order. Do you want to continue?" should appear in the "Question" pane
    When I click the "No" button in the "Question" pane
    When I mouse over the "AMRContinueChange" element and click the "STOP" radio of the row with text "New: Bystolic tablet (nebivolol) 5MG Oral Daily" under the "Home Medications*" column in the "Medication Reconciliation" table
#        And I move the mouse over the "Continue / Change" text in the row with "New: Bystolic tablet (nebivolol) 5MG Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
#        And I select the "Stop" radio in the row with "New: Bystolic tablet (nebivolol) 5MG Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Yes" button
#  in the "Question" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                               | Action for Hospitalization | Hospital Orders*                                      |
      | New: Bystolic tablet (nebivolol) 5MG Oral Daily | Stop                       | Discontinued: Bystolic tablet (nebivolol) (test order |
    And I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button
#  in the "Question" pane

  @MedRecTest
  Scenario: 14. Stop the continued home medication which has no matched hospital order
    When "MEDREC RECON1" is on the patient list
    When I select patient "MEDREC RECON1" from the patient list
    And I select "Home Meds" from clinical navigation
    And I click the "Adm Med Rec" button in the "Home Medications" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Alprazolam" in the "Search for order" field in the "Search for order" pane
    And I select "ALPRAZolam tablet  1MG" from the "Searched Combined Med Orders" list in the search results
    And I select "Daily" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*          | Action for Hospitalization | Hospital Orders* |
      | New: ALPRAZolam tablet 1MG | Stop Continue / Change     |                  |
    When I select the "Continue" radio in the row with "New: ALPRAZolam tablet 1MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
     #Hover out of radio button to display the changes
    And I move the mouse over the "New: ALPRAZolam tablet 1MG" text in the row with "New: ALPRAZolam tablet 1MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*          | Action for Hospitalization | Hospital Orders*           |
      | New: ALPRAZolam tablet 1MG | Continue / Change          | New: ALPRAZolam tablet 1MG |
    When I move the mouse over the "Continue / Change" text in the row with "New: ALPRAZolam tablet 1MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with "New: ALPRAZolam tablet 1MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then the text "Stopping the home med will also delete the new Hospital Order. Do you want to continue?" should appear in the "Question" pane
    When I click the "No" button in the "Question" pane
     #Hover over the text to display radio
    And I move the mouse over the "Continue / Change" text in the row with "New: ALPRAZolam tablet 1MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with "New: ALPRAZolam tablet 1MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Yes" button
#  in the "Question" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*          | Action for Hospitalization | Hospital Orders* |
      | New: ALPRAZolam tablet 1MG | Stop                       | Stopped          |
    And I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 15. Stop the changed home medication which has no matched hospital order
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Home Meds" from clinical navigation
    And I click the "Adm Med Rec" button in the "Home Medications" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Xanax" in the "Search for order" field in the "Search for order" pane
    And I select "Xanax tablet (alprazolam)  1MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                  | Action for Hospitalization | Hospital Orders* |
      | New: Xanax tablet (alprazolam) 1MG | Stop Continue / Change     |                  |
    When I select the "Continue" radio in the row with "New: Xanax tablet (alprazolam) 1MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
     #Hover out of radio button to display the changes
    And I move the mouse over the "New: Xanax tablet (alprazolam) 1MG Oral Daily" text in the row with "New: Xanax tablet (alprazolam) 1MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                  | Action for Hospitalization | Hospital Orders*                   |
      | New: Xanax tablet (alprazolam) 1MG | Continue / Change          | New: Xanax tablet (alprazolam) 1MG |
    When I move the mouse over the "Continue / Change" text in the row with "New: Xanax tablet (alprazolam) 1MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I select the "Change" link in the row with "New: Xanax tablet (alprazolam) 1MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then the value in the "Search For" field in the "Search for order" pane should be "Xanax"
   #		When I select "Xanax XR tablet,extended release (alprazolam)  2MG Oral" from the "Searched Combined Med Orders Update" list in the search results
    When I select "Xanax XR tablet,extended release (alprazolam)  2MG" from the "Searched NonFormulary Med Orders Update" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                  | Action for Hospitalization | Hospital Orders*                                   |
      | New: Xanax tablet (alprazolam) 1MG | Continue / Change          | New: Xanax XR tablet,extended release (alprazolam) |
    When I mouse over the "AMRContinueChange" element and click the "STOP" radio of the row with text "New: Xanax tablet (alprazolam) 1MG Oral Daily" under the "Home Medications*" column in the "Medication Reconciliation" table
#        When I move the mouse over the "Continue / Change" text in the row with "New: Xanax tablet (alprazolam) 1MG Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
#        And I select the "Stop" radio in the row with "New: Xanax tablet (alprazolam) 1MG Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then the text "Stopping the home med will also delete the new Hospital Order. Do you want to continue?" should appear in the "Question" pane
    When I click the "No" button in the "Question" pane
     #Hover over the text to display radio
    When I mouse over the "AMRContinueChange" element and click the "STOP" radio of the row with text "New: Xanax tablet (alprazolam) 1MG Oral Daily" under the "Home Medications*" column in the "Medication Reconciliation" table
#        And I move the mouse over the "Continue / Change" text in the row with "New: Xanax tablet (alprazolam) 1MG Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
#        And I select the "Stop" radio in the row with "New: Xanax tablet (alprazolam) 1MG Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Yes" button
#  in the "Question" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                  | Action for Hospitalization | Hospital Orders* |
      | New: Xanax tablet (alprazolam) 1MG | Stop                       | Stopped          |
    And I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 16. No Known Home Medications
    When "MEDREC PATIENT4" is on the patient list
    And I select patient "MEDREC PATIENT4" from the patient list
    And I select "Home Meds" from clinical navigation
    And I click the "Adm Med Rec" button in the "Home Medications" pane
    Then the "Admission Medication Reconciliation" pane should load within "5" seconds
    And the following fields should display in the "Admission Medication Reconciliation" pane
      | Name                   | Type  |
      | Noknownhomemedications | check |
    When I uncheck the "No known home medications" checkbox
    And I click the "Reconcile and Submit" button
    Then the "Warning Popup" pane should load within "5" seconds
    And the text "You must either add a home med or indicate" should appear in the "Warning Popup" pane
    And I click the "OK" button in the "Warning Popup" pane
    When I check the "No known home medications" checkbox
    And I click the "Reconcile and Submit" button
    Then the "Admission Medication Reconciliation" pane should close


  Scenario: 17. Undo Stopped home medication which has no matched hospital order
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Home Meds" from clinical navigation
    And I click the "Adm Med Rec" button in the "Home Medications" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "corn starch" in the "Search for order" field in the "Search for order" pane
    And I select "Resource Thickenup Packet (corn starch)" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                            | Action for Hospitalization | Hospital Orders* |
      | New: Resource Thickenup Packet (corn starch) | Stop Continue / Change     |                  |
    When I select the "Stop" radio in the row with "New: Resource Thickenup Packet (corn starch)" as the value under "Home Medications*" in the "Medication Reconciliation" table
     #Hover out of radio button to display the changes
    And I move the mouse over the "New: Resource Thickenup Packet (corn starch)" text in the row with "New: Resource Thickenup Packet (corn starch)" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                            | Action for Hospitalization | Hospital Orders* |
      | New: Resource Thickenup Packet (corn starch) | Stop                       | Stopped          |
    When I choose "Undo Stop" option by clicking "Edit" icon in the row with "New: Resource Thickenup Packet (corn starch)" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                            | Action for Hospitalization | Hospital Orders* |
      | New: Resource Thickenup Packet (corn starch) | Stop Continue / Change     |                  |
    And I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 18. Reconcile and Submit the home medication which has no matched hospital order
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Home Meds" from clinical navigation
    And I click the "Adm Med Rec" button in the "Home Medications" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "REBETOL" in the "Search for order" field in the "Search for order" pane
    And I select "REBETOL capsule (ribavirin)  200MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                      | Action for Hospitalization | Hospital Orders* |
      | New: REBETOL capsule (ribavirin) 200MG | Stop Continue / Change     |                  |
    When I select the "Stop" radio in the row with "New: REBETOL capsule (ribavirin) 200MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
     #Hover out of radio button to display the changes
    And I move the mouse over the "New: REBETOL capsule (ribavirin) 200MG" text in the row with "New: REBETOL capsule (ribavirin) 200MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                      | Action for Hospitalization | Hospital Orders* |
      | New: REBETOL capsule (ribavirin) 200MG | Stop                       | Stopped          |
    When I reconcile and Submit the Orders
    Then the "Admission Medication Reconciliation" pane should close


  Scenario: 19. Correct newly added home medication
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Home Meds" from clinical navigation
    And I click the "Adm Med Rec" button in the "Home Medications" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Plasma-Lyte" in the "Search for order" field in the "Search for order" pane
    And I select "Plasma-Lyte A IV (electrolyte-A)  IV" from the "Searched Combined Med Orders" list in the search results
    And I select "Special Inst" from the "Dose" multiselect in the "Edit Medication Order" pane
    And I enter "test order" in the "Special Instructions" field in the "Edit Medication Order" pane
    And I select "Daily" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                   | Action for Hospitalization | Hospital Orders* |
      | New: Plasma-Lyte A IV (electrolyte-A) IV Oral Daily | Stop Continue / Change     |                  |
    When I choose "Correct this home medication" option by clicking "Edit" icon in the row with "New: Plasma-Lyte A IV (electrolyte-A) IV Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I select "Weekly" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                               | Action for Hospitalization | Hospital Orders* |
      | New: Plasma-Lyte A IV (electrolyte-A) IV Weekly | Stop Continue / Change     |                  |
    And I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 20. Delete newly added home medication
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Home Meds" from clinical navigation
    And I click the "Adm Med Rec" button in the "Home Medications" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Glyset" in the "Search for order" field in the "Search for order" pane
    And I select "Glyset tablet (miglitol)  25MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                  | Action for Hospitalization | Hospital Orders* |
      | New: Glyset tablet (miglitol) 25MG | Stop Continue / Change     |                  |
    When I choose "Delete" option by clicking "Edit" icon in the row with "New: Glyset tablet (miglitol) 25MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then the "Medication Reconciliation" table should have "0" rows containing the text "Glyset"
    And I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 21. Discontinue newly added home medication
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Home Meds" from clinical navigation
    And I click the "Adm Med Rec" button in the "Home Medications" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "PARoxetine" in the "Search for order" field in the "Search for order" pane
    And I select "PARoxetine tablet  10MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*           | Action for Hospitalization | Hospital Orders* |
      | New: PARoxetine tablet 10MG | Stop Continue / Change     |                  |
    When I choose "Discontinue this home medication" option by clicking "Edit" icon in the row with "New: PARoxetine tablet 10MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                         | Action for Hospitalization | Hospital Orders* |
      | New: Discontinued: PARoxetine tablet 10MG | Stop                       | Stopped          |
    And I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 22. Undo DC of newly added home medication
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Home Meds" from clinical navigation
    And I click the "Adm Med Rec" button in the "Home Medications" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "glutamine" in the "Search for order" field in the "Search for order" pane
    And I select "L-Glutamine tablet (glutamine) 500MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                    | Action for Hospitalization | Hospital Orders* |
      | New: L-Glutamine tablet (glutamine) 500MG Oral Daily | Stop Continue / Change     |                  |
     # first discontinue the medication to do 'Undoing'
    When I choose "Discontinue this home medication" option by clicking "Edit" icon in the row with "New: L-Glutamine tablet (glutamine) 500MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                                  | Action for Hospitalization | Hospital Orders* |
      | New: Discontinued: L-Glutamine tablet (glutamine) 500MG Oral Daily | Stop                       | Stopped          |
    When I choose "Undo DC" option by clicking "Edit" icon in the row with "New: Discontinued: L-Glutamine tablet (glutamine) 500MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                    | Action for Hospitalization | Hospital Orders* |
      | New: L-Glutamine tablet (glutamine) 500MG Oral Daily | Stop Continue / Change     |                  |
    And I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 23. Continue Home med has matched order def
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Home Meds" from clinical navigation
    And I click the "Adm Med Rec" button in the "Home Medications" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "pioglitazone tablet" in the "Search for order" field in the "Search for order" pane
    And I select "Actos tablet (pioglitazone) 15MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                | Action for Hospitalization | Hospital Orders* |
      | New: Actos tablet (pioglitazone) 15MG Oral Daily | Stop Continue / Change     |                  |
    When I select the "Continue" radio in the row with "New: Actos tablet (pioglitazone) 15MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I move the mouse over the "New: Actos tablet (pioglitazone) 15MG Oral Daily" text in the row with "New: Actos tablet (pioglitazone) 15MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                | Action for Hospitalization | Hospital Orders*                                 |
      | New: Actos tablet (pioglitazone) 15MG Oral Daily | Continue / Change          | New: Actos tablet (pioglitazone) 15MG Oral Daily |
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 24. Continue No matched hospital order new order interacts with other new orders
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I enable interaction display alerts
    And I revert prevent ordering of redundant lab tests
    And I disable the medication duplicate display interaction checking option
    And I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And I select "MedRecPLV2" from the "Patient List" menu
    And "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Home Meds" from clinical navigation
    And I click the "Adm Med Rec" button in the "Home Medications" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Aspirin chewable tablet" in the "Search for order" field in the "Search for order" pane
    And I select "Aspirin Childrens chewable tablet (aspirin) 81MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                                | Action for Hospitalization | Hospital Orders* |
      | New: Aspirin Childrens chewable tablet (aspirin) 81MG Oral Daily | Stop Continue / Change     |                  |
    When I select the "Continue" radio in the row with "New: Aspirin Childrens chewable tablet (aspirin) 81MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I select "Home Medication" as override reason in the "Clinical Decision Support Warnings" pane if it exists
    And I click the "CDSW OK" button if it exists
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane if it exists
    And I move the mouse over the "New: Aspirin Childrens chewable tablet (aspirin) 81MG" text in the row with "New: Aspirin Childrens chewable tablet (aspirin) 81MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                                | Action for Hospitalization | Hospital Orders*                                                 |
      | New: Aspirin Childrens chewable tablet (aspirin) 81MG Oral Daily | Continue / Change          | New: Aspirin Childrens chewable tablet (aspirin) 81MG Oral Daily |
    When I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table
    And I enter "advil tablet" in the "Search for order" field in the "Search for order" pane
    And I select "Advil tablet (ibuprofen)  100MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I select "Home Medication" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                                                | Action for Hospitalization | Hospital Orders*                                      |
      | New: Aspirin Childrens chewable tablet (aspirin) 81MG Daily Moderate Interaction | Continue / Change          | New: Aspirin Childrens chewable tablet (aspirin) 81MG |
      | New: Advil tablet (ibuprofen) 100MG Daily Moderate Interaction                   | Stop Continue / Change     |                                                       |
    When I select the "Continue" radio in the row with "New: Advil tablet (ibuprofen) 100MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I select "Home Medication" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                                                | Action for Hospitalization | Hospital Orders*                                                                 |
      | New: Aspirin Childrens chewable tablet (aspirin) 81MG Daily Moderate Interaction | Continue / Change          | New: Aspirin Childrens chewable tablet (aspirin) 81MG Daily Moderate Interaction |
      | New: Advil tablet (ibuprofen) 100MG Daily Moderate Interaction                   | Continue / Change          | New: Advil tablet (ibuprofen) 100MG Daily Moderate Interaction                   |
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 25. Continue- new order interacts with other matched order
    When "MEDREC PATIENT2" is on the patient list
    And I select patient "MEDREC PATIENT2" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I click the "OK" button in the "Warning" pane if it exists
    And I enter "acebutolol" in the "Add Order" field in the "Enter Orders" pane
    And I select "acebutolol capsule 200MG" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
#		And I click the "Sign/Submit" button in the "Order Submission" pane
    And I Submit the Orders
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for* | Start          | Status    |
#            |acebutolol capsule 200MG Oral |%Current Date% |Submitted |
      | acebutolol capsule   | %Current Date% | Submitted |
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "acebutolol" in the "Search for order" field in the "Search for order" pane
    And I select "acebutolol capsule 200MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*             | Action for Hospitalization | Hospital Orders*             |
      | New: acebutolol capsule 200MG | Continue / Change          | Existing: acebutolol capsule |
    When I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table
    And I enter "Advil tablet" in the "Search for order" field in the "Search for order" pane
    And I select "Advil tablet (ibuprofen)  100MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I select "Home Medication" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                              | Action for Hospitalization | Hospital Orders*             |
      | New: acebutolol capsule 200MG Daily Moderate Interaction       | Continue / Change          | Existing: acebutolol capsule |
      | New: Advil tablet (ibuprofen) 100MG Daily Moderate Interaction | Stop Continue / Change     |                              |
    When I select the "Continue" radio in the row with "New: Advil tablet (ibuprofen) 100MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I select "Home Medication" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button
    And I wait "2" seconds
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                              | Action for Hospitalization | Hospital Orders*                                               |
      | New: acebutolol capsule 200MG Daily Moderate Interaction       | Continue / Change          | Existing: acebutolol capsule                                   |
      | New: Advil tablet (ibuprofen) 100MG Daily Moderate Interaction | Continue / Change          | New: Advil tablet (ibuprofen) 100MG Daily Moderate Interaction |
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 26. Continue- New order interacts with an active order not on med rec screen
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I click the "OK" button in the "Warning" pane if it exists
    And I enter "carmustine" in the "Add Order" field in the "Enter Orders" pane
    And I select "carmustine IV Solution  100MG IV" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
   #		And I click the "Sign/Submit" button in the "Order Submission" pane
    And I Submit the Orders
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*   | Start          | Status    |
#            |carmustine IV Solution 100MG IV |%Current Date% |Submitted |
      | carmustine IV Solution | %Current Date% | Submitted |
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "cimetidine" in the "Search for order" field in the "Search for order" pane
    And I select "cimetidine tablet  200MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*            | Action for Hospitalization | Hospital Orders* |
      | New: cimetidine tablet 200MG | Stop Continue / Change     |                  |
    When I select the "Continue" radio in the row with "New: cimetidine tablet 200MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I select "Home Medication" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*            | Action for Hospitalization | Hospital Orders*                                      |
      | New: cimetidine tablet 200MG | Continue / Change          | New: cimetidine tablet 200MG Daily Severe Interaction |
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 27. DC the matched hospital orders-Then Continue its home med
    When "MEDREC PATIENT3" is on the patient list
    And I select patient "MEDREC PATIENT3" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I click the "OK" button in the "Warning" pane if it exists
    And I enter "Zetia tablet" in the "Add Order" field in the "Enter Orders" pane
    And I select "Zetia tablet (ezetimibe) 10MG" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
   #		And I click the "Sign/Submit" button in the "Order Submission" pane
    And I Submit the Orders
    Then rows starting with the following should appear in the "Orders" clinical table
      | Existing orders for*     | Start          | Status    |
#            |Zetia tablet (ezetimibe) 10MG |%Current Date% |Submitted |
      | Zetia tablet (ezetimibe) | %Current Date% | Submitted |
    And I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Zetia tablet" in the "Search for order" field in the "Search for order" pane
    And I select "Zetia tablet (ezetimibe) 10MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                  | Action for Hospitalization | Hospital Orders*                   |
      | New: Zetia tablet (ezetimibe) 10MG | Continue / Change          | Existing: Zetia tablet (ezetimibe) |
    When I choose "Discontinue" option by clicking "Edit" icon against "Existing: Zetia tablet (ezetimibe)" text in the row with "New: Zetia tablet (ezetimibe) 10MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Yes" button
#  in the "Question" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                  | Action for Hospitalization | Hospital Orders*                       |
      | New: Zetia tablet (ezetimibe) 10MG | Stop                       | Discontinued: Zetia tablet (ezetimibe) |
     #Hover over the stop text to display radio
    When I mouse over the "AMRStop" element and click the "CONTINUE" radio of the row with text "New: Zetia tablet (ezetimibe) 10MG Oral Daily" under the "Home Medications*" column in the "Medication Reconciliation" table
#        When I move the mouse over the "Stop" text in the row with "New: Zetia tablet (ezetimibe) 10MG Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
#        And I select the "Continue" radio in the row with "New: Zetia tablet (ezetimibe) 10MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I move the mouse over the "New: Zetia tablet (ezetimibe) 10MG Oral Daily" text in the row with "New: Zetia tablet (ezetimibe) 10MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                  | Action for Hospitalization | Hospital Orders*                   |
      | New: Zetia tablet (ezetimibe) 10MG | Continue / Change          | Existing: Zetia tablet (ezetimibe) |
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 28. Change Home med has matched order def
    When "MEDREC PATIENT2" is on the patient list
    And I select patient "MEDREC PATIENT2" from the patient list
    And I select "Home Meds" from clinical navigation
    And I click the "Adm Med Rec" button in the "Home Medications" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "carmustine" in the "Search for order" field in the "Search for order" pane
    And I select "carmustine IV Solution  100MG IV" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                 | Action for Hospitalization | Hospital Orders* |
      | New: carmustine IV Solution 100MG | Stop Continue / Change     |                  |
    And I select the "Change" link in the row with "New: carmustine IV Solution 100MG IV Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
   #		When I select "BiCNU IV Solution (carmustine)  100MG IV" from the "Searched Combined Med Orders Update" list in the search results
    When I select "BiCNU IV Solution (carmustine)  100MG IV" from the "Searched NonFormulary Med Orders Update" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                 | Action for Hospitalization | Hospital Orders*                       |
      | New: carmustine IV Solution 100MG | Continue / Change          | New: BiCNU IV Solution (carmustine) IV |
    When I move the mouse over the "Continue / Change" text in the row with "New: carmustine IV Solution 100MG IV Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I select the "Change" link in the row with "New: carmustine IV Solution 100MG IV Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Close Icon" button
    And I click the "Close Order Search" button
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I select "Lescol capsule (fluvastatin)" from the hospital medication favorites list in the "AdmissionMedicationReconciliation" pane
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then the "Medication Reconciliation" table should have at least "1" rows containing the text "Lescol capsule"
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 29. Change - No matched hospital order - new order interacts with other new orders
    When "MEDREC PATIENT3" is on the patient list
    And I select patient "MEDREC PATIENT3" from the patient list
    And I select "Home Meds" from clinical navigation
    And I click the "Adm Med Rec" button in the "Home Medications" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "aspirin Rectal" in the "Search for order" field in the "Search for order" pane
    And I select "aspirin Rectal Suppository  300MG Rect" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications                                 | Action for Hospitalization | Hospital Orders |
      | New: aspirin Rectal Suppository 300MG Rect Daily | Stop Continue / Change     |                 |
    When I select the "Change" link in the row with "New: aspirin Rectal Suppository 300MG Rect Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
#   		And I select "aspirin, buffered tablet  81MG" from the "Searched Combined Med Orders Update" list in the search results
    And I select "aspirin, buffered tablet  81MG" from the "Searched NonFormulary Med Orders Update" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I select "Home Medication" as override reason in the "Clinical Decision Support Warnings" pane if it exists
    And I click the "CDSW OK" button if it exists
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                | Action for Hospitalization | Hospital Orders*              |
      | New: aspirin Rectal Suppository 300MG Rect Daily | Continue / Change          | New: aspirin, buffered tablet |
#        And the "Delta" icon should be shown in the following rows in the "Medication Reconciliation" table
#            |Displayed |Home Medications*                                |
#            |true      |New: aspirin Rectal Suppository 300MG Rect Oral Daily |
    When I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table
    And I enter "Advil tablet" in the "Search for order" field in the "Search for order" pane
    And I select "Advil tablet (ibuprofen)  100MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then the "Clinical Decision Support Warnings" pane should load within "5" seconds
    When I select "Home Medication" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                                     | Action for Hospitalization | Hospital Orders*              |
      | New: aspirin Rectal Suppository 300MG Rect Daily Moderate Interaction | Continue / Change          | New: aspirin, buffered tablet |
      | New: Advil tablet (ibuprofen) 100MG Daily Moderate Interaction        | Stop Continue / Change     |                               |
    When I select the "Change" link in the row with "New: Advil tablet (ibuprofen) 100MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
#   		And I select "Advil tablet (ibuprofen)  100MG" from the "Searched Combined Med Orders Update" list in the search results
    And I select "Advil tablet (ibuprofen) 100MG" from the "Searched NonFormulary Med Orders Update" list in the search results
#        Then the "Clinical Decision Support Warnings" pane should load within "5" seconds
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    Then the "Clinical Decision Support Warnings" pane should close
    And I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 30. Change - No matched hospital order - new order interacts with other matched order
    When "MEDREC PATIENT3" is on the patient list
    And I select patient "MEDREC PATIENT3" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I click the "OK" button in the "Warning" pane if it exists
    Then the "Enter Orders" pane should load within "5" seconds
    When I enter "acebutolol" in the "Add Order" field in the "Enter Orders" pane
    And I select "acebutolol capsule 200MG" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
   #		And I click the "Sign/Submit" button in the "Order Submission" pane
    And I Submit the Orders
    Then rows starting with the following should appear in the "Orders" clinical table
      | Existing orders for* | Start          | Status    |
      | acebutolol capsule   | %Current Date% | Submitted |
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "aacebutolol" in the "Search for order" field in the "Search for order" pane
    And I select "acebutolol capsule 200MG" from the "Searched Combined Med Orders" list in the search results
    And I select "Daily" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" clinical table
      | Home Medications*                        | Action for Hospitalization | Hospital Orders*             |
      | New: acebutolol capsule 200MG Oral Daily | Continue / Change          | Existing: acebutolol capsule |
    When I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Advil" in the "Search for order" field in the "Search for order" pane
    And I select "Advil tablet (ibuprofen)  200MG" from the "Searched Combined Med Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load within "5" seconds
    When I select "Home Medication" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSWOK" button
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                              | Action for Hospitalization | Hospital Orders*             |
      | New: acebutolol capsule 200MG Daily Moderate Interaction       | Continue / Change          | Existing: acebutolol capsule |
      | New: Advil tablet (ibuprofen) 200MG Daily Moderate Interaction | Stop Continue / Change     |                              |
    When I select the "Change" link in the row with "New: Advil tablet (ibuprofen) 200MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
   #		And I select "Advil tablet (ibuprofen)  200MG Oral" from the "Searched Combined Med Orders Update" list in the search results
    And I select "Advil tablet (ibuprofen) 200MG" from the "Searched NonFormulary Med Orders Update" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load within "5" seconds
    When I select "Home Medication" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSWOK" button
    And I select "Daily" from the "Frequency" multiselect in the "Clinical Decision Support Warnings" pane
    And I click the "CDSWOK" button
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                              | Action for Hospitalization | Hospital Orders*                                               |
      | New: acebutolol capsule 200MG Daily Moderate Interaction       | Continue / Change          | Existing: acebutolol capsule                                   |
      | New: Advil tablet (ibuprofen) 200MG Daily Moderate Interaction | Continue / Change          | New: Advil tablet (ibuprofen) 200MG Daily Moderate Interaction |
    And I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 31. Change - not a hyperlink
    When "MEDREC PATIENT4" is on the patient list
    And I select patient "MEDREC PATIENT4" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I click the "OK" button in the "Warning" pane if it exists
    Then the "Enter Orders" pane should load within "5" seconds
    When I enter "Zetia tablet" in the "Add Order" field in the "Enter Orders" pane
    And I select "Zetia tablet (ezetimibe) 10MG" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
   #		And I click the "Sign/Submit" button in the "Order Submission" pane
    And I Submit the Orders
    Then rows starting with the following should appear in the "Orders" clinical table
      | Existing orders for*     | Start          | Status    |
      | Zetia tablet (ezetimibe) | %Current Date% | Submitted |
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Zetia tablet" in the "Search for order" field in the "Search for order" pane
    And I select "Zetia tablet (ezetimibe) 10MG" from the "Searched Combined Med Orders" list in the search results
    And I select "Daily" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" clinical table
      | Home Medications*                             | Action for Hospitalization | Hospital Orders*                   |
      | New: Zetia tablet (ezetimibe) 10MG Oral Daily | Continue / Change          | Existing: Zetia tablet (ezetimibe) |
    And I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 32. Change - New order interacts with an active order not on med rec screen
    When "MEDREC PATIENT3" is on the patient list
    And I select patient "MEDREC PATIENT3" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I click the "OK" button in the "Warning" pane if it exists
    Then the "Enter Orders" pane should load within "5" seconds
    When I enter "carmustine" in the "Add Order" field in the "Enter Orders" pane
    And I select "carmustine IV Solution  100MG IV" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
   #		And I click the "Sign/Submit" button in the "Order Submission" pane
    And I Submit the Orders
    Then rows starting with the following should appear in the "Orders" clinical table
      | Existing orders for*   | Start          | Status    |
      | carmustine IV Solution | %Current Date% | Submitted |
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "cimetidine" in the "Search for order" field in the "Search for order" pane
    And I select "cimetidine tablet  200MG" from the "Searched Combined Med Orders" list in the search results
    And I select "Oral Daily" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" clinical table
      | Home Medications*                       | Action for Hospitalization | Hospital Orders* |
      | New: cimetidine tablet 200MG Oral Daily | Stop Continue / Change     |                  |
    When I select the "Continue" radio in the row with "New: cimetidine tablet 200MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then the "Clinical Decision Support Warnings" pane should load within "5" seconds
    And the text "Severe Interaction" should appear in the "Clinical Decision Support Warnings" pane
    When I select "Home Medication" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSWOK" button
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                       | Action for Hospitalization | Hospital Orders*                                      |
      | New: cimetidine tablet 200MG Oral Daily | Continue / Change          | New: cimetidine tablet 200MG Daily Severe Interaction |
    And I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button
#  in the "Question" pane


  @PatientSafety
  Scenario: 33. Disable interaction display alerts
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I disable interaction display alerts
    And I disable the medication duplicate display interaction checking option


  Scenario: 34. DC the matched hospital orders -Then Change its home med
    When "MEDREC PATIENT4" is on the patient list
    And I select patient "MEDREC PATIENT4" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button in the "Orders" pane
    And I click the "OK" button in the "Warning" pane if it exists
    And I enter "Xanax tablet" in the "Add Order" field in the "Enter Orders" pane
    Then the following options should appear in the "NonFormulary MedOrders" list in the search results
      | Xanax tablet (alprazolam) 1MG |
    When I select "Xanax tablet (alprazolam) 1MG" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
   #		And I click the "Sign/Submit" button in the "Order Submission" pane
    And I Submit the Orders
    And I select "All" from the "Order Type" menu
    And I select "Today" from the "Past Order Date" dropdown
    Then the "Orders" table should load
    And rows containing the following should appear in the "Orders" clinical table
      | Existing orders for*      | Start          | Status    |
      | Xanax tablet (alprazolam) | %Current Date% | Submitted |
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "5" seconds
    When I enter "Xanax tablet" in the "Search for order" field in the "Search for order" pane
    And I select "Xanax tablet (alprazolam) 1MG" from the "Searched Combined MedOrders" list in the search results
    And I select "Oral Daily" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                  | Action for Hospitalization | Hospital Orders*                    |
      | New: Xanax tablet (alprazolam) 1MG | Continue / Change          | Existing: Xanax tablet (alprazolam) |
    When I choose "Discontinue" option by clicking "Edit" icon against "Existing: Xanax tablet (alprazolam)" text in the row with "New: Xanax tablet (alprazolam) 1MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                  | Action for Hospitalization | Hospital Orders*                        |
      | New: Xanax tablet (alprazolam) 1MG | Stop                       | Discontinued: Xanax tablet (alprazolam) |
    When I move the mouse over the "Stop" text in the row with "New: Xanax tablet (alprazolam) 1MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I select the "Change" link in the row with "New: Xanax tablet (alprazolam) 1MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then the value in the "Search For" field in the "Search for order" pane should be "Xanax"
   #		When I select "cimetidine tablet  200MG Oral" from the "Searched Combined Med Orders Update" list in the search results
    When I select "Xanax tablet (alprazolam) 1MG" from the "Searched NonFormulary Med Orders Update" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                  | Action for Hospitalization | Hospital Orders*               |
      | New: Xanax tablet (alprazolam) 1MG | Continue / Change          | New: Xanax tablet (alprazolam) |
    And I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 35. Hospital Med Reconcile and Submit
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Home Meds" from clinical navigation
    And I click the "Adm Med Rec" button in the "Home Medications" pane
    Then the "Admission Medication Reconciliation" pane should load within "5" seconds
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "5" seconds
    When I enter "acebutolol" in the "Search for order" field in the "Search for order" pane
    And I select "acebutolol capsule  200MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*             | Action for Hospitalization | Hospital Orders* |
      | New: acebutolol capsule 200MG | Stop                       |                  |
    When I select the "Continue" radio in the row with "New: acebutolol capsule 200MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                        | Action for Hospitalization | Hospital Orders*                         |
      | New: acebutolol capsule 200MG Oral Daily | Continue / Change          | New: acebutolol capsule 200MG Oral Daily |
    When I reconcile and Submit the Orders
    Then the "Admission Medication Reconciliation" pane should close
    When I click the "Adm Med Rec" button in the "Home Medications" pane
    Then the text "The selected visit does not have any home medications to reconcile" should appear in the "Admission Medication Reconciliation" pane
    And I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 36. Existing Hospital Order-Modify
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button in the "Orders" pane
    And I click the "OK" button in the "Warning" pane if it exists
    And I enter "Xanax tablet" in the "Add Order" field in the "Enter Orders" pane
    Then the following options should appear in the "NonFormulary MedOrders" list in the search results
      | Xanax tablet (alprazolam) 1MG |
    When I select "Xanax tablet (alprazolam) 1MG" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
   #		And I click the "Sign/Submit" button in the "Order Submission" pane
    And I Submit the Orders
    And I select "All" from the "Order Type" menu
    And I select "Today" from the "Past Order Date" dropdown
    Then the "Orders" table should load
    And rows starting with the following should appear in the "Orders" clinical table
      | Existing orders for*      | Start          | Status    |
      | Xanax tablet (alprazolam) | %Current Date% | Submitted |
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Xanax tablet" in the "Search for order" field in the "Search for order" pane
    And I select "Xanax tablet (alprazolam) 1MG" from the "Searched Combined Med Orders" list in the search results
    And I select "Daily" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                             | Action for Hospitalization | Hospital Orders*                    |
      | New: Xanax tablet (alprazolam) 1MG Oral Daily | Continue / Change          | Existing: Xanax tablet (alprazolam) |
    When I choose "Modify" option by clicking "Edit" icon against "Existing: Xanax tablet (alprazolam)" text in the row with "New: Xanax tablet (alprazolam) 1MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I select "Weekly" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                             | Action for Hospitalization | Hospital Orders*                                   |
      | New: Xanax tablet (alprazolam) 1MG Oral Daily | Continue / Change          | New: Xanax tablet (alprazolam) Weekly (test order) |
    And I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 37. Existing Hospital order- DC
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button in the "Orders" pane
    And I click the "OK" button in the "Warning" pane if it exists
    And I enter "diazepam tablet" in the "Add Order" field in the "Enter Orders" pane
    And I select "Valium tablet (diazepam) 2MG" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
   #		And I click the "Sign/Submit" button in the "Order Submission" pane
    And I Submit the Orders
    Then rows starting with the following should appear in the "Orders" clinical table
      | Existing orders for* | Start          | Status    |
      | Valium tablet        | %Current Date% | Submitted |
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "diazepam tablet" in the "Search for order" field in the "Search for order" pane
    And I select "Valium tablet (diazepam) 2MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                 | Action for Hospitalization | Hospital Orders*        |
      | New: Valium tablet (diazepam) 2MG | Continue / Change          | Existing: Valium tablet |
    When I choose "Discontinue" option by clicking "Edit" icon against "Existing: Valium tablet" text in the row with "New: Valium tablet (diazepam) 2MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                 | Action for Hospitalization | Hospital Orders*            |
      | New: Valium tablet (diazepam) 2MG | Stop                       | Discontinued: Valium tablet |
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 38. Modified existing hosp order-UNDO Modifications
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button in the "Orders" pane
    And I click the "OK" button in the "Warning" pane if it exists
    And I enter "zafirlukast " in the "Add Order" field in the "Enter Orders" pane
    And I select "Accolate tablet (zafirlukast) 10MG" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
   #		And I click the "Sign/Submit" button in the "Order Submission" pane
    And I Submit the Orders
    Then rows starting with the following should appear in the "Orders" clinical table
      | Existing orders for* | Start          | Status    |
      | Accolate tablet      | %Current Date% | Submitted |
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "5" seconds
    When I enter "zafirlukast" in the "Search for order" field in the "Search for order" pane
    And I select "Accolate tablet (zafirlukast) 10MG" from the "Searched Combined Med Orders" list in the search results
    And I select "Daily" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                  | Action for Hospitalization | Hospital Orders*                                     |
      | New: Accolate tablet (zafirlukast) 10MG Oral Daily | Continue / Change          | Existing: Accolate tablet (zafirlukast) (test order) |
    When I choose "Modify" option by clicking "Edit" icon against "Existing: Accolate tablet (zafirlukast) (test order)" text in the row with "New: Accolate tablet (zafirlukast) 10MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I select "Weekly" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                  | Action for Hospitalization | Hospital Orders*                                       |
      | New: Accolate tablet (zafirlukast) 10MG Oral Daily | Continue / Change          | New: Accolate tablet (zafirlukast) Weekly (test order) |
    When I choose "Delete" option by clicking "Edit" icon against "New: Accolate tablet (zafirlukast) Weekly (test order)" text in the row with "New: Accolate tablet (zafirlukast) 10MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                  | Action for Hospitalization | Hospital Orders*          |
      | New: Accolate tablet (zafirlukast) 10MG Oral Daily | Continue / Change          | Existing: Accolate tablet |
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 39. Modified existing hosp order-Undo DC
    When "MEDREC PATIENT4" is on the patient list
    And I select patient "MEDREC PATIENT4" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button in the "Orders" pane
    And I click the "OK" button in the "Warning" pane if it exists
    And I enter "zafirlukast " in the "Add Order" field in the "Enter Orders" pane
    And I select "Accolate tablet (zafirlukast) 10MG" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
   #		And I click the "Sign/Submit" button in the "Order Submission" pane
    And I Submit the Orders
    And I select "All" from the "Order Type" menu
    And I select "Today" from the "Past Order Date" dropdown
    Then rows starting with the following should appear in the "Orders" clinical table
      | Existing orders for* | Start          | Status    |
      | Accolate tablet      | %Current Date% | Submitted |
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "5" seconds
    When I enter "zafirlukast" in the "Search for order" field in the "Search for order" pane
    And I select "Accolate tablet (zafirlukast) 10MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                       | Action for Hospitalization | Hospital Orders*          |
      | New: Accolate tablet (zafirlukast) 10MG | Continue / Change          | Existing: Accolate tablet |
    When I choose "Discontinue" option by clicking "Edit" icon against "Existing: Accolate tablet" text in the row with "New: Accolate tablet (zafirlukast) 10MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                       | Action for Hospitalization | Hospital Orders*              |
      | New: Accolate tablet (zafirlukast) 10MG | Stop                       | Discontinued: Accolate tablet |
    When I choose "Undo DC" option by clicking "Edit" icon against "Discontinued: Accolate tablet" text in the row with "New: Accolate tablet (zafirlukast) 10MG" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                       | Action for Hospitalization | Hospital Orders*          |
      | New: Accolate tablet (zafirlukast) 10MG | Stop Continue / Change     | Existing: Accolate tablet |
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 40. Setup-Med Rec Enable in Location
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Location" subtab
    And I select the "PKHospital-Verve" facility
    And I click the "Edit Location" button
    And I wait for loading to complete
    And I select "true" from the "CPOE Enabled" radio list
    And I check the "Admission" checkbox
    And I check the "Discharge" checkbox
    And I mouse over and click the "Select Order Definition" button in the "Edit Location Prefs" pane
#        And I click the "Select Order Definition" button
    And I wait "4" seconds
    And I click the "Order Entry Search" link in the "CPOE Order Definitions" pane
    And I enter "tylenol" in the "Search For Order" field
    And I select "the first item" in the "Medications" table
    And I select "the first item" from the "Order Name" column in the "CPOE Order Search" table
    And I click the "OK" button in the "CPOE Order Definitions" pane
    And I wait "3" seconds
    And I click the "Save Edit Location Pref" button
    Then the "Location" pane should load within "5" seconds


  Scenario: 41. New Hospital Order-Modify
    When "MEDREC PATIENT4" is on the patient list
    And I select patient "MEDREC PATIENT4" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then I enter "ketorolac" in the "Search for order" field in the "Search for order" pane
    And I select "Acular 0.5 % Eye Drops (ketorolac) Opht" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "MedicationReconciliation" table
    And I enter "leg brace" in the "Hospital Search For Order" field in the "Search for order" pane
    And I select "ACE Ankle Brace (leg brace)  Misc" from the "Searched NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then the "Medication Reconciliation" table should have at least "1" rows containing the text "ACE Ankle Brace (leg brace) Misc (test order)"
    When I choose "Modify" option by clicking "Edit" icon against "New: ACE Ankle Brace (leg brace) Misc (test order)" text in the row with "New: ACE Ankle Brace (leg brace) Misc (test order)" as the value under "Hospital Orders*" in the "Medication Reconciliation" table
    And I select "Weekly" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
#        Then the "Medication Reconciliation" table should have at least "1" rows containing the text "New: ACE Ankle Brace (leg brace) Misc Weekly (test order)"
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | New: ACE Ankle Brace (leg brace) Misc Weekly (test order) |
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane


  Scenario: 42. New Hospital Order-Delete
    When "MEDREC PATIENT4" is on the patient list
    And I select patient "MEDREC PATIENT4" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then I enter "ketorolac" in the "Search for order" field in the "Search for order" pane
    And I select "Acular 0.5 % Eye Drops (ketorolac) Opht" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "MedicationReconciliation" table
    And I enter "leg brace" in the "Hospital Search For Order" field in the "Search for order" pane
    And I select "ACE Ankle Brace (leg brace)  Misc" from the "Searched NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then the "Medication Reconciliation" table should have at least "1" rows containing the text "ACE Ankle Brace (leg brace) Misc (test order)"
    When I choose "Delete" option by clicking "Edit" icon against "New: ACE Ankle Brace (leg brace) Misc (test order)" text in the row with "New: ACE Ankle Brace (leg brace) Misc (test order)" as the value under "Hospital Orders*" in the "Medication Reconciliation" table
    Then the "Medication Reconciliation" table should have "0" rows containing the text "New: ACE Ankle Brace (leg brace) Misc Weekly (test order)"
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane


  @CHS14 @PatientSafety
  Scenario: 43. Admission MedRec - Reconcile and Submit medication
    Given I am logged into the portal with user "pkadminv2" using the default password
    Then I disable the medication duplicate display interaction checking option
    When I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And I select "MedRecPLV2" from the "Patient List" menu
    Then "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Home Meds" from clinical navigation
    And I click the "Adm Med Rec" button in the "Home Medications" pane
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load
    And I enter "Gabitril tablet" in the "Search for order" field in the "Search for order" pane
#    And I select "Gabitril 4 mg tablet Oral" from the "Searched Combined Med Orders" list in the search results
    And I select "Gabitril tablet (tiagabine) 4MG Oral" from the "Searched Combined Med Orders" list in the search results
#    And I select "Gabitril tablet (tiagabine) 4MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                | Action for Hospitalization | Hospital Orders* |
      | New: Gabitril tablet (tiagabine) 4 mg Oral Daily | Stop Continue / Change     |                  |
    When I select the "Continue" radio in the row with "New: Gabitril tablet (tiagabine) 4 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I move the mouse over the "New: Gabitril tablet (tiagabine) 4 mg Oral Daily" text in the row with "New: Gabitril tablet (tiagabine) 4 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                | Action for Hospitalization | Hospital Orders*                                 |
      | New: Gabitril tablet (tiagabine) 4 mg Oral Daily | Continue / Change          | New: Gabitril tablet (tiagabine) 4 mg Oral Daily |
    When I reconcile and Submit the Orders
    And I click the "Submit Partial Med Rec" button if it exists
    Then the "Admission Medication Reconciliation" pane should close


  @CHS14 @PatientSafety
  Scenario: 44. Admission MedRec - Add/modify, delete, and continue home medications
    Given "NEIL HEATH" is on the patient list
    Then I select patient "NEIL HEATH" from the patient list
    And I select "Home Meds" from clinical navigation
    And I click the "Adm Med Rec" button in the "Home Medications" pane
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load
    And I enter "zofran tablet" in the "Search for order" field in the "Search for order" pane
#    And I select "Zofran 4 mg tablet Oral" from the "Searched Combined Med Orders" list in the search results
#    And I select "Zofran tablet (ondansetron HCl) 4MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I select "Zofran tablet (ondansetron HCl) 4MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                    | Action for Hospitalization | Hospital Orders* |
      | New: Zofran tablet (ondansetron HCl) 4 mg Oral Daily | Stop Continue / Change     |                  |
    When I select the "Continue" radio in the row with "New: Zofran tablet (ondansetron HCl) 4 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I move the mouse over the "New: Zofran tablet (ondansetron HCl) 4 mg Oral Daily" text in the row with "New: Zofran tablet (ondansetron HCl) 4 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                    | Action for Hospitalization | Hospital Orders*                                     |
      | New: Zofran tablet (ondansetron HCl) 4 mg Oral Daily | Continue / Change          | New: Zofran tablet (ondansetron HCl) 4 mg Oral Daily |
    When I choose "Discontinue this home medication" option by clicking "Edit" icon in the row with "New: Zofran tablet (ondansetron HCl) 4 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Yes" button
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                                  | Action for Hospitalization | Hospital Orders* |
      | New: Discontinued: Zofran tablet (ondansetron HCl) 4 mg Oral Daily | Stop                       | Stopped          |
    When I choose "Undo DC" option by clicking "Edit" icon in the row with "New: Discontinued: Zofran tablet (ondansetron HCl) 4 mg" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                    | Action for Hospitalization | Hospital Orders* |
      | New: Zofran tablet (ondansetron HCl) 4 mg Oral Daily | Stop Continue / Change     |                  |
    When I select the "Continue" radio in the row with "New: Zofran tablet (ondansetron HCl) 4 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
#    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I move the mouse over the "New: Zofran tablet (ondansetron HCl) 4 mg Oral Daily" text in the row with "New: Zofran tablet (ondansetron HCl) 4 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                    | Action for Hospitalization | Hospital Orders*                                     |
      | New: Zofran tablet (ondansetron HCl) 4 mg Oral Daily | Continue / Change          | New: Zofran tablet (ondansetron HCl) 4 mg Oral Daily |
    When I choose "Delete" option by clicking "Edit" icon in the row with "New: Zofran tablet (ondansetron HCl) 4 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
#    Then the "Medication Reconciliation" table should have "0" rows
    Then the "Medication Reconciliation" table should have "0" rows containing the text "New: Zofran tablet (ondansetron HCl) 4 mg Oral Daily"
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button
    Then the "Admission Medication Reconciliation" pane should close


  @CHS14 @PatientSafety
  Scenario: 45. Discharge MedRec - Reconcile and Submit medication
    Given "NEIL HEATH" is on the patient list
    Then I select patient "NEIL HEATH" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close
    When I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Antivert tablet" in the "Discharge Search For Order" field in the "Search for order" pane
#    And I select "Antivert 25 mg tablet Oral" from the "Searched Combined Med Orders" list in the search results
    And I select "Antivert tablet (meclizine)  25MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane
    And I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close


  @CHS14
  Scenario: 46. Drug allergy popup, Delete the order after provider aware popup
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I enable the drug allergy display interaction checking option
    And I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And I select "MedRecPLV2" from the "Patient List" menu
    And "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Home Meds" from clinical navigation
    And I click the "Adm Med Rec" button in the "Home Medications" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    When I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "ASPIRIN EC 1 TAB" in the "Search for order" field in the "Search for order" pane
    And I select "ASPIRIN EC 1 TAB  325MG Oral Daily" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    When I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table
    And I enter "penicillamine capsule" in the "Hospital Search For Order" field in the "Search for order" pane
    And I select "penicillamine capsule 250MG" from the "Searched NonFormulary MedOrders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    When I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSWOK" button in the "Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    Then the "Clinical Decision Support Warnings" pane should close
    When I choose "Modify" option by clicking "Edit" icon in the row with "New: penicillamine capsule 250MG Oral Daily" as the value under "Hospital Orders*" in the "Medication Reconciliation" table
    And I select "TID" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    Then the "Medication Reconciliation" table should have at least "1" rows containing the text "penicillamine capsule 250MG"
    When I choose "Delete" option by clicking "Edit" icon in the row with "New: penicillamine capsule 250MG" as the value under "Hospital Orders*" in the "Medication Reconciliation" table
    Then the text "penicillamine capsule 250MG" should not appear in the "Admission Medication Reconciliation" pane
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button
    Then the "Admission Medication Reconciliation" pane should close


  @CHS14 @PatientSafety
  Scenario: 47. Discharge MedRec - Add/modify, delete, and continue home medications
    Given "ROY BLAZER" is on the patient list
    Then I select patient "ROY BLAZER" from the patient list
    And I select "Orders" from clinical navigation
    When I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    When I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close
    When I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "zofran tablet" in the "Discharge Search For Order" field in the "Search for order" pane
#    And I select "Zofran 4 mg tablet Oral" from the "Searched Combined Med Orders" list in the search results
    And I select "Zofran tablet (ondansetron HCl) 4MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane
    Then the following text should appear in the "Discharge Medication Reconciliation" pane
      | New: Zofran tablet (ondansetron HCl) 4 mg Oral Daily |
    When I choose "Modify" option by clicking "Edit" icon in the row with "New: Zofran tablet (ondansetron HCl) 4 mg Oral Daily" as the value under "Discharge Orders*" in the "Medication Reconciliation" table
    And I select "Weekly" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "PRN" checkbox
    And I enter "pain" in the "PRN Reason" discoverable textbox that appears
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    Then the following text should appear in the "Discharge Medication Reconciliation" pane
      | New: Zofran tablet (ondansetron HCl) 4 mg Oral Weekly PRN pain |
    When I choose "Delete" option by clicking "Edit" icon in the row with "New: Zofran tablet (ondansetron HCl) 4 mg Oral Weekly PRN pain" as the value under "Discharge Orders*" in the "Medication Reconciliation" table
    Then the text "New: Zofran tablet (ondansetron HCl) 4 mg Oral Weekly PRN pain" should not appear in the "Discharge Medication Reconciliation" pane
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button
    Then the "Discharge Medication Reconciliation" pane should close


  @CHS14
  Scenario: 48. ADMISSION MEDREC TRACKING/REPORTING
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I am on the "Admin" tab
    And I select the "Tracking/Reporting" subtab
    And I click the "Submission Status" element in the "Tracking Report" pane
    Then the "Submission Status" pane should load
    When I select "Today" from the "Time frame" dropdown in the "Submission Status" pane
    And I enter "medrecuser3" in the "User Track Report" field in the "Submission Status" pane
    And I click the "RefreshSummary Submission Record" button
    And I click the "Total Submission Records" element
    Then the "Show Detailed Results" table should load
    When the "Show Detailed Results" table should have at least "1" row containing the text "DARR,MOLLY"
    And I click the "Submitted Link" element
    Then the "Show Detailed Results" table should load
    And the following text should appear in the "Show Detailed Results" pane
      | ketorolac tablet 10MG Oral Daily |

  @CHS14
  Scenario: 49. DISCHARGE MEDREC TRACKING/REPORTING
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I am on the "Admin" tab
    And I select the "Tracking/Reporting" subtab
    And I click the "Submission Status" element in the "Tracking Report" pane
    Then the "Submission Status" pane should load
    When I select "Today" from the "Time frame" dropdown in the "Submission Status" pane
    And I enter "medrecuser3" in the "User Track Report" field in the "Submission Status" pane
    And I click the "RefreshSummary Submission Record" button
    And I click the "Total Submission Records" element
    Then the "Show Detailed Results" table should load
    And the "Show Detailed Results" table should have at least "1" row containing the text "DARR,MOLLY"
    And I click the "Submitted Link" element
    Then the "Show Detailed Results" table should load
    And the following text should appear in the "Show Detailed Results" pane
      | Antivert tablet (meclizine)  25MG |


  @Demo @PatientSafety
  Scenario: 50. Pre-Requisites Enable AMR, DMR and TMR
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I am on the "Admin" tab
    And I select the "Preferences" subtab
    And I select "CPOE" from the "Edit User Settings" dropdown
#    in the "User Preferences" pane
    And I edit the following user settings and I click save
      | Page | Name                     | Type  | Value |
      | CPOE | Can Enter Orders         | radio | true  |
      | CPOE | Enable Admission Med Rec | radio | true  |
      | CPOE | Enable Transfer Med Rec  | radio | true  |
      | CPOE | Enable Discharge Med Rec | radio | true  |
      | CPOE | Add Home Medications     | radio | true  |
      | CPOE | Continue Home Meds       | radio | true  |
    And I wait "2" seconds
    And I enable all the interaction checking options
    And I disable the medication duplicate display interaction checking option
    And I select the "Location" subtab
    And I select the "PKHospital-Central" facility
    And I click the "Edit Location" button
    And I wait "2" seconds
    And the "Edit Location Prefs" pane should load
    And I check the "Admission" checkbox
    And I check the "Discharge" checkbox
    And I check the "Transfer" checkbox
    And I wait "3" seconds
    And I click the "Save Edit Location Pref" button


  @Demo
  Scenario: 51. Stop aspirin in AMR
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "aspirin chewable tablet" in the "Search for order" field in the "Search for order" pane
    And I select "Aspirin Childrens chewable tablet (aspirin) 81MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                                | Action for Hospitalization | Hospital Orders* |
      | New: Aspirin Childrens chewable tablet (aspirin) 81MG Oral Daily | Stop Continue / Change     |                  |
    When I select the "Stop" radio in the row with "New: Aspirin Childrens chewable tablet (aspirin) 81MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I move the mouse over the "New: Aspirin Childrens chewable tablet (aspirin) 81MG Oral Daily" text in the row with "New: Aspirin Childrens chewable tablet (aspirin) 81MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                                | Action for Hospitalization | Hospital Orders* |
      | New: Aspirin Childrens chewable tablet (aspirin) 81MG Oral Daily | Stop                       | Stopped          |
    And I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button
#  in the "Question" pane


  @Demo @PatientSafety
  Scenario: 52a. Disable interaction display alerts
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I disable interaction display alerts
    And I disable the medication duplicate display interaction checking option


  @Demo @PatientSafety
  Scenario: 52b. Add aspirin in AMR
    Given "MOLLY DARR" is on the patient list
    Then I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load
    And I enter "aspirin chewable tablet" in the "Search for order" field in the "Search for order" pane
    And I wait "2" seconds
#    And I select "Aspirin Childrens 81 mg chewable tablet Oral" from the "Searched Combined Med Orders" list in the search results
    And I select "Aspirin Childrens chewable tablet (aspirin) 81MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                                 | Action for Hospitalization | Hospital Orders* |
      | New: Aspirin Childrens chewable tablet (aspirin) 81 mg Oral Daily | Stop Continue / Change     |                  |
    When I select the "Continue" radio in the row with "New: Aspirin Childrens chewable tablet (aspirin) 81 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I move the mouse over the "New: Aspirin Childrens chewable tablet (aspirin) 81 mg Oral Daily" text in the row with "New: Aspirin Childrens chewable tablet (aspirin) 81 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                                 | Action for Hospitalization | Hospital Orders*                                                  |
      | New: Aspirin Childrens chewable tablet (aspirin) 81 mg Oral Daily | Continue / Change          | New: Aspirin Childrens chewable tablet (aspirin) 81 mg Oral Daily |
    And I reconcile and Submit the Orders


#  DEV-85655 -- Automation: 9x Classic: Existing meds are not getting loaded into environment from simpk
#  Blocks scenarios: 53, 55b, 55c, 56, 57, and 58
  @Demo @PatientSafety
  Scenario: 53. Validate adding a Home Med in AMR that already has an existing hospital order
    Given "MOLLY DARR" is on the patient list
    Then I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
#    Then the "Search for order" pane should load
    And I enter "simvastatin tablet" in the "Search for order" field in the "Search for order" pane
#    And I select "simvastatin 20 mg tablet Oral" from the "Searched Combined Med Orders" list in the search results
    And I select "simvastatin tablet 20MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I select "QPM" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Done" button in the "Edit Medication Order" pane
    When I select the "Continue" radio in the row with "New: simvastatin tablet 20 mg Oral QPM" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                      | Action for Hospitalization | Hospital Orders*                           |
#      | New: simvastatin tablet 20 mg QPM | Continue / Change          | Existing: simvastatin tablet 20mg Oral QPM |
#      | New: simvastatin tablet 20 mg Oral QPM | Continue / Change          | Existing: simvastatin tablet 20 mg Oral QPM |
      | New: simvastatin tablet 20 mg Oral QPM | Continue / Change          | Existing: simvastatin tablet 20mg Oral qPM |
    And I reconcile and Submit the Orders


  @Demo @PatientSafety
  Scenario: 54a. Pre-req - Enable duplicate med display alerts
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I disable interaction display alerts
    And I enable the medication duplicate display interaction checking option


# DEV-84519 -- In AMR when adding a new home med, wrong existing order is being added next to it under Hospital Meds
  @Demo @PatientSafety
  Scenario: 54b. Receive a non-cLogin ritical duplicate alert on Diovan
    Given "MOLLY DARR" is on the patient list
    Then I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
#    Then the "Search for order" pane should load
    And I enter "Diovan" in the "Search for order" field in the "Search for order" pane
#    When I select "Diovan 320 mg tablet Oral" from the "Searched Combined Med Orders" list in the search results
    When I select "Diovan tablet (valsartan) 320MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                | Action for Hospitalization | Hospital Orders* |
      | New: Diovan tablet (valsartan) 320 mg Oral Daily | Stop Continue / Change     |                  |
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table
    And I enter "Diovan" in the "Search for order" field in the "Search for order" pane
    When I select "Diovan tablet (valsartan) 40MG" from the "Searched Combined Med Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSWOK" button
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane
    Then the "Clinical Decision Support Warnings" pane should close
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                               | Action for Hospitalization | Hospital Orders* |
      | New: Diovan tablet (valsartan) 40 mg Oral Daily | Stop Continue / Change     |                  |
    When I select the "Continue" radio in the row with "New: Diovan tablet (valsartan) 40 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                               | Action for Hospitalization | Hospital Orders*                                |
      | New: Diovan tablet (valsartan) 40 mg Oral Daily | Continue / Change          | New: Diovan tablet (valsartan) 40 mg Oral Daily |
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button


  @Demo @PatientSafety
  Scenario: 55a. Pre-req - Enable interaction display alerts
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I enable interaction display alerts
    And I disable the medication duplicate display interaction checking option

#DEV-85319 -- Conflict needs to be resolved twice in Clinical decision support warning popup for a specific med order
  @Demo @PatientSafety
  Scenario: 55b. Receive a critical alert, severe interaction warning on continuing Coumadin[DEV-85319]
    Given "MOLLY DARR" is on the patient list
    Then I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
#    Then the "Search for order" pane should load
    And I enter "Coumadin" in the "Search for order" field in the "Search for order" pane
#    And I select "Coumadin 10 mg tablet Oral" from the "Searched Combined Med Orders" list in the search results
    And I select "Coumadin tablet (warfarin) 10MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane
    When I select the "Continue" radio in the row with "New: Coumadin tablet (warfarin) 10 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications                                 | Action for Hospitalization | Hospital Orders                                      |
      | New: Coumadin tablet (warfarin) 10 mg Oral Daily | Continue / Change          | Existing: Coumadin tablet (warfarin) 10mg Oral Daily |
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table
    And I enter "aspirin 500 mg tablet" in the "Search for order" field in the "Search for order" pane
#    When I select "aspirin 500 mg tablet, delayed release Oral" from the "Searched Combined Med Orders" list in the search results
    When I select "aspirin tablet 500MG" from the "Searched Combined Med Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSWOK" button
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    And I wait "2" seconds
    Then the "Clinical Decision Support Warnings" pane should close
    And I reconcile and Submit the Orders


#dev-85319 -- Conflict needs to be resolved twice in Clinical decision support warning popup for a specific med order
#  Won't make scenario fail but is showing this issue
  @Demo @PatientSafety
  Scenario: 55c. Receive a moderate interaction alert on continuing Coumadin[DEV-85319]
    Given "MOLLY DARR" is on the patient list
    Then I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
#    Then the "Search for order" pane should load
    And I enter "Coumadin" in the "Search for order" field in the "Search for order" pane
    And I select "Coumadin tablet (warfarin) 10MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane
    When I select the "Continue" radio in the row with "New: Coumadin tablet (warfarin) 10 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications                                 | Action for Hospitalization | Hospital Orders                                      |
#      | New: Coumadin tablet (warfarin) 10 mg Oral Daily | Continue / Change          | Existing: Coumadin tablet (warfarin) 10 mg Oral Daily |
      | New: Coumadin tablet (warfarin) 10 mg Oral Daily | Continue / Change          | Existing: Coumadin tablet (warfarin) 10mg Oral Daily |
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table
    When I enter "tylenol 500mg" in the "Search for order" field in the "Search for order" pane
    And I select "Tylenol Extra Strength tablet (acetaminophen) 500MG" from the "Searched Combined Med Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSWOK" button
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    And I wait "2" seconds
    Then the "Clinical Decision Support Warnings" pane should close
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button


#DEV-85036 -- 9x Classic: Moderate interaction alert not displaying in AMR
#  @Demo @PatientSafety
#  Scenario: 55c. Receive a moderate interaction alert on continuing Diovan[DEV-85036]
#    Given "MOLLY DARR" is on the patient list
#    Then I select patient "MOLLY DARR" from the patient list
#    And I select "Orders" from clinical navigation
#    And I click the "Adm Med Rec" button in the "Orders" pane
#    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
#    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
#    And I enter "Diovan" in the "Search for order" field in the "Search for order" pane
##    When I select "Diovan 320 mg tablet Oral" from the "Searched Combined Med Orders" list in the search results
#    When I select "Diovan tablet (valsartan) 320MG Oral" from the "Searched Combined Med Orders" list in the search results
#    And I fill the mandatory order details in the "Edit Medication Order" pane
#    Then rows starting with the following should appear in the "Medication Reconciliation" table
#      | Home Medications*                                | Action for Hospitalization | Hospital Orders* |
#      | New: Diovan tablet (valsartan) 320 mg Daily | Stop Continue / Change     |                  |
#    And I select the "Continue" radio in the row with "New: Diovan tablet (valsartan) 320 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
#    Then the "Clinical Decision Support Warnings" pane should load
#    And I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
#    And I click the "CDSWOK" button
#    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane
#    And I fill the mandatory order details in the "Edit Medication Order" pane
#    Then rows starting with the following should appear in the "Medication Reconciliation" table
#      | Home Medications*                                | Action for Hospitalization | Hospital Orders*                                 |
#      | New: Diovan tablet (valsartan) 320 mg Oral Daily | Continue / Change          | New: Diovan tablet (valsartan) 320 mg Oral Daily |
#    And I reconcile and Submit the Orders


  @Demo @PatientSafety
  Scenario: 56. Select Therapeutic (Name-Brand) equivalent for Generic Carvedilol
    Given "MOLLY DARR" is on the patient list
    Then I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
#    Then the "Search for order" pane should load
    And I enter "carvedilol" in the "Search for order" field in the "Search for order" pane
    And I select "Coreg CR capsule, extended release (carvedilol phosphate) 10MG" from the "Searched Combined Med Orders" list in the search results
    And I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane if it exists
    And I click the "CDSWOK" button if it exists
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                                               | Hospital Orders*                           |
      | New: Coreg CR capsule, extended release (carvedilol phosphate) 10 mg Oral Daily | Existing: carvedilol tablet 25mg Oral q12h |
    When I select the "Substitute w/Existing Order" radio in the row with "New: Coreg CR capsule, extended release (carvedilol phosphate) 10 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I move the mouse over the "New: Coreg CR capsule, extended release (carvedilol phosphate) 10 mg Oral Daily" text in the row with "New: Coreg CR capsule, extended release (carvedilol phosphate) 10 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                                                               | Action for Hospitalization  | Hospital Orders*                           |
      | New: Coreg CR capsule, extended release (carvedilol phosphate) 10 mg Oral Daily | Substitute w/Existing Order | Existing: carvedilol tablet 25mg Oral q12h |
    And I reconcile and Submit the Orders


  @Demo @PatientSafety
  Scenario: 57. Continue incorrectly spelled Med Order in AMR
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
#    Then the "Search for order" pane should load
#    And I enter "glyBURIDi" in the "Search for order" field in the "Search for order" pane
    And I enter "carvedilloll" in the "Search for order" field in the "Search for order" pane
    And I wait "4" seconds
#    And I select "glyburide 5 mg tablet Oral" from the "Searched Combined Med Orders" list in the search results
#    And I select "carvedilol 25 mg tablet Oral" from the "Searched Combined Med Orders" list in the search results
    And I select "carvedilol tablet 25MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    When I select the "Continue" radio in the row with "New: carvedilol tablet 25 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                       | Hospital Orders*                           |
      | New: carvedilol tablet 25 mg Oral Daily | Existing: carvedilol tablet 25mg Oral q12h |
    And I reconcile and Submit the Orders


  @Demo @PatientSafety
  Scenario: 58. Validate Home Meds for Molly Darr from Home Meds clinical navigation
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Home Meds" from clinical navigation
    Then rows containing the following should appear in the "Pre Admission Medication" clinical table
      | Pre-Admission Medication | Dose   | Sig   |
      | Aspir 81                 | 81 MG  | DAILY |
      | Coumadin                 | 2 MG   | DAILY |
      | Diovan                   | 320 MG | DAILY |
      | Plavix                   | 75 MG  | DAILY |
      | Pravachol                | 40 MG  | DAILY |


  @Demo
  Scenario: 59. Transfer - Change including previous route on Med [AUTO-184][DEV-59862]
    When I am on the "Patient List V2" tab
    And there should not be any unfinished orders
    When "ROY BLAZER" is on the patient list
    And I select patient "ROY BLAZER" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Transfer Order Rec" button in the "Orders" pane
    And I uncheck the "Transfer From" checkbox
    And I select the "Change" link in the row with the text "morphine 2 mg/mL Syringe 2mg inj q4h PRN pain" in the "Medication Reconciliation" table
    And I wait "2" seconds
    And I select "morphine (PF) 0.5 mg/mL Injection IV" from the "Searched Non Formulary Med Orders" list in the search results
    Then the following text should appear in the "Edit Medication Order" pane
      | morphine (PF) 0.5 mg/mL Injection 2mg IV |
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And rows containing the following should appear in the "Medication Reconciliation" clinical table
      | morphine 2 mg/mL Syringe 2mg inj q4h PRN pain | Continue / Change | New: morphine (PF) 0.5 mg/mL Injection IV (test order) |
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane


  @Demo
  Scenario: 60. Continue, Change and Stop any Medication in DMR
    When "ROY BLAZER" is on the patient list
    And I select patient "ROY BLAZER" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    And I select the "Continue" radio in the row with the text "carvedilol tablet 25mg q12h" from the "Medication Reconciliation" table
    And I move the mouse over the "carvedilol tablet 25mg q12h" text in the row with "carvedilol tablet 25mg q12h" as the value under "Current Orders" in the "Medication Reconciliation" table
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | carvedilol tablet 25mg q12h | Continue / Change | New: carvedilol tablet 25mg q12h |
    And rows containing the following should appear in the "Medication Reconciliation" clinical table
#            |acetaminophen 325mg Q6H PRN |Stop Continue / Change  |
      | acetaminophen tablet 325mg Q6H PRN pain | Stop Continue / Change |
#        When I select the "Change" link in the row with the text "Acetaminophen 325mg Q6H PRN" in the "Medication Reconciliation" table
    When I select the "Change" link in the row with the text "acetaminophen tablet 325mg Q6H PRN pain" in the "Medication Reconciliation" table
    And I select "acetaminophen (bulk) 100 % Powder Misc" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
#        And I move the mouse over the "Acetaminophen 325mg Q6H PRN" text in the row with "Acetaminophen 325mg Q6H PRN" as the value under "Current Orders" in the "Medication Reconciliation" table
    And I move the mouse over the "acetaminophen tablet 325mg Q6H PRN pain" text in the row with "acetaminophen tablet 325mg Q6H PRN pain" as the value under "Current Orders" in the "Medication Reconciliation" table
    Then rows containing the following should appear in the "Medication Reconciliation" clinical table
#            |Acetaminophen 325mg Q6H PRN |Continue / Change    |New: acetaminophen (bulk) 100 % Powder |
      | acetaminophen tablet 325mg Q6H PRN pain | Continue / Change | New: acetaminophen (bulk) 100 % Powder Misc (test order) |
    And I select the "Stop" radio in the row with the text "furosemide tablet 20mg q8h" from the "Medication Reconciliation" table
    And I move the mouse over the "furosemide tablet 20mg q8h" text in the row with "furosemide tablet 20mg q8h" as the value under "Current Orders" in the "Medication Reconciliation" table
    Then rows containing the following should appear in the "Medication Reconciliation" clinical table
      | furosemide tablet 20mg q8h | Stop | Stopped |
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I reconcile and Submit the Orders


  @Demo
  Scenario: 61. Continue, Stop and Change any Medication in TMR
    When "ROY BLAZER" is on the patient list
    And I select patient "ROY BLAZER" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Transfer Order Rec" button in the "Orders" pane
    And I uncheck the "Transfer From" checkbox
    And I select the "Continue" radio in the row with the text "Plavix tablet (clopidogrel) 75mg Oral Daily" from the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I move the mouse over the "Continue: Plavix tablet (clopidogrel) 75mg Oral Daily" text in the row with "Continue: Plavix tablet (clopidogrel) 75mg Oral Daily" as the value under "New Orders" in the "Medication Reconciliation" table
    Then rows containing the following should appear in the "Medication Reconciliation" clinical table
      | Plavix tablet (clopidogrel) 75mg Oral Daily | Continue / Change | Continue: Plavix tablet (clopidogrel) 75mg Oral Daily |
    And I select the "Stop" radio in the row with the text "Humulin R 100 unit/mL Injection (insulin regular human) 3-11units inj QAC SS" from the "Medication Reconciliation" table
    And I move the mouse over the "Continue: Plavix tablet (clopidogrel) 75mg Oral Daily" text in the row with "Continue: Plavix tablet (clopidogrel) 75mg Oral Daily" as the value under "New Orders" in the "Medication Reconciliation" table
    Then rows containing the following should appear in the "Medication Reconciliation" clinical table
      | Humulin R 100 unit/mL Injection (insulin regular human) 3-11units inj QAC SS | Stop | Discontinued: Humulin R 100 unit/mL Injection (insulin regular human) 3-11units inj QAC SS |
    Then rows containing the following should appear in the "Medication Reconciliation" clinical table
      | Continue: Plavix tablet (clopidogrel) 75mg Oral Daily | Stop Continue / Change |  |
    When I select the "Change" link in the row with the text "morphine 2 mg/mL Syringe 2mg inj q4h PRN pain" in the "Medication Reconciliation" table
    And I wait "2" seconds
    And I select "morphine (PF) 0.5 mg/mL Injection IV" from the "Searched Non Formulary Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I move the mouse over the "Continue: Plavix tablet (clopidogrel) 75mg Oral Daily" text in the row with "Continue: Plavix tablet (clopidogrel) 75mg Oral Daily" as the value under "New Orders" in the "Medication Reconciliation" table
    Then rows containing the following should appear in the "Medication Reconciliation" clinical table
      | morphine 2 mg/mL Syringe 2mg inj q4h PRN pain | Continue / Change | New: morphine (PF) 0.5 mg/mL Injection IV (test order) |
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button
#  in the "Question" pane
    And I am on the "Patient List V2" tab
    And "ROY BLAZER" is not on the patient list