Feature: MedRec Field Found Defects
  This test suite validates the defects which are found in CI.

  @MedRec
  Scenario: 8.4.0:DEV-75276- HCA Dev2 DMR : Cannot do changes on meds
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And I select "MedRecPLV2" from the "Patient List" menu
    When "NEIL HEATH" is on the patient list
    And I select patient "NEIL HEATH" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    When I select the "Change" link in the row with the text "Promethazine IM 25mg q3h PRN" in the "Medication Reconciliation" table
    And I select "Promethegan Rectal Suppository (promethazine) 25MG Rect" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane
    Then rows containing the following should appear in the "Medication Reconciliation" clinical table
      |Promethazine IM 25mg q3h PRN |Continue / Change |New: Promethegan Rectal Suppository (promethazine) Rect (test order) |
    When I select the "Change" link in the row with the text "simvastatin tablet 20mg Oral qPM" in the "Medication Reconciliation" table
    And I select "Zocor tablet (simvastatin) 5MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane
    Then rows containing the following should appear in the "Medication Reconciliation" clinical table
      |simvastatin tablet 20mg Oral qPM |Continue / Change |New: Zocor tablet (simvastatin) Oral (test order) |
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane

  @MedRec
  Scenario: 8.4.0:DEV-76694- HCA EFL PROD: Highlands: DMR Error: Cannot rollback a transaction without a session
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And I select "MedRecPLV2" from the "Patient List" menu
    When "NEIL HEATH" is on the patient list
    And I select patient "NEIL HEATH" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I click the "OK" button in the "Warning" pane if it exists
    Then the "Enter Orders" pane should load within "5" seconds
    When I enter "nevirapine" in the "Add Order" field in the "Enter Orders" pane
    And I select "Viramune tablet (nevirapine) 200MG Oral" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
    And I Submit the Orders
    When I click the "Discharge Med Rec" button in the "Orders" pane
    And I select the "Continue" radio in the row with the text "Viramune tablet (nevirapine) Oral (test order)" from the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      |Current Orders*                                |Action for Discharge       |Discharge Orders*                                      |
      |Viramune tablet (nevirapine) Oral (test order) |Continue / Change          |New: Viramune tablet (nevirapine) Oral (test order)    |
    When I choose "Delete" option by clicking "Edit" icon in the row with "New: Viramune tablet (nevirapine) Oral (test order)" as the value under "Discharge Orders*" in the "Medication Reconciliation" table
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      |Current Orders*                                |Action for Discharge       |Discharge Orders*           |
      |Viramune tablet (nevirapine) Oral (test order) |Stop Continue / Change     |                            |
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane

  @MedRec
  Scenario: 8.4.1. DEV-75548- Error occurs when discharging Meds
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "MedRecPLV2" from the "Patient List" menu
    And there should not be any unfinished orders
    When "ANGELINE, MONA" is on the patient list
    And I select patient "ANGELINE, MONA" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And rows starting with the following should appear in the "Medication Reconciliation" table
      |Current Orders*                                          |Action for Discharge   |Discharge Orders* |
      |acetaminophen tablet 325mg Oral Q6H PRN pain             |Stop Continue / Change |                  |
    When I select the "Continue" radio in the row with "acetaminophen tablet 325mg Oral Q6H PRN pain" as the value under "Current Orders*" in the "Medication Reconciliation" table
    When I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close
    When I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I choose "Modify" option by clicking "Edit" icon in the row with "Existing: acetaminophen tablet 325mg Oral Q6H PRN pain" as the value under "Discharge Orders*" in the "Medication Reconciliation" table
    And I select "Q8H" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    And rows starting with the following should appear in the "Medication Reconciliation" table
      |Current Orders*                               |Action for Discharge   |Discharge Orders*                                |
      |acetaminophen tablet 325mg Oral Q6H PRN pain  |Continue / Change      |New: acetaminophen tablet 325mg Oral Q8H PRN pain|
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane

