@Performance @OneWindow_Performance
Feature: Performance ePrescription test

    @Performance @eRxPerformance @MedRecPerformance @OneWindow_Performance @OneWindow_eRxPerformance @OneWindow_MedRecPerformance
  Scenario: DMR/eRX tests for WHITESIDE, KARA
  #TODO change the plan
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "erxtest" from the "Patient List" menu
    #Given "WHITESIDE, KARA", admitted in the past "201" days, is on the patient list
    When I select patient "WHITESIDE, KARA" from the patient list
    And I select "Home Meds" from clinical navigation
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
#HomeMeds
    And I select the "Stop" radio in the row with the text "Allergy Relief (diphenhydrAMINE) capsule (diphenhydramine HCl) 25MG oral BEDTIME" from the "Medication Reconciliation" table
    #And I select the "Stop" radio in the row with the text "diphenhydrAMINE capsule 25MG oral BEDTIME" from the "Medication Reconciliation" table
    #And I select the "Stop" radio in the row with the text "Promethazine Tab (Phenergan Tab) 25MG oral Q6H PRN" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Prenatal Vitamin Tab 1TAB oral DAILY" in the "Medication Reconciliation" table
    And I select "Prenatal-U 106.5 mg-1 mg capsule (PNV without calcium #5-iron-FA)  1 CAP oral DAILY" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Change" button
    And I select "PBMF PLANX" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I select "PBMF PLANABX" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I select "CERT PBM-B PLANA4" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I click the "Change Plan Cancel" button
    And I select the "Prenatal-U 106.5 mg-1 mg capsule" link in the row with the text "Prenatal-U 106.5 mg-1 mg capsule" in the "Select Medication" table if it exists
    Then I click the "Default Pharmacy" icon
    And I enter "77001" in the "Near By" field in the "SelectDefaultPharmacy" pane
    And I click the "Search Addr" button
    And I click the "+Icon" element in the row with text "TX Pharmacy 10.6MU" in the "Pharmacy Search Results" table
#    And I select "TX Pharmacy 10.6MU" in the "Pharmacy Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "PROzac capsule (fluoxetine) 40MG oral DAILY" from the "Medication Reconciliation" table
    #And I select the "Stop" radio in the row with the text "PROzac capsule (fluoxetine) 40MG oral DAILY" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Acetaminophen Tab (Tylenol Tab) 325-650 MG oral Q6H PRN" from the "Medication Reconciliation" table
