@Performance @OneWindow_Performance
Feature: Performance Admission MedRec test

  @Performance @MedRecPerformance @AMRPerformance @OneWindow_Performance @OneWindow_MedRecPerformance @OneWindow_AMRPerformance
  Scenario Outline: Open AMR
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    And I click the "Logo" element
    And I select "Home Meds" from clinical navigation
    Then the "Medication Reconciliation List" table should load
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Adm Med Rec" button in the "Med Rec List" pane
    Then the "Admission Medication Reconciliation" pane should load
    And I click the "Yes" button in the "Question" pane if it exists
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane if it exists

    Examples:
      | Patient             |
      | PATIENT2, MEDREC    |
      | PATIENT1, MEDREC    |
      | PATIENT3, MEDREC    |
      | PATIENT4, MEDREC    |
      | PATIENT5, MEDREC    |
      | PATIENT7, MEDREC    |
      | PATIENT8, MEDREC    |
      | PATIENT9, MEDREC    |

  @Performance @MedRecPerformance @AMRPerformance @OneWindow_Performance @OneWindow_MedRecPerformance @OneWindow_AMRPerformance
  Scenario: Resolve AMR for MedRec1
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "PATIENT1, AMR", admitted in the past "201" days, is on the patient list
    When I select patient "PATIENT1, AMR" from the patient list
    And I click the "Logo" element
    And I select "Orders" from clinical navigation
  #And I select "the first item" in the "Orders" table
    And I click the "Adm Med Rec" button in the "Orders" pane
    And I select the "Change" link in the row with the text "Citrulline 1TAB oral DAILY" in the "Medication Reconciliation" table
    And I select "citrulline 200 mg/4 gram oral powder packet  oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "New Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Ferrous Sulfate Tab 325 mg (65 mg iron) 3TAB oral BID" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "VitaminD 50000UNIT oral" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "VitaminD 50000UNIT oral Q7D PRN lowvitdlevel" from the "Medication Reconciliation" table
    And I select the "Not Therapeutic Equivalents" radio in the row with the text "Zofran tablet (ondansetron HCl) 4MG oral Q6H PRN nausea" from the "Medication Reconciliation" table
    And I click the "Yes" button
    And I select the "Continue" radio in the row with the text "Zofran tablet (ondansetron HCl) 4MG oral Q6H PRN nausea" from the "Medication Reconciliation" table
    And I click the "Reconcile and Submit" button
    And I click the "Submit Partial MedRec" button
    Then I sign and submit the order with default password



  @Performance @MedRecPerformance @AMRPerformance @OneWindow_Performance @OneWindow_MedRecPerformance @OneWindow_AMRPerformance
  Scenario: Resolve AMR for MedRec2
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "PATIENT2, AMR", admitted in the past "201" days, is on the patient list
    When I select patient "PATIENT2, AMR" from the patient list
    And I click the "Logo" element
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I click the "Adm Med Rec" button in the "Orders" pane
    And I select the "Stop" radio in the row with the text "Lasix 20 MG Tab tab (furosemide) 20MG oral BID" from the "Medication Reconciliation" table
    And I select the "Substitute w/Existing Order" radio in the row with the text "Levofloxacin Tab (Levaquin Tab) 500MG oral DAILY@1000 (Tostart11/3/17or)" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "LEVORA28-DAY 1 oral DAILY" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Potassium Chloride ER Cap (Micro K Extencaps Cap) 20MEQ oral BID (Oktoholdmedicatio)" in the "Medication Reconciliation" table
    And I select "Potassium phosphate soln 3 mmol/mL (potassium phosphate m-/d-basic)  8 MMOL oral Q6H" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "MSCONTIN 15MG oral BID" from the "Medication Reconciliation" table
    And I select "MS Contin SR 15 MG Tab TbER (morphine)  15 MG oral BEDTIME" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Substitute w/Existing Order" radio in the row with the text "oxyCODONE tablet 10MG oral Q3-4H PRN pain" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Acyclovir Tab (Zovirax Tab) 400MG oral BID" from the "Medication Reconciliation" table
    And I click the "Yes" button
    And I click the "Reconcile and Submit" button
    And I click the "Submit Partial MedRec" button
    Then I sign and submit the order with default password

  @Performance @MedRecPerformance @AMRPerformance @OneWindow_Performance @OneWindow_MedRecPerformance @OneWindow_AMRPerformance
  Scenario: Resolve AMR for MedRec3
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "PATIENT3, AMR", admitted in the past "201" days, is on the patient list
    When I select patient "PATIENT3, AMR" from the patient list
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I click the "Adm Med Rec" button in the "Orders" pane
    And I select the "Stop" radio in the row with the text "Estrace tablet (estradiol) 1MG oral DAILY" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "GABAPENTIN 900MG oral TID" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "LEVOTHYROXINE 50MCG oral DAILY" in the "Medication Reconciliation" table
    And I select "levothyroxine capsule  50MCG oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "OXcarbazepine Tab (Trileptal Tab) 600MG oral TID" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "VITD 5000IU oral DAILY" from the "Medication Reconciliation" table
    And I click the "Reconcile and Submit" button
    Then I sign and submit the order with default password


  @Performance @MedRecPerformance @AMRPerformance @OneWindow_Performance @OneWindow_MedRecPerformance @OneWindow_AMRPerformance
  Scenario: Resolve AMR for MedRec4
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "PATIENT4, AMR", admitted in the past "201" days, is on the patient list
    When I select patient "PATIENT4, AMR" from the patient list
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I click the "Adm Med Rec" button in the "Orders" pane
    And I select the "Stop" radio in the row with the text "alpha lipoic acid capsule 300MG oral DAILY" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Sulfameth/Trimeth 400/80 Tab (Bactrim 400/80 Tab) 160-800MG oral" from the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Substitute w/Existing Order" radio in the row with the text "Fluconazole Tab (Diflucan Tab) 400MG oral DAILY" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Glucosamine Cap 1500MG oral DAILY" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Potassium Chloride ER Tab (K Dur Tab) 20MEQ oral DAILY" in the "Medication Reconciliation" table
    And I select "Potassium phosphate soln 3 mmol/mL (potassium phosphate m-/d-basic)  8 MMOL oral Q6H" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Lasix 20 MG Tab tab (furosemide) 10MG oral DAILY" from the "Medication Reconciliation" table
    And I select the "Not Therapeutic Equivalents" radio in the row with the text "Levofloxacin Tab (Levaquin Tab) 500MG oral DAILY" from the "Medication Reconciliation" table
    And I click the "Yes" button
    And I select the "Continue" radio in the row with the text "Levofloxacin Tab (Levaquin Tab) 500MG oral DAILY" from the "Medication Reconciliation" table
    And I select the "Substitute w/Existing Order" radio in the row with the text "Magnesium Oxide Tab (Mag Ox Tab) 400MG oral DAILY" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "PEPCID 40MG oral DAILY" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Probiotic sprinkle capsule (lactobacillus combo no.11) oral DAILY (OPTIMAPROBIOTIC(1)" from the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Stop" radio in the row with the text "TURMERICROOT 100MG oral DAILY" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Vicodin 5 mg-300 mg tablet (hydrocodone-acetaminophen) 1TAB oral Q6H PRN pain" in the "Medication Reconciliation" table
    And I select "Lorcet (hydrocodone) 5 mg-325 mg tablet (hydrocodone-acetaminophen)  oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Substitute w/Existing Order" radio in the row with the text "Acyclovir Tab (Zovirax Tab) oral BID" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "ZyrTEC 10MG oral DAILY" from the "Medication Reconciliation" table
    And I click the "Reconcile and Submit" button
    And I click the "Submit Partial MedRec" button
    Then I sign and submit the order with default password


  @Performance @MedRecPerformance @AMRPerformance @OneWindow_Performance @OneWindow_MedRecPerformance @OneWindow_AMRPerformance
  Scenario: Resolve AMR for MedRec5
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "PATIENT5, AMR", admitted in the past "201" days, is on the patient list
    When I select patient "PATIENT5, AMR" from the patient list
    And I click the "Logo" element
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I click the "Adm Med Rec" button in the "Orders" pane
    And I select the "Stop" radio in the row with the text "Folic Acid Tab (Folvite Tab) 1MG oral DAILY" from the "Medication Reconciliation" table
    And I select the "Substitute w/Existing Order" radio in the row with the text "oxyCODONE IR Tab (Roxicodone IR Tab) 5MG oral Q6H PRN pain" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Vitamin B-12 ER tablet,extended release (cyanocobalamin (vitamin B-12)) 2000MCG oral DAILY" from the "Medication Reconciliation" table
    And I select the "Not Therapeutic Equivalents" radio in the row with the text "Zovirax capsule (acyclovir) 200MG oral DAILY" from the "Medication Reconciliation" table
    And I click the "Yes" button
    And I select the "Change" link in the row with the text "Zovirax capsule (acyclovir) 200MG oral DAILY" in the "Medication Reconciliation" table
    And I select "Zovirax 200 MG Cap cap (acyclovir)  200 MG oral DAILY" from the "Searched Combined Med Orders" list in the search results
    And I click the "No" button
    And I click the "Reconcile and Submit" button
    And I click the "Submit Partial MedRec" button
    Then I sign and submit the order with default password


  @Performance @MedRecPerformance @AMRPerformance @OneWindow_Performance @OneWindow_MedRecPerformance @OneWindow_AMRPerformance
  Scenario: Resolve AMR for MedRec6
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "PATIENT6, AMR", admitted in the past "201" days, is on the patient list
    When I select patient "PATIENT6, AMR" from the patient list
    And I click the "Logo" element
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I click the "Adm Med Rec" button in the "Orders" pane
    And I select the "Stop" radio in the row with the text "Allergy Relief (diphenhydrAMINE) capsule (diphenhydramine HCl) 50MG oral Q6H PRN allergies" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Zolpidem Tab (Ambien Tab) 10MG oral BEDTIME PRN insomnia" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Amitiza capsule (lubiprostone) 24MCG oral BIDMEALS" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Combivent Respimat 20 mcg-100 mcg/actuation solution for inhalation (ipratropium-albuterol) 1PUFF inhl TID PRN shortnessofbreath" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Fluticasone Nasal Spray (Flonase Nasal Spray) 1SPRAY BID" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Fluticasone 110mcg *Non-isolat (Flovent HFA 110mcg *Non-isolat) 2PUFF inhl RTBID" in the "Medication Reconciliation" table
    And I select "fluticasone 100 mcg-vilanterol 25 mcg/dose powder for inhalation  inhl" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with the text "Lidocaine Patch 5% (Lidoderm Patch 5%) 1PATCH top BEDTIME" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Milk of Magnesia 400 mg/5 mL oral suspension (magnesium hydroxide) 5ML oral TID PRN constipation" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "guaiFENesin ER Tab (Mucinex Tab) 600MG oral BID X 7 days PRN mucus/congestion" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Oxtellar XR tablet,extended release (oxcarbazepine) 300MG oral DAILY" from the "Medication Reconciliation" table
    #And I select the "Stop" radio in the row with the text "Diazepam Tab (Valium Tab) 10MG oral TID" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Senna/Docusate Tab (Senokot S Tab) 1TAB oral BID" from the "Medication Reconciliation" table
    #And I select "Senokot 8.6 MG Tab tab (sennosides)  1 EA oral DAILY" from the "Searched Combined Med Orders" list in the search results
    And I select the "Not Therapeutic Equivalents" radio in the row with the text "Ondansetron ODT Tab (Zofran ODT Tab) 8MG oral Q8H PRN nauseaandvomiting" from the "Medication Reconciliation" table
    And I click the "Yes" button
    And I select the "Change" link in the row with the text "Ondansetron ODT Tab (Zofran ODT Tab) 8MG oral Q8H PRN nauseaandvomiting" in the "Medication Reconciliation" table
    And I select "Zofran ODT TbDL (ondansetron)  4 MG oral Q8H" from the "Searched Combined Med Orders" list in the search results
    And I click the "No" button
    And I click the "Reconcile and Submit" button
    And I click the "Submit Partial MedRec" button
    Then I sign and submit the order with default password


  @Performance @MedRecPerformance @AMRPerformance @OneWindow_Performance @OneWindow_MedRecPerformance @OneWindow_AMRPerformance
  Scenario: Resolve AMR for MedRec7
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "PATIENT7, AMR", admitted in the past "201" days, is on the patient list
    When I select patient "PATIENT7, AMR" from the patient list
    And I click the "Logo" element
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I click the "Adm Med Rec" button in the "Orders" pane
    And I select the "Stop" radio in the row with the text "alpha lipoic acid capsule 200MG oral" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Colace 100 MG Cap cap (docusate sodium) 100MG oral BID" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "EZFE 200 capsule (polysaccharide iron complex) 200MG oral DAILY" in the "Medication Reconciliation" table
    And I select "Niferex-150 Cap cap (polysaccharide iron complex)  150 MG oral BID" from the "Searched Combined Med Orders" list in the search results
    And I select the "Stop" radio in the row with the text "Fluticasone Nasal Spray (Flonase Nasal Spray) 1SPRAY DAILY" from the "Medication Reconciliation" table
    And I select the "Substitute w/Existing Order" radio in the row with the text "Omeprazole Cap (NF) PED (PriLOSEC Cap (NF) PED) 20MG oral DAILY" from the "Medication Reconciliation" table
    And I click the "Reconcile and Submit" button
    And I click the "Submit Partial MedRec" button
    Then I sign and submit the order with default password


  @Performance @MedRecPerformance @AMRPerformance @OneWindow_Performance @OneWindow_MedRecPerformance @OneWindow_AMRPerformance
  Scenario: Resolve AMR for MedRec8
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "PATIENT8, AMR", admitted in the past "201" days, is on the patient list
    When I select patient "PATIENT8, AMR" from the patient list
    And I click the "Logo" element
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I click the "Adm Med Rec" button in the "Orders" pane
    And I select the "Stop" radio in the row with the text "Hydrocortisone Rectal Crm 2.5% (Anusol HC Cream Rectal 2.5%) 1APPLIC rect BEDTIME PRN hemmroids" from the "Medication Reconciliation" table
    And I select the "Substitute w/Existing Order" radio in the row with the text "Prochlorperazine Tab (Compazine Tab) 10MG oral Q6H PRN nausea" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "APAP/Caffeine/Butalbital Tab (Fioricet Tab) 2EA oral Q6H PRN headache" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Glucophage XR tablet,extended release (metformin) 500MG oral BID" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Hydrocortisone 1% (Hydrocortisone 1% Oint) 1APPLIC top TID" in the "Medication Reconciliation" table
    And I select "Hydrocortisone 0.5% crea (hydrocortisone)  1 APPLIC top TID" from the "Searched Combined Med Orders" list in the search results
    And I select the "Stop" radio in the row with the text "Magnesium+Protein 1TAB oral BID (6tabsspreadthroug)" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "Posaconazole DR Tab (NF) (Noxafil DR Tab (NF)) 100MG oral DAILY" from the "Medication Reconciliation" table
    And I select the "Substitute w/Existing Order" radio in the row with the text "omeprazole capsule,delayed release 40MG oral BID (DECREASESONSTOMAC)" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "PROGRAF 0.4MG oral BID (1MG/MLINCREASEDBY)" from the "Medication Reconciliation" table
    And I select the "Not Therapeutic Equivalents" radio in the row with the text "oxyCODONE IR Tab (Roxicodone IR Tab) 5MG oral Q4H PRN moderate-severepain mrx1" from the "Medication Reconciliation" table
    And I click the "Yes" button
    And I select the "Change" link in the row with the text "oxyCODONE IR Tab (Roxicodone IR Tab) 5MG oral Q4H PRN moderate-severepain mrx1" in the "Medication Reconciliation" table
    And I select "Oxycodone Hcl soln 5 mg/5 mL (oxycodone)  0.15 MG/KG oral ONCE" from the "Searched Combined Med Orders" list in the search results
    And I click the "No" button
    And I select the "Stop" radio in the row with the text "Vitamin D3 Tab (Cholecalciferol Tab) 2000UNITS oral DAILY" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "ZOVIRAX 800MG oral BID X 30 days (PREVENTSVIRALINFE)" from the "Medication Reconciliation" table
    And I select "Zovirax 200 MG Cap cap (acyclovir)  200 MG oral 5XDAY" from the "Searched Combined Med Orders" list in the search results
    And I click the "Yes" button
    And I select the "Substitute w/Existing Order" radio in the row with the text "ZOVIRAX 800MG oral BID X 30 days (PREVENTSVIRALINFE)" from the "Medication Reconciliation" table
    And I click the "Reconcile and Submit" button
    And I click the "Submit Partial MedRec" button
    Then I sign and submit the order with default password


  @Performance @MedRecPerformance @AMRPerformance @OneWindow_Performance @OneWindow_MedRecPerformance @OneWindow_AMRPerformance
  Scenario: Resolve AMR for MedRec9
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "PATIENT9, AMR", admitted in the past "201" days, is on the patient list
    When I select patient "PATIENT9, AMR" from the patient list
    And I click the "Logo" element
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I click the "Adm Med Rec" button in the "Orders" pane
    And I select the "Not Therapeutic Equivalents" radio in the row with the text "Coreg tablet (carvedilol) 25MG oral BIDMEALS" from the "Medication Reconciliation" table
    And I click the "Yes" button
    And I select the "Change" link in the row with the text "Coreg tablet (carvedilol) 25MG oral BIDMEALS" in the "Medication Reconciliation" table
    And I select "Coreg 12.5 MG Tab tab (carvedilol)  12.5 MG oral BID MEALS" from the "Searched Combined Med Orders" list in the search results
    And I click the "No" button if it exists
    And I select the "Stop" radio in the row with the text "DEMADEX 20MG oral BID" from the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with the text "doxycycline hyclate capsule 100MG oral BID" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "Atorvastatin Tab (Lipitor Tab) 20MG oral BEDTIME" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "amLODIPine Tab (Norvasc Tab) 5MG oral BEDTIME" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "nystatin tablet 1000000UNITS oral BID" from the "Medication Reconciliation" table
    And I select the "Stop" radio in the row with the text "omeprazole tablet,delayed release 20MG oral BID" from the "Medication Reconciliation" table
    And I click the "Yes" button
    And I select the "Stop" radio in the row with the text "Calcium Carb Chew Tab (Tums Chew Tab) 1000MG oral MEALS" from the "Medication Reconciliation" table
    And I select the "Change" link in the row with the text "Metolazone Tab (Zaroxolyn Tab) 5MG oral DAILY" in the "Medication Reconciliation" table
    And I select "Zaroxolyn tab (metolazone)  10 MG oral DAILY" from the "Searched Combined Med Orders" list in the search results
    And I click the "Reconcile and Submit" button
    And I click the "Submit Partial MedRec" button
    Then I sign and submit the order with default password

