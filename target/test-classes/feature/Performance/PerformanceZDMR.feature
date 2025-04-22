@Performance @OneWindow_Performance
Feature: Performance Discharge MedRec test

  @Performance @DMRPerformance @MedRecPerformance @OneWindow_Performance @OneWindow_DMRPerformance @OneWindow_MedRecPerformance
  Scenario: Resolve DMR for MedRec9
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "PATIENT9, MEDREC", admitted in the past "201" days, is on the patient list
    When I select patient "PATIENT9, MEDREC" from the patient list
    And I click the "Logo" element
    And I select "Home Meds" from clinical navigation
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
    Then the "Discharge Medication Reconciliation" pane should load
#HomeMeds
    And I select the "Continue" radio in the row with the text "Allergy Relief (diphenhydrAMINE) capsule (diphenhydramine HCl) 25MG oral BEDTIME" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "New Edit Medication Order" pane if it exists
    #And I select the "Stop" radio in the row with the text "diphenhydrAMINE capsule 25MG oral BEDTIME" from the "Medication Reconciliation" table
    #And I select the "Stop" radio in the row with the text "promethazine tablet 25MG oral Q6H PRN" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Prenatal Vitamin Tab 1TAB oral DAILY" in the "Medication Reconciliation" table
    And I select "Prenatal-U 106.5 mg-1 mg capsule (PNV without calcium #5-iron-FA)  1 CAP oral DAILY" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "New Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "PROzac capsule (fluoxetine) 40MG oral DAILY" from the "Medication Reconciliation" table
    #And I select the "Stop" radio in the row with the text "PROzac capsule (fluoxetine) 40MG oral DAILY" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Acetaminophen Tab (Tylenol Tab) 325-650 MG oral Q6H PRN" in the "Medication Reconciliation" table
    And I select "Acetaminophen Extra Strength tablet (acetaminophen)  500MG oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "New Edit Medication Order" pane if it exists
#HospitalMeds
    And I select the "Continue" radio in the row with the text "Cetirizine Tab (ZyrTEC Tab) 10MG oral DAILY" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "New Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "ARIPiprazole Tab (Abilify Tab) 20MG oral DAILY" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "LORazepam Inj (Ativan Inj) 1MG IV Q4H PRN" from the "Medication Reconciliation" table
    #And I select the "Stop" radio in the row with the text "BD PosiFlush Normal Saline injection syringe (sodium chloride 0.9 %) 10ML inj PRN" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Decadron 4 MG Tab tab (dexamethasone) 2MG oral Q6H" in the "Medication Reconciliation" table
    And I select "Decadron 1mg Oral Soln drop (dexamethasone)  1 MG oral TID" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "New Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "zz Simethicone Sam Kit (zz Mylicon 80 Mg Tab Sam Kit) 160MG oral QID PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "clonazePAM Tab (KlonoPIN Tab) 1MG oral TID" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "New Edit Medication Order" pane if it exists
#    And I select the "Stop" radio in the row with the text "Labetalol Inj (Shortage) (Trandate Inj (Shortage)) 20MG IV ONCE PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "labetalol tablet 200MG oral TID" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "LORazepam Tab (SHORTAGE) (Ativan Tab (SHORTAGE)) 1MG oral Q4H PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Enoxaparin Inj (Lovenox Inj) 40MG subQ Q24H" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Milk Of Magnesia Conc Oral 10 ML susp 2,400 mg/10 mL (magnesium hydroxide) 10ML oral DAILY PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Polyethylene Glycol Powder (Miralax Powder) 17GM oral DAILY" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "New Edit Medication Order" pane if it exists
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Reconcile and Submit" button
    Then I sign and submit the order with default password


  @Performance @DMRPerformance @MedRecPerformance @OneWindow_Performance @OneWindow_DMRPerformance @OneWindow_MedRecPerformance
  Scenario: Resolve DMR for MedRec8
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "PATIENT8, MEDREC", admitted in the past "201" days, is on the patient list
    When I select patient "PATIENT8, MEDREC" from the patient list
    And I click the "Logo" element
    And I select "Home Meds" from clinical navigation
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
    Then the "Discharge Medication Reconciliation" pane should load
  #HomeMeds
    And I select the "Stop" radio in the row with the text "BACTRIMSSTAB 0.5EA oral DAILY X 90 days" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Bayer Aspirin tablet (aspirin) 325MG oral DAILY X 90 days" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Change" link in the row with the text "Mycophenolate Mofetil Tab (Cellcept Tab) 1000MG oral BID@1000,2200 X 90 days" in the "Medication Reconciliation" table
    And I select "CellCept 250 MG Cap cap (mycophenolate mofetil)  250 MG oral Q12H" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Tamsulosin Cap (Flomax Cap) 0.4MG oral BID X 90 days" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "LASIX40MGTAB 40MG oral DAILY X 90 days" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Multi-Day tablet (multivitamin) 1EA oral DAILY X 90 days" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
#    And I select the "Stop" radio in the row with the text "Clotrimazole Troche (Mycelex Troche) 10MG oral PCHS X 30 days" from the "Medication Reconciliation" table
      #And I select "Mycelex 10 MG Troche troc (clotrimazole)  10 MG oral 5XDAY" from the "Searched Combined Med Orders" list in the search results
      #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "omeprazole tablet,delayed release 20MG oral DAILY X 90 days" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "PERCOCET5-325MGTA 0TAB oral Q4H PRN pain (1-2TABLETS)" from the "Medication Reconciliation" table
    And I select "Percocet 10 mg-325 mg tablet (oxycodone-acetaminophen)  1 TAB oral Q4H PRN" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Prednisone 5 MG Tab tab (prednisone) 15MG oral BID X 90 days" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "PROGRAF1MGCAP 1MG oral BID X 90 days" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Calcitriol Cap (Rocaltrol Cap) 0.5MCG oral BID X 90 days" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "TUMSCHEWTAB 500MG oral TIDMEALS X 90 days" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Zovirax capsule (acyclovir) 400MG oral BID X 90 days" in the "Medication Reconciliation" table
    And I select "Zovirax 200 MG Cap cap (acyclovir)  200 MG oral Q4H WA" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
  #HospitalMeds
    And I select the "Continue" radio in the row with the text "Amantadine Cap (Symmetrel Cap) 100MG oral QOTHERDAY" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "NaCl Pres Free Inj (Sodium Chlor Pres Free Inj) 10ML IV PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "NaCl Pres Free Inj (Sodium Chlor Pres Free Inj) 10ML IV Q12H" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "bisacodyl tablet,delayed release 5-10 MG oral DAILY PRN" from the "Medication Reconciliation" table
      #And I select the "Stop" radio in the row with the text "clotrimazole troche 10MG MM PC HS" from the "Medication Reconciliation" table
    #And I select the "Change" link in the row with the text "zz Docusate Cap (zz Colace Cap SAM Kit) 100MG oral BID" in the "Medication Reconciliation" table
    #And I select "ZzzQuil capsule (diphenhydramine HCl)  25MG oral" from the "Searched Combined Med Orders" list in the search results
    #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
      #And I select the "Continue" radio in the row with the text "furosemide tablet 40MG oral DAILY" from the "Medication Reconciliation" table
      #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "hydrALAZINE Inj (Apresoline Inj) 10 - 20 MG IV Q3H PRN" from the "Medication Reconciliation" table
#    And I select the "Stop" radio in the row with the text "Labetalol Inj (Trandate Inj) 10 - 20 MG IV Q3H PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Levothyroxine Tab (Synthroid Tab) 75MCG oral DAILY@0600" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Polyethylene Glycol Powder (Miralax Powder) 17GM oral BID 9A 5P" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Naloxone Inj (Narcan Inj) 0.1MG IV ASDIR PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "ondansetron HCl (PF) 4 mg/2 mL injection solution 4MG IV Q4H PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Percocet 5-325 MG Tab tab (oxycodone-acetaminophen) 1-2 TABLETS oral Q4H PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Tacrolimus Anhydrous Cap (Prograf Cap) 1MG oral BID" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "sulfamethoxazole 400 mg-trimethoprim 80 mg tablet 0.5EA oral DAILY" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Calcium Carb Chew Tab (Tums Chew Tab) 500MG oral Q4H PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Calcium Carb Chew Tab (Tums Chew Tab) 500MG oral TID MEALS" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Reconcile and Submit" button
    Then I sign and submit the order with default password



  @Performance @DMRPerformance @MedRecPerformance @OneWindow_Performance @OneWindow_DMRPerformance @OneWindow_MedRecPerformance
  Scenario: Resolve DMR for MedRec7
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "PATIENT7, MEDREC", admitted in the past "201" days, is on the patient list
    When I select patient "PATIENT7, MEDREC" from the patient list
    And I click the "Logo" element
    And I select "Home Meds" from clinical navigation
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
  #HomeMeds
    And I select the "Continue" radio in the row with the text "cyclobenzaprine tablet 5MG oral BEDTIME PRN spasms" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
      #And I select the "Stop" radio in the row with the text "insulin detemir (Levemir FlexTouch 100 unit/mL (3 mL) subcutaneous insulin pen) 10UNIT subQ BID" from the "Medication Reconciliation" table
      #And I select "Humulin R soln 100 unit/mL (insulin regular human)  100UNIT inj X1ED" from the "Searched Combined Med Orders" list in the search results
      #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "Neurontin capsule (gabapentin) 400MG oral TID" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Omeprazole Cap (NF) PED (PriLOSEC Cap (NF) PED) 40MG oral BID" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Lisinopril Tab (Prinivil Tab) 5MG oral DAILY" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "ProAir HFA 90 mcg/actuation aerosol inhaler (albuterol sulfate) 1-2PUFF inhl Q4H PRN difficultybreathing" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Change" link in the row with the text "Senna Plus 8.6 mg-50 mg tablet (sennosides-docusate sodium) 2TAB oral NotSpecified PRN constipation" in the "Medication Reconciliation" table
    And I select "Senna Lax tablet (sennosides)  8.6MG oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "Stress Formula tablet (multivitamin, stress formula) 1TAB oral DAILY" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "traMADol Tab (Ultram Tab) 50MG oral Q8H PRN legpain" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
  #HospitalMeds
    And I select the "Continue" radio in the row with the text "Multivitamin Tab (Theragran Tab) 1EA oral DAILY" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" link in the row with the text "Thiamine Tab (Vitamin B-1 Tab) 100MG oral DAILY" in the "Medication Reconciliation" table
      #And I select "Thiamine HCl tab (thiamine HCl (vitamin B1)) 100MG oral Daily" from the "Searched Combined Med Orders" list in the search results
      #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Reconcile and Submit" button
    Then I sign and submit the order with default password


  @Performance @DMRPerformance @MedRecPerformance @OneWindow_Performance @OneWindow_DMRPerformance @OneWindow_MedRecPerformance
  Scenario: Resolve DMR for MedRec5
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "PATIENT5, MEDREC", admitted in the past "201" days, is on the patient list
    When I select patient "PATIENT5, MEDREC" from the patient list
    And I click the "Logo" element
    And I select "Home Meds" from clinical navigation
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
  #HomeMeds
    And I select the "Stop" radio in the row with the text "Milk of Magnesia 400 mg/5 mL oral suspension (magnesium hydroxide) 15ML oral DAILY PRN constipation" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Polyethylene Glycol Powder (Miralax Powder) 17GM oral DAILY X 30 days" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Change" link in the row with the text "ondansetron HCl (PF) 4 mg/2 mL injection solution 4MG IV Q6H PRN" in the "Medication Reconciliation" table
    And I select "Zofran ODT TbDL (ondansetron)  4 MG oral ONCE" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
  #HospitalMeds
    And I select the "Continue" radio in the row with the text "Bisacodyl Supp (Dulcolax Supp) 10MG rect DAILY" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "Diazepam Inj (Valium Inj) 2.5MG IV BEDTIME PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "HYDROmorphone Inj (Dilaudid Inj) 0.5MG IV Q2H PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "HYDROmorphone Inj (Dilaudid Inj) 0.5MG IV Q30M PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "levETIRAcetam Inj PED (Keppra Inj PED) 500MG IV Q12HR" from the "Medication Reconciliation" table
    And I select "Keppra soln 100 mg/mL (levetiracetam)  500MG oral BID" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "clonazePAM Tab (KlonoPIN Tab) 2MG oral BEDTIME PRN" from the "Medication Reconciliation" table
      #And I select the "Change" link in the row with the text "Lipitor 40 MG Tab tab (atorvastatin) 40MG oral DAILY@2000" in the "Medication Reconciliation" table
      #And I select "Lipitor 10 MG Tab tab (atorvastatin)  10 MG oral DAILY" from the "Searched Combined Med Orders" list in the search results
      #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
      #And I select the "Stop" radio in the row with the text "magnesium sulfate 4 mEq/mL (50 %) injection solution see admin criteria inj ASDIR" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Gabapentin Cap (Neurontin Cap) 900MG oral TID" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
#    And I select the "Continue" radio in the row with the text "Remove Ointment (Nitroglycerin 2% Top Oint Pkt) 1APPLIC top DAILY@00" from the "Medication Reconciliation" table
#    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    #And I select the "Stop" radio in the row with the text "Nitroglycerin 2% Top Oint Pkt oint (nitroglycerin) 1APPLIC top Q6H PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "oxyCODONE IR Tab (Roxicodone IR Tab) 5MG oral Q4H PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Protonix tablet,delayed release (pantoprazole) 40MG oral BID" from the "Medication Reconciliation" table
    #And I select "Protonix tablet,delayed release (pantoprazole)  40MG oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Yes" button if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
      #And I select the "Continue" radio in the row with the text "Sod CL 0.9% IV Soln 100 ML solp (sodium chloride 0.9 %) 100ML IV Q12HR" from the "Medication Reconciliation" table
      #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "Topiramate Tab (Topamax Tab) 100MG oral BID" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Acetaminophen Tab (Tylenol Tab) 650MG oral Q6H PRN" from the "Medication Reconciliation" table
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Reconcile and Submit" button
    Then I sign and submit the order with default password




  @Performance @DMRPerformance @MedRecPerformance @OneWindow_Performance @OneWindow_DMRPerformance @OneWindow_MedRecPerformance
  Scenario: Resolve DMR for MedRec4
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "PATIENT4, MEDREC", admitted in the past "201" days, is on the patient list
    When I select patient "PATIENT4, MEDREC" from the patient list
    And I click the "Logo" element
    And I select "Home Meds" from clinical navigation
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
  #HomeMeds
    And I select the "Continue" radio in the row with the text "CeleBREX capsule (celecoxib) 200MG oral BID" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Ecotrin tablet,delayed release (aspirin) 325MG oral BID" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "HYDROcodone/APAP 10/325 Tab (Norco 10/325 Tab) 1-2EA oral Q4H PRN painscale4-6(use1st) (1-2TABS)" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Change" link in the row with the text "Ondansetron ODT Tab (Zofran ODT Tab) 4MG oral Q4H PRN nausea/vomiting(use1st)" in the "Medication Reconciliation" table
    And I select "Zofran ODT TbDL (ondansetron)  4 MG oral Q12H" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
  #HospitalMeds
    And I select the "Stop" radio in the row with the text "Tylenol #3 Tab tab 300-30 mg (acetaminophen-codeine) 1EA oral Q4H PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Zolpidem Tab (Ambien Tab) 5MG oral BEDTIME PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Bisacodyl Supp (Dulcolax Supp) 10MG rect Q12H PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Lactobacillus Rhamnosus Cap (Culturelle Cap) 1EACH oral BID" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
#    And I select the "Stop" radio in the row with the text "Cyclobenzaprine Tab (Flexeril Tab) 5MG oral TID PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "diazepam tablet 5-10 MG oral Q6H PRN" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "diphenhydrAMINE Inj (Benadryl Inj) 12.5 - 25 MG IV Q6H PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Ferrous Sulfate Tab 325MG oral BID" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "HYDROmorphone Tab (Dilaudid Tab) 2-4 MG oral Q4H PRN" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Polyethylene Glycol Powder (Miralax Powder) 17GM oral DAILY" in the "Medication Reconciliation" table
    And I select "mineral oil 90 %-polyethylene (bulk) ointment  misc" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "Prochlorperazine Inj (Compazine Inj) 5-10 MG IV Q4H PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Senna/Docusate Tab (Senokot S Tab) 1EA oral BID" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
      #And I select the "Stop" radio in the row with the text "Sod CL 0.9% IV Soln 100 ML solp (sodium chloride 0.9 %) 1000ML IV .Q10H" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Cepacol Sugar Free Lozenge 1EA MM PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Multivitamin Tab (Theragran Tab) 1EA oral DAILY" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "traMADol tablet 50-100 MG oral Q6H PRN" from the "Medication Reconciliation" table
      #And I select the "Stop" radio in the row with the text "Vitamin C tablet (ascorbic acid) 500MG oral BID" from the "Medication Reconciliation" table
      #And I select the "Stop" radio in the row with the text "vitamin E capsule 400IU oral DAILY" from the "Medication Reconciliation" table
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Reconcile and Submit" button
    Then I sign and submit the order with default password



  @Performance @DMRPerformance @MedRecPerformance @OneWindow_Performance @OneWindow_DMRPerformance @OneWindow_MedRecPerformance
  Scenario: Resolve DMR for MedRec3
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "PATIENT3, MEDREC", admitted in the past "201" days, is on the patient list
    When I select patient "PATIENT3, MEDREC" from the patient list
    And I select "Home Meds" from clinical navigation
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
  #HomeMeds
    And I select the "Stop" radio in the row with the text "LORazepam Tab (Ativan Tab) 0.5MG oral Q4H PRN" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Carvedilol Tab (Coreg Tab) 3.125MG oral BID" in the "Medication Reconciliation" table
    And I select "Coreg 12.5 MG Tab tab (carvedilol)  12.5 MG oral BID" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "lisinopril tablet 2.5MG oral DAILY" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "Ondansetron ODT Tab (Zofran ODT Tab) 8MG oral Q8H PRN" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Acyclovir Tab (Zovirax Tab) 800MG oral BID" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
  #HospitalMeds
    And I select the "Stop" radio in the row with the text "Zolpidem Tab (Ambien Tab) 5MG oral BEDTIME PRN" from the "Medication Reconciliation" table
    And I select the "Stop" link in the row with the text "Aztreonam Inj (Azactam Inj) 2GM IV Q8H PRN" in the "Medication Reconciliation" table
      #And I select "Azactam 1 G Inj solr (aztreonam)  1GM inj Q8H" from the "Searched Combined Med Orders" list in the search results
      #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Reconcile and Submit" button
    Then I sign and submit the order with default password

  @Performance @DMRPerformance @MedRecPerformance @OneWindow_Performance @OneWindow_DMRPerformance @OneWindow_MedRecPerformance
  Scenario: Resolve DMR for MedRec2
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "PATIENT2, MEDREC", admitted in the past "201" days, is on the patient list
    When I select patient "PATIENT2, MEDREC" from the patient list
    And I select "Home Meds" from clinical navigation
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
  #HomeMeds
    And I select the "Continue" radio in the row with the text "B-12 DOTS tablet (cyanocobalamin (vitamin B-12)) oral DAILY" from the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "buPROPion HCl tablet 100MG oral DAILY" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Diflucan tablet (fluconazole) 150MG oral ONCE (takedoseon5/30if)" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "APAP/Caffeine/Butalbital Tab (Fioricet Tab) 1EA oral Q6-8H PRN headache" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "Enoxaparin Inj (Lovenox Inj) 40MG subQ Q24H" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "morphine CR Tab (MS Contin Tab) 15 mg 1TAB oral TID" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Roxicodone tablet (oxycodone) 15 mg 1TAB oral Q6H PRN breakthroughpain" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
      #And I select the "Continue" radio in the row with the text "Nystatin crea 100,000 unit/gram 1APPLIC top BID" from the "Medication Reconciliation" table
      #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Diazepam Tab (Valium Tab) 5 mg 1TAB oral Q6H PRN severemusclespasms" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    #And I select the "Change" link in the row with the text "Zoloft 100 MG Tab tab (sertraline) 200MG oral DAILY" in the "Medication Reconciliation" table
    #And I select "Zoloft 50 MG Tab tab (sertraline)  100MG oral BID" from the "Searched Combined Med Orders" list in the search results
    #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
  #HospitalMeds
    And I select the "Continue" radio in the row with the text "Calcium Carb/Vit D 500/200 Tab (OsCal + Vit D 500/200 Tab) 1500MG oral DAILY" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Change" link in the row with the text "cefTRIAXone Inj (Rocephin Inj) 2GM IV Q24H" in the "Medication Reconciliation" table
    And I select "Ceftriaxone Sodium solr (ceftriaxone)  2 GRAM IV Q24H" from the "Searched Combined Med Orders" list in the search results
    And I click the "Yes" button in the "Question" pane if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "diphenhydrAMINE capsule 25MG oral Q4H PRN" from the "Medication Reconciliation" table
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Reconcile and Submit" button
    Then I sign and submit the order with default password

  @Performance @DMRPerformance @MedRecPerformance @OneWindow_Performance @OneWindow_DMRPerformance @OneWindow_MedRecPerformance
  Scenario: Resolve DMR for MedRec1
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "PATIENT1, MEDREC", admitted in the past "201" days, is on the patient list
    When I select patient "PATIENT1, MEDREC" from the patient list
    And I select "Home Meds" from clinical navigation
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
  #HomeMeds
      #And I select the "Stop" radio in the row with the text "lorazepam tab (Ativan 0.5 MG Tab) 0.5MG oral Q4H PRN n/v;use2nd;mrx1" from the "Medication Reconciliation" table
      #And I select the "Continue" radio in the row with the text "prochlorperazine maleate tab (Compazine 5 MG Tab) 5MG oral Q8H PRN n/v;use3rd;mayrepeatx1" from the "Medication Reconciliation" table
      #And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "Prochlorperazine Tab (Compazine Tab) 10MG oral Q6H" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "heparin, porcine (PF) 10 unit/mL intravenous syringe 30UNITS IV NotSpecified X 30 days PRN eachlumendaily/afteruse" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Loperamide Cap (Imodium Cap) 2MG oral Q4H WA" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Granisetron Tab (Kytril Tab) 1MG oral Q12H PRN nausea-use2nd" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Nicotine Patch (Nicoderm CQ Patch) 1PATCH TD DAILY" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Protonix tablet,delayed release (pantoprazole) 40MG oral AC BK" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    #And I select the "Stop" radio in the row with the text "Pantoprazole Tab (Protonix Tab) 40MG oral DAILY X 30 days (GERDPROPHYLAXIS)" from the "Medication Reconciliation" table
      #And I select the "Stop" radio in the row with the text "Rapamune tab (sirolimus) 0.5MG oral SuTuFr@1300 (GVHDPROPHYLAXIS)" from the "Medication Reconciliation" table
      #And I select the "Stop" radio in the row with the text "Rapamune tablet (sirolimus) NEW GOAL 5/20 PER DR.GREGORY oral ASDIR" from the "Medication Reconciliation" table
      #And I select the "Stop" radio in the row with the text "Rapamune tab (sirolimus) 0.5MG oral SuTuFr@1300" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Ondansetron ODT Tab (Zofran ODT Tab) 8MG oral Q8H PRN n/vuse1st" in the "Medication Reconciliation" table
    And I select "Zofran 40 MG Vial soln 2 mg/mL (ondansetron HCl)  8 MG oral Q12H" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
  #HospitalMeds
    And I select the "Continue" radio in the row with the text "Ursodiol Liquid (Actigall Liquid) 300MG oral BID" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Change" link in the row with the text "Citalopram Tab (CeleXA Tab) 20MG oral DAILY" in the "Medication Reconciliation" table
    And I select "CeleXA tablet (citalopram)  30 MG oral DAILY" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Mycophenolate Mofetil Tab (Cellcept Tab) 1000MG oral TID" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "Mycophenolate Mofetil Cap (Cellcept Cap) 250MG oral TID" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Levofloxacin Tab (Levaquin Tab) 500MG oral BEDTIME" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Posaconazole DR Tab (NF) (Noxafil DR Tab (NF)) 300MG oral DAILY@12" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Tacrolimus Anhydrous Cap (Prograf Cap) 0.3MG oral BID" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "ValACYclovir Tab 500MG oral BID" from the "Medication Reconciliation" table
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Reconcile and Submit" button
    Then I sign and submit the order with default password