#HospitalMeds
    And I select the "Continue" radio in the row with the text "Cetirizine Tab (ZyrTEC Tab) 10MG oral DAILY" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Change" button
    And I select "PBMF PLANX" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I select "PBMF PLANABX" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I select "CERT PBM-B PLANA4" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I click the "Change Plan Cancel" button
    And I select the "All Day Allergy (cetirizine) 10 mg tablet" link in the row with the text "All Day Allergy (cetirizine) 10 mg tablet" in the "Select Medication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "ARIPiprazole Tab (Abilify Tab) 20MG oral DAILY" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "LORazepam Inj (Ativan Inj) 1MG IV Q4H PRN" from the "Medication Reconciliation" table
    #And I select the "Stop" radio in the row with the text "BD PosiFlush Normal Saline injection syringe (sodium chloride 0.9 %) 10ML inj PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Decadron 4 MG Tab tab (dexamethasone) 2MG oral Q6H" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "zz Simethicone Sam Kit (zz Mylicon 80 Mg Tab Sam Kit) 160MG oral QID PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Enoxaparin Inj (Lovenox Inj) 40MG subQ Q24H" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Change" button
    And I select "PBMF PLANX" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I select "PBMF PLANABX" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I select "CERT PBM-B PLANA4" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I select "PBMF PLANX" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I click the "Change Plan Cancel" button
    And I select the "Lovenox 40 mg/0.4 mL subcutaneous syringe" link in the row with the text "Lovenox 40 mg/0.4 mL subcutaneous syringe" in the "Select Medication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "labetalol tablet 200MG oral TID" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "clonazePAM Tab (KlonoPIN Tab) 1MG oral TID" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "LORazepam Tab (SHORTAGE) (Ativan Tab (SHORTAGE)) 1MG oral Q4H PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Trandate 100 MG Inj soln 5 mg/mL (labetalol) 20MG IV ONCE PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Ondansetron ODT Tab (Zofran ODT Tab) 4MG oral Q4H PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Polyethylene Glycol Powder (Miralax Powder) 17GM oral DAILY" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Change" button
    And I select "PBMF PLANX" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I select "PBMF PLANABX" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I select "CERT PBM-B PLANA4" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I click the "Change Plan Cancel" button
    And I select the "Miralax 17 gram oral powder packet" link in the row with the text "Miralax 17 gram oral powder packet" in the "Select Medication" table if it exists
    Then I click the "Other Pharmacy" icon
    And I click the "Phone Orders" element
    And I enter "(703) 205-7034" in the "Phone Number Search" field
    And I click the "Search Pharmacy Phone" button
    And I click the "+Icon" element in the row with text "VA Pharmacy 10.6MU" in the "Pharmacy Phone Order Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Reconcile and Submit" button
    Then I sign and submit the order with default password
    And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane



  @Performance @eRxPerformance @MedRecPerformance @OneWindow_Performance @OneWindow_eRxPerformance @OneWindow_MedRecPerformance
  Scenario: DMR/eRX tests for for WAYNE, BRUCE
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "erxtest" from the "Patient List" menu
    #Given "WAYNE, BRUCE", admitted in the past "201" days, is on the patient list
    When I select patient "WAYNE, BRUCE" from the patient list
    And I select "Home Meds" from clinical navigation
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
#HomeMeds
    And I select the "Stop" radio in the row with the text "BACTRIMSSTAB 0.5EA oral DAILY X 90 days" from the "Medication Reconciliation" table
    #And I select the "Continue" radio in the row with the text "Bayer Aspirin tablet (aspirin) 325MG oral DAILY X 90 days" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Mycophenolate Mofetil Tab (Cellcept Tab) 1000MG oral BID@1000,2200 X 90 days" in the "Medication Reconciliation" table
    And I select "CellCept 250 MG Cap cap (mycophenolate mofetil)  250 MG oral Q12H" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "CellCept 250 mg capsule" link in the row with the text "CellCept 250 mg capsule" in the "Select Medication" table if it exists
    Then I click the "Default Pharmacy" icon
    And I enter "22201" in the "Near By" field
    And I click the "Search Addr" button
    And I click the "+Icon" element in the row with text "Test 000 Pharmacy 10.6MU" in the "Pharmacy Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Tamsulosin Cap (Flomax Cap) 0.4MG oral BID X 90 days" from the "Medication Reconciliation" table
    #And I uncheck the "Rx Needed" checkbox
    #And I check the "Rx Needed" checkbox
    #And I click the "tamsulosin 0.4 mg capsule" link if it exists in the "EditOrderErx" pane
    #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "LASIX40MGTAB 40MG oral DAILY X 90 days" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Multi-Day tablet (multivitamin) 1EA oral DAILY X 90 days" from the "Medication Reconciliation" table
    #JWP - this appears to be missing now
	#And I select the "Continue" radio in the row with the text "Clotrimazole Troche (Mycelex Troche) 10MG oral PCHS X 30 days" from the "Medication Reconciliation" table
    #And I select "Mycelex 10 MG Troche troc (clotrimazole)  10 MG oral 5XDAY" from the "Searched Combined Med Orders" list in the search results
    #And I uncheck the "Rx Needed" checkbox
    #And I check the "Rx Needed" checkbox
    #And I click the "clotrimazole 10 mg troche" link if it exists in the "EditOrderErx" pane
    #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "omeprazole tablet,delayed release 20MG oral DAILY X 90 days" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "PERCOCET5-325MGTA 0TAB oral Q4H PRN pain (1-2TABLETS)" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Prednisone 5 MG Tab tab (prednisone) 15MG oral BID X 90 days" from the "Medication Reconciliation" table
    #And I uncheck the "Rx Needed" checkbox
    #And I check the "Rx Needed" checkbox
    #And I click the "prednisone 5 mg tablet" link if it exists in the "EditOrderErx" pane
    #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "PROGRAF1MGCAP 1MG oral BID X 90 days" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Calcitriol Cap (Rocaltrol Cap) 0.5MCG oral BID X 90 days" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "TUMSCHEWTAB 500MG oral TIDMEALS X 90 days" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Acyclovir Tab (Zovirax Tab) 400MG oral BID" in the "Medication Reconciliation" table
    And I select "acyclovir tablet  400MG oral" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "acyclovir 400 mg tablet" link in the row with the text "acyclovir 400 mg tablet" in the "Select Medication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
