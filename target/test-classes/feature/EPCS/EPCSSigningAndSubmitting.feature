@EPCS
Feature: EPCS - Signing and Submitting EPCS Rx's with 2FA
#  ALM Path: eRx [PK] >>> EPCS >>> 6. Signing and Submitting EPCS Rx's with 2FA

  # This scenario is merged with 2 test cases 1.NO EPCS Order in a DMR session and 2.Sign non-EPCS orders
  Scenario: TC001_25322_NO EPCS Order in a DMR session and 23227_Sign non-EPCS orders
    Given I am logged into the portal with user "epcsprov7" using the default password
    And I am on the "Patient List V2" tab
    And I select "erx_patients_epcsprov7" from the "Patient List" menu
    And there should not be any unfinished orders
    And "WHITESIDE, KARA" is on the patient list
    And I select patient "WHITESIDE, KARA" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    And I wait for the "RxDefaultDestinationPharmacyID" field of type "RADIO" in the "Discharge Medication Reconciliation" pane to be clickable
    And I wait "2" seconds
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Lasix" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select "Lasix tablet (furosemide)  20MG oral" from the "Searched Combined Med Orders" list in the search results
    And I wait "2" seconds
    And I click the "Rx Needed" element
    And I select the "Lasix 20 mg tablet" link in the row with the text "Lasix 20 mg tablet" in the "SelectMedication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane
    Then the text "New: Lasix tablet (furosemide) 20 mg oral" should appear in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    And I click the "Submit Partial MedRec" button if it exists
    Then I sign and submit the order with default password
    And I click the "PDMP Reconcile And Submit" button in the "Review PDMP" pane
    Then the "Sign Controlled Substance 2FA" pane should not load



  # This scenario is merged with 3 test cases 1.Appearance and Behavior of 2 FA pop up, 2.If 2FA is successful and 3.Cancel an EPCS Order
  # Omitted steps related to "Click here to resend it" and "Manually Enter security code here" fields
  Scenario: TC002_23223_Appearance and Behavior of 2 FA pop up, 23224_If 2FA is successful and 23228_Cancel an EPCS Order
    Given I am logged into the portal with user "epcsprov7" using the default password
    And I am on the "Patient List V2" tab
    And I select "erx_patients_epcsprov7" from the "Patient List" menu
    And there should not be any unfinished orders
    And "WHITESIDE, KARA" is on the patient list
    And I select patient "WHITESIDE, KARA" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    And I wait for the "RxDefaultDestinationPharmacyID" field of type "RADIO" in the "Discharge Medication Reconciliation" pane to be clickable
    And I wait "2" seconds
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "adderall" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select "Adderall tablet (dextroamphetamine-amphetamine)  10MG oral" from the "Searched Combined Med Orders" list in the search results
    And I wait "2" seconds
    And I click the "Rx Needed" element
    And I select the "Adderall 10 mg tablet" link in the row with the text "Adderall 10 mg tablet" in the "SelectMedication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane
    Then the text "New: Adderall tablet (dextroamphetamine-amphetamine) 10 mg oral" should appear in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    And I click the "Submit Partial MedRec" button if it exists
    Then I sign and submit the order with default password
    And I wait for the "PDMPNext" field of type "BUTTON" in the "Review PDMP" pane to be clickable
    And I click the "PDMP Next" button in the "Review PDMP" pane
    And I click the "PDMP Reconcile And Submit" button in the "Review PDMP" pane
    Then the "Sign Controlled Substance 2FA" pane should appear with the text "The two-factor authentication protocol may only be completed by the practitioner whose name and DEA registration number appear below"
    When I apply the security key from VIP Access
    And I click the "Ok 2FA" button
    And I wait "3" seconds
    Then the "Review PDMP" pane should close
    And I select patient "WHITESIDE, KARA" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    And I wait for the "RxDefaultDestinationPharmacyID" field of type "RADIO" in the "Discharge Medication Reconciliation" pane to be clickable
    And I wait "2" seconds
    When I choose "Delete" option by clicking "Edit" icon in the row with "Adderall tablet (dextroamphetamine-amphetamine) 10 mg oral Daily X 2 days" as the value under "Discharge Orders*" in the "Medication Reconciliation" table

    #TODO: Deleted order is displayed with a strikehtrough. validation step need to be add

    And I reconcile and Submit the Orders
    And I click the "Submit Partial MedRec" button if it exists
    Then I sign and submit the order with default password

    #Review prescriptoin screen is not displayed. after delete



  Scenario: TC003_35007_Change an EPCS Order
    Given I am logged into the portal with user "epcsprov7" using the default password
    And I am on the "Patient List V2" tab
    And I select "erx_patients_epcsprov7" from the "Patient List" menu
    And there should not be any unfinished orders
    And "WHITESIDE, KARA" is on the patient list
    And I select patient "WHITESIDE, KARA" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    And I wait for the "RxDefaultDestinationPharmacyID" field of type "RADIO" in the "Discharge Medication Reconciliation" pane to be clickable
    And I select the "Change" link in the row with the text "aspirin tablet 325mg oral Daily" in the "Medication Reconciliation" table
    And I enter "adderall" in the "DischargeHomeSearchForOrder" field in the "Search for order" pane
    And I select "Adderall tablet (dextroamphetamine-amphetamine)  15MG oral" from the "Searched Combined Med Orders" list in the search results
    And I wait "2" seconds
    And I click the "Rx Needed" element
    And I select the "Adderall 15 mg tablet" link in the row with the text "Adderall 15 mg tablet" in the "SelectMedication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane
    Then the text "New: Adderall tablet (dextroamphetamine-amphetamine) 15 mg oral" should appear in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    And I click the "Submit Partial MedRec" button if it exists
    Then I sign and submit the order with default password
    And I wait for the "PDMPNext" field of type "BUTTON" in the "Review PDMP" pane to be clickable
    And I click the "PDMP Next" button in the "Review PDMP" pane
    And I click the "PDMP Reconcile And Submit" button in the "Review PDMP" pane
    Then the "Sign Controlled Substance 2FA" pane should appear with the text "The two-factor authentication protocol may only be completed by the practitioner whose name and DEA registration number appear below"
    When I apply the security key from VIP Access
    And I click the "Ok 2FA" button in the "Sign Controlled Substance 2FA" pane
    And I wait "3" seconds
    Then the "Review PDMP" pane should close
    And I select patient "WHITESIDE, KARA" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    And I wait for the "RxDefaultDestinationPharmacyID" field of type "RADIO" in the "Discharge Medication Reconciliation" pane to be clickable
    And I wait "2" seconds
    And I move the mouse over the "Continue Icon" element in the "Discharge Medication Reconciliation" pane
    And I select the "Change" link in the row with the text "aspirin tablet 325mg oral Daily" in the "Medication Reconciliation" table
    And I enter "adderall" in the "DischargeHomeSearchForOrder" field in the "Search for order" pane
    And I select "Adderall tablet (dextroamphetamine-amphetamine)  12.5MG oral" from the "Searched Combined Med Orders" list in the search results
    And I wait "2" seconds
    And I click the "Rx Needed" element
    And I select the "Adderall 12.5 mg tablet" link in the row with the text "Adderall 12.5 mg tablet" in the "SelectMedication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane for change order
    Then the text "New: Adderall tablet (dextroamphetamine-amphetamine) 12.5 mg oral" should appear in the "Discharge Medication Reconciliation" pane

    #TODO: strikehtrough validation step need to add

    And I reconcile and Submit the Orders
    And I click the "Submit Partial MedRec" button if it exists
    Then I sign and submit the order with default password
    And I wait for the "PDMPNext" field of type "BUTTON" in the "Review PDMP" pane to be clickable
    And I click the "PDMP Next" button in the "Review PDMP" pane
    And the text "Adderall 12.5 mg tablet" should appear in the "New Retail Prescriptions" section in the "Review PDMP" pane
    And the text "Adderall 15 mg tablet" should appear in the "Electronically Cancelled Prescriptions" section in the "Review PDMP" pane
    And I click the "PDMP Reconcile And Submit" button in the "Review PDMP" pane
    When I apply the security key from VIP Access
    And I click the "Ok 2FA" button in the "Sign Controlled Substance 2FA" pane
    Then the "Review PDMP" pane should close


  Scenario: TC004_23229_Modify an EPCS Order
    Given I am logged into the portal with user "epcsprov7" using the default password
    And I am on the "Patient List V2" tab
    And I select "erx_patients_epcsprov7" from the "Patient List" menu
    And there should not be any unfinished orders
    And "WHITESIDE, KARA" is on the patient list
    And I select patient "WHITESIDE, KARA" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    And I wait for the "RxDefaultDestinationPharmacyID" field of type "RADIO" in the "Discharge Medication Reconciliation" pane to be clickable
    And I wait "2" seconds
    And I select the "Change" link in the row with the text "atenolol tablet 25mg oral QAM" in the "Medication Reconciliation" table
    And I enter "adderall" in the "DischargeHomeSearchForOrder" field in the "Search for order" pane
    And I select "Adderall tablet (dextroamphetamine-amphetamine)  20MG oral" from the "Searched Combined Med Orders" list in the search results
    And I wait "2" seconds
    And I click the "Rx Needed" element
    And I select the "Adderall 20 mg tablet" link in the row with the text "Adderall 20 mg tablet" in the "SelectMedication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane
    Then the text "New: Adderall tablet (dextroamphetamine-amphetamine) 20 mg oral" should appear in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    And I click the "Submit Partial MedRec" button if it exists
    Then I sign and submit the order with default password
    And I wait for the "PDMPNext" field of type "BUTTON" in the "Review PDMP" pane to be clickable
    And I click the "PDMP Next" button in the "Review PDMP" pane
    And I click the "PDMP Reconcile And Submit" button in the "Review PDMP" pane
    Then the "Sign Controlled Substance 2FA" pane should appear with the text "The two-factor authentication protocol may only be completed by the practitioner whose name and DEA registration number appear below"
    When I apply the security key from VIP Access
    And I click the "Ok 2FA" button in the "Sign Controlled Substance 2FA" pane
    And I wait "3" seconds
    Then the "Review PDMP" pane should close
    And I select patient "WHITESIDE, KARA" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    And I wait for the "RxDefaultDestinationPharmacyID" field of type "RADIO" in the "Discharge Medication Reconciliation" pane to be clickable
    And I wait "2" seconds
    When I choose "Modify" option by clicking "Edit" icon in the row with "Adderall tablet (dextroamphetamine-amphetamine) 20 mg oral Daily X 2 days" as the value under "Discharge Orders*" in the "Medication Reconciliation" table
    And I wait "2" seconds
    And I click the "Rx Needed" element
    And I select the "Adderall 20 mg tablet" link in the row with the text "Adderall 20 mg tablet" in the "SelectMedication" table if it exists
    And I fill the mandatory order details in the "Edit Medication Order" pane for change order
    Then the text "New: Adderall tablet (dextroamphetamine-amphetamine) 20 mg oral Daily X 4 days" should appear in the "Discharge Medication Reconciliation" pane

    #TODO: strikehtrough validation step need to add

    And I reconcile and Submit the Orders
    And I click the "Submit Partial MedRec" button if it exists
    Then I sign and submit the order with default password
    And I wait for the "PDMPNext" field of type "BUTTON" in the "Review PDMP" pane to be clickable
    And I click the "PDMP Next" button in the "Review PDMP" pane
    And the text "Adderall 20 mg tablet" should appear in the "New Retail Prescriptions" section in the "Review PDMP" pane
    And the text "Adderall 15 mg tablet" should appear in the "Electronically Cancelled Prescriptions" section in the "Review PDMP" pane
    And I click the "PDMP Reconcile And Submit" button in the "Review PDMP" pane
    When I apply the security key from VIP Access
    And I click the "Ok 2FA" button in the "Sign Controlled Substance 2FA" pane
    Then the "Review PDMP" pane should close


  Scenario: TC005_23226_If 2FA fails
    Given I am logged into the portal with user "epcsprov7" using the default password
    And I am on the "Patient List V2" tab
    And I select "erx_patients_epcsprov7" from the "Patient List" menu
    And there should not be any unfinished orders
    And "WHITESIDE, KARA" is on the patient list
    And I select patient "WHITESIDE, KARA" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    And I wait for the "RxDefaultDestinationPharmacyID" field of type "RADIO" in the "Discharge Medication Reconciliation" pane to be clickable
    And I wait "2" seconds
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "adderall" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select "Adderall XR capsule,extended release (dextroamphetamine-amphetamine)  10MG oral" from the "Searched Combined Med Orders" list in the search results
    And I wait "2" seconds
    And I click the "Rx Needed" element
    And I select the "Adderall XR 10 mg capsule,extended release" link in the row with the text "Adderall XR 10 mg capsule,extended release" in the "SelectMedication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane
    Then the text "New: Adderall XR capsule,extended release (dextroamphetamine-amphetamine) 10 mg oral" should appear in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    And I click the "Submit Partial MedRec" button if it exists
    Then I sign and submit the order with default password
    And I wait for the "PDMPNext" field of type "BUTTON" in the "Review PDMP" pane to be clickable
    And I click the "PDMP Next" button in the "Review PDMP" pane
    And I click the "PDMP Reconcile And Submit" button in the "Review PDMP" pane
    Then the "Sign Controlled Substance 2FA" pane should appear with the text "The two-factor authentication protocol may only be completed by the practitioner whose name and DEA registration number appear below"
    And I enter "12345" in the "ControlledSubstance2FA" field in the "Sign Controlled Substance 2FA" pane
    And I click the "Ok 2FA" button in the "Sign Controlled Substance 2FA" pane
    And the following text should appear in the "Sign Controlled Substance 2FA" pane
      | Authentication failed. Please try again |
    And I click the "Cancel 2FA" button
    And I click the "Back To DMR" button in the "Review PDMP" pane
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button


  Scenario: TC006_23225_If 2FA is canceled
    Given I am logged into the portal with user "epcsprov7" using the default password
    And I am on the "Patient List V2" tab
    And I select "erx_patients_epcsprov7" from the "Patient List" menu
    And there should not be any unfinished orders
    And "WHITESIDE, KARA" is on the patient list
    And I select patient "WHITESIDE, KARA" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    And I wait for the "RxDefaultDestinationPharmacyID" field of type "RADIO" in the "Discharge Medication Reconciliation" pane to be clickable
    And I wait "2" seconds
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "adderall" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select "Adderall XR capsule,extended release (dextroamphetamine-amphetamine)  15MG oral" from the "Searched Combined Med Orders" list in the search results
    And I wait "2" seconds
    And I click the "Rx Needed" element
    And I select the "Adderall XR 15 mg capsule,extended release" link in the row with the text "Adderall XR 15 mg capsule,extended release" in the "SelectMedication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane
    Then the text "New: Adderall XR capsule,extended release (dextroamphetamine-amphetamine) 15 mg oral" should appear in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    And I click the "Submit Partial MedRec" button if it exists
    Then I sign and submit the order with default password
    And I wait for the "PDMPNext" field of type "BUTTON" in the "Review PDMP" pane to be clickable
    And I click the "PDMP Next" button in the "Review PDMP" pane
    And I click the "PDMP Reconcile And Submit" button in the "Review PDMP" pane
    Then the "Sign Controlled Substance 2FA" pane should appear with the text "The two-factor authentication protocol may only be completed by the practitioner whose name and DEA registration number appear below"
    And I click the "Cancel 2FA" button
    Then the "Sign Controlled Substance 2FA" pane should close
    Then the "Review PDMP" pane should load
    And I click the "Back To DMR" button in the "Review PDMP" pane
    When I click the "Med Rec Cancel" button
    And I click the "Yes" button