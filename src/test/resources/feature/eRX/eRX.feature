@eRx
Feature: eRX

    Background:
        Given I am logged into the portal with user "erxprovider" using the default password
        And I am on the "Patient List V2" tab
        And I use the API to create a patient list named "erxPL1" owned by "erxprovider" with the following parameters
            | Type   | Name            | Value             |
            | Filter | Location        | PKHospital-Valley |
        And I use the API to favorite patient list "erxPL1" for user "erxprovider" owned by "erxprovider"
        And I click the "Refresh Patient List" button
        And I select "erxPL1" from the "Patient List" menu
        And there should not be any unfinished orders

    Scenario Outline: Pre-Requisite for Linked, Overlapped, Home and Hospital Meds
        When "<Patient>" is on the patient list
        And I select patient "<Patient>" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Adm Med Rec" button in the "Orders" pane
        Then the "Admission Medication Reconciliation" pane should load within "5" seconds
        When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
        And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
        And I enter "Lasix tablet" in the "Search for order" field in the "Search for order" pane
        And I select "Lasix tablet (furosemide)  20MG Oral" from the "Searched Combined Med Orders" list in the search results
        And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
        And I select the "Change" link in the row with "New: Lasix tablet (furosemide)" as the value under "Home Medications*" in the "Medication Reconciliation" table
        Then the value in the "Search For" field in the "Search for order" pane should be "Lasix"
        When I select "Lasix tablet (furosemide)  40MG Oral" from the "Searched NonFormulary Med Orders Update" list in the search results
        And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
        And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
        And I enter "Lopressor" in the "Search for order" field in the "Search for order" pane
        And I select "Lopressor tablet (metoprolol tartrate) 50MG Oral" from the "Searched Combined Med Orders" list in the search results
        And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
        Then I select the "Continue" radio in the row with "New: Lopressor tablet (metoprolol tartrate)" as the value under "Home Medications*" in the "Medication Reconciliation" table
        And I click the "Ok Button" button in the "Edit Medication Order" pane if it exists
        And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
        And I enter "ARIPiprazole disintegrating tablet" in the "Search for order" field in the "Search for order" pane
        And I select "ARIPiprazole disintegrating tablet  10MG Oral" from the "Searched Combined Med Orders" list in the search results
        And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
        And I select the "Stop" radio in the row with "New: ARIPiprazole disintegrating tablet" as the value under "Home Medications*" in the "Medication Reconciliation" table
        And I click the "Reconcile and Submit" button
        When I click the "Enter Orders" button
        And I click the "OK" button in the "Warning" pane if it exists
        Then the "Enter Orders" pane should load within "5" seconds
        When I enter "alendronate tablet" in the "Add Order" field in the "Enter Orders" pane
        And I select "alendronate tablet  5MG Oral" from the "NonFormulary MedOrders" list in the search results
        Then I fill the mandatory order details in the "Edit Order" pane if it exists
        And I Submit the Orders

        Examples:
            | Patient               |
            | AUBAINE, CHENIN BLANC |
            | CROSS, DAVID M        |
#           | DOCKENDORF, TAD A     |
#           | WAYNE, BRUCE          |

    Scenario: Enable Incomplete Discharge Reconciliation
        Given I am on the "Admin" tab
        And I select the "Facility Group" subtab
        And I click the "CPOE Preferences" link in the "Facility Group Navigation" pane
        When I click the "Edit CPOE Preferences" button
        And I select "true" from the "Incomplete Discharge Reconciliation" radio list
        And I click the "Save Edit Facility Group Preferences" button
        And the "Edit Facility Group Preferences" pane should close
        And I am on the "Patient List V2" tab
        And I wait "2" seconds
        When "AUBAINE, CHENIN BLANC" is on the patient list
        And I select patient "AUBAINE, CHENIN BLANC" from the patient list
        And I click the logout button

    Scenario: Continue Overlapped med
        And I am on the "Patient List V2" tab
        When "AUBAINE, CHENIN BLANC" is on the patient list
        And I select patient "AUBAINE, CHENIN BLANC" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        And I wait "3" seconds
        #Overlapped med
        And I select the "Continue" radio in the row with the text "Lopressor tablet (metoprolol tartrate) 50MG Oral Daily" from the "Medication Reconciliation" table
#        And I uncheck the "Rx Needed" checkbox
#        And I check the "Rx Needed" checkbox
#        And I select the "Lopressor 50 mg tablet" link in the row with the text "Lopressor 50 mg tablet" in the "SelectMedication" table
#        And I enter "2" in the "Disp" field
#        And I select "printer" from the "Printer" radio list
#        And I click the "Ok Button" button in the "Prescription" pane
#        Then rows containing the following should appear in the "Medication Reconciliation" clinical table
#            |Lopressor tablet (metoprolol tartrate) 50MG Oral Daily |Continue / Change  |New: Lopressor tablet (metoprolol tartrate) 50MG Oral Daily, Disp: 2 Tablet|
        And I reconcile and Submit the Orders
        And I click the "Submit Partial Med Rec" button if it exists
#        And the following text should appear in the "Review Prescriptions Contents" pane
#            |Patient: AUBAINE, CHENIN BLANC           |
#            |Prescriptions to be printed and signed:  |
#            |Lopressor 50 mg tablet                   |
#            |Take 1 tablet by mouth Daily.            |
##           |Take 1 tablet Oral Daily.                |
#            |Notes: Substitutions allowed.            |
#            |Printer                                  |
#        And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane


    Scenario:Continue Linked med
        When "AUBAINE, CHENIN BLANC" is on the patient list
        And I select patient "AUBAINE, CHENIN BLANC" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        And I wait "3" seconds
        #Linked med
        When I select the "Continue" radio in the row with the text "Lasix tablet (furosemide) 20MG Oral Daily" from the "Medication Reconciliation" table
#       Commenting the steps as the Edit order pane doesnt popup on continuing Home Med that has all fields filled out Order Details
#        And I uncheck the "Rx Needed" checkbox
#        And I check the "Rx Needed" checkbox
#        And I select the "Lasix 20 mg tablet" link in the row with the text "Lasix 20 mg tablet" in the "SelectMedication" table
#        And I select "otherPharmacy" from the "Other Pharmacy" radio list
#        And I enter "10705" in the "Near By" field
#        And I click the "Search Addr" button
#        And I select "Duane Reade 14204" in the "Pharmacy Search Results" table
#        And I enter "2" in the "Disp" field
#        And I click the "Ok Button" button in the "Prescription" pane
        Then rows containing the following should appear in the "Medication Reconciliation" clinical table
            |Lasix tablet (furosemide) 20MG Oral Daily |Continue / Change  |New: Lasix tablet (furosemide) 20MG Oral Daily|
         And I reconcile and Submit the Orders
         And I click the "Submit Partial Med Rec" button if it exists
