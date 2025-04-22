@MedRec2
Feature: Medication Reconciliation Phase 2
  This is Milestone 2.

  #  * * Almost everything in the whole suite is failing due to: https://jira/browse/DEV-84737.  Per Igor "MDS Service appears to be down"

  Background:
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And I select "MedRecPLV2" from the "Patient List" menu
    And there should not be any unfinished orders


#    [DEV-84514] -- Edit Facility Group Utilities Settings pane can take more than 10 - 20 seconds to load, Intermittent issue
  @PatientSafety
  Scenario: Pre-requisite Setup scenario
    Given I am logged into the portal with the default user
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "medrecuser3"
    And I select the user "medrecuser3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "CPOE" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I edit the following user settings and I click save
      | Page | Name                     | Type  | Value |
      | CPOE | Can Enter Orders         | radio | true  |
      | CPOE | Enable Admission Med Rec | radio | true  |
      | CPOE | Enable Discharge Med Rec | radio | true  |
      | CPOE | Add Home Medications     | radio | true  |
      | CPOE | Continue Home Meds       | radio | true  |
        #Disable all interaction checking options
    And I disable all the interaction checking options
    And I select the "Location" subtab
    And I select the "PKHospital-Verve" facility
    And I click the "Edit Location" button
    And I wait "3" seconds
    And I select "true" from the "CPOE Enabled" radio list
    And I check the "Admission" checkbox
    And I check the "Discharge" checkbox
    And I check the "Transfer" checkbox
    And I select "false" from the "Allow Hold for Admission" radio list
    And I select "true" from the "Enable Continue Home Meds" radio list
    And I click the "Delete Order Definition" image if it exists
    And I click the "Save Edit Location Pref" button


  Scenario: 1. Discharge Med Rec link on Actions (Patient search)
    When "MEDREC RECON1" is on the patient list
    And I select patient "MEDREC RECON1" from the patient list
      # To stop the medications present in the DMR screen
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
#        And I click the "Reconcile and Submit" button in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close
    When I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I "uncheck" the following
      | Include Cancelled Visits |
      | Include Past Visits      |
    And I enter "RECON1" in the "Last" field in the "Patient Search Criteria" pane
    And I enter "MEDREC" in the "First" field in the "Patient Search Criteria" pane
    And I select "PKHospital-Verve" from the "Facility" dropdown in the "Patient Search Criteria" pane
    And I click the "Search for Visits" button
    And I select patient "MEDREC RECON1" from the "Name (\d)" column in the "Visit Search Results" table
    And I select "Discharge Med Rec" from the "Actions" menu
    Then the "Discharge Medication Reconciliation" pane should load
    And the following fields should display in the "Discharge Medication Reconciliation" pane
      | Name                 | Type     |
      | Med Rec Visits       | dropdown |
      | Show Clinical Data   | button   |
      | Reconcile and Submit | button   |
      | Med Rec Cancel       | button   |
    And the text "The selected visit does not have any home or hospital medications to reconcile." should appear in the "Discharge Medication Reconciliation" pane
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close


  @PatientSafety
  Scenario: 2. Home Med matches to hospital Meds
    Given "RECON1, MEDREC" is on the patient list
    Then I select patient "MEDREC RECON1" from the patient list
    And I select "Orders" from clinical navigation
#    And I place the "danazol 100 mg capsule Oral" order
    And I place the "danazol capsule 100MG Oral" order
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*              | Start          | Status    |
      | danazol capsule 100 mg Oral Daily | %Current Date% | Submitted |
#      | danazol capsule 100 mg Daily | %Current Date% | Submitted |
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "danazol capsule" in the "Search for order" field in the "Search for order" pane
#    And I select "danazol 100 mg capsule Oral" from the "Searched Combined Med Orders" list in the search results
    And I select "danazol capsule 100MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                      | Action for Hospitalization | Hospital Orders*                            |
      | New: danazol capsule 100 mg Oral Daily | Continue / Change          | Existing: danazol capsule 100 mg Oral Daily |
