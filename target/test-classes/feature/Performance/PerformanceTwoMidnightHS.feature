@Performance @OneWindow_Performance
Feature: Two Midnight Performance test

  @TwoMidnightPerformance @MedRecPerformance @OneWindow_TwoMidnightPerformance @OneWindow_MedRecPerformance
  Scenario: No signed or authenticated order, can submit medication added order
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Two Midnight" from the "Patient List" menu
    #Given "TWOMIDNIGHT, PATIENT1", admitted in the past "201" days, is on the patient list
    When I select patient "TWOMIDNIGHT, PATIENT1" from the patient list
    And I select "Home Meds" from clinical navigation
    #And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
    And the following text should appear in the "DMR Notification" pane
      |Notification:           |
      |You may proceed with DMR, but Discharge Orders may not be submitted.           |
      |Signed Admission Order Needed:           |
      |This patient has an admission order that needs to be signed before discharge.  |
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "zofran tablet" in the "DMR-SearchForOrder" field in the "Search for order" pane
    And I select "Zofran tablet (ondansetron HCl)  8 MG oral Q8H" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Reconcile and Submit" button
    And I click the "Search" button
    Then I select "the first item" in the "Look Up" table
    And I click the "Look Up OK" button
    #And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
    And the following text should appear in the "DMR Notification" pane
      |Notification:           |
      |You may proceed with DMR, but Discharge Orders may not be submitted.           |
      |Signed Admission Order Needed:           |
      |This patient has an admission order that needs to be signed before discharge.  |
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    #lab
    And I enter "CBC" in the "DMR-SearchForOrder" field in the "Search for order" pane
    And I select "CBC W/MANUAL DIFFERENTIAL  STAT" from the "Searched Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And the following text should appear in the "DMR Notification" pane
      |Notification:           |
      |Save as Draft. Discharge Orders may not be submitted.           |
      |Signed Admission Order Needed:           |
      |This patient has an admission order that needs to be signed before discharge.  |
    And I click the "Reconcile and Submit" button
    And Text exact "Please Save as Draft and follow facility admission order process to continue discharge." should appear in the "WarningPopup" pane
    And I click the "Warning OK" button in the "Warning" pane
    And I click the "DMR Save As Draft" button

  @TwoMidnightPerformance @MedRecPerformance @OneWindow_TwoMidnightPerformance @OneWindow_MedRecPerformance
  Scenario: No signed or authenticated order, cannot submit non-medication added order hard stop for all non-med types
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Two Midnight" from the "Patient List" menu
    #Given "TWOMIDNIGHT, PATIENT6", admitted in the past "201" days, is on the patient list
    When I select patient "TWOMIDNIGHT, PATIENT6" from the patient list
    And I select "Home Meds" from clinical navigation
    #And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
    And the following text should appear in the "DMR Notification" pane
      |Notification:           |
      |You may proceed with DMR, but Discharge Orders may not be submitted.           |
      |Signed Admission Order Needed:           |
      |An electronic admit order does not exisit on this patient. Follow facility admission order entry process.  |
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    #nursing
    And I enter "POC" in the "DMR-SearchForOrder" field in the "Search for order" pane
    And I select "POC: ABG" from the "Searched All Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And the following text should appear in the "DMR Notification" pane
      |Notification:           |
      |Save as Draft. Discharge Orders may not be submitted.           |
      |Signed Admission Order Needed:           |
      |An electronic admit order does not exisit on this patient. Follow facility admission order entry process.  |
    And I click the "Reconcile and Submit" button
    And Text exact "Please Save as Draft and follow facility admission order process to continue discharge." should appear in the "WarningPopup" pane
    And I click the "Warning OK" button in the "Warning" pane
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
    And the following text should appear in the "DMR Notification" pane
      |Notification:           |
      |You may proceed with DMR, but Discharge Orders may not be submitted.           |
      |Signed Admission Order Needed:           |
      |An electronic admit order does not exisit on this patient. Follow facility admission order entry process.  |
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    #diet
    And I enter "Diet" in the "DMR-SearchForOrder" field in the "Search for order" pane
    And I select "Diet: Bariatric" from the "Searched All Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And the following text should appear in the "DMR Notification" pane
      |Notification:           |
      |Save as Draft. Discharge Orders may not be submitted.           |
      |Signed Admission Order Needed:           |
      |An electronic admit order does not exisit on this patient. Follow facility admission order entry process.  |
    And I click the "Reconcile and Submit" button
    And Text exact "Please Save as Draft and follow facility admission order process to continue discharge." should appear in the "WarningPopup" pane
    And I click the "Warning OK" button in the "Warning" pane
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
    And the following text should appear in the "DMR Notification" pane
      |Notification:           |
      |You may proceed with DMR, but Discharge Orders may not be submitted.           |
      |Signed Admission Order Needed:           |
      |An electronic admit order does not exisit on this patient. Follow facility admission order entry process.  |
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    #radiology
    And I enter "XR" in the "DMR-SearchForOrder" field in the "Search for order" pane
    And I select "XR ANKLE LT COMPLETE PORT" from the "Searched All Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And the following text should appear in the "DMR Notification" pane
      |Notification:           |
      |Save as Draft. Discharge Orders may not be submitted.           |
      |Signed Admission Order Needed:           |
      |An electronic admit order does not exisit on this patient. Follow facility admission order entry process.  |
    And I click the "Reconcile and Submit" button
    And Text exact "Please Save as Draft and follow facility admission order process to continue discharge." should appear in the "WarningPopup" pane
    And I click the "Warning OK" button in the "Warning" pane
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
    And the following text should appear in the "DMR Notification" pane
      |Notification:           |
      |You may proceed with DMR, but Discharge Orders may not be submitted.           |
      |Signed Admission Order Needed:           |
      |An electronic admit order does not exisit on this patient. Follow facility admission order entry process.  |
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    #other
    And I enter "Add" in the "DMR-SearchForOrder" field in the "Search for order" pane
    And I select "Add other Provider-CPOE" from the "Searched All Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And the following text should appear in the "DMR Notification" pane
      |Notification:           |
      |Save as Draft. Discharge Orders may not be submitted.           |
      |Signed Admission Order Needed:           |
      |An electronic admit order does not exisit on this patient. Follow facility admission order entry process.  |
    And I click the "Reconcile and Submit" button
    And Text exact "Please Save as Draft and follow facility admission order process to continue discharge." should appear in the "WarningPopup" pane
    And I click the "Warning OK" button in the "Warning" pane
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane


  @TwoMidnightPerformance @MedRecPerformance @OneWindow_TwoMidnightPerformance @OneWindow_MedRecPerformance
  Scenario: No admit orders, cannot submit non-medication added order hard stop
  Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Two Midnight" from the "Patient List" menu
    #Given "TWOMIDNIGHT, PATIENT5", admitted in the past "201" days, is on the patient list
    When I select patient "TWOMIDNIGHT, PATIENT5" from the patient list
    And I select "Home Meds" from clinical navigation
    #And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
    And the following text should appear in the "DMR Notification" pane
      |Notification:           |
      |You may proceed with DMR, but Discharge Orders may not be submitted.           |
      |Signed Admission Order Needed:           |
      |An electronic admit order does not exisit on this patient. Follow facility admission order entry process.  |
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "zofran tablet" in the "DMR-SearchForOrder" field in the "Search for order" pane
    And I select "Zofran tablet (ondansetron HCl)  8 MG oral Q8H" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Reconcile and Submit" button
    And I click the "Search" button
    Then I select "the first item" in the "Look Up" table
    And I click the "Look Up OK" button
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
    And the following text should appear in the "DMR Notification" pane
      |Notification:           |
      |You may proceed with DMR, but Discharge Orders may not be submitted.           |
      |Signed Admission Order Needed:           |
      |An electronic admit order does not exisit on this patient. Follow facility admission order entry process.  |
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    #lab
    And I enter "CBC" in the "DMR-SearchForOrder" field in the "Search for order" pane
    And I select "CBC W/MANUAL DIFFERENTIAL  STAT" from the "Searched All Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And the following text should appear in the "DMR Notification" pane
      |Notification:           |
      |Save as Draft. Discharge Orders may not be submitted.           |
      |Signed Admission Order Needed:           |
      |An electronic admit order does not exisit on this patient. Follow facility admission order entry process.  |
    And I click the "Reconcile and Submit" button
    And Text exact "Please Save as Draft and follow facility admission order process to continue discharge." should appear in the "WarningPopup" pane
    And I click the "Warning OK" button in the "Warning" pane
    And I click the "DMR Save As Draft" button



  @TwoMidnightPerformance @MedRecPerformance @OneWindow_TwoMidnightPerformance @OneWindow_MedRecPerformance
  Scenario Outline: Negative test cases, submit medication and all types of non-medication added orders 
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Two Midnight" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    When I select patient "<Patient>" from the patient list
    And I select "Home Meds" from clinical navigation
    And I select "the first item" in the "Medication Reconciliation List" table
    And I click the "Discharge Med Rec List" button in the "Med Rec List" pane
    And Text exact "You may proceed with DMR, but Discharge Orders may not be submitted." should not appear in the "DMR Notification" pane
    And Text exact "This patient has an admission order that needs to be signed before discharge." should not appear in the "DMR Notification" pane
    And Text exact "An electronic admit order does not exisit on this patient. Follow facility admission order entry process." should not appear in the "DMR Notification" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    #lab
    And I enter "CBC" in the "DMR-SearchForOrder" field in the "Search for order" pane
    And I select "CBC W/MANUAL DIFFERENTIAL  STAT" from the "Searched Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    #nursing
    And I enter "POC" in the "DMR-SearchForOrder" field in the "Search for order" pane
    And I select "POC: ABG" from the "Searched All Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    #diet
    And I enter "Diet" in the "DMR-SearchForOrder" field in the "Search for order" pane
    And I select "Diet: Bariatric" from the "Searched All Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    #other
    And I enter "Add" in the "DMR-SearchForOrder" field in the "Search for order" pane
    And I select "Add other Provider-CPOE" from the "Searched All Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    #radiology
    And I enter "XR" in the "DMR-SearchForOrder" field in the "Search for order" pane
    And I select "XR ANKLE LT COMPLETE PORT" from the "Searched All Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "zofran tablet" in the "DMR-SearchForOrder" field in the "Search for order" pane
    And I select "Zofran tablet (ondansetron HCl)  8 MG oral Q8H" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And Text exact "You may proceed with DMR, but Discharge Orders may not be submitted." should not appear in the "DMR Notification" pane
    And Text exact "This patient has an admission order that needs to be signed before discharge." should not appear in the "DMR Notification" pane
    And Text exact "An electronic admit order does not exisit on this patient. Follow facility admission order entry process." should not appear in the "DMR Notification" pane
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    And I click the "Reconcile and Submit" button
    Then I sign and submit the order with default password
    And I select "the first item" in the "Medication Reconciliation List" table

    #these are all negative cases that messages should NOT appear
    #patient2 signed and authenticated admit order
    #patient3 signed admit order
    #patient4 authenticated admit order
    #patient7 signed/auth but with wrong finanical class
    #patient8 signed/auth but wrong visit type

  Examples:
  | Patient                |
  | TWOMIDNIGHT, PATIENT2  |
  | TWOMIDNIGHT, PATIENT3  |
  | TWOMIDNIGHT, PATIENT4  |
  | TWOMIDNIGHT, PATIENT7  |
  | TWOMIDNIGHT, PATIENT8  |