#         Commenting the below validation, "Review Prescriptions Contents" pane doesnt popup as the home med is continued with all the order details filled out
#         And the following text should appear in the "Review Prescriptions Contents" pane
#             |Patient: AUBAINE, CHENIN BLANC           |
#             |Prescriptions to be printed and signed:  |
#             |Lasix 20 mg tablet                       |
#             |Take 1 tablet by mouth Daily.            |
##            |Take 1 tablet Oral Daily.                |
#             |Notes: Substitutions allowed.            |
#             |Duane Reade 14204                        |
#         And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane


    Scenario:Continue Standard home med
        When "AUBAINE, CHENIN BLANC" is on the patient list
        And I select patient "AUBAINE, CHENIN BLANC" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        And I wait "3" seconds
        When I select the "Continue" radio in the row with the text "ARIPiprazole disintegrating tablet 10MG Oral Daily" from the "Medication Reconciliation" table
#        Commenting the steps as the Edit order pane doesnt popup on continuing Home Med that has all fields filled out Order Details
#        And I uncheck the "Rx Needed" checkbox
#        And I check the "Rx Needed" checkbox
#        And I select the "aripiprazole 10 mg disintegrating tablet" link in the row with the text "aripiprazole 10 mg disintegrating tablet" in the "SelectMedication" table
#        And I select "defaultPharmacy" from the "Default Pharmacy" radio list
#        And I click on the link "Select Pharmacy" in the "DefaultPharmacy" pane
#        And I enter "55419" in the "Near By" field
#        And I click the "Search Addr" button
#        And I select "RTBC Test 55419" in the "Pharmacy Search Results" table
#        And I enter "2" in the "Disp" field
#        And I click the "Ok Button" button in the "Prescription" pane
        Then rows containing the following should appear in the "Medication Reconciliation" clinical table
            |ARIPiprazole disintegrating tablet 10MG Oral Daily |Continue / Change  |New: ARIPiprazole disintegrating tablet 10MG Oral Daily|
        And I reconcile and Submit the Orders
        And I click the "Submit Partial Med Rec" button if it exists
#         Commenting the below validation, "Review Prescriptions Contents" pane doesnt popup as the home med is continued with all the order details filled out
#        And the following text should appear in the "Review Prescriptions Contents" pane
#            |Patient: AUBAINE, CHENIN BLANC           |
#            |Prescriptions to be printed and signed:  |
#            |aripiprazole 10 mg disintegrating tablet |
#            |Take 1 tablet by mouth Daily.            |
##           |Take 1 tablet Oral Daily.                |
#            |Notes: Substitutions allowed.            |
#            |RTBC Test 55419                          |
#        And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane

    Scenario:Continue Hospital med
        When "AUBAINE, CHENIN BLANC" is on the patient list
        And I select patient "AUBAINE, CHENIN BLANC" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        And I wait "3" seconds
        When I select the "Continue" radio in the row with the text "alendronate tablet Oral (test order)" from the "Medication Reconciliation" table
#        And I uncheck the "Rx Needed" checkbox
        And I check the "Rx Needed" checkbox
        And I select the "alendronate 5 mg tablet" link in the row with the text "alendronate 5 mg tablet" in the "SelectMedication" table
        And I enter "2" in the "Disp" field
        And I select "printer" from the "Printer" radio list
        And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
        Then rows containing the following should appear in the "Medication Reconciliation" clinical table
            |alendronate tablet Oral (test order) |Continue / Change  |New: alendronate tablet Oral (test order), Disp: 2|
        And I click the "Stop Remaining Meds" button if it exists
        And I reconcile and Submit the Orders
        And I click the "Submit Partial Med Rec" button if it exists
        And the following text should appear in the "Review Prescriptions Contents" pane
            |Patient: AUBAINE, CHENIN BLANC           |
            |Prescriptions to be printed and signed:  |
            |alendronate 5 mg tablet                  |
            |test order.                              |
            |Notes: Substitutions allowed.            |
            |Printer                                  |
        And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane
        Then the "Review Prescriptions Contents" pane should close

    Scenario: Change Overlapped med
        And I am on the "Patient List V2" tab
        When "CROSS, DAVID M" is on the patient list
        And I select patient "CROSS, DAVID M" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        And I wait "3" seconds
#        #Overlapped med
        And I select the "Change" link in the row with the text "Lopressor tablet (metoprolol tartrate) 50MG Oral Daily" in the "Medication Reconciliation" table
        And I select "Lopressor tablet (metoprolol tartrate)  100MG Oral" from the "Searched Combined Med Orders" list in the search results if it exists
#        And I uncheck the "Rx Needed" checkbox
        And I check the "Rx Needed" checkbox
        And I select the "Lopressor 100 mg tablet" link in the row with the text "Lopressor 100 mg tablet" in the "SelectMedication" table
        And I wait up to "30" seconds for the "Other Pharmacy" field of type "RADIO" to be visible
        And I select "otherPharmacy" from the "Other Pharmacy" radio list
        And I wait up to "20" seconds for the "Near By" field of type "TEXT_FIELD" to be visible
        And I enter "10705" in the "Near By" field
        And I click the "Search Addr" button
        And I select "Duane Reade 14204" in the "Pharmacy Search Results" table
        And I enter "2" in the "Disp" field
        And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
        Then rows containing the following should appear in the "Medication Reconciliation" clinical table
            |Lopressor tablet (metoprolol tartrate) 50MG Oral Daily |Continue / Change  |New: Lopressor tablet (metoprolol tartrate) Oral (test order), Disp: 2|
        And I reconcile and Submit the Orders
        And I click the "Submit Partial Med Rec" button if it exists
        And the following text should appear in the "Review Prescriptions Contents" pane
            |Patient: CROSS, DAVID M                  |
            |Prescriptions to be printed and signed:  |
            |Lopressor 100 mg tablet                  |
            |test order.                              |
            |Notes: Substitutions allowed.            |
            |Duane Reade 14204                        |
        And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane
        Then the "Review Prescriptions Contents" pane should close

    Scenario: Change Linked med
        And I am on the "Patient List V2" tab
        When "CROSS, DAVID M" is on the patient list
        And I select patient "CROSS, DAVID M" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        And I wait "3" seconds
        When I select the "Change" link in the row with the text "Lasix tablet (furosemide) 20MG Oral Daily" in the "Medication Reconciliation" table
        And I select "Lasix tablet (furosemide) 40MG Oral" from the "Searched Combined Med Orders" list in the search results
#        And I uncheck the "Rx Needed" checkbox
        And I check the "Rx Needed" checkbox
        And I select the "Lasix 40 mg tablet" link in the row with the text "Lasix 40 mg tablet" in the "SelectMedication" table
#        And I select "defaultPharmacy" from the "Default Pharmacy" radio list
#        And I click on the link "Select Pharmacy" in the "DefaultPharmacy" pane
#        And I wait up to "20" seconds for the "Near By" field of type "TEXT_FIELD" to be visible
#        And I enter "55419" in the "Near By" field
#        And I click the "Search Addr" button
#        And I select "RTBC Test 55419" in the "Pharmacy Search Results" table
        And I enter "2" in the "Disp" field
        And I select "printer" from the "Printer" radio list
        And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
        Then rows containing the following should appear in the "Medication Reconciliation" clinical table
            |Lasix tablet (furosemide) 20MG Oral Daily |Continue / Change  |New: Lasix tablet (furosemide) Oral (test order), Disp: 2|
        And I reconcile and Submit the Orders
        And I click the "Submit Partial Med Rec" button if it exists
        And the following text should appear in the "Review Prescriptions Contents" pane
            |Patient: CROSS, DAVID M                  |
            |Prescriptions to be printed and signed:  |
            |Lasix 40 mg tablet                       |
            |test order.                              |
            |Notes: Substitutions allowed.            |
            |Printer                                  |
        And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane
        Then the "Review Prescriptions Contents" pane should close

        #Standard home med
    Scenario: Change Standard home med
        And I am on the "Patient List V2" tab
        When "CROSS, DAVID M" is on the patient list
        And I select patient "CROSS, DAVID M" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        And I wait "3" seconds
        When I select the "Change" link in the row with the text "ARIPiprazole disintegrating tablet 10MG Oral Daily" in the "Medication Reconciliation" table
        And I select "ARIPiprazole disintegrating tablet  15MG Oral" from the "Searched Combined Med Orders" list in the search results
#        And I uncheck the "Rx Needed" checkbox
        And I check the "Rx Needed" checkbox
        And I select the "aripiprazole 15 mg disintegrating tablet" link in the row with the text "aripiprazole 15 mg disintegrating tablet" in the "SelectMedication" table
        And I enter "2" in the "Disp" field
        And I select "printer" from the "Printer" radio list
        And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
        Then rows containing the following should appear in the "Medication Reconciliation" clinical table
            |ARIPiprazole disintegrating tablet 10MG Oral Daily |Continue / Change  |New: ARIPiprazole disintegrating tablet Oral (test order), Disp: 2|
        And I reconcile and Submit the Orders
        And I click the "Submit Partial Med Rec" button if it exists
        And the following text should appear in the "Review Prescriptions Contents" pane
            |Patient: CROSS, DAVID M                  |
            |Prescriptions to be printed and signed:  |
            |aripiprazole 15 mg disintegrating tablet |
            |test order.                              |
            |Notes: Substitutions allowed.            |
            |Printer                                  |
        And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane
        Then the "Review Prescriptions Contents" pane should close

    #Hospital med
    Scenario: Change Hospital med
        And I am on the "Patient List V2" tab
        When "CROSS, DAVID M" is on the patient list
        And I select patient "CROSS, DAVID M" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        And I wait "3" seconds
        When I select the "Change" link in the row with the text "alendronate tablet Oral (test order)" in the "Medication Reconciliation" table
        And I select "alendronate tablet  10MG Oral" from the "Searched Combined Med Orders" list in the search results
#        And I uncheck the "Rx Needed" checkbox
        And I check the "Rx Needed" checkbox
        And I select the "alendronate 10 mg tablet" link in the row with the text "alendronate 10 mg tablet" in the "SelectMedication" table
        And I enter "2" in the "Disp" field
        And I select "printer" from the "Printer" radio list
        And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
        Then rows containing the following should appear in the "Medication Reconciliation" clinical table
            |alendronate tablet Oral (test order) |Continue / Change  |New: alendronate tablet Oral (test order), Disp: 2|
        And I click the "Stop Remaining Meds" button if it exists
        And I reconcile and Submit the Orders
        And I click the "Submit Partial Med Rec" button if it exists
        And the following text should appear in the "Review Prescriptions Contents" pane
            |Patient: CROSS, DAVID M                  |
            |Prescriptions to be printed and signed:  |
            |alendronate 10 mg tablet                 |
            |test order.                              |
            |Notes: Substitutions allowed.            |
            |Printer                                  |
        And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane
        Then the "Review Prescriptions Contents" pane should close

    Scenario: Pre-requiste Change-Changed linked Medication[DEV-67712]
        When "WILCOX, AUDREY" is on the patient list
        And I select patient "WILCOX, AUDREY" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Adm Med Rec" button in the "Orders" pane
        Then the "Admission Medication Reconciliation" pane should load within "5" seconds
        When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
        And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
        And I enter "Lasix tablet" in the "Search for order" field in the "Search for order" pane
        And I select "Lasix tablet (furosemide)  20MG Oral" from the "Searched Combined Med Orders" list in the search results
        And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
        And I select the "Change" link in the row with "New: Lasix tablet (furosemide) 20MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
        Then the value in the "Search For" field in the "Search for order" pane should be "Lasix"
        When I select "Lasix tablet (furosemide)  40MG Oral" from the "Searched NonFormulary Med Orders Update" list in the search results
        And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
        And I reconcile and Submit the Orders
        And I am on the "Patient List V2" tab
        And I select patient "WILCOX, AUDREY" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        And I wait "3" seconds
        When I select the "Change" link in the row with the text "Lasix tablet (furosemide) Oral (test order)" in the "Medication Reconciliation" table
        And I select "Lasix tablet (furosemide) 40MG Oral" from the "Searched Combined Med Orders" list in the search results
        And I select the "Lasix 40 mg tablet" link in the row with the text "Lasix 40 mg tablet" in the "SelectMedication" table if it exists
        And I select "defaultPharmacy" from the "Default Pharmacy" radio list
        And I wait "2" seconds
        And I click on the link "Select Pharmacy" in the "DefaultPharmacy" pane
        And I wait up to "20" seconds for the "Near By" field of type "TEXT_FIELD" to be visible
        And I click the "Mail Orders" element
        And I select "A247PC00" in the "Pharmacy Mail Order Search Results" table
        And I enter "2" in the "Disp" field
        And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
        Then rows containing the following should appear in the "Medication Reconciliation" clinical table
            |Lasix tablet (furosemide) Oral (test order) |Continue / Change  |New: Lasix tablet (furosemide) Oral (test order), Disp: 2|
        And I reconcile and Submit the Orders
        And I click the "Submit Partial Med Rec" button if it exists
        And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane
        Then the "Review Prescriptions Contents" pane should close

    Scenario: Change-Changed linked Medication[DEV-67712]
#        When "WILCOX, AUDREY" is on the patient list
        And I select patient "WILCOX, AUDREY" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        Then the "Discharge Medication Reconciliation" pane should load
        #        Changing Changed linked med
        And I move the mouse over the "Continuedicon" element in the "Discharge Medication Reconciliation" pane
        And I select the "Change" link in the row with the text "Lasix tablet (furosemide) Oral (test order)" in the "Medication Reconciliation" table
        When I select "Lasix tablet (furosemide)  80MG Oral" from the "Searched Combined Med Orders" list in the search results
        And I select the "Lasix 80 mg tablet" link in the row with the text "Lasix 80 mg tablet" in the "SelectMedication" table if it exists
#        And I wait up to "30" seconds for the "Other Pharmacy" field of type "RADIO" to be visible
#        And I select "otherPharmacy" from the "Other Pharmacy" radio list
#        And I click the "Mail Orders" element
#        And I select "A247PC00" in the "Pharmacy Mail Order Search Results" table
        And I select "Daily" from the "Frequency" multiselect in the "EditOrderErx" pane
        And I enter "2" in the "Disp" field in the "EditOrderErx" pane
        And I click the "OkButton" button in the "EditOrderErx" pane
        And rows containing the following should appear in the "Medication Reconciliation" clinical table
            |Lasix tablet (furosemide) 20MG Oral Daily   |Continue / Change  |New: Lasix tablet (furosemide) 80MG Oral Daily, Disp: 2|
            |Lasix tablet (furosemide) Oral (test order) |                   |                                                       |
        And I click the "Reconcile and Submit" button
        And I click the "Submit Partial Med Rec" button if it exists
        And the "Review Prescriptions" pane should load
        Then the following text should appear in the "Review Prescriptions Contents" pane
            |Patient: WILCOX, AUDREY          |
            |Lasix 80 mg tablet               |
            |1 tablet by mouth Daily.         |
            |Notes: Substitutions allowed.    |
        And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane
        Then the "Review Prescriptions Contents" pane should close
        And I wait "10" seconds
        And the "Action Required Call Pharmacy" pane should load
        Then the text "You must call the pharmacy directly to cancel the following prescription(s):" should appear in the "Action Required Call Pharmacy Contents" pane
        And I click the "Pharmacy Has Been Called" button in the "Action Required Call Pharmacy Contents" pane

    Scenario: Pre-requisite Change-Changed Overlapped Medication[DEV-67712]
        When "WAYNE, BRUCE" is on the patient list
        And I select patient "WAYNE, BRUCE" from the patient list
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
        And I select patient "WAYNE, BRUCE" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        And I wait "3" seconds
         #Overlapped med
        And I select the "Change" link in the row with the text "Lopressor tablet (metoprolol tartrate) 50MG Oral Daily" in the "Medication Reconciliation" table
        And I select "Lopressor tablet (metoprolol tartrate)  100MG Oral" from the "Searched Combined Med Orders" list in the search results if it exists
        And I select the "Lopressor 100 mg tablet" link in the row with the text "Lopressor 100 mg tablet" in the "SelectMedication" table
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

    Scenario: Change-Changed Overlapped Medication[DEV-67712]
        When "WAYNE, BRUCE" is on the patient list
        And I select patient "WAYNE, BRUCE" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        Then the "Discharge Medication Reconciliation" pane should load
             #Changing Changed Overlapped med
        And I move the mouse over the "Continuedicon" element in the "Discharge Medication Reconciliation" pane
        And I select the "Change" link in the row with the text "Lopressor tablet (metoprolol tartrate) 50MG Oral Daily" in the "Medication Reconciliation" table
        And I select "Lopressor tablet (metoprolol tartrate) 50MG Oral" from the "Searched Combined Med Orders" list in the search results
#        And the text "You have selected a discharge medication with a route of IV.  Are you sure you want to continue?" should appear in the "Question" pane
        And I click the "Yes" button in the "Question" pane if it exists
        And I select the "Lopressor 50 mg tablet" link in the row with the text "Lopressor 50 mg tablet" in the "SelectMedication" table
         #        And I click the "Lopressor 100 mg tablet" link if it exists in the "EditOrderErx" pane
        And I wait up to "30" seconds for the "Other Pharmacy" field of type "RADIO" to be visible
        And I select "otherPharmacy" from the "Other Pharmacy" radio list
        And I click the "EditOtherPharmacy" button if it exists
        And I wait "3" seconds
        And I click the "Mail Orders" element
        And I select "A247PC00" in the "Pharmacy Mail Order Search Results" table
        And I select "Daily" from the "Frequency" multiselect in the "EditOrderErx" pane
        And I enter "2" in the "Disp" field in the "EditOrderErx" pane
        And I click the "OkButton" button in the "EditOrderErx" pane
        And rows containing the following should appear in the "Medication Reconciliation" clinical table
            |Lopressor tablet (metoprolol tartrate) 50MG Oral Daily|Continue / Change |Lopressor tablet (metoprolol tartrate) 50MG Oral Daily, Disp: 2 Tablet|
        And I click the "Reconcile and Submit" button
        And I click the "Submit Partial Med Rec" button if it exists
        And the "Review Prescriptions" pane should load
        Then the following text should appear in the "Review Prescriptions Contents" pane
            |Patient: WAYNE, BRUCE                                  |
            |Lopressor 50 mg tablet                                 |
            |1 tablet by mouth Daily.                               |
            |Notes: Substitutions allowed.                          |
        And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane
        Then the "Review Prescriptions Contents" pane should close
        And I wait "10" seconds
        And the "Action Required Call Pharmacy" pane should load
        Then the text "You must call the pharmacy directly to cancel the following prescription(s):" should appear in the "Action Required Call Pharmacy Contents" pane
        And I click the "Pharmacy Has Been Called" button in the "Action Required Call Pharmacy Contents" pane

    Scenario: Stop Linked Medication
        And I am on the "Patient List V2" tab
        When "JULIA SMITH" is on the patient list
        And I select patient "JULIA SMITH" from the patient list
        And I select "Home Meds" from clinical navigation
        And I click the "Adm Med Rec" button
        Then the "Admission Medication Reconciliation" pane should load
        And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
        And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
#        #Preparing Linked med
        And I enter "amoxapine tablet" in the "Search for order" field in the "Search for order" pane
        And I select "amoxapine tablet  25MG Oral" from the "Searched Combined Med Orders" list in the search results
        And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
        And I select the "Change" link in the row with "New: amoxapine tablet 25MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
        When I select "amoxapine tablet  50MG Oral" from the "Searched NonFormulary Med Orders Update" list in the search results
        And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
        And I click the "Reconcile and Submit" button
        And I am on the "Patient List V2" tab
        And I select patient "JULIA SMITH" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        Then the "Discharge Medication Reconciliation" pane should load
        And I wait "3" seconds
        #Stop linked med
        And I select the "Stop" radio in the row with the text "amoxapine tablet 25MG Oral Daily" from the "Medication Reconciliation" table
        And rows containing the following should appear in the "Medication Reconciliation" clinical table
            |amoxapine tablet 25MG Oral Daily |Stop |Stopped |
        And I click the "Reconcile and Submit" button
        And I click the "Submit Partial Med Rec" button if it exists
        And I am on the "Patient List V2" tab
        And I select patient "JULIA SMITH" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        Then the "Discharge Medication Reconciliation" pane should load
        #Reviewing Stopped Linked med
        And the "Stop" image should be displayed for the "amoxapine tablet 25MG Oral Daily" row in the Medication Reconciliation table
        And I click the "ReconcileCancel" button in the "Discharge Medication Reconciliation" pane
        And I click the "Yes" button in the "Question" pane

    Scenario: Change-Stopped Linked Medication
        And I am on the "Patient List V2" tab
        When "JULIA SMITH" is on the patient list
        And I select patient "JULIA SMITH" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        Then the "Discharge Medication Reconciliation" pane should load
        And I wait "3" seconds
#        Changing Stopped linked med
        And the "Stop" image should be displayed for the "amoxapine tablet 25MG Oral Daily" row in the Medication Reconciliation table
        And I move the mouse over the "StopIcon" element in the "Discharge Medication Reconciliation" pane
        And I select the "Change" link in the row with the text "amoxapine tablet 25MG Oral Daily" in the "Medication Reconciliation" table
        And I select "amoxapine tablet  50MG Oral" from the "Searched Combined Med Orders" list in the search results
#        And I uncheck the "Rx Needed" checkbox
#        And I check the "Rx Needed" checkbox
#        And I select the "amoxapine 50 mg tablet" link in the row with the text "amoxapine 50 mg tablet" in the "SelectMedication" table
#        And I wait up to "30" seconds for the "Other Pharmacy" field of type "RADIO" to be visible
#        And I select "otherPharmacy" from the "Other Pharmacy" radio list
#        And I click the "Mail Orders" element
#        And I select "A247PC00" in the "Pharmacy Mail Order Search Results" table
        And I enter "2" in the "Disp" field
        And I select "printer" from the "Printer" radio list
        And I fill the mandatory order details in the "Edit Medication Order" pane
        And rows containing the following should appear in the "Medication Reconciliation" clinical table
            |amoxapine tablet 25MG Oral Daily   |Continue / Change  |New: amoxapine tablet Oral (test order), Disp: 2|
            |amoxapine tablet Oral (test order) |                   |                                                |
        And I click the "Reconcile and Submit" button
        And I click the "Submit Partial Med Rec" button if it exists
        Then the following text should appear in the "Review Prescriptions Contents" pane
            |Patient: SMITH, JULIA                      |
            |Prescriptions to be printed and signed:    |
            |amoxapine 50 mg tablet                     |
            |test order.                                |
            |Notes: Substitutions allowed.              |
            |Printer                                    |
        And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane
        Then the "Review Prescriptions Contents" pane should close

    Scenario: Stop Overlapped Medication
        And I am on the "Patient List V2" tab
        When "DOCKENDORF, TAD A" is on the patient list
        And I select patient "DOCKENDORF, TAD A" from the patient list
        And I select "Home Meds" from clinical navigation
        And I click the "Adm Med Rec" button
        Then the "Admission Medication Reconciliation" pane should load
        And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
        And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
##        #Preparing Overlapped med
        And I enter "Minocin capsule" in the "Search for order" field in the "Search for order" pane
        And I select "Minocin capsule (minocycline)  50MG Oral" from the "Searched Combined Med Orders" list in the search results
        And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
        Then I select the "Continue" radio in the row with "New: Minocin capsule (minocycline) 50MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
        And I click the "Reconcile and Submit" button
        And I am on the "Patient List V2" tab
        And I select patient "DOCKENDORF, TAD A" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        Then the "Discharge Medication Reconciliation" pane should load
        And I wait "3" seconds
#        #stop overlapped
        And I select the "Stop" radio in the row with the text "Minocin capsule (minocycline) 50MG Oral Daily" from the "Medication Reconciliation" table
        And rows containing the following should appear in the "Medication Reconciliation" clinical table
            |Minocin capsule (minocycline) 50MG Oral |Stop |Stopped |
        And I click the "Reconcile and Submit" button
        And I click the "Submit Partial Med Rec" button if it exists
        And I am on the "Patient List V2" tab
        And I select patient "DOCKENDORF, TAD A" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        Then the "Discharge Medication Reconciliation" pane should load
        #Reviewing Stopped Overlapped med
        And the "Stop" image should be displayed for the "Minocin capsule (minocycline) 50MG Oral Daily" row in the Medication Reconciliation table
        And I click the "ReconcileCancel" button in the "Discharge Medication Reconciliation" pane
        And I click the "Yes" button in the "Question" pane

    Scenario:Change-Stopped Overlapped Medication
        And I am on the "Patient List V2" tab
        When "DOCKENDORF, TAD A" is on the patient list
        And I select patient "DOCKENDORF, TAD A" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        Then the "Discharge Medication Reconciliation" pane should load
        And I wait "3" seconds
        And the "Stop" image should be displayed for the "Minocin capsule (minocycline) 50MG Oral Daily" row in the Medication Reconciliation table
        And I move the mouse over the "StopIcon" element in the "Discharge Medication Reconciliation" pane
        And I select the "Change" link in the row with the text "Minocin capsule (minocycline) 50MG Oral Daily" in the "Medication Reconciliation" table
        When I select "Minocin capsule (minocycline)  100MG Oral" from the "Searched Combined Med Orders" list in the search results
#        And I check the "Rx Needed" checkbox
        And I select the "Minocin 100 mg capsule" link in the row with the text "Minocin 100 mg capsule" in the "SelectMedication" table if it exists
        And I enter "2" in the "Disp" field
        And I enter "1" in the "DispenseUnit" field
        And I select "printer" from the "Printer" radio list
        And I fill the mandatory order details in the "Edit Medication Order" pane
        And rows containing the following should appear in the "Medication Reconciliation" clinical table
            |Minocin capsule (minocycline) 50MG Oral Daily |Continue / Change |New: Minocin capsule (minocycline) Oral (test order), Disp: 2 x 1|
        And I click the "Reconcile and Submit" button
        And I click the "Submit Partial Med Rec" button if it exists
        And the "Review Prescriptions" pane should load
        Then the following text should appear in the "Review Prescriptions Contents" pane
            |Patient: DOCKENDORF, TAD A                 |
            |Prescriptions to be printed and signed:    |
            |Minocin 100 mg capsule                     |
            |test order.                                |
            |Notes: Substitutions allowed.              |
            |Printer                                    |
        And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane
        Then the "Review Prescriptions Contents" pane should close

        # Adding donot run tag for the below scenario as per [DEV-69232]
    @donotrun
    Scenario: Review Previously Reconciled Medications in DMR
        And I am on the "Patient List V2" tab
        When "JULIA SMITH" is on the patient list
        And I select patient "JULIA SMITH" from the patient list
        When I select "Discharge Med Rec" from the "Patient Header Actions" menu
        Then the "Discharge Medication Reconciliation" pane should load
        And I click the "Previously Reconciled" element in the "Discharge Medication Reconciliation" pane
        And I click the "MedstoReconcile" element in the "Discharge Medication Reconciliation" pane
        And I click the "Previously Reconciled" element in the "Discharge Medication Reconciliation" pane
        Then the "Discharge Medication Reconciliation" pane should load
          # Linked med
        Then rows containing the following should appear in the "MedRecPreviouslyReconciled" clinical table
            |amoxapine tablet 25MG Oral Daily   |Stop |
            |amoxapine tablet Oral (test order) |     |
       # Overlapped Med
        Then rows containing the following should appear in the "MedRecPreviouslyReconciled" clinical table
            |tetracycline capsule 250MG Oral Daily |Stop |
        And I click the "Back" button in the "Discharge Medication Reconciliation" pane
        And I click the "ReconcileCancel" button in the "Discharge Medication Reconciliation" pane
        And I click the "Yes" button in the "Question" pane
       #Adding donotrun tag to below scenario as call Pharmacy popup is not triggering [DEV-67712

    Scenario: Continue hospital only Medication
        When "JOSEF WILSON" is on the patient list
        And I select patient "JOSEF WILSON" from the patient list
        #Preparing hospital only med
        And I select "Orders" from clinical navigation
        And I click the "Enter Orders" button
        And I click the "OK" button in the "Warning" pane if it exists
        Then the "Enter Orders" pane should load
        When I enter "acebutolol" in the "Add Order" field in the "Enter Orders" pane
        And I select "acebutolol capsule 200MG Oral" from the "NonFormulary MedOrders" list in the search results
        And I fill the mandatory order details in the "Edit Order" pane if it exists
        And I Submit the Orders
        #Continue the hospital only med
        And I click the "Discharge Med Rec" button
        Then the "Discharge Medication Reconciliation" pane should load
        And I wait "3" seconds
        And I select the "Continue" radio in the row with the text "acebutolol capsule Oral (test order)" from the "Medication Reconciliation" table
        And I check the "Rx Needed" checkbox
        And I select the "acebutolol 200 mg capsule" link in the row with the text "acebutolol 200 mg capsule" in the "SelectMedication" table
        Then the "EditMedicationDetails" pane should load within "15" seconds
        And I wait "3" seconds
        And I select "otherPharmacy" from the "Other Pharmacy" radio list
        And I click the "Mail Orders" element
        And I select "A247PC00" in the "Pharmacy Mail Order Search Results" table
        And I enter "2" in the "Disp" field
        And I fill the mandatory order details in the "Edit Medication Order" pane
        And rows containing the following should appear in the "Medication Reconciliation" clinical table
            |acebutolol capsule Oral (test order) |Continue / Change |New: acebutolol capsule Oral (test order), Disp: 2 |
        And I click the "Reconcile and Submit" button
        And I click the "Submit Partial Med Rec" button if it exists
        And the "Review Prescriptions" pane should load
        Then the following text should appear in the "Review Prescriptions Contents" pane
        |Patient: WILSON, JOSEF                  |
#        |Prescriptions to be printed and signed: |
        |acebutolol 200 mg capsule               |
        |test order.                             |
        |Notes: Substitutions allowed.           |
        |A247PC00                                |
        And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane
        Then the "Review Prescriptions Contents" pane should close

    Scenario: Stop hospital only Medication
        When "JOSEF WILSON" is on the patient list
        And I select patient "JOSEF WILSON" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        And the "Discharge Medication Reconciliation" pane should load
        And I wait "3" seconds
        And I move the mouse over the "Continuedicon" element in the "Discharge Medication Reconciliation" pane
        And I select the "Stop" radio in the row with the text "acebutolol capsule Oral (test order)" from the "Medication Reconciliation" table
        Then rows containing the following should appear in the "Medication Reconciliation" clinical table
            |acebutolol capsule Oral (test order) |Stop |
        And I click the "Reconcile and Submit" button
        And I click the "Submit Partial Med Rec" button if it exists
        And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane
        And I wait "10" seconds
        And the "Action Required Call Pharmacy" pane should load
        Then the text "You must call the pharmacy directly to cancel the following prescription(s):" should appear in the "Action Required Call Pharmacy Contents" pane
        And I click the "Pharmacy Has Been Called" button in the "Action Required Call Pharmacy Contents" pane
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        And the "Discharge Medication Reconciliation" pane should load
        And the "Stop" image should be displayed for the "acebutolol capsule Oral (test order)" row in the Medication Reconciliation table
        And I click the "ReconcileCancel" button in the "Discharge Medication Reconciliation" pane
        And I click the "Yes" button in the "Question" pane

    Scenario: Change- Stopped hospital only Medication
        When "JOSEF WILSON" is on the patient list
        And I select patient "JOSEF WILSON" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        And the "Discharge Medication Reconciliation" pane should load
        And I wait "3" seconds
        And the "Stop" image should be displayed for the "acebutolol capsule Oral (test order)" row in the Medication Reconciliation table
        And I move the mouse over the "Stop Icon" element in the "Discharge Medication Reconciliation" pane
        And I select the "Change" link in the row with the text "acebutolol capsule Oral (test order)" in the "Medication Reconciliation" table
        When I select "acebutolol capsule  400MG Oral" from the "Searched Combined Med Orders" list in the search results
#        And I click the "acebutolol 400 mg capsule" link if it exists in the "EditOrderErx" pane
#        And I uncheck the "Rx Needed" checkbox
        And I check the "Rx Needed" checkbox
        And I select the "acebutolol 400 mg capsule" link in the row with the text "acebutolol 400 mg capsule" in the "SelectMedication" table
        And I select "Daily" from the "Frequency" multiselect in the "EditOrderErx" pane
        And I enter "2" in the "Disp" field
        And I wait up to "30" seconds for the "Other Pharmacy" field of type "RADIO" to be visible
        And I select "otherPharmacy" from the "Other Pharmacy" radio list
        And I click the "EditOtherPharmacy" button if it exists
        And I wait "3" seconds
        And I click the "Mail Orders" element
        And I select "A247PC00" in the "Pharmacy Mail Order Search Results" table
        And I click the "OkButton" button in the "EditOrderErx" pane
        And rows containing the following should appear in the "Medication Reconciliation" clinical table
            |acebutolol capsule Oral (test order) |Continue / Change  |New: acebutolol capsule 400MG Oral Daily, Disp: 2|
        And I click the "Reconcile and Submit" button
        And I click the "Submit Partial Med Rec" button if it exists
        And the "Review Prescriptions" pane should load
        Then the following text should appear in the "Review Prescriptions Contents" pane
            |Patient: WILSON, JOSEF                  |
#            |Prescriptions to be printed and signed: |
            |acebutolol 400 mg capsule               |
            |1 capsule by mouth Daily.               |
#           |Take 1 capsule Oral Daily.              |
            |Notes: Substitutions allowed.           |
            |A247PC00                            |
        And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane
        Then the "Review Prescriptions Contents" pane should close

    @donotrun
    Scenario: Change- Changed hospital only Medication[Dev-67712]
        When "JOSEF WILSON" is on the patient list
        And I select patient "JOSEF WILSON" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        And the "Discharge Medication Reconciliation" pane should load
        And I move the mouse over the "Continuedicon" element in the "Discharge Medication Reconciliation" pane
        And I select the "Change" link in the row with the text "acebutolol capsule Oral (test order)" in the "Medication Reconciliation" table
        When I select "acebutolol Powder  Misc" from the "Searched Combined Med Orders" list in the search results
        And I click the "acebutolol (bulk) powder" link if it exists in the "EditOrderErx" pane
#        And I uncheck the "Rx Needed" checkbox
        And I check the "Rx Needed" checkbox
        And I wait up to "30" seconds for the "Other Pharmacy" field of type "RADIO" to be visible
        And I select "otherPharmacy" from the "Other Pharmacy" radio list
        And I click the "Mail Orders" element
        And I select "A247PC00" in the "Pharmacy Mail Order Search Results" table
        And I select "Special Inst" from the "Frequency" multiselect in the "EditOrderErx" pane
        And I enter "2" in the "Disp" field in the "EditOrderErx" pane
        And I enter "1" in the "DispenseUnit" field in the "EditOrderErx" pane
        And I enter "test order" in the "Special Instructions" field in the "EditOrderErx" pane
        And I select "printer" from the "Printer" radio list
        And I click the "OkButton" button in the "EditOrderErx" pane
        And rows containing the following should appear in the "Medication Reconciliation" clinical table
            |acebutolol capsule Oral (test order) |Continue / Change  |New: acebutolol Powder Misc (test order), Disp: 2|
        And I click the "Reconcile and Submit" button
        And the "Review Prescriptions" pane should load
        Then the following text should appear in the "Review Prescriptions Contents" pane
            |Patient: WILSON, JOSEF                  |
            |Prescriptions to be printed and signed: |
            |acebutolol Powder                       |
            |test order.                             |
            |Notes: Substitutions allowed.           |
            |Printer                                 |
        And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane
        Then the "Review Prescriptions Contents" pane should close

    Scenario: Enable Incomplete AMR & DMR settings
         #  Enable Partial Medrec
        Given I am on the "Admin" tab
        And I select the "Facility Group" subtab
        And I click the "CPOE Preferences" link in the "Facility Group Navigation" pane
        When I click the "Edit CPOE Preferences" button
        And I select "true" from the "Incomplete Admission Reconciliation" radio list
        And I select "true" from the "Incomplete Discharge Reconciliation" radio list
        And I click the "Save Edit Facility Group Preferences" button
        And the "Edit Facility Group Preferences" pane should close
        And I wait "3" seconds
        #Aditional steps for sync issue
        And I am on the "Patient List V2" tab
        And "KARA WHITESIDE" is on the patient list
        And I select patient "KARA WHITESIDE" from the patient list
        And I click the logout button

    Scenario: Stop Standard Medication
        And I am on the "Patient List V2" tab
        And "KARA WHITESIDE" is on the patient list
        And I select patient "KARA WHITESIDE" from the patient list
        And I select "Home Meds" from clinical navigation
        And I click the "Adm Med Rec" button
        Then the "Admission Medication Reconciliation" pane should load
        When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
        And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
             #Preparing Standard med
        And I enter "alendronate tablet" in the "Search for order" field in the "Search for order" pane
        And I select "alendronate tablet  5MG Oral" from the "Searched Combined Med Orders" list in the search results
        And I fill the mandatory order details in the "Admission Medication Reconciliation" pane
        And I click the "Reconcile and Submit" button
        And I click the "Submit Partial Med Rec" button if it exists
        And I am on the "Patient List V2" tab
        And I select patient "KARA WHITESIDE" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        And the "Discharge Medication Reconciliation" pane should load
        And I wait "3" seconds
        And I select the "Stop" radio in the row with the text "alendronate tablet 5MG Oral Daily" from the "Medication Reconciliation" table
        Then rows containing the following should appear in the "Medication Reconciliation" clinical table
            |alendronate tablet 5MG Oral Daily |Stop |Stopped |
        And I click the "Reconcile and Submit" button
        And I click the "Submit Partial Med Rec" button if it exists
        And I am on the "Patient List V2" tab
        And I select patient "KARA WHITESIDE" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        And the "Discharge Medication Reconciliation" pane should load
        And the "Stop" image should be displayed for the "alendronate tablet 5MG Oral Daily" row in the Medication Reconciliation table
        And I click the "ReconcileCancel" button in the "Discharge Medication Reconciliation" pane
        And I click the "Yes" button in the "Question" pane

    Scenario: Change - Stopped Standard Medication
        And I am on the "Patient List V2" tab
        And "KARA WHITESIDE" is on the patient list
        And I select patient "KARA WHITESIDE" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Discharge Med Rec" button
        And the "Discharge Medication Reconciliation" pane should load
        And I wait "3" seconds
        And the "Stop" image should be displayed for the "alendronate tablet 5MG Oral Daily" row in the Medication Reconciliation table
        And I move the mouse over the "Stop Icon" element in the "Discharge Medication Reconciliation" pane
        And I select the "Change" link in the row with the text "alendronate tablet 5MG Oral Daily" in the "Medication Reconciliation" table
        And I select "alendronate tablet  10MG Oral" from the "Searched Combined Med Orders" list in the search results
#        And I uncheck the "Rx Needed" checkbox
        And I check the "Rx Needed" checkbox
        And I select the "alendronate 10 mg tablet" link in the row with the text "alendronate 10 mg tablet" in the "SelectMedication" table
        And I wait up to "30" seconds for the "Other Pharmacy" field of type "RADIO" to be visible
#        And I select "otherPharmacy" from the "Other Pharmacy" radio list
#        And I click the "Mail Orders" element
#        And I select "A247PC00" in the "Pharmacy Mail Order Search Results" table
        And I enter "2" in the "Disp" field
        And I select "printer" from the "Printer" radio list
        And I fill the mandatory order details in the "Edit Medication Order" pane
        And rows containing the following should appear in the "Medication Reconciliation" clinical table
            |alendronate tablet 5MG Oral Daily |Continue / Change |New: alendronate tablet Oral (test order), Disp: 2|
        And I click the "Reconcile and Submit" button
        And I click the "Submit Partial Med Rec" button if it exists
        And the "Review Prescriptions" pane should load
        Then the following text should appear in the "Review Prescriptions Contents" pane
            |Patient: WHITESIDE, KARA                |
            |Prescriptions to be printed and signed: |
            |alendronate 10 mg tablet                |
            |test order.                             |
            |Notes: Substitutions allowed.           |
            |Printer                                 |
        And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane
        Then the "Review Prescriptions Contents" pane should close

    Scenario: Review Medications in Clinical Notes
        And I am on the "Patient List V2" tab
        When "BONNET, LOLA" is on the patient list
        And I select patient "BONNET, LOLA" from the patient list
        And I click the "Discharge Med Rec" button
        Then the "Discharge Medication Reconciliation" pane should load
        And I wait "3" seconds
        And I select the "Continue" radio in the row with the text "acetaminophen tablet 325mg Oral Q6H PRN pain" from the "Medication Reconciliation" table
        And rows containing the following should appear in the "Medication Reconciliation" clinical table
            |acetaminophen tablet 325mg Oral Q6H PRN pain |Continue / Change |New: acetaminophen tablet 325mg Oral Q6H PRN pain|
        And I select the "Continue" radio in the row with the text "Deltasone Tab Oral 20mg QAM" from the "Medication Reconciliation" table
        And I select "Deltasone tablet oral" in the "SearchedCombinedMedOrders" table
        And rows containing the following should appear in the "Medication Reconciliation" clinical table
            |Deltasone Tab Oral 20mg QAM |Continue / Change |New: Deltasone tablet (prednisone) 20MG Oral QAM|
        And I click the "Stop Remaining Meds" button if it exists
        And I click the "Reconcile and Submit" button
        And I click the "Submit Partial Med Rec" button if it exists
        And I load the "Discharge Summary" template note for the selected patient
        And I select the note "Discharge Medications" section
        Then the "Discharge Medications" pane should load
        Then rows containing the following should appear in the "Discharge Medications" table
            |Deltasone Tab Oral 20mg QAM    |
            |acetaminophen tablet 325mg Oral Q6H PRN pain |
        And I click the "Cancel" button in the "Note Writer Main" pane
        And I click the "Yes" button in the "Question" pane
        And I load the "Discharge Summary" template note for the selected patient
        And I select the note "Follow Up" section
        Then the "Follow Up" pane should load
        Then rows containing the following should appear in the "Pending Labs Or Tests At Discharge" table
            |Type                      |Status  |
            |Micro - sputum culture    |Pending |
        And I click the "Cancel" button in the "Note Writer Main" pane
        And I click the "Yes" button in the "Question" pane

    Scenario: Disable-Incomplete AMR & DMR settings
        And I am on the "Admin" tab
        And I select the "Facility Group" subtab
        And I click the "CPOE Preferences" link in the "Facility Group Navigation" pane
        When I click the "Edit CPOE Preferences" button
        And I wait "2" seconds
        And I select "false" from the "Incomplete Admission Reconciliation" radio list
        And I select "false" from the "Incomplete Discharge Reconciliation" radio list
        Then I click the "Save Edit Facility Group Preferences" button
        When I click the logout button