#HospitalMeds
    And I select the "Continue" radio in the row with the text "Amantadine Cap (Symmetrel Cap) 100MG oral QOTHERDAY" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "amantadine HCl 100 mg capsule" link in the row with the text "amantadine HCl 100 mg capsule" in the "Select Medication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "NaCl Pres Free Inj (Sodium Chlor Pres Free Inj) 10ML IV PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "NaCl Pres Free Inj (Sodium Chlor Pres Free Inj) 10ML IV Q12H" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "bisacodyl tablet,delayed release 5-10 MG oral DAILY PRN" from the "Medication Reconciliation" table
    #And I select the "Stop" radio in the row with the text "clotrimazole troche 10MG MM PC HS" from the "Medication Reconciliation" table
    And I select the "Stop" link in the row with the text "zz Docusate Cap (zz Colace Cap SAM Kit) 100MG oral BID" in the "Medication Reconciliation" table
    #And I select "Colace liqd 50 mg/5 mL (docusate sodium)  100 MG oral DAILY" from the "Searched Combined Med Orders" list in the search results
    #And I uncheck the "Rx Needed" checkbox
    #And I check the "Rx Needed" checkbox
    #And I click the "Docu 50 mg/5 mL oral liquid" link if it exists in the "EditOrderErx" pane
    #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    #And I select the "Continue" radio in the row with the text "furosemide tablet 40MG oral DAILY" from the "Medication Reconciliation" table
    #And I uncheck the "Rx Needed" checkbox
    #And I check the "Rx Needed" checkbox
    #And I click the "furosemide 40 mg tablet" link if it exists in the "EditOrderErx" pane
    #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Tacrolimus Anhydrous Cap (Prograf Cap) 1MG oral BID" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "Prograf 1 mg capsule" link in the row with the text "Prograf 1 mg capsule" in the "Select Medication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "sulfamethoxazole 400 mg-trimethoprim 80 mg tablet 0.5EA oral DAILY" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Calcium Carb Chew Tab (Tums Chew Tab) 500MG oral Q4H PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Calcium Carb Chew Tab (Tums Chew Tab) 500MG oral TID MEALS" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "Tums 200 mg calcium (500 mg) chewable tablet" link in the row with the text "Tums 200 mg calcium (500 mg) chewable tablet" in the "Select Medication" table if it exists
    #And I select "otherPharmacy" from the "Other Pharmacy" radio list
    #And I click the "Phone Orders" element
    #And I enter "(703) 205-7034" in the "Phone Number Search" field
    #And I click the "Search Pharmacy Phone" button
    #And I select "VA Pharmacy 10.6MU" in the "Pharmacy Phone Order Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Reconcile and Submit" button
    Then I sign and submit the order with default password
    And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane


  @Performance @eRxPerformance @MedRecPerformance @OneWindow_Performance @OneWindow_eRxPerformance @OneWindow_MedRecPerformance
  Scenario: DMR/eRX tests for WILSON, JOSEF
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "erxtest" from the "Patient List" menu
    #Given "WILSON, JOSEF", admitted in the past "201" days, is on the patient list
    When I select patient "WILSON, JOSEF" from the patient list
    And I select "Home Meds" from clinical navigation
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
#HomeMeds
    And I select the "Continue" radio in the row with the text "Flexeril 10 MG Tab tab (cyclobenzaprine) 5MG oral BEDTIME" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "cyclobenzaprine 10 mg tablet" link in the row with the text "cyclobenzaprine 10 mg tablet" in the "Select Medication" table if it exists
    Then I click the "Default Pharmacy" icon
    And I enter "22201" in the "Near By" field
    And I click the "Search Addr" button
    And I click the "+Icon" element in the row with text "Test 000 Pharmacy 10.6MU" in the "Pharmacy Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "Levemir FlexTouch 100 unit/mL (3 mL) subcutaneous insulin pen (insulin detemir) 10UNIT subQ BID" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Neurontin capsule (gabapentin) 400MG oral TID" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Omeprazole Cap (NF) PED (PriLOSEC Cap (NF) PED) 40MG oral BID" in the "Medication Reconciliation" table
    And I select "Zegerid 20 MG Capsule cap (omeprazole-sodium bicarbonate)  20 MG oral DAILY" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Zegerid 20 mg-1.1 gram capsule" link if it exists in the "EditOrderErx" pane
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Lisinopril Tab (Prinivil Tab) 5MG oral DAILY" from the "Medication Reconciliation" table
 #And I select "Prinivil/zestril 10 MG Tab tab (lisinopril)  10MG oral BID" from the "Searched Combined Med Orders" list in the search results
    #And I uncheck the "Rx Needed" checkbox
    #And I check the "Rx Needed" checkbox
    #And I click the "lisinopril 10 mg tablet" link if it exists in the "EditOrderErx" pane
    #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "Stress Formula tablet (multivitamin, stress formula) 1TAB oral DAILY" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Naloxone Inj (Narcan Inj) 0.1MG IV PACU Q2MIN PRN" in the "Medication Reconciliation" table
    And I select "Naloxone Hcl syrg 1 mg/mL (naloxone)  inj" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "naloxone 1 mg/mL injection syringe" link in the row with the text "naloxone 1 mg/mL injection syringe" in the "Select Medication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
#HospitalMeds
    And I select the "Continue" radio in the row with the text "Multivitamin Tab (Theragran Tab) 1EA oral DAILY" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "Thera 400 mcg tablet" link in the row with the text "Thera 400 mcg tablet" in the "Select Medication" table if it exists
    Then I click the "Other Pharmacy" icon
    And I click the "Phone Orders" element
    And I enter "(703) 205-7034" in the "Phone Number Search" field
    And I click the "Search Pharmacy Phone" button
    And I click the "+Icon" element in the row with text "VA Pharmacy 10.6MU" in the "Pharmacy Phone Order Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "Thiamine Tab (Vitamin B-1 Tab) 100MG oral DAILY" from the "Medication Reconciliation" table
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Reconcile and Submit" button
    Then I sign and submit the order with default password
    And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane



  @Performance @eRxPerformance @MedRecPerformance @OneWindow_Performance @OneWindow_eRxPerformance @OneWindow_MedRecPerformance
  Scenario: DMR/eRX tests for DOCKENDORF, TAD A
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "erxtest" from the "Patient List" menu
    #Given "DOCKENDORF, TAD A", admitted in the past "201" days, is on the patient list
    When I select patient "DOCKENDORF, TAD A" from the patient list
    And I select "Home Meds" from clinical navigation
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
#HomeMeds
    And I select the "Stop" radio in the row with the text "Milk of Magnesia 400 mg/5 mL oral suspension (magnesium hydroxide) 15ML oral DAILY PRN constipation" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "ondansetron HCl (PF) 4 mg/2 mL injection solution 4MG IV Q6H PRN" in the "Medication Reconciliation" table
    And I select "ondansetron HCl tablet  4MG oral" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Change" button
    And I select "CERT PBM-A PLANA5" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I select "CERT PBM-C" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I select "CERT PBM-B PLANZ" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I click the "Change Plan Cancel" button
    And I select the "ondansetron HCl 4 mg tablet" link in the row with the text "ondansetron HCl 4 mg tablet" in the "Select Medication" table if it exists
    Then I click the "Default Pharmacy" icon
    And I enter "22201" in the "Near By" field
    And I click the "Search Addr" button
    And I click the "+Icon" element in the row with text "Test 000 Pharmacy 10.6MU" in the "Pharmacy Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "Polyethylene Glycol Powder (Miralax Powder) 17GM oral DAILY X 30 days" from the "Medication Reconciliation" table
    #And I select "polyethylene glycol 1000 powder  misc" from the "Searched Combined Med Orders" list in the search results
    #And I uncheck the "Rx Needed" checkbox
    #And I check the "Rx Needed" checkbox
    #And I click the "polyethylene glycol 1000 (bulk) powder" link if it exists in the "EditOrderErx" pane
    #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
