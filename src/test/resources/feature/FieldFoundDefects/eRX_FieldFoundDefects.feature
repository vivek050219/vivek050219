Feature: eRx Field Found Defects
  This test suite validates the defects which are found in CI.

  @eRx
  Scenario: Pre-requisite Change-Changed Overlapped Medication[DEV-67712]
    Given I am logged into the portal with user "erxprovider" using the default password
    And I am on the "Patient List V2" tab
    And I select "erxPL1" from the "Patient List" menu
    When "BURDETTE, VINCENT" is on the patient list
    And I select patient "BURDETTE, VINCENT" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load within "5" seconds
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Lopressor" in the "Search for order" field in the "Search for order" pane
    And I select "Lopressor tablet (metoprolol tartrate) 50MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then I select the "Continue" radio in the row with "New: Lopressor tablet (metoprolol tartrate)" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Ok Button" button in the "Edit Medication Order" pane if it exists
    And I click the "Reconcile and Submit" button
    And I am on the "Patient List V2" tab
    And I select patient "BURDETTE, VINCENT" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button
    And I wait "3" seconds
         #Overlapped med
    And I select the "Change" link in the row with the text "Lopressor tablet (metoprolol tartrate) 50MG Oral Daily" in the "Medication Reconciliation" table
    And I select "Lopressor tablet (metoprolol tartrate)  100MG Oral" from the "Searched Combined Med Orders" list in the search results if it exists
    And I select the "Lopressor 100 mg tablet" link in the row with the text "Lopressor 100 mg tablet" in the "SelectMedication" table if it exists
    And I select "defaultPharmacy" from the "Default Pharmacy" radio list
    And I click on the link "Select Pharmacy" in the "DefaultPharmacy" pane
    And I wait up to "20" seconds for the "Near By" field of type "TEXT_FIELD" to be visible
    And I enter "55419" in the "Near By" field
    And I click the "Search Addr" button
    And I select "RTBC Test 55419" in the "Pharmacy Search Results" table
    And I enter "2" in the "Disp" field
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows containing the following should appear in the "Medication Reconciliation" clinical table
      |Lopressor tablet (metoprolol tartrate) 50MG Oral Daily |Continue / Change  |New: Lopressor tablet (metoprolol tartrate) Oral (test order), Disp: 2|
    And I reconcile and Submit the Orders
    And I click the "Submit Partial Med Rec" button if it exists
    And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane
    Then the "Review Prescriptions Contents" pane should close

  @eRx
    Scenario: DEV-75421 - eRX: Change default Pharmacy popup is not displaying (regression)
    #for this patient there should be pre-existing discharge order submitted to one of the pharmacy.
    Given I am logged into the portal with user "erxprovider" using the default password
    And I am on the "Patient List V2" tab
    And I select "erxPL1" from the "Patient List" menu
    And there should not be any unfinished orders
    When "BURDETTE, VINCENT" is on the patient list
    And I select patient "BURDETTE, VINCENT" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button
    And I wait "5" seconds
    And I click the "SelectPharmacyIcon" element in the "Discharge Medication Reconciliation" pane
    And I wait up to "3" seconds for the "Search Addr" field of type "BUTTON" to be clickable
    And I click the "Search Addr" button
    And I select "Shapiro PHARMACY" in the "Pharmacy Search Results" table
    And I wait "2" seconds
    Then the "Warning Message" pane should appear with the text "The default pharmacy has changed. Do you want to resend the previously sent e-prescriptions to the new default pharmacy?"
    And I click the "YesChange" button in the "Warning Message" pane
    And I click the "ReconcileCancel" button in the "Discharge Medication Reconciliation" pane
    And I click the "Yes" button in the "Question" pane

  @eRx
  Scenario: 8.4.0: DEV-75850 - Defects with Dispense Unit calculation with QND frequency format
    Given I am logged into the portal with user "erxprovider" using the default password
    And I am on the "Patient List V2" tab
    And I select "erxPL1" from the "Patient List" menu
    And there should not be any unfinished orders
    When "SCANLAN, BRYCE" is on the patient list
    And I select patient "SCANLAN, BRYCE" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "zofran tablet" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select "Zofran tablet (ondansetron HCl)  4MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I select the "Zofran 4 mg tablet" link in the row with the text "Zofran 4 mg tablet" in the "SelectMedication" table if it exists
    And I select "Other" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I enter "Q5D" in the "Frequency Other Field" field
    And I enter "3" in the "TotalNoOfDays" field
    And I select "printer" from the "Printer" radio list
    Then the value in the "Disp" field in the "Edit Medication Order" pane should be blank
    Then the following text should appear in the "Edit Medication Order" pane
      |1 tablet by mouth every 5 days for 3 days.|
    And I click the "Cancel" button in the "Edit Medication Order" pane
    And I click the "ReconcileCancel" button in the "Discharge Medication Reconciliation" pane
    And I click the "Yes" button in the "Question" pane

  @eRx
  Scenario: 8.4.0: DEV-75378 - MedRec - DMR Add as Free Text not working (Regression)
    Given I am logged into the portal with user "erxprovider" using the default password
    And I am on the "Patient List V2" tab
    And I select "erxPL1" from the "Patient List" menu
    And there should not be any unfinished orders
    When "SCANLAN, BRYCE" is on the patient list
    And I select patient "SCANLAN, BRYCE" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Happy pill" in the "Discharge Search For Order" field in the "Search for order" pane
    And I click the "DMR Add As Free Text" button in the "Edit Medication Order" pane
    Then the "Free Text Order" pane should load
    And I click the "Diet" link in the "Free Text Order" pane
    Then rows containing the following should appear in the "Medication Reconciliation" clinical table
      | | |New: Happy pill|
    And I click the "ReconcileCancel" button in the "Discharge Medication Reconciliation" pane
    And I click the "Yes" button in the "Question" pane