#      | New: danazol capsule 100 mg Daily | Continue / Change          | Existing: danazol capsule 100 mg Daily |
    When I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button
    Then the "Admission Medication Reconciliation" pane should close


  Scenario: 3. Modify a matched hospital order no interaction
    When "MEDREC RECON2" is on the patient list
    And I select patient "MEDREC RECON2" from the patient list
        # To stop the medications present in the DMR screen
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
#        And I click the "Reconcile and Submit" button in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close
    And I select "Orders" from clinical navigation
    And I place the "phenelzine tablet  15MG Oral" order
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*        | Start          | Status    |
      | phenelzine tablet 15MG Oral | %Current Date% | Submitted |
    And I wait "2" seconds
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "phenelzine tablet" in the "Search for order" field in the "Search for order" pane
    And I select "phenelzine tablet  15MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I select "Daily" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                | Action for Hospitalization | Hospital Orders*                            |
      | New: phenelzine tablet 15MG Oral | Continue / Change          | Existing: phenelzine tablet 15MG Oral Daily |
    When I choose "Correct this home medication" option by clicking "Edit" icon in the row with "Existing: phenelzine tablet 15MG Oral Daily" as the value under "Hospital OrdersAdd" in the "Medication Reconciliation" table
    And I select "Weekly" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                | Action for Hospitalization | Hospital Orders*                        |
      | New: phenelzine tablet 15MG Oral | Continue / Change          | New: phenelzine tablet 15MG Oral Weekly |
    And the "Medication Reconciliation" table should have at least "1" row containing the text "Discontinued:"
    And the "Medication Reconciliation" table should have at least "1" row containing the text "phenelzine tablet 15MG Oral Daily"
    When I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: 4. Multiple Hospital meds corresponded to Home Meds listed on the right
    When "MEDREC RECON3" is on the patient list
    And I select patient "MEDREC RECON3" from the patient list
        # To stop the medications present in the DMR screen
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
#        And I click the "Reconcile and Submit" button in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close
    And I select "Orders" from clinical navigation
    And I search for the "aspirin chewable tablet" order
    And I select "aspirin chewable tablet  81mg Oral Daily" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
    And I enter "aspirin tablet" in the "Add Order" field in the "Enter Orders" pane
    And I select "aspirin tablet  500MG Oral" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
    And I Submit the Orders
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*              | Start          | Status    |
      | aspirin chewable tablet 81mg Oral | %Current Date% | Submitted |
      | aspirin tablet 500MG Oral         | %Current Date% | Submitted |
    And I wait "2" seconds
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "2" seconds
    And I enter "aspirin chewable tablet" in the "Search for order" field in the "Search for order" pane
    And I select "aspirin chewable tablet  81mg Oral Daily" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                      | Action for Hospitalization | Hospital Orders*                            |
      | New: aspirin chewable tablet 81mg Oral | Continue / Change          | Existing: aspirin chewable tablet 81mg Oral |
    And the "Medication Reconciliation" table should have at least "1" row containing the text "aspirin tablet 500MG Oral"
    When I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: 5. Directly DC the matched order and Undo DC
    When "MEDREC PATIENT4" is on the patient list
    And I select patient "MEDREC PATIENT4" from the patient list
        # To stop the medications present in the DMR screen
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
#        And I click the "Reconcile and Submit" button in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close
    And I select "Orders" from clinical navigation
    And I place the "aspirin chewable tablet  81mg Oral Daily" order
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*              | Start          | Status    |
      | aspirin chewable tablet 81mg Oral | %Current Date% | Submitted |
    And I wait "1" seconds
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "2" seconds
    And I enter "aspirin tablet" in the "Search for order" field in the "Search for order" pane
    And I select "aspirin chewable tablet  81mg Oral Daily" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                            | Action for Hospitalization | Hospital Orders*                                  |
      | New: aspirin chewable tablet 81mg Oral Daily | Continue / Change          | Existing: aspirin chewable tablet 81mg Oral Daily |
    When I choose "Discontinue this home medication" option by clicking "Edit" icon in the row with "Existing: aspirin chewable tablet 81mg Oral" as the value under "Hospital OrdersAdd" in the "Medication Reconciliation" table
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                            | Action for Hospitalization | Hospital Orders*                                      |
      | New: aspirin chewable tablet 81mg Oral Daily | Stop                       | Discontinued: aspirin chewable tablet 81mg Oral Daily |
    When I choose "Undo DC" option by clicking "Edit" icon in the row with "Discontinued: aspirin chewable tablet 81mg Oral" as the value under "Hospital OrdersAdd" in the "Medication Reconciliation" table
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                            | Action for Hospitalization | Hospital Orders*                                  |
      | New: aspirin chewable tablet 81mg Oral Daily | Stop Continue / Change     | Existing: aspirin chewable tablet 81mg Oral Daily |
    When I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: 6. Modify a matched hospital order interact with its own match
    Given I am logged into the portal with the default user
    And I enable the medication duplicate display interaction checking option
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    When "MEDREC RECON4" is on the patient list
    And I select patient "MEDREC RECON4" from the patient list
        # To stop the medications present in the DMR screen
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
#        And I click the "Reconcile and Submit" button in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close
    And I select "Orders" from clinical navigation
    And I search for the "aspirin tablet" order
    And I select "aspirin chewable tablet  81mg Oral Daily" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
    And I enter "aspirin tablet" in the "Add Order" field in the "Enter Orders" pane
    And I select "aspirin tablet  500MG Oral" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
    And I Submit the Orders
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*              | Start          | Status    |
      | aspirin chewable tablet 81mg Oral | %Current Date% | Submitted |
      | aspirin tablet 500MG Oral         | %Current Date% | Submitted |
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "aspirin chewable tablet" in the "Search for order" field in the "Search for order" pane
    And I select "aspirin chewable tablet  81mg Oral Daily" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                            | Action for Hospitalization | Hospital Orders*                                  |
      | New: aspirin chewable tablet 81mg Oral Daily | Continue / Change          | Existing: aspirin chewable tablet 81mg Oral Daily |
    And the "Medication Reconciliation" table should have "1" row containing the text "aspirin tablet 500MG Oral"
    When I choose "Correct this home medication" option by clicking "Edit" icon in the row with "Existing: aspirin chewable tablet 81mg Oral" as the value under "Hospital OrdersAdd" in the "Medication Reconciliation" table
    And I select "Weekly" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    Then the "CDS Warnings" pane should load
    When I select "Provider Aware - Continue as ordered" as override reason in the "CDS Warnings" pane
    And I click the "CDS Warnings OK" button
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                            | Action for Hospitalization | Hospital Orders*                              |
      | New: aspirin chewable tablet 81mg Oral Daily | Continue / Change          | New: aspirin chewable tablet 81mg Oral Weekly |
    And the "Medication Reconciliation" table should have "1" row containing the text "aspirin tablet 500MG"
    And the "Medication Reconciliation" table should have at least "1" row containing the text "Discontinued:"
    When I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: 7. Modify a matched hospital order interact with other match
    Given I am logged into the portal with the default user
    And I enable interaction display alerts
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
        # To stop the medications present in the DMR screen
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
#        And I click the "Reconcile and Submit" button in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close
    And I select "Orders" from clinical navigation
    And I search for the "aspirin chewable tablet" order
    And I select "aspirin chewable tablet  81mg Oral Daily" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
    And I enter "ketorolac tablet" in the "Add Order" field in the "Enter Orders" pane
    And I select "ketorolac tablet  10MG Oral" from the "NonFormulary MedOrders" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should load
    When I select "Provider Aware - Continue as ordered" as override reason in the "Order Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Order Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Order Clinical Decision Support Warnings" pane if it exists
    And I Submit the Orders
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*              | Start          | Status    |
      | aspirin chewable tablet 81mg Oral | %Current Date% | Submitted |
      | ketorolac tablet 10MG Oral        | %Current Date% | Submitted |
    And I wait "2" seconds
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "2" seconds
    And I enter "aspirin chewable tablet" in the "Search for order" field in the "Search for order" pane
    And I select "aspirin chewable tablet  81mg Oral Daily" from the "Searched Combined Med Orders" list in the search results
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                      | Action for Hospitalization | Hospital Orders*                            |
      | New: aspirin chewable tablet 81mg Oral | Continue / Change          | Existing: aspirin chewable tablet 81mg Oral |
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "2" seconds
    And I enter "ketorolac tablet" in the "Search for order" field in the "Search for order" pane
    And I select "ketorolac tablet  10MG Oral" from the "Searched Combined Med Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    When I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                            | Action for Hospitalization | Hospital Orders*                                  |
      | New: aspirin chewable tablet 81mg Oral Daily | Continue / Change          | Existing: aspirin chewable tablet 81mg Oral Daily |
      | New: ketorolac tablet 10MG Oral              | Continue / Change          | Existing: ketorolac tablet 10MG Oral              |
    When I choose "Correct this home medication" option by clicking "Edit" icon in the row with "Existing: aspirin chewable tablet 81mg Oral" as the value under "Hospital OrdersAdd" in the "Medication Reconciliation" table
    And I select "Weekly" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    Then the "CDS Warnings" pane should load
    When I select "Provider Aware - Continue as ordered" as override reason in the "CDS Warnings" pane
    And I click the "CDSWarnings OK" button
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                            | Action for Hospitalization | Hospital Orders*                              |
      | New: aspirin chewable tablet 81mg Oral Daily | Continue / Change          | New: aspirin chewable tablet 81mg Oral Weekly |
      | New: ketorolac tablet 10MG Oral              | Continue / Change          | Existing: ketorolac tablet 10MG Oral          |
    Then the "Medication Reconciliation" table should have at least "1" row containing the text "Discontinued: "
    When I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: 8. Modify a matched hospital order interact with a continued med
    When "MEDREC PATIENT2" is on the patient list
    And I select patient "MEDREC PATIENT2" from the patient list
        # To stop the medications present in the DMR screen
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
#        And I click the "Reconcile and Submit" button in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button in the "Orders" pane
    And I place the "aspirin chewable tablet  81mg Oral Daily" order
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*              | Start          | Status    |
      | aspirin chewable tablet 81mg Oral | %Current Date% | Submitted |
    And I wait "2" seconds
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "2" seconds
    And I enter "aspirin chewable tablet" in the "Search for order" field in the "Search for order" pane
    And I select "aspirin chewable tablet  81mg Oral Daily" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                            | Action for Hospitalization | Hospital Orders*                                  |
      | New: aspirin chewable tablet 81mg Oral Daily | Continue / Change          | Existing: aspirin chewable tablet 81mg Oral Daily |
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "2" seconds
    And I enter "ginkgo biloba tablet" in the "Search for order" field in the "Search for order" pane
    And I select "ginkgo biloba tablet  60MG Oral" from the "Searched Combined Med Orders" list in the search results
    When I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                            | Action for Hospitalization | Hospital Orders*                                  |
      | New: aspirin chewable tablet 81mg Oral Daily | Continue / Change          | Existing: aspirin chewable tablet 81mg Oral Daily |
      | New: ginkgo biloba tablet 60MG Oral          | Stop Continue / Change     |                                                   |
    When I choose "Correct this home medication" option by clicking "Edit" icon in the row with "Existing: aspirin chewable tablet 81mg Oral" as the value under "Hospital OrdersAdd" in the "Medication Reconciliation" table
    And I select "Weekly" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    Then the "CDSWarnings" pane should load
    When I select "Provider Aware - Continue as ordered" as override reason in the "CDS Warnings" pane
    And I click the "CDSWarnings OK" button
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                            | Action for Hospitalization | Hospital Orders*                              |
      | New: aspirin chewable tablet 81mg Oral Daily | Continue / Change          | New: aspirin chewable tablet 81mg Oral Weekly |
      | New: ginkgo biloba tablet 60MG Oral          | Stop Continue / Change     |                                               |
    Then the "Medication Reconciliation" table should have at least "1" row containing the text "Discontinued: "
    When I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: 9. Modify a matched hospital order interact with a new hospital med
    When "MEDREC RECON1" is on the patient list
    And I select patient "MEDREC RECON1" from the patient list
    And I select "Orders" from clinical navigation
    And I place the "aspirin chewable tablet  81mg Oral Daily" order
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*              | Start          | Status    |
      | aspirin chewable tablet 81mg Oral | %Current Date% | Submitted |
    And I wait "2" seconds
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "2" seconds
    And I enter "aspirin tablet" in the "Search for order" field in the "Search for order" pane
    And I select "aspirin chewable tablet  81mg Oral Daily" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                            | Action for Hospitalization | Hospital Orders*                                  |
      | New: aspirin chewable tablet 81mg Oral Daily | Continue / Change          | Existing: aspirin chewable tablet 81mg Oral Daily |
    When I choose "Correct this home medication" option by clicking "Edit" icon in the row with "Existing: aspirin chewable tablet 81mg Oral" as the value under "Hospital OrdersAdd" in the "Medication Reconciliation" table
    And I select "Weekly" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    Then the "CDS Warnings" pane should load
    When I select "Provider Aware - Continue as ordered" as override reason in the "CDS Warnings" pane
    And I click the "CDSWarnings OK" button
    And I wait "2" seconds
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                            | Action for Hospitalization | Hospital Orders*                              |
      | New: aspirin chewable tablet 81mg Oral Daily | Continue / Change          | New: aspirin chewable tablet 81mg Oral Weekly |
    Then the "Medication Reconciliation" table should have at least "1" row containing the text "Discontinued: "
    And the "Medication Reconciliation" table should have at least "1" row containing the text "aspirin chewable tablet 81mg Oral Daily"
    When I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "ketorolac tablet" in the "Hospital Search For Order" field in the "Search for order" pane
    And I select "ketorolac tablet  10MG Oral" from the "Searched Non Formulary MedOrders" list in the search results
    When I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                            | Action for Hospitalization | Hospital Orders*                              |
      | New: aspirin chewable tablet 81mg Oral Daily | Continue / Change          | New: aspirin chewable tablet 81mg Oral Weekly |
    Then the "Medication Reconciliation" table should have at least "1" row containing the text "ketorolac tablet 10MG Oral"
    When I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: 10. Continue Hospital Order-Contraindicated Drug Combination
    Given I am logged into the portal with the default user
    And I enable interaction display alerts
    And I enable the medication duplicate display interaction checking option
    And I enable the drug allergy display interaction checking option
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    When "MEDREC RECON2" is on the patient list
    And I select patient "MEDREC RECON2" from the patient list
    And I select "Orders" from clinical navigation
    When I place the "aspirin tablet  500MG Oral" order
    And I search for the "ketorolac tablet" order
    And I select "ketorolac tablet  10MG Oral" from the "NonFormulary MedOrders" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should load
    And the text "Contraindicated Drug Combination" should appear in the "Order Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Order Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Order Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Order Clinical Decision Support Warnings" pane if it exists
    Then the "Order Clinical Decision Support Warnings" pane should close
    When I Submit the Orders
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*  | Start          | Status    |
      | aspirin tablet 500MG  | %Current Date% | Submitted |
      | ketorolac tablet 10MG | %Current Date% | Submitted |
    When I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*       | Action for Discharge   | Discharge Orders* |
      | aspirin tablet 500MG  | Stop Continue / Change |                   |
      | ketorolac tablet 10MG | Stop Continue / Change |                   |
    When I select the "Continue" radio in the row with "aspirin tablet 500MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I move the mouse over the "aspirin tablet 500MG" text in the row with "aspirin tablet 500MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*       | Action for Discharge   | Discharge Orders*         |
      | aspirin tablet 500MG  | Continue / Change      | New: aspirin tablet 500MG |
      | ketorolac tablet 10MG | Stop Continue / Change |                           |
    When I select the "Continue" radio in the row with "ketorolac tablet 10MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Contraindicated Drug Combination" should appear in the "Clinical Decision Support Warnings" pane
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    Then the "Clinical Decision Support Warnings Header" pane should close
    And rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*       | Action for Discharge   | Discharge Orders*         |
      | aspirin tablet 500MG  | Continue / Change      | New: aspirin tablet 500MG |
      | ketorolac tablet 10MG | Stop Continue / Change |                           |
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: 11. Continue Hospital Order- Severe Interaction
    Given I am logged into the portal with the default user
    And I enable interaction display alerts
    And I enable the medication duplicate display interaction checking option
    And I enable the drug allergy display interaction checking option
    Given I am logged into the portal with user "medrecuser3" using the default password
    When I am on the "Patient List V2" tab
    And "MEDREC RECON3" is on the patient list
    And I select patient "MEDREC RECON3" from the patient list
    And I select "Orders" from clinical navigation
    And I place the "cimetidine tablet  200MG Oral" order
    And I search for the "carmustine" order
    And I select "carmustine IV Solution  100MG IV" from the "NonFormulary MedOrders" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should load
    And the text "Severe Interaction" should appear in the "Order Clinical Decision Support Warnings" pane
    And I select "Provider Aware - Continue as ordered" as override reason in the "Order Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Order Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Order Clinical Decision Support Warnings" pane if it exists
    Then the "Order Clinical Decision Support Warnings" pane should close
    When I Submit the Orders
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*         | Start          | Status    |
      | cimetidine tablet 200MG      | %Current Date% | Submitted |
      | carmustine IV Solution 100MG | %Current Date% | Submitted |
    When I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*              | Action for Discharge   | Discharge Orders* |
      | cimetidine tablet 200MG      | Stop Continue / Change |                   |
      | carmustine IV Solution 100MG | Stop Continue / Change |                   |
    When I select the "Continue" radio in the row with "cimetidine tablet 200MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I move the mouse over the "cimetidine tablet 200MG" text in the row with "cimetidine tablet 200MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*              | Action for Discharge   | Discharge Orders*            |
      | cimetidine tablet 200MG      | Continue / Change      | New: cimetidine tablet 200MG |
      | carmustine IV Solution 100MG | Stop Continue / Change |                              |
    When I select the "Continue" radio in the row with "carmustine IV Solution 100MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    And I click the "Yes" button in the "Question" pane if it exists
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Severe Interaction" should appear in the "Clinical Decision Support Warnings" pane
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    Then the "Clinical Decision Support Warnings Header" pane should close
    And rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*              | Action for Discharge   | Discharge Orders*            |
      | cimetidine tablet 200MG      | Continue / Change      | New: cimetidine tablet 200MG |
      | carmustine IV Solution 100MG | Stop Continue / Change |                              |
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: 12. Continue Hospital Order- Moderate Interaction
    Given I am logged into the portal with the default user
    And I enable interaction display alerts
    And I enable the medication duplicate display interaction checking option
    And I enable the drug allergy display interaction checking option
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And "MEDREC RECON4" is on the patient list
    And I select patient "MEDREC RECON4" from the patient list
    And I select "Orders" from clinical navigation
    When I place the "verapamil tablet  40MG Oral" order
    And I search for the "Eplerenone" order
    And I select "eplerenone tablet  25MG Oral" from the "NonFormulary MedOrders" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should load
    And the text "Moderate Interaction" should appear in the "Order Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Order Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Order Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Order Clinical Decision Support Warnings" pane if it exists
    Then the "Order Clinical Decision Support Warnings" pane should close
    When I Submit the Orders
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*   | Start          | Status    |
      | verapamil tablet 40MG  | %Current Date% | Submitted |
      | eplerenone tablet 25MG | %Current Date% | Submitted |
    When I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*        | Action for Discharge   | Discharge Orders* |
      | verapamil tablet 40MG  | Stop Continue / Change |                   |
      | eplerenone tablet 25MG | Stop Continue / Change |                   |
    When I select the "Continue" radio in the row with "verapamil tablet 40MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I move the mouse over the "verapamil tablet 40MG" text in the row with "verapamil tablet 40MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*        | Action for Discharge   | Discharge Orders*          |
      | verapamil tablet 40MG  | Continue / Change      | New: verapamil tablet 40MG |
      | eplerenone tablet 25MG | Stop Continue / Change |                            |
    When I select the "Continue" radio in the row with "eplerenone tablet 25MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Moderate Interaction" should appear in the "Clinical Decision Support Warnings" pane
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    Then the "Clinical Decision Support Warnings Header" pane should close
    And rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*        | Action for Discharge   | Discharge Orders*          |
      | verapamil tablet 40MG  | Continue / Change      | New: verapamil tablet 40MG |
      | eplerenone tablet 25MG | Stop Continue / Change |                            |
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: 13. Continue Hospital Order-Undetermined Severity - Alternative Therapy Interaction
    Given I am logged into the portal with the default user
    And I enable interaction display alerts
    And I enable the medication duplicate display interaction checking option
    And I enable the drug allergy display interaction checking option
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Orders" from clinical navigation
    When I place the "aspirin tablet  500MG Oral" order
    And I search for the "Ginkgo biloba Cap" order
    And I select "ginkgo biloba capsule  40MG Oral" from the "NonFormulary MedOrders" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should load
    And the text "Undetermined Severity - Alternative Therapy Interaction" should appear in the "Order Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Order Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Order Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Order Clinical Decision Support Warnings" pane if it exists
    Then the "Order Clinical Decision Support Warnings" pane should close
    When I Submit the Orders
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*       | Start          | Status    |
      | aspirin tablet 500MG       | %Current Date% | Submitted |
      | ginkgo biloba capsule 40MG | %Current Date% | Submitted |
    When I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*            | Action for Discharge   | Discharge Orders* |
      | aspirin tablet 500MG       | Stop Continue / Change |                   |
      | ginkgo biloba capsule 40MG | Stop Continue / Change |                   |
    When I select the "Continue" radio in the row with "aspirin tablet 500MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I move the mouse over the "aspirin tablet 500MG" text in the row with "aspirin tablet 500MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*            | Action for Discharge   | Discharge Orders*         |
      | aspirin tablet 500MG       | Continue / Change      | New: aspirin tablet 500MG |
      | ginkgo biloba capsule 40MG | Stop Continue / Change |                           |
    When I select the "Continue" radio in the row with "ginkgo biloba capsule 40MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Undetermined Severity - Alternative Therapy Interaction" should appear in the "Clinical Decision Support Warnings" pane
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    Then the "Clinical Decision Support Warnings Header" pane should close
    And rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*            | Action for Discharge   | Discharge Orders*         |
      | aspirin tablet 500MG       | Continue / Change      | New: aspirin tablet 500MG |
      | ginkgo biloba capsule 40MG | Stop Continue / Change |                           |
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: 14. Resolve -Contraindicated Drug Combination
    Given I am logged into the portal with the default user
    And I enable interaction display alerts
    And I enable the medication duplicate display interaction checking option
    And I enable the drug allergy display interaction checking option
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And "MEDREC PATIENT2" is on the patient list
    And I select patient "MEDREC PATIENT2" from the patient list
    And I select "Orders" from clinical navigation
    When I place the "aspirin tablet  500MG Oral" order
    And I search for the "ketorolac tablet" order
    And I select "ketorolac tablet  10MG Oral" from the "NonFormulary MedOrders" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should load
    And the text "Contraindicated Drug Combination" should appear in the "Order Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Order Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Order Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Order Clinical Decision Support Warnings" pane if it exists
    Then the "Order Clinical Decision Support Warnings" pane should close
    When I Submit the Orders
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*  | Start          | Status    |
      | aspirin tablet 500MG  | %Current Date% | Submitted |
      | ketorolac tablet 10MG | %Current Date% | Submitted |
    When I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*       | Action for Discharge   | Discharge Orders* |
      | aspirin tablet 500MG  | Stop Continue / Change |                   |
      | ketorolac tablet 10MG | Stop Continue / Change |                   |
    When I select the "Continue" radio in the row with "aspirin tablet 500MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I move the mouse over the "aspirin tablet 500MG" text in the row with "aspirin tablet 500MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*       | Action for Discharge   | Discharge Orders*         |
      | aspirin tablet 500MG  | Continue / Change      | New: aspirin tablet 500MG |
      | ketorolac tablet 10MG | Stop Continue / Change |                           |
    When I select the "Continue" radio in the row with "ketorolac tablet 10MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Contraindicated Drug Combination" should appear in the "Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    Then the "interaction warning icon" changed to "green checkmark" on the left side in the "Clinical Decision Support Warnings" pane
    When I reselect "Provide an override reason" as override reason in the "Clinical Decision Support Warnings" pane
    Then the "green checkmark" changed to "interaction warning icon" on the left side in the "Clinical Decision Support Warnings" pane
    When I click the "CDSW OK" button
    Then the text "Please provide a reason to override the interaction(s)." should appear in the "Clinical Decision Support Warnings" pane
    When I reselect "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    Then the "interaction warning icon" changed to "green checkmark" on the left side in the "Clinical Decision Support Warnings" pane
    When I click the "CDSW OK" button
    Then the "Clinical Decision Support Warnings Header" pane should close
    And rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*       | Action for Discharge | Discharge Orders*               |
      | aspirin tablet 500MG  | Continue / Change    | New: aspirin tablet 500MG Oral  |
      | ketorolac tablet 10MG | Continue / Change    | New: ketorolac tablet 10MG Oral |
    And rows containing the following should appear in the "Medication Reconciliation" table
      | Current Orders*       | Action for Discharge | Discharge Orders*                                     |
      | aspirin tablet 500MG  | Continue / Change    | Contraindicated Drug Combination                      |
      | aspirin tablet 500MG  | Continue / Change    | Override Reason: Provider Aware - Continue as ordered |
      | ketorolac tablet 10MG | Continue / Change    | Contraindicated Drug Combination                      |
      | ketorolac tablet 10MG | Continue / Change    | Override Reason: Provider Aware - Continue as ordered |
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: 15. Resolve - Severe Interaction
    Given I am logged into the portal with the default user
    And I enable interaction display alerts
    And I enable the medication duplicate display interaction checking option
    And I enable the drug allergy display interaction checking option
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And "MEDREC PATIENT3" is on the patient list
    And I select patient "MEDREC PATIENT3" from the patient list
        # To stop the medications present in the DMR screen
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
#        And I click the "Reconcile and Submit" button in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close
    And I select "Orders" from clinical navigation
    When I place the "cimetidine tablet  200MG Oral" order
    And I search for the "carmustine" order
    And I select "carmustine IV Solution  100MG IV" from the "NonFormulary MedOrders" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should load
    And the text "Severe Interaction" should appear in the "Order Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Order Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Order Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Order Clinical Decision Support Warnings" pane if it exists
    Then the "Order Clinical Decision Support Warnings" pane should close
    When I Submit the Orders
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*         | Start          | Status    |
      | cimetidine tablet 200MG      | %Current Date% | Submitted |
      | carmustine IV Solution 100MG | %Current Date% | Submitted |
    When I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*              | Action for Discharge   | Discharge Orders* |
      | cimetidine tablet 200MG      | Stop Continue / Change |                   |
      | carmustine IV Solution 100MG | Stop Continue / Change |                   |
    When I select the "Continue" radio in the row with "cimetidine tablet 200MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I move the mouse over the "cimetidine tablet 200MG" text in the row with "cimetidine tablet 200MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*              | Action for Discharge   | Discharge Orders*            |
      | cimetidine tablet 200MG      | Continue / Change      | New: cimetidine tablet 200MG |
      | carmustine IV Solution 100MG | Stop Continue / Change |                              |
    When I select the "Continue" radio in the row with "carmustine IV Solution 100MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    And I click the "Yes" button in the "Question" pane if it exists
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Severe Interaction" should appear in the "Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    Then the "interaction warning icon" changed to "green checkmark" on the left side in the "Clinical Decision Support Warnings" pane
    When I reselect "Provide an override reason" as override reason in the "Clinical Decision Support Warnings" pane
    Then the "green checkmark" changed to "interaction warning icon" on the left side in the "Clinical Decision Support Warnings" pane
    When I click the "CDSW OK" button
    Then the text "Please provide a reason to override the interaction(s)." should appear in the "Clinical Decision Support Warnings" pane
    When I reselect "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    Then the "interaction warning icon" changed to "green checkmark" on the left side in the "Clinical Decision Support Warnings" pane
    When I click the "CDSW OK" button
    Then the "Clinical Decision Support Warnings Header" pane should close
    And rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*              | Action for Discharge | Discharge Orders*                    |
      | cimetidine tablet 200MG      | Continue / Change    | New: cimetidine tablet 200MG Oral    |
      | carmustine IV Solution 100MG | Continue / Change    | New: carmustine IV Solution 100MG IV |
    And rows containing the following should appear in the "Medication Reconciliation" table
      | Current Orders*              | Action for Discharge | Discharge Orders*                                     |
      | cimetidine tablet 200MG      | Continue / Change    | Severe Interaction                                    |
      | cimetidine tablet 200MG      | Continue / Change    | Override Reason: Provider Aware - Continue as ordered |
      | carmustine IV Solution 100MG | Continue / Change    | Severe Interaction                                    |
      | carmustine IV Solution 100MG | Continue / Change    | Override Reason: Provider Aware - Continue as ordered |
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: 16. Resolve - Moderate Interaction
    Given I am logged into the portal with the default user
    And I enable interaction display alerts
    And I enable the medication duplicate display interaction checking option
    And I enable the drug allergy display interaction checking option
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And "MEDREC PATIENT4" is on the patient list
    And I select patient "MEDREC PATIENT4" from the patient list
    And I select "Orders" from clinical navigation
    When I place the "verapamil tablet  40MG Oral" order
    And I search for the "Eplerenone" order
    And I select "eplerenone tablet  25MG Oral" from the "NonFormulary MedOrders" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should load
    And the text "Moderate Interaction" should appear in the "Order Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Order Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Order Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Order Clinical Decision Support Warnings" pane if it exists
    Then the "Order Clinical Decision Support Warnings" pane should close
    When I Submit the Orders
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*   | Start          | Status    |
      | verapamil tablet 40MG  | %Current Date% | Submitted |
      | eplerenone tablet 25MG | %Current Date% | Submitted |
    When I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*        | Action for Discharge   | Discharge Orders* |
      | verapamil tablet 40MG  | Stop Continue / Change |                   |
      | eplerenone tablet 25MG | Stop Continue / Change |                   |
    When I select the "Continue" radio in the row with "verapamil tablet 40MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I move the mouse over the "verapamil tablet 40MG" text in the row with "verapamil tablet 40MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*        | Action for Discharge   | Discharge Orders*          |
      | verapamil tablet 40MG  | Continue / Change      | New: verapamil tablet 40MG |
      | eplerenone tablet 25MG | Stop Continue / Change |                            |
    When I select the "Continue" radio in the row with "eplerenone tablet 25MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Moderate Interaction" should appear in the "Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    Then the "interaction warning icon" changed to "green checkmark" on the left side in the "Clinical Decision Support Warnings" pane
    When I reselect "Provide an override reason" as override reason in the "Clinical Decision Support Warnings" pane
    Then the "green checkmark" changed to "interaction warning icon" on the left side in the "Clinical Decision Support Warnings" pane
    When I click the "CDSW OK" button
    Then the text "Please provide a reason to override the interaction(s)." should appear in the "Clinical Decision Support Warnings" pane
    When I reselect "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    Then the "interaction warning icon" changed to "green checkmark" on the left side in the "Clinical Decision Support Warnings" pane
    When I click the "CDSW OK" button
    Then the "Clinical Decision Support Warnings Header" pane should close
    And rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*        | Action for Discharge | Discharge Orders*                |
      | verapamil tablet 40MG  | Continue / Change    | New: verapamil tablet 40MG Oral  |
      | eplerenone tablet 25MG | Continue / Change    | New: eplerenone tablet 25MG Oral |
    And rows containing the following should appear in the "Medication Reconciliation" table
      | Current Orders*        | Action for Discharge | Discharge Orders*                                     |
      | verapamil tablet 40MG  | Continue / Change    | Moderate Interaction                                  |
      | verapamil tablet 40MG  | Continue / Change    | Override Reason: Provider Aware - Continue as ordered |
      | eplerenone tablet 25MG | Continue / Change    | Moderate Interaction                                  |
      | eplerenone tablet 25MG | Continue / Change    | Override Reason: Provider Aware - Continue as ordered |
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: 17. Resolve - Undetermined Severity - Alternative Therapy Interaction
    Given I am logged into the portal with the default user
    And I enable interaction display alerts
    And I enable the medication duplicate display interaction checking option
    And I enable the drug allergy display interaction checking option
    Given I am logged into the portal with user "medrecuser3" using the default password
    When I am on the "Patient List V2" tab
    And "MEDREC RECON1" is on the patient list
    And I select patient "MEDREC RECON1" from the patient list
    And I select "Orders" from clinical navigation
    And I place the "aspirin tablet  500MG Oral" order
    And I search for the "Ginkgo biloba Cap" order
    And I select "ginkgo biloba capsule  40MG Oral" from the "NonFormulary MedOrders" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should load
    And the text "Undetermined Severity - Alternative Therapy Interaction" should appear in the "Order Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Order Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Order Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Order Clinical Decision Support Warnings" pane if it exists
    Then the "Order Clinical Decision Support Warnings" pane should close
    When I Submit the Orders
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*       | Start          | Status    |
      | aspirin tablet 500MG       | %Current Date% | Submitted |
      | ginkgo biloba capsule 40MG | %Current Date% | Submitted |
    When I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*            | Action for Discharge   | Discharge Orders* |
      | aspirin tablet 500MG       | Stop Continue / Change |                   |
      | ginkgo biloba capsule 40MG | Stop Continue / Change |                   |
    When I select the "Continue" radio in the row with "aspirin tablet 500MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I move the mouse over the "aspirin tablet 500MG" text in the row with "aspirin tablet 500MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*            | Action for Discharge   | Discharge Orders*         |
      | aspirin tablet 500MG       | Continue / Change      | New: aspirin tablet 500MG |
      | ginkgo biloba capsule 40MG | Stop Continue / Change |                           |
    When I select the "Continue" radio in the row with "ginkgo biloba capsule 40MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Undetermined Severity - Alternative Therapy Interaction" should appear in the "Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    Then the "interaction warning icon" changed to "green checkmark" on the left side in the "Clinical Decision Support Warnings" pane
    When I reselect "Provide an override reason" as override reason in the "Clinical Decision Support Warnings" pane
    Then the "green checkmark" changed to "interaction warning icon" on the left side in the "Clinical Decision Support Warnings" pane
    When I click the "CDSW OK" button
    Then the text "Please provide a reason to override the interaction(s)." should appear in the "Clinical Decision Support Warnings" pane
    When I reselect "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    Then the "interaction warning icon" changed to "green checkmark" on the left side in the "Clinical Decision Support Warnings" pane
    When I click the "CDSW OK" button
    Then the "Clinical Decision Support Warnings Header" pane should close
    And rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*            | Action for Discharge | Discharge Orders*                    |
      | aspirin tablet 500MG       | Continue / Change    | New: aspirin tablet 500MG Oral       |
      | ginkgo biloba capsule 40MG | Continue / Change    | New: ginkgo biloba capsule 40MG Oral |
    And rows containing the following should appear in the "Medication Reconciliation" table
      | Current Orders*            | Action for Discharge | Discharge Orders*                                       |
      | aspirin tablet 500MG       | Continue / Change    | Undetermined Severity - Alternative Therapy Interaction |
      | aspirin tablet 500MG       | Continue / Change    | Override Reason: Provider Aware - Continue as ordered   |
      | ginkgo biloba capsule 40MG | Continue / Change    | Undetermined Severity - Alternative Therapy Interaction |
      | ginkgo biloba capsule 40MG | Continue / Change    | Override Reason: Provider Aware - Continue as ordered   |
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: 18. Disable Discharge User Preference and Enable Loc Pref
    Given I am logged into the portal with the default user
    When I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "Site Administration" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    Then the "Site Administration" pane should load
    When I edit the following user settings and I click save
      | Page                | Name                      | Type  | Value |
      | Site Administration | CPOE                      | radio | true  |
      | Site Administration | Home Medication           | radio | true  |
      | Site Administration | Medication Reconciliation | radio | true  |
      | Site Administration | CPOE Facility Groups      | radio | true  |
    And I select the "User" subtab
    And I search for the user "medrecuser3"
    And I select the user "medrecuser3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "CPOE" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I wait "3" seconds
    And I edit the following user settings and I click save
      | Page | Name                     | Type  | Value |
      | CPOE | Can Enter Orders         | radio | true  |
      | CPOE | Enable Admission Med Rec | radio | true  |
      | CPOE | Enable Discharge Med Rec | radio | false |
      | CPOE | Add Home Medications     | radio | true  |
      | CPOE | Continue Home Meds       | radio | true  |
    And I select the "Location" subtab
    And I click the "PK Hospital" element
    And I click the "Edit Location" button
    And I wait "2" seconds
    And I check the "Admission" checkbox
    And I uncheck the "Discharge" checkbox
    And I click the "Save Edit Location Pref" button
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And "MEDREC RECON2" is on the patient list
    And I select patient "MEDREC RECON2" from the patient list
    Then the following clinical navigation options should not be available
      | Discharge Orders |
    When I select "Orders" from clinical navigation
    Then the following field should not display in the "Orders" pane
      | Name              | Type   |
      | Discharge Med Rec | button |
    When I select "Home Meds" from clinical navigation
    Then the following field should not display in the "Home Medications" pane
      | Name              | Type   |
      | Discharge Med Rec | button |

  Scenario: 19. Disable Discharge User Preference and Enable Loc Pref
    Given I am logged into the portal with the default user
    When I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "medrecuser3"
    And I select the user "medrecuser3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "CPOE" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I wait "3" seconds
    And I edit the following user settings and I click save
      | Page | Name                     | Type  | Value |
      | CPOE | Can Enter Orders         | radio | true  |
      | CPOE | Enable Admission Med Rec | radio | true  |
      | CPOE | Enable Discharge Med Rec | radio | false |
      | CPOE | Add Home Medications     | radio | true  |
      | CPOE | Continue Home Meds       | radio | true  |
    And I select the "Location" subtab
    And I click the "PK Hospital" element
    And I click the "Edit Location" button
    And I wait "2" seconds
    And I check the "Discharge" checkbox
    And I click the "Save Edit Location Pref" button
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And "MEDREC RECON3" is on the patient list
    And I select patient "MEDREC RECON3" from the patient list
    Then the following clinical navigation options should not be available
      | Discharge Orders |
    When I select "Orders" from clinical navigation
    Then the following field should not display in the "Orders" pane
      | Name              | Type   |
      | Discharge Med Rec | button |
    When I select "Home Meds" from clinical navigation
    Then the following field should not display in the "Home Medications" pane
      | Name              | Type   |
      | Discharge Med Rec | button |

  Scenario: 20. Enable Discharge User Preference and Disable Location Preference
    Given I am logged into the portal with the default user
    When I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "medrecuser3"
    And I select the user "medrecuser3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "CPOE" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I wait "3" seconds
    And I edit the following user settings and I click save
      | Page | Name                     | Type  | Value |
      | CPOE | Can Enter Orders         | radio | true  |
      | CPOE | Enable Admission Med Rec | radio | true  |
      | CPOE | Enable Discharge Med Rec | radio | true  |
      | CPOE | Add Home Medications     | radio | true  |
      | CPOE | Continue Home Meds       | radio | true  |
    And I select the "Location" subtab
    And I select the "MedRec" unit under "PKHospital-Verve" facility
    And I click the "Edit Location" button
    And I wait "2" seconds
    And I uncheck the "Discharge" checkbox
    And I click the "Save Edit Location Pref" button
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Orders" from clinical navigation
    Then the following field should display in the "Orders" pane
      | Name              | Type   |
      | Discharge Med Rec | button |
    When I select "Home Meds" from clinical navigation
    Then the following field should display in the "Home Medications" pane
      | Name              | Type   |
      | Discharge Med Rec | button |
    When I select "Discharge Orders" from clinical navigation
    Then the following field should display in the "Discharge Orders" pane
      | Name              | Type   |
      | Discharge Med Rec | button |
    When I click the "Discharge Med Rec" button in the "Discharge Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And the text "This patient does not have any recent visits for Discharge Medication Reconciliation enabled locations" should appear in the "Warning" pane
    And I click the "OK" button in the "Warning" pane

  Scenario: 21. Enable Discharge User and Location Preference
    Given I am logged into the portal with the default user
    When I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "medrecuser3"
    And I select the user "medrecuser3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "CPOE" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I wait "3" seconds
    And I edit the following user settings and I click save
      | Page | Name                     | Type  | Value |
      | CPOE | Can Enter Orders         | radio | true  |
      | CPOE | Enable Admission Med Rec | radio | true  |
      | CPOE | Enable Discharge Med Rec | radio | true  |
      | CPOE | Add Home Medications     | radio | true  |
      | CPOE | Continue Home Meds       | radio | true  |
    And I select the "Location" subtab
    And I select the "MedRec" unit under "PKHospital-Verve" facility
    And I click the "Edit Location" button
    And I wait "2" seconds
    And I check the "Admission" checkbox
    And I check the "Discharge" checkbox
    And I click the "Save Edit Location Pref" button
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Orders" from clinical navigation
    Then the following field should display in the "Orders" pane
      | Name              | Type   |
      | Discharge Med Rec | button |
    When I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close
    When I select "Home Meds" from clinical navigation
    Then the following field should display in the "Home Medications" pane
      | Name              | Type   |
      | Discharge Med Rec | button |
    When I click the "Discharge Med Rec" button in the "Home Medications" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close
    When I select "Discharge Orders" from clinical navigation
    Then the following field should display in the "Discharge Orders" pane
      | Name              | Type   |
      | Discharge Med Rec | button |
    When I click the "Discharge Med Rec" button in the "Discharge Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close

  Scenario: 22. Discharge Med Rec link on Actions (Patient list)
    When I select "Admission Med Rec" from the "Patient Header Actions" menu
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close
    When I select "Discharge Med Rec" from the "Patient Header Actions" menu
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close

  Scenario: 23. Discharge Med Rec button on Orders Link
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Orders" from clinical navigation
    Then the following field should display in the "Orders" pane
      | Name              | Type   |
      | Discharge Med Rec | button |
    When I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close

  Scenario: 24. DMR button on Home Meds link
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Home Meds" from clinical navigation
    Then the following field should display in the "Home Medications" pane
      | Name              | Type   |
      | Discharge Med Rec | button |
    When I click the "Discharge Med Rec" button in the "Home Medications" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close

  Scenario: 25. Discharge Med Rec button on Discharge Orders link
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Discharge Orders" from clinical navigation
    Then the following field should display in the "Discharge Orders" pane
      | Name              | Type   |
      | Discharge Med Rec | button |
    When I click the "Discharge Med Rec" button in the "Discharge Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close

  Scenario: 26. Order Again - PK Lab
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Admission Med Rec" from the "Patient Header Actions" menu
    Then the "Admission Medication Reconciliation" pane should load
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "2" seconds
    And I enter "aspirin tablet" in the "Search for order" field in the "Search for order" pane
    And I select "aspirin chewable tablet  81mg Oral Daily" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    When I click the "Show Clinical Data" button in the "Admission Medication Reconciliation" pane
    And I select "Lab Results" from clinical navigation in the "MedRec ClincialNavigation" pane
    Then the "MedRec LabComponentList" table should load
    When I select "BMP" from the "Panel*" column in the "MedRec LabComponentList" table
    Then the "Lab Panel Tabel Detail" pane should load
    When I click the "Panel OrderAgain" button in the "Lab Panel Tabel Detail" pane
    Then the "Order Again" pane should load
    When I click the "Lab Panel Radio" element in the "Order Again Contents" pane
    Then the "Search for" pane should load
    And the text "(No matches)" should appear in the "No Hits Message" section in the "Search for" pane
    And I click the "Search CloseIcon" button
    And I click the "Search Close" button
    When I click the "Show Clinical Data" button in the "Admission Medication Reconciliation" pane
    When I select "CBC" from the "Panel*" column in the "MedRec LabComponentList" table
    When I click the "Panel OrderAgain" button
    When I click the "Lab Panel Radio" element in the "Order Again Contents" pane
    Then the "Search for" pane should load
    When I select "CBC" from the "Searched Lab Orders" list in the search results
    And I fill the mandatory order details in the "Search for" pane if it exists
    Then the "Medication Reconciliation" table should have at least "1" row containing the text "CBC"
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: 27. Order Again - PK Test
    When "MEDREC PATIENT2" is on the patient list
    When I select patient "MEDREC PATIENT2" from the patient list
    And I select "Admission Med Rec" from the "Patient Header Actions" menu
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "Show Clinical Data" button
    And I select "Test Results" from clinical navigation in the "MedRec ClincialNavigation" pane
    Then the "MedRec TestResults" table should load
    When I select "the first item" in the "MedRec TestResults" table
    And I click the "TestResults OrderAgain" button
    Then the "SearchOrder" pane should load
    When I enter "cimetidine" in the "HospitalSearchForOrder" field
    And I select "cimetidine tablet  300MG Oral" from the "SearchedNonFormularyMedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then the "Medication Reconciliation" table should have at least "1" rows containing the text "cimetidine tablet 300MG Oral"
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: 28. Order Again - No orders on AMR screen-lab or test result added to Hospital column
    Given I am logged into the portal with the default user
    And I disable all the interaction checking options
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    When "MEDREC PATIENT3" is on the patient list
    When I select patient "MEDREC PATIENT3" from the patient list
    And I select "Admission Med Rec" from the "Patient Header Actions" menu
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "Show Clinical Data" button
    And I select "Lab Results" from clinical navigation in the "MedRec ClincialNavigation" pane
    Then the "MedRec LabComponentList" table should load
    When I select "CBC" from the "Panel*" column in the "MedRec LabComponentList" table
    And I click the "Panel OrderAgain" button in the "Lab Panel Tabel Detail" pane
    Then the "Order Again" pane should load
    And I click the "Lab Panel Radio" element in the "Order Again Contents" pane
    Then the "SearchOrder" pane should load
    When I enter "cimetidine" in the "HospitalSearchForOrder" field
    And I select "cimetidine tablet  200MG Oral" from the "Searched NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then the "Medication Reconciliation" table should have at least "1" rows containing the text "cimetidine tablet 200MG Oral"
    When I click the "Show Clinical Data" button
    And I select "Test Results" from clinical navigation in the "MedRec ClincialNavigation" pane
    Then the "MedRec TestResults" table should load
    When I select "the first item" in the "MedRec TestResults" table
    And I click the "TestResults OrderAgain" button
    Then the "SearchOrder" pane should load
    When I enter "cimetidine" in the "HospitalSearchForOrder" field
    And I select "cimetidine tablet  300MG Oral" from the "Searched NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then the "Medication Reconciliation" table should have at least "1" rows containing the text "cimetidine tablet 300MG Oral"
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: 29. Drug Allergy interaction - Drug class
    Given I am logged into the portal with the default user
    And I enable the medication duplicate display interaction checking option
    And I enable interaction display alerts
    And I enable the drug allergy display interaction checking option
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And "MEDREC PATIENT4" is on the patient list
    And I select patient "MEDREC PATIENT4" from the patient list
    And I select "Discharge Med Rec" from the "Patient Header Actions" menu
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge Order*" cell header in the "Medication Reconciliation" table if table exists
    And I enter "amoxicillin capsule" in the "Discharge SearchForOrder" field
    And I select "amoxicillin capsule  250MG Oral" from the "Searched Combined Med Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    Then the "Clinical Decision Support Warnings Header" pane should close
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close

  Scenario: 30. Drug Allergy interaction - Resolve
    When "MEDREC RECON1" is on the patient list
    And I select patient "MEDREC RECON1" from the patient list
    And I select "Discharge Med Rec" from the "Patient Header Actions" menu
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge Order*" cell header in the "Medication Reconciliation" table if table exists
    And I enter "amoxicillin capsule" in the "Discharge SearchForOrder" field
    And I select "amoxicillin capsule  250MG Oral" from the "Searched Combined Med Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And I click the "CDSW OK" button
    Then the text "Please provide a reason to override the interaction(s)." should appear in the "Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    Then the "Clinical Decision Support Warnings Header" pane should close
    And the "Medication Reconciliation" table should have at least "1" rows containing the text "amoxicillin capsule 250MG Oral"
    And the "Medication Reconciliation" table should have at least "1" rows containing the text "Provider Aware - Continue as ordered"
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close

  Scenario: 40. Delete New Order
    Given I am logged into the portal with the default user
    And I disable all the interaction checking options
    And I enable the drug allergy display interaction checking option
    And I enable the medication duplicate display interaction checking option
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    When "MEDREC PATIENT4" is on the patient list
    And I select patient "MEDREC PATIENT4" from the patient list
    And I select "Orders" from clinical navigation
    And I place the "aspirin chewable tablet  81mg Oral Daily" order
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*              | Start          | Status    |
      | aspirin chewable tablet 81mg Oral | %Current Date% | Submitted |
    When I place the "ketorolac tablet 10MG Oral" order
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*       | Start          | Status    |
      | ketorolac tablet 10MG Oral | %Current Date% | Submitted |
    Given I am logged into the portal with the default user
    And I enable interaction display alerts
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    When "MEDREC PATIENT4" is on the patient list
    And I select patient "MEDREC PATIENT4" from the patient list
    When I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*                   | Action for Discharge   | Discharge Orders* |
      | aspirin chewable tablet 81mg Oral | Stop Continue / Change |                   |
      | ketorolac tablet 10MG Oral        | Stop Continue / Change |                   |
    When I select the "Continue" radio in the row with "aspirin chewable tablet 81mg Oral" as the value under "Current Orders*" in the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*                   | Action for Discharge   | Discharge Orders*                      |
      | aspirin chewable tablet 81mg Oral | Stop Continue / Change | New: aspirin chewable tablet 81mg Oral |
    When I select the "Continue" radio in the row with "ketorolac tablet 10MG Oral" as the value under "Current Orders*" in the "Medication Reconciliation" table
    Then the "Clinical Decision Support Warnings" pane should load
    When I click the "CDSW Delete" element
    Then the text "No more clinical decision support warnings. Click" should appear in the "Info" pane
    When I click the "Info OK" element in the "Info" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Current Orders*            | Action for Discharge | Discharge Orders*               |
      | ketorolac tablet 10MG Oral | Continue / Change    | New: ketorolac tablet 10MG Oral |
    When I click the "Med Rec Cancel" button in the "Discharge Medication Reconciliation" pane
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close

  Scenario: 41. Discharge orders New New drug duplicate Provide Override
    Given I am logged into the portal with the default user
    And I disable all the interaction checking options
    And I enable the medication duplicate display interaction checking option
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And "MEDREC RECON2" is on the patient list
    And I select patient "MEDREC RECON2" from the patient list
    When I select "Discharge Med Rec" from the "Patient Header Actions" menu
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "advil" in the "Discharge SearchForOrder" field
    And I select "Advil tablet (ibuprofen)  100MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Discharge Medication Reconciliation" pane if it exists
    Then the "Medication Reconciliation" table should have at least "1" rows containing the text "Advil tablet (ibuprofen) 100MG Oral"
    When I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "advil" in the "Discharge SearchForOrder" field
    And I select "Advil tablet (ibuprofen)  100MG Oral" from the "Searched Combined Med Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    When I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    Then the "Medication Reconciliation" table should have at least "2" rows containing the text "Advil tablet (ibuprofen) 100MG Oral"
    Then the "Medication Reconciliation" table should have at least "1" rows containing the text "Duplicate"
    When I click the "Med Rec Cancel" button in the "Discharge Medication Reconciliation" pane
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close

  Scenario: 42. Discharge New New drug duplicate Dont Order
    When "MEDREC RECON3" is on the patient list
    And I select patient "MEDREC RECON3" from the patient list
    And I select "Discharge Med Rec" from the "Patient Header Actions" menu
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "advil" in the "Discharge SearchForOrder" field
    And I select "Advil tablet (ibuprofen)  100MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Discharge Medication Reconciliation" pane if it exists
    Then the "Medication Reconciliation" table should have at least "1" rows containing the text "Advil tablet (ibuprofen) 100MG Oral"
    When I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "advil" in the "Discharge SearchForOrder" field
    And I select "Advil tablet (ibuprofen)  100MG Oral" from the "Searched Combined Med Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    Then the "Clinical Decision Support Warnings Header" pane should close
    And the "Medication Reconciliation" table should have at least "1" rows containing the text "Advil tablet (ibuprofen) 100MG Oral"
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close

  Scenario: 43. Discharge New New drug duplicate DELETE NEW ORDER
    When "MEDREC RECON4" is on the patient list
    And I select patient "MEDREC RECON4" from the patient list
    And I select "Discharge Med Rec" from the "Patient Header Actions" menu
    Then the "Discharge Medication Reconciliation" pane should load
    And I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "advil" in the "Discharge SearchForOrder" field
    And I select "Advil tablet (ibuprofen)  100MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Discharge Medication Reconciliation" pane if it exists
    Then the "Medication Reconciliation" table should have at least "1" rows containing the text "Advil tablet (ibuprofen) 100MG Oral"
    When I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "advil" in the "Discharge SearchForOrder" field
    And I select "Advil tablet (ibuprofen)  100MG Oral" from the "Searched Combined Med Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And I click the "MissingField" element if it exists
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
#        And I select "Daily" from the "Frequency" multiselect in the "Clinical Decision Support Warnings" pane
    When I click the "CDSW Delete" element
    Then the text "No more clinical decision support warnings. Click" should appear in the "Info" pane
    And the following fields should display in the "Info" pane
      | Name    | Type    |
      | Info OK | element |
    When I click the "Info OK" element in the "Info" pane
    And I wait "2" seconds
    Then the "Clinical Decision Support Warnings Header" pane should close
    And the "Medication Reconciliation" table should have at least "1" rows containing the text "Advil tablet (ibuprofen) 100MG Oral"
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close

  Scenario: 44. Discharge Order- Existing- New- Duplicate interaction-same med
    When "MEDREC RECON1" is on the patient list
    And I select patient "MEDREC RECON1" from the patient list
    And I select "Orders" from clinical navigation
    And I place the "Advil tablet (ibuprofen)  100MG Oral" order
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*                | Start          | Status    |
      | Advil tablet (ibuprofen) 100MG Oral | %Current Date% | Submitted |
    When I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And rows containing the following should appear in the "Medication Reconciliation" table
      | Current Orders*                     | Action for Discharge   | Discharge OrdersAdd |
      | Advil tablet (ibuprofen) 100MG Oral | Stop Continue / Change |                     |
    When I select the "Continue" radio in the row with "Advil tablet (ibuprofen) 100MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    And I select "Home Medication" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Clinical Decision Support Warnings" pane if it exists
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
#        And I click the "Reconcile and Submit" button in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close
    When I click the "Discharge Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "advil" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select "Advil tablet (ibuprofen)  100MG Oral" from the "Searched Combined Med Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "Med Rec Cancel" button in the "Discharge Medication Reconciliation" pane
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close

  Scenario: 45. Discharge Order- Existing- New- Duplicate interaction-same class
    Given I am logged into the portal with the default user
    And I disable all the interaction checking options
    And I enable the medication duplicate display interaction checking option
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Orders" from clinical navigation
    And I place the "Advil tablet (ibuprofen)  100MG Oral" order
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*                | Start          | Status    |
      | Advil tablet (ibuprofen) 100MG Oral | %Current Date% | Submitted |
    When I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And rows containing the following should appear in the "Medication Reconciliation" table
      | Current Orders*                     | Action for Discharge   | Discharge OrdersAdd |
      | Advil tablet (ibuprofen) 100MG Oral | Stop Continue / Change |                     |
    When I select the "Continue" radio in the row with "Advil tablet (ibuprofen) 100MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    And I select "Home Medication" as override reason in the "Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    And I click the "CDSW OK" button in the "Clinical Decision Support Warnings" pane if it exists
#        And I click the "Reconcile and Submit" button in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close
    When I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "ibuprofen cap" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select "ibuprofen capsule  200MG Oral" from the "Searched Combined Med Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "Med Rec Cancel" button in the "Discharge Medication Reconciliation" pane
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close

  Scenario: 46. Duplicate interaction-Existing- New-Resolve Interaction
    When "MEDREC RECON2" is on the patient list
    And I select patient "MEDREC RECON2" from the patient list
    And I select "Orders" from clinical navigation
    And I place the "Advil tablet (ibuprofen)  100MG Oral" order
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*                | Start          | Status    |
      | Advil tablet (ibuprofen) 100MG Oral | %Current Date% | Submitted |
    When I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And rows containing the following should appear in the "Medication Reconciliation" table
      | Current Orders*                     | Action for Discharge   | Discharge OrdersAdd |
      | Advil tablet (ibuprofen) 100MG Oral | Stop Continue / Change |                     |
    When I select the "Continue" radio in the row with "Advil tablet (ibuprofen) 100MG" as the value under "Current Orders*" in the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Discharge Medication Reconciliation" pane if it exists
    And I select "Home Medication" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Clinical Decision Support Warnings" pane if it exists
#        And I click the "Reconcile and Submit" button in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close
    When I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Advil" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select "Advil tablet (ibuprofen)  100MG Oral" from the "Searched Combined Med Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Duplicate" should appear in the "Clinical Decision Support Warnings" pane
    And I select "Home Medication" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "MissingField" element if it exists
    And I select "Daily" from the "Frequency" multiselect in the "Clinical Decision Support Warnings" pane
    Then the "interaction warning icon" changed to "green checkmark" on the left side in the "Clinical Decision Support Warnings" pane
    When I reselect "Provide an override reason" as override reason in the "Clinical Decision Support Warnings" pane
    Then the "green checkmark" changed to "interaction warning icon" on the left side in the "Clinical Decision Support Warnings" pane
    When I click the "CDSW OK" button
    Then the text "Please provide a reason to override the interaction(s)." should appear in the "Question" pane
    When I reselect "Home Medication" as override reason in the "Clinical Decision Support Warnings" pane
    Then the "interaction warning icon" changed to "green checkmark" on the left side in the "Clinical Decision Support Warnings" pane
    When I click the "CDSW OK" button
    Then the "Clinical Decision Support Warnings" pane should close
    And the "Medication Reconciliation" table should have "1" row containing the text "Advil tablet (ibuprofen)  100MG"
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: 47. Non-Med Duplicate Other with two New Discharge Med Orders
    Given I am logged into the portal with the default user
    And I disable all the interaction checking options
    Given I am logged into the portal with user "medrecuser3" using the default password
    When I am on the "Patient List V2" tab
    And "MEDREC PATIENT3" is on the patient list
    And I select patient "MEDREC PATIENT3" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge Orders*" cell header in the "Medication Reconciliation" table if table exists
    And I enter "ketorolac tablet  10MG Oral" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select "ketorolac tablet  10MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Add" link in the "Discharge Orders*" cell header in the "Medication Reconciliation" table
    And I enter "ketorolac tablet  10MG Oral" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select "ketorolac tablet  10MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Discharge Medication Reconciliation" pane if it exists
    And the "Medication Reconciliation" table should have at least "1" row containing the text "ketorolac tablet"
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close

  Scenario: 48. Warning when Discharged visit selected
    When "MEDREC PATIENT1" is on the patient list
    And I select patient "MEDREC PATIENT1" from the patient list
    And I select "Visits" from clinical navigation
    And I select "Inpatient" from the "Type" column in the "Visits" table
    And I click the "Edit Visit" button
    And I wait "7" seconds
    And I enter "%Current Date MMDDYYYY%" in the "DischargeDateTime-Date" field in the "EditVisit" pane
    And I enter "%Current Time HHMM%" in the "DischargeDateTime-Time" field
    And I click the "Save" button
    And I select "Discharge Med Rec" from the "Patient Header Actions" menu
    Then the "Discharge Medication Reconciliation" pane should load
    And the "Warning" pane should load
    And the text "This patient does not have any recent visits for Discharge Medication Reconciliation enabled locations." should appear in the "Warning" pane
    When I click the "OK" button in the "Warning" pane
    Then the "Discharge Medication Reconciliation" pane should close
    And I select "Visits" from clinical navigation
    And I select "Inpatient" from the "Type" column in the "Visits" table
    And I click the "Edit Visit" button
    And I enter "" in the "DischargeDateTime-Date" field
    And I enter "" in the "DischargeDateTime-Time" field
    And I click the "Save" button

  Scenario: 49. DCing a matched order from the interaction window
    Given I am logged into the portal with the default user
    And I enable interaction display alerts
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    When "MEDREC RECON3" is on the patient list
    And I select patient "MEDREC RECON3" from the patient list
    And I select "Orders" from clinical navigation
    And I search for the "Aspirin tablet" order
    And I select "aspirin chewable tablet  81mg Oral Daily" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
    And I enter "ketorolac tablet" in the "Add Order" field in the "Enter Orders" pane
    And I select "ketorolac tablet  10MG Oral" from the "NonFormulary MedOrders" list in the search results
    And I wait "2" seconds
    Then the "Order Clinical Decision Support Warnings" pane should load
    When I select "Provider Aware - Continue as ordered" as override reason in the "Order Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Order Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Order Clinical Decision Support Warnings" pane if it exists
    And I Submit the Orders
    Then rows starting with the following should appear in the "Orders" table
      | Existing orders for*              | Start          | Status    |
      | aspirin chewable tablet 81mg Oral | %Current Date% | Submitted |
      | ketorolac tablet 10MG Oral        | %Current Date% | Submitted |
    And I wait "2" seconds
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "2" seconds
    And I enter "aspirin tablet" in the "Search for order" field in the "Search for order" pane
    And I select "aspirin chewable tablet  81mg Oral Daily" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                            | Action for Hospitalization | Hospital Orders*                                  |
      | New: aspirin chewable tablet 81mg Oral Daily | Continue / Change          | Existing: aspirin chewable tablet 81mg Oral Daily |
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "2" seconds
    And I enter "ketorolac tablet" in the "Search for order" field in the "Search for order" pane
    And I select "ketorolac tablet  10MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I wait "2" seconds
    When I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                            | Action for Hospitalization | Hospital Orders*                                  |
      | New: aspirin chewable tablet 81mg Oral Daily | Continue / Change          | Existing: aspirin chewable tablet 81mg Oral Daily |
      | New: ketorolac tablet 10MG Oral              | Continue / Change          | Existing: ketorolac tablet 10MG Oral              |
    When I choose "Correct this home medication" option by clicking "Edit" icon in the row with "Existing: aspirin chewable tablet 81mg Oral" as the value under "Hospital OrdersAdd" in the "Medication Reconciliation" table
    And I select "Weekly" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    Then the "CDSWarnings" pane should load
    When I select "Provider Aware - Continue as ordered" as override reason in the "CDS Warnings" pane
    And I click the "CDSWarnings OK" button
    And I wait "2" seconds
    Then rows containing the following should appear in the "Medication Reconciliation" table
      | Home Medications*                            | Action for Hospitalization | Hospital Orders*                              |
      | New: aspirin chewable tablet 81mg Oral Daily | Continue / Change          | New: aspirin chewable tablet 81mg Oral Weekly |
      | New: ketorolac tablet 10MG Oral              | Continue / Change          | Existing: ketorolac tablet 10MG Oral          |
    When I click the "Med Rec Cancel" button in the "Admission Medication Reconciliation" pane
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close