#HospitalMeds
    And I select the "Change" link in the row with the text "Bisacodyl Supp (Dulcolax Supp) 10MG rect DAILY" in the "Medication Reconciliation" table
    And I select "Dulcolax (bisacodyl) rectal suppository (bisacodyl)  10 MG rect DAILY" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Change" button
    And I select "CERT PBM-A PLANA5" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I select "CERT PBM-C" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I select "CERT PBM-B PLANZ" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I click the "Change Plan Cancel" button
    And I select the "Dulcolax (bisacodyl) 10 mg rectal suppository" link in the row with the text "Dulcolax (bisacodyl) 10 mg rectal suppository" in the "Select Medication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "Diazepam Inj (Valium Inj) 2.5MG IV BEDTIME PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "HYDROmorphone Inj (Dilaudid Inj) 0.5MG IV Q2H PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "HYDROmorphone Inj (Dilaudid Inj) 0.5MG IV Q30M PRN" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "levETIRAcetam Inj PED (Keppra Inj PED) 500MG IV Q12HR" in the "Medication Reconciliation" table
    And I select "Keppra soln 100 mg/mL (levetiracetam)  500MG oral BID" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Change" button
    And I select "CERT PBM-A PLANA5" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I select "CERT PBM-C" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I select "CERT PBM-B PLANZ" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I click the "Change Plan Cancel" button
    And I select the "Keppra 100 mg/mL oral solution" link in the row with the text "Keppra 100 mg/mL oral solution" in the "Select Medication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Change" link in the row with the text "clonazePAM Tab (KlonoPIN Tab) 2MG oral BEDTIME PRN" in the "Medication Reconciliation" table
    #And I select the "Change" link in the row with the text "Lipitor 40 MG Tab tab (atorvastatin) 40MG oral DAILY@2000" in the "Medication Reconciliation" table
    And I select "Klonopin 2 MG Tab tab (clonazepam)  2 MG oral BEDTIME" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Change" button
    And I select "CERT PBM-A PLANA5" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I select "CERT PBM-C" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I select "CERT PBM-B PLANZ" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I click the "Change Plan Cancel" button
    And I select the "Klonopin 2 mg tablet" link in the row with the text "Klonopin 2 mg tablet" in the "Select Medication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "Magnesium Sulfate Inj PED see admin criteria IV ASDIR" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Gabapentin Cap (Neurontin Cap) 900MG oral TID" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Change" button
    And I select "CERT PBM-A PLANA5" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I select "CERT PBM-C" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I select "CERT PBM-B PLANZ" from the "Change Prescription Plan" dropdown
    And I wait "1" seconds
    And I click the "Change Plan Cancel" button
    And I select the "Neurontin 300 mg capsule" link in the row with the text "Neurontin 300 mg capsule" in the "Select Medication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    #And I select the "Continue" radio in the row with the text "Nitroglycerin 2% Top Oint Pkt oint (nitroglycerin) 1APPLIC top DAILY@00" from the "Medication Reconciliation" table
    #And I uncheck the "Rx Needed" checkbox
    #And I check the "Rx Needed" checkbox
    #And I select "PBMA PLANA5" from the "Change Prescription Plan" dropdown
    #And I wait "1" seconds
    #And I select "PBMC" from the "Change Prescription Plan" dropdown
    #And I wait "1" seconds
    #And I select "PBMB PLANZ" from the "Change Prescription Plan" dropdown
    #And I wait "1" seconds
    #And I click the "Nitro-Bid 2 % transdermal ointment" link if it exists in the "EditOrderErx" pane
    #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    #And I select the "Stop" radio in the row with the text "Nitroglycerin 2% Top Oint Pkt oint (nitroglycerin) 1APPLIC top Q6H PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "oxyCODONE IR Tab (Roxicodone IR Tab) 5MG oral Q4H PRN" from the "Medication Reconciliation" table
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Reconcile and Submit" button
    Then I sign and submit the order with default password
    And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane



  @Performance @eRxPerformance @MedRecPerformance @OneWindow_Performance @OneWindow_eRxPerformance @OneWindow_MedRecPerformance
  Scenario: DMR/eRX tests for JOCKEY, FRED A
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "erxtest" from the "Patient List" menu
    #Given "JOCKEY, FRED A", admitted in the past "201" days, is on the patient list
    When I select patient "JOCKEY, FRED A" from the patient list
    And I select "Home Meds" from clinical navigation
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
#HomeMeds
    And I select the "Change" link in the row with the text "CeleBREX capsule (celecoxib) 200MG oral BID" in the "Medication Reconciliation" table
    And I select "CeleBREX capsule (celecoxib)  200 MG oral DAILY" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "Celebrex 200 mg capsule" link in the row with the text "Celebrex 200 mg capsule" in the "Select Medication" table if it exists
    Then I click the "Default Pharmacy" icon
    And I enter "22201" in the "Near By" field
    And I click the "Search Addr" button
    And I click the "+Icon" element in the row with text "Test 000 Pharmacy 10.6MU" in the "Pharmacy Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Ecotrin tablet,delayed release (aspirin) 325MG oral BID" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "Ecotrin 325 mg tablet,enteric coated" link in the row with the text "Ecotrin 325 mg tablet,enteric coated" in the "Select Medication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "Ondansetron ODT Tab (Zofran ODT Tab) 4MG oral Q4H PRN nausea/vomiting(use1st)" from the "Medication Reconciliation" table
    #And I select the "Change" link in the row with the text "Zofran ODT TbDL (ondansetron) 4MG oral Q4H PRN nausea/vomiting(use1st)" in the "Medication Reconciliation" table
    #And I select "Zofran 40 MG Vial soln 2 mg/mL (ondansetron HCl)  4 MG oral Q8H" from the "Searched Combined Med Orders" list in the search results
    #And I uncheck the "Rx Needed" checkbox
    #And I check the "Rx Needed" checkbox
    #And I click the "Zofran 2 mg/mL intravenous solution" link if it exists in the "EditOrderErx" pane
    #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
#HospitalMeds
    And I select the "Stop" radio in the row with the text "Zolpidem Tab (Ambien Tab) 5MG oral BEDTIME PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Bisacodyl Supp (Dulcolax Supp) 10MG rect Q12H PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Lactobacillus Rhamnosus Cap (Culturelle Cap) 1EACH oral BID" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Flexeril 10 MG Tab tab (cyclobenzaprine) 5MG oral TID PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "diazepam tablet 5-10 MG oral Q6H PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "diphenhydrAMINE Inj (Benadryl Inj) 12.5 - 25 MG IV Q6H PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Ferrous Sulfate Tab 325MG oral BID" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "Feosol 325 mg (65 mg iron) tablet" link in the row with the text "Feosol 325 mg (65 mg iron) tablet" in the "Select Medication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "HYDROmorphone Tab (Dilaudid Tab) 2-4 MG oral Q4H PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Prochlorperazine Inj (Compazine Inj) 5-10 MG IV Q4H PRN" from the "Medication Reconciliation" table
   # And I select the "Stop" radio in the row with the text "Sod CL 0.9% IV Soln 100 ML solp (sodium chloride 0.9 %) 1000ML IV .Q10H" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Cepacol Sugar Free Lozenge 1EA MM PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Multivitamin Tab (Theragran Tab) 1EA oral DAILY" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "Thera 400 mcg tablet" link in the row with the text "Thera 400 mcg tablet" in the "Select Medication" table if it exists
    Then I click the "Other Pharmacy" icon
    And I click the "Phone Orders" element
    And I enter "(703) 205-7034" in the "Phone Number Search" field
    And I click the "Search Pharmacy Phone" button
    And I click the "+Icon" element in the row with text "VA Pharmacy 10.6MU" in the "Pharmacy Phone Order Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "traMADol tablet 50-100 MG oral Q6H PRN" from the "Medication Reconciliation" table
    #And I select the "Stop" radio in the row with the text "Vitamin C tablet (ascorbic acid) 500MG oral BID" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Vitamin E Cap 400IU oral DAILY" from the "Medication Reconciliation" table
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Reconcile and Submit" button
    Then I sign and submit the order with default password
    And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane



  @Performance @eRxPerformance @MedRecPerformance @OneWindow_Performance @OneWindow_eRxPerformance @OneWindow_MedRecPerformance
  Scenario: DMR/eRX tests for CROSS, DAVID M
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "erxtest" from the "Patient List" menu
    #Given "CROSS, DAVID M", admitted in the past "201" days, is on the patient list
    When I select patient "CROSS, DAVID M" from the patient list
    And I select "Home Meds" from clinical navigation
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
#HomeMeds
    And I select the "Stop" radio in the row with the text "LORazepam Tab (Ativan Tab) 0.5MG oral Q4H PRN" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Carvedilol Tab (Coreg Tab) 3.125MG oral BID" in the "Medication Reconciliation" table
    And I select "Coreg 12.5 MG Tab tab (carvedilol)  12.5 MG oral BID" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "Coreg 12.5 mg tablet" link in the row with the text "Coreg 12.5 mg tablet" in the "Select Medication" table if it exists
    Then I click the "Default Pharmacy" icon
    And I enter "22201" in the "Near By" field
    And I click the "Search Addr" button
    And I click the "+Icon" element in the row with text "Test 000 Pharmacy 10.6MU" in the "Pharmacy Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Change" link in the row with the text "lisinopril tablet 2.5MG oral DAILY" in the "Medication Reconciliation" table
    And I select "lisinopril tablet  20 MG oral Q12H" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "lisinopril 20 mg tablet" link in the row with the text "lisinopril 20 mg tablet" in the "Select Medication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "Ondansetron ODT Tab (Zofran ODT Tab) 8MG oral Q8H PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Acyclovir Tab (Zovirax Tab) 800MG oral BID" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "Zovirax 800 mg tablet" link in the row with the text "Zovirax 800 mg tablet" in the "Select Medication" table if it exists
    Then I click the "Other Pharmacy" icon
    And I click the "Phone Orders" element
    And I enter "(703) 205-7034" in the "Phone Number Search" field
    And I click the "Search Pharmacy Phone" button
    And I click the "+Icon" element in the row with text "VA Pharmacy 10.6MU" in the "Pharmacy Phone Order Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
#HospitalMeds
    And I select the "Stop" radio in the row with the text "Zolpidem Tab (Ambien Tab) 5MG oral BEDTIME PRN" from the "Medication Reconciliation" table
    And I select the "Stop" link in the row with the text "Aztreonam Inj (Azactam Inj) 2GM IV Q8H PRN" in the "Medication Reconciliation" table
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Reconcile and Submit" button
    Then I sign and submit the order with default password
    And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane

  @Performance @eRxPerformance @MedRecPerformance @OneWindow_Performance @OneWindow_eRxPerformance @OneWindow_MedRecPerformance
  Scenario: DMR/eRX tests for KYLE, SELENA R
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "erxtest" from the "Patient List" menu
    #Given "KYLE, SELENA R", admitted in the past "201" days, is on the patient list
    When I select patient "KYLE, SELENA R" from the patient list
    And I select "Home Meds" from clinical navigation
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
    And I select the "Continue" radio in the row with the text "APAP/Caffeine/Butalbital Tab (Fioricet Tab) 1EA oral Q6-8H PRN headache" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "Esgic 50 mg-325 mg-40 mg tablet" link in the row with the text "Esgic 50 mg-325 mg-40 mg tablet" in the "Select Medication" table if it exists
    Then I click the "Default Pharmacy" icon
    And I enter "77001" in the "Near By" field
    And I click the "Search Addr" button
    And I enter "T" in the "Refine Near By" field
    And I click the "Search Addr" button
    And I click the "+Icon" element in the row with text "TX Pharmacy 10.6MU" in the "Pharmacy Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Change" link in the row with the text "Diflucan tablet (fluconazole) 150MG oral ONCE (takedoseon5/30if)" in the "Medication Reconciliation" table
    And I select "Diflucan tablet (fluconazole)  50 MG oral DAILY" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "Diflucan 50 mg tablet" link in the row with the text "Diflucan 50 mg tablet" in the "Select Medication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Change" link in the row with the text "buPROPion HCl tablet 100MG oral DAILY" in the "Medication Reconciliation" table
    And I select "buPROPion HCl tablet  75MG oral" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "bupropion HCl 75 mg tablet" link in the row with the text "bupropion HCl 75 mg tablet" in the "Select Medication" table if it exists
    Then I click the "Other Pharmacy" icon
    And I click the "Mail Orders" element
    And I enter "M" in the "Mail Order Search" field
    And I click the "Search Pharmacy Mail" button
    And I click the "+Icon" element in the row with text "A247PC00-Anesthesia 24/7, PC" in the "Pharmacy Mail Order Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Change" link in the row with the text "Diazepam Tab (Valium Tab) 5 mg 1TAB oral Q6H PRN severemusclespasms" in the "Medication Reconciliation" table
    And I select "diazepam tablet  5 MG oral BID" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "diazepam 5 mg tablet" link in the row with the text "diazepam 5 mg tablet" in the "Select Medication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "Sod CL 0.9% 1000ml IV Soln solp (sodium chloride 0.9 %) 1000ML IV .Q13H20M" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Enoxaparin Inj (Lovenox Inj) 40MG subQ Q24H" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "B-12 DOTS tablet (cyanocobalamin (vitamin B-12)) oral DAILY" in the "Medication Reconciliation" table
    And I select "B-12 DOTS tablet (cyanocobalamin (vitamin B-12))  500MCG oral" from the "Searched Combined Med Orders" list in the search results
    And I click the "Yes" button in the "Question" pane if it exists
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "B-12 DOTS 500 mcg tablet" link in the row with the text "B-12 DOTS 500 mcg tablet" in the "Select Medication" table if it exists
    And I click the "Yes" button in the "Question" pane if it exists
    Then I click the "Default Pharmacy" icon
    And I enter "22201" in the "Near By" field
    And I click the "Search Addr" button
    And I click the "+Icon" element in the row with text "Test 000 Pharmacy 10.6MU" in the "Pharmacy Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Change" link in the row with the text "Sertraline Tab (Zoloft Tab) 200MG oral DAILY" in the "Medication Reconciliation" table
    And I select "sertraline tablet  100MG oral" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "sertraline 100 mg tablet" link in the row with the text "sertraline 100 mg tablet" in the "Select Medication" table if it exists
    Then I click the "Other Pharmacy" icon
    And I click the "Phone Orders" element
    And I enter "(703) 205-7034" in the "Phone Number Search" field
    And I click the "Search Pharmacy Phone" button
    And I click the "+Icon" element in the row with text "VA Pharmacy 10.6MU" in the "Pharmacy Phone Order Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    #And I select the "Stop" radio in the row with the text "Nystatin crea 100,000 unit/gram 1APPLIC top BID" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "oxyCODONE IR Tab (Roxicodone IR Tab) 5-15 mg oral Q6H PRN" in the "Medication Reconciliation" table
    And I select "oxyCODONE capsule  5MG oral" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "oxycodone 5 mg capsule" link in the row with the text "oxycodone 5 mg capsule" in the "Select Medication" table if it exists
    #And I select "otherPharmacy" from the "Other Pharmacy" radio list
    #And I click the "Phone Orders" element
    #And I enter "(703) 205-7034" in the "Phone Number Search" field
    #And I click the "Search Pharmacy Phone" button
    #And I select "VA Pharmacy 10.6MU" in the "Pharmacy Phone Order Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
#HospitalMeds
    And I select the "Stop" radio in the row with the text "Calcium Carb/Vit D 500/200 Tab (OsCal + Vit D 500/200 Tab) 1500MG oral DAILY" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Change" link in the row with the text "Senna Tab (Senokot Tab) 2EA oral BEDTIME PRN" in the "Medication Reconciliation" table
    And I select "Senno tablet (sennosides)  8.6MG oral" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I select the "Senno 8.6 mg tablet" link in the row with the text "Senno 8.6 mg tablet" in the "Select Medication" table if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "diphenhydrAMINE capsule 25MG oral Q4H PRN" from the "Medication Reconciliation" table
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Reconcile and Submit" button
    Then I sign and submit the order with default password
    And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane

  #DOES NOT RUN
  #DOES NOT RUN
  #DOES NOT RUN
  @donotrun @eRxPerformance
  Scenario: DMR/eRX tests for FLOUNDERS, FELICIA A
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "erxtest" from the "Patient List" menu
    #Given "FLOUNDERS, FELICIA A", admitted in the past "201" days, is on the patient list
    When I select patient "FLOUNDERS, FELICIA A" from the patient list
    And I select "Home Meds" from clinical navigation
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
#HomeMeds
    And I select the "Stop" radio in the row with the text "Ativan tablet (lorazepam) 0.5MG oral Q4H PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Compazine 5 MG Tab tab (prochlorperazine maleate) 10MG oral Q6-8H PRN nausea-use1st" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    Then I click the "Other Pharmacy" icon
    And I enter "77001" in the "Near By" field
    And I click the "Search Addr" button
    And I click the "+Icon" element in the row with text "TX Pharmacy 10.6MU" in the "Pharmacy Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "prochlorperazine Edisylate 10 mg/2 mL (5 mg/mL) injection solution 5MG inj Q6H PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "heparin, porcine (PF) 10 unit/mL intravenous syringe 30UNITS IV NotSpecified X 30 days PRN eachlumendaily/afteruse" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    Then I click the "Default Pharmacy" icon
    And I enter "22201" in the "Near By" field
    And I click the "Search Addr" button
    And I click the "+Icon" element in the row with text "VA Pharmacy 10.6MU" in the "Pharmacy Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "loperamide capsule 2MG oral Q4H WA" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Kytril 1 MG Tab tab (granisetron HCl) 1MG oral Q12H PRN nausea-use2nd" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Nicoderm 14 MG Top Patch pt24 (nicotine) 1PATCH top DAILY" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Protonix tablet,delayed release (pantoprazole) 40MG oral AC BK" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "PROGRAF 0.3MG oral BID X 30 days (GVHDPROPHYLAXIS)" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Rapamune tablet (sirolimus) NEW GOAL 5/20 PER DR.GREGORY oral ASDIR" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Zofran Odt tab (ondansetron HCl) 8MG oral Q8H PRN n/vuse1st" in the "Medication Reconciliation" table
    And I select "Zofran ODT TbDL (ondansetron)  1MG oral X1ED" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
#HospitalMeds
    And I select the "Continue" radio in the row with the text "Actigall capsule (ursodiol) 300MG oral BID" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Change" link in the row with the text "CeleXA tablet (citalopram) 20MG oral DAILY" in the "Medication Reconciliation" table
    And I select "CeleXA tablet (citalopram)  30 MG oral DAILY" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "CellCept tablet (mycophenolate mofetil) 1000MG oral TID" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "CellCept capsule (mycophenolate mofetil) 250MG oral TID" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Levaquin tablet (levofloxacin) 500MG oral BEDTIME" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Noxafil tablet,delayed release (posaconazole) 300MG oral DAILY@12" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Prograf capsule (tacrolimus) 0.3MG oral BID" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Valtrex tablet (valacyclovir) 500MG oral BID" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists

    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Reconcile and Submit" button
    And I click the "Search" button
    Then I select "the first item" in the "Look Up" table
    And I click the "Look Up OK" button
    And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane

  @donotrun @eRxPerformance
  Scenario: DMR/eRX tests for SWIFT, JONATHAN
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "erxtest" from the "Patient List" menu
    #Given "SWIFT, JONATHAN", admitted in the past "201" days, is on the patient list
    When I select patient "SWIFT, JONATHAN" from the patient list
    And I select "Home Meds" from clinical navigation
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
#HomeMeds
    And I select the "Stop" radio in the row with the text "Ativan tablet (lorazepam) 0.5MG oral Q4H PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Compazine 5 MG Tab tab (prochlorperazine maleate) 10MG oral Q6-8H PRN nausea-use1st" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    Then I click the "Other Pharmacy" icon
    And I click the "Phone Orders" element
    And I enter "(703) 205-7034" in the "Phone Number Search" field
    And I click the "Search Pharmacy Phone" button
    And I click the "+Icon" element in the row with text "VA Pharmacy 10.6MU" in the "Pharmacy Phone Order Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "prochlorperazine Edisylate 10 mg/2 mL (5 mg/mL) injection solution 5MG inj Q6H PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "heparin, porcine (PF) 10 unit/mL intravenous syringe 30UNITS IV NotSpecified X 30 days PRN eachlumendaily/afteruse" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    Then I click the "Default Pharmacy" icon
    And I enter "77001" in the "Near By" field
    And I click the "Search Addr" button
    And I click the "+Icon" element in the row with text "TX Pharmacy 10.6MU" in the "Pharmacy Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "loperamide capsule 2MG oral Q4H WA" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Kytril 1 MG Tab tab (granisetron HCl) 1MG oral Q12H PRN nausea-use2nd" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Nicoderm 14 MG Top Patch pt24 (nicotine) 1PATCH top DAILY" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Protonix tablet,delayed release (pantoprazole) 40MG oral AC BK" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "PROGRAF 0.3MG oral BID X 30 days (GVHDPROPHYLAXIS)" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Rapamune tablet (sirolimus) NEW GOAL 5/20 PER DR.GREGORY oral ASDIR" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Zofran Odt tab (ondansetron HCl) 8MG oral Q8H PRN n/vuse1st" in the "Medication Reconciliation" table
    And I select "Zofran ODT TbDL (ondansetron)  1MG oral X1ED" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
#HospitalMeds
    And I select the "Continue" radio in the row with the text "Actigall capsule (ursodiol) 300MG oral BID" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Change" link in the row with the text "CeleXA tablet (citalopram) 20MG oral DAILY" in the "Medication Reconciliation" table
    And I select "CeleXA tablet (citalopram)  30 MG oral DAILY" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "CellCept tablet (mycophenolate mofetil) 1000MG oral TID" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "CellCept capsule (mycophenolate mofetil) 250MG oral TID" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Levaquin tablet (levofloxacin) 500MG oral BEDTIME" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Noxafil tablet,delayed release (posaconazole) 300MG oral DAILY@12" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Prograf capsule (tacrolimus) 0.3MG oral BID" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Valtrex tablet (valacyclovir) 500MG oral BID" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    #And I click the "Reconcile and Submit" button
    And I click the "Search" button
    Then I select "the first item" in the "Look Up" table
    And I click the "Look Up OK" button
    And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane

  @donotrun @eRxPerformance
  Scenario: DMR/eRX tests for AUBAINE, CHENIN BLANC
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "erxtest" from the "Patient List" menu
    #Given "AUBAINE, CHENIN BLANC", admitted in the past "201" days, is on the patient list
    When I select patient "AUBAINE, CHENIN BLANC" from the patient list
    And I select "Home Meds" from clinical navigation
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
#HomeMeds
    And I select the "Stop" radio in the row with the text "Ativan tablet (lorazepam) 0.5MG oral Q4H PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Compazine 5 MG Tab tab (prochlorperazine maleate) 10MG oral Q6-8H PRN nausea-use1st" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    Then I click the "Other Pharmacy" icon
    And I click the "Mail Orders" element
    And I enter "M" in the "Mail Order Search" field
    And I click the "Search Pharmacy Mail" button
    And I click the "+Icon" element in the row with text "Mail Order Pharmacy 10.6MU" in the "Pharmacy Mail Order Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "prochlorperazine Edisylate 10 mg/2 mL (5 mg/mL) injection solution 5MG inj Q6H PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "heparin, porcine (PF) 10 unit/mL intravenous syringe 30UNITS IV NotSpecified X 30 days PRN eachlumendaily/afteruse" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    Then I click the "Default Pharmacy" icon
    And I enter "22201" in the "Near By" field
    And I click the "Search Addr" button
    And I click the "+Icon" element in the row with text "VA Pharmacy 10.6MU" in the "Pharmacy Search Results" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "loperamide capsule 2MG oral Q4H WA" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Kytril 1 MG Tab tab (granisetron HCl) 1MG oral Q12H PRN nausea-use2nd" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Nicoderm 14 MG Top Patch pt24 (nicotine) 1PATCH top DAILY" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Protonix tablet,delayed release (pantoprazole) 40MG oral AC BK" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "PROGRAF 0.3MG oral BID X 30 days (GVHDPROPHYLAXIS)" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Rapamune tablet (sirolimus) NEW GOAL 5/20 PER DR.GREGORY oral ASDIR" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Zofran Odt tab (ondansetron HCl) 8MG oral Q8H PRN n/vuse1st" in the "Medication Reconciliation" table
    And I select "Zofran ODT TbDL (ondansetron)  1MG oral X1ED" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
#HospitalMeds
    And I select the "Continue" radio in the row with the text "Actigall capsule (ursodiol) 300MG oral BID" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Change" link in the row with the text "CeleXA tablet (citalopram) 20MG oral DAILY" in the "Medication Reconciliation" table
    And I select "CeleXA tablet (citalopram)  30 MG oral DAILY" from the "Searched Combined Med Orders" list in the search results
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "CellCept tablet (mycophenolate mofetil) 1000MG oral TID" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "CellCept capsule (mycophenolate mofetil) 250MG oral TID" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Levaquin tablet (levofloxacin) 500MG oral BEDTIME" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Noxafil tablet,delayed release (posaconazole) 300MG oral DAILY@12" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Prograf capsule (tacrolimus) 0.3MG oral BID" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Valtrex tablet (valacyclovir) 500MG oral BID" from the "Medication Reconciliation" table
    And I click the "Rx Needed" element
    And I click the "Rx Needed" element
    And I click the "Order Details" element if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    #And I click the "Reconcile and Submit" button
    And I click the "Search" button
    Then I select "the first item" in the "Look Up" table
    And I click the "Look Up OK" button
    And I click the "Prescriptions Reconcile Submit" button in the "Review Prescriptions Contents" pane

