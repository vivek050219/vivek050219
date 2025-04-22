@EPCS
Feature: EPCS - Changes to NewRx Message
#  ALM Path: eRx [PK] >>> EPCS >>> EPCS Changes to NewRx Message

  Scenario: TC001_36334_Increase Notes to Pharmacy character limit to 135 characters
    Given I am logged into the portal with user "epcsprov7" using the default password
    And I am on the "Patient List V2" tab
    And I select "erx_patients_epcsprov7" from the "Patient List" menu
    And there should not be any unfinished orders
    And "WHITESIDE, KARA" is on the patient list
    And I select patient "WHITESIDE, KARA" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    And I wait for the "RxDefaultDestinationPharmacyID" field of type "RADIO" in the "Discharge Medication Reconciliation" pane to be clickable
    And I click the "Select Pharmacy" element in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Pharmacy Edit Icon" element in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Delete PreSelected Pharmacy" element in the "SelectDefaultPharmacy" pane if it exists
    And I enter "77001" in the "Near By" field in the "SelectDefaultPharmacy" pane
    And I click the "Search Addr" button
    And I click the "+Icon" element in the row with text "TX Pharmacy 10.6MU" in the "Pharmacy Search Results" table
    Then the text "TX Pharmacy 10.6MU" should appear in the "RxDefaultDestinationSection" section in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "adderall" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select "Adderall tablet (dextroamphetamine-amphetamine)  30MG oral" from the "Searched Combined Med Orders" list in the search results
    And I wait "2" seconds
    And I click the "Rx Needed" element
    And I select the "Adderall 30 mg tablet" link in the row with the text "Adderall 30 mg tablet" in the "SelectMedication" table if it exists
    And I enter "This is sample text to verify notes to pharmacy section character count. the field will accepts the maximum 135 characters NotePharmacy-TEXT" in the "Notes To Pharmacy" field
    And Text exact "135 / 135" should appear in the "NotesToPharmacyCharCount" section in the "EditOrderErx" pane
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane
    Then the text "New: Adderall tablet (dextroamphetamine-amphetamine) 30 mg oral" should appear in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    And I click the "Submit Partial MedRec" button if it exists
    Then I sign and submit the order with default password
    And I wait for the "PDMPNext" field of type "BUTTON" in the "Review PDMP" pane to be clickable
    And I click the "PDMP Next" button in the "Review PDMP" pane
    And I click the "PDMP Reconcile And Submit" button in the "Review PDMP" pane
    When I apply the security key from VIP Access
    And I click the "Ok 2FA" button
    And I wait "3" seconds
    Then the "Review PDMP" pane should close