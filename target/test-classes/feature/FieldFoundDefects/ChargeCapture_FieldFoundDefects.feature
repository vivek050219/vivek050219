Feature: ChargeCapture Field Found Defects
#  This test suite validates the defects which are found in CI.

  @ChargeCapture
  Scenario: 8.4.1:DEV-76864-Validate the error message for invalid DX code while submitting chtx
    Given I am logged into the portal with user "addchargeuser1" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Charges" from clinical navigation
    And I select "Last 2 Years" from the "ClinicalTimeframe" menu
    And patient "Molly Darr" has no charges
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      | Name     | Value     |
      | Svc Site | Inpatient |
    And I wait "2" seconds
    And I enter "08/30/2018" in the "Date" field in the "Charge Entry" pane
    And I enter the ICD-10 code "N35.8"
    And I enter the CPT code "78007"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane
    And I select "the first item" in the "Charges" table
    And I click the "Edit" button in the "Charge Detail" pane
    And I enter "%Current Date MMDDYYYY%" in the "Date" field in the "Charge Entry" pane
    And I enter the CPT code "86005"
    And I click the "Submit" button
    Then the text "Invalid IMO Diagnosis Description. Please make another selection." should appear in the "Charge Entry" pane
    And I wait "2" seconds
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "Invalid IMO Diagnosis Description. Please make another selection." should appear in the "Charge Entry" pane
    And I wait "2" seconds
    And I click the "Send to Outbox" button
    Then the text "Invalid IMO Diagnosis Description. Please make another selection." should appear in the "Charge Entry" pane
    Then I click the "Close" image
    And I select "Most Recent Visit" from the "ClinicalTimeframe" menu

  @HoldForReview
  Scenario:8.4.1:DEV-77581- Charges are not held for review with custom hold reasons when entered through Notewriter
    Given I am logged into the portal with user "HFR1" using the default password
    And I am on the "Admin" tab
    And I am on the manage hold for review page
    Then the "Manage Hold For Review Reasons" pane should load
#     Activating Custom Hold Reason
    And I activate the following reasons in manage hold for review pane
      | Custom Hold Test |
    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And patient "Molly Darr" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "86005"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "Held for Review: Custom Hold Test" should appear in the "Charge Entry" pane
    And I click the "Close" image
#     // Verify Custom Hold Reason In Notewriter
    When I select patient "Molly Darr" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "Add Charge" section
    Then the "NoteWriter Charge Entry" pane should load
    And I enter the ICD-10 code "B36.0" in the "NoteWriter Charge Entry" pane
    And I enter the CPT code "86003" in the "NoteWriter Charge Entry" pane
    And I click the "Validate Charge" button in the "Note Writer Main" pane
    Then the text "Held for Review: Custom Hold Test" should appear in the "NoteWriter Charge Entry" pane
    And I click the "NoteWriter Cancel Note" button in the "Note Writer Main" pane
    Then I click the "Yes" button in the "Question" pane
#      De-activating custom Reason
    And I am on the "Admin" tab
    And I am on the manage hold for review page
    Then the "Manage Hold For Review Reasons" pane should load
    And I deactivate the following reasons in manage hold for review pane
      | Custom Hold Test |
    And I click the "X-close" button in the "Manage Hold For Review Reasons" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box

  @ChargeCapture
  Scenario: 8.3.2:DEV-74802- Editing charge in HoldingBin without any error
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And patient "Molly Darr" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name      | Value       |
      | Bill Area | /Department |
      | Svc Site  | Inpatient   |
    And I enter the ICD-10 codes "B36.0"
    And I enter the CPT codes "00192"
    And I click the "Submit" button
    Then I wait "4" seconds
    And I am on the "Charges" tab
    And I select the "Holding Bin" subtab
    Then I click the "Reset Criteria" button in the "Holding Bin" pane
    And I select "Current Week" from the "Timeframe" dropdown in the "Holding Bin" pane
    And I select "500" from the "Limit Results" dropdown in the "HoldingBin" pane
    Then I click the "Show Charges" button in the "Holding Bin" pane
    And I sort the "Holding Bin" table chronologically by the "Date" column in "Descending" order
    And I select "the first item" in the "Holding Bin" table
    When I select the "None" link in the row with "None" as the value under "Edits" in the "Holding Bin" table
    Then the "Charge Details" pane should load
    And I click the "Cancel Charge Details" button

  @ChargeCapture
  Scenario: 8.1.7: DEV-75431- Charges With Free Text Error Allowed to be Sent to Outbox
# Below settings should be set for the level-2 user "addchargeuser2"
#  User's Charge Transaction Header settings allows Free Text for Referring
#  User's Charge Transaction Header settings causes Free Text Validity Errors for Referring
#  User's Charge Capture Settings have All Types of Charges Sent to the Holding Bin
#  User's Charge Capture Settings can Edit Charges in Outbox
#  User's Charge Capture Settings don't Allow Free Text Errors to go to Outbox
#  User's User Permissions Can Send Charges to Outbox
    Given I am logged into the portal with user "addchargeuser2" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Charges" from clinical navigation
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value            |
      | Bill Area    | Verve            |
      | Billing Prov | USER2, ADDCHARGE |
      | Svc Site     | Inpatient        |
    And I click the "Clear Selection Referring" element in the "Charge Entry" pane if it exists
    And I enter "freetexterror" in the "Referring" field
    And I enter the CPT codes "01462"
    And I enter the ICD-10 codes "B36.0"
    And I click the "Send to Outbox" button in the "Charge Entry" pane
    Then the text "Free text values are not allowed for Referring" should appear in the "Charge Entry" pane
    Then the text "The charge transaction has been saved as a COMPLETED transaction, but cannot be sent to Outbox due to errors. Choose the next step." should appear in the "Confirm" pane
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And I wait for loading to complete
    And I am on the "Charges" tab
    And I select the "Holding Bin" subtab
    And I click the "Reset Criteria" button in the "Holding Bin" pane
    And I select "Today" from the "Timeframe" dropdown in the "Holding Bin" pane
    And I check the "My Charges Only" checkbox in the "Holding Bin" pane
    And I click the "Show Charges" button in the "Holding Bin" pane
    And I sort the "Holding Bin" table chronologically by the "Date" column in "Descending" order
    Then rows containing the following should appear in the "Holding Bin" table
      | Patient     | Date                  | Edits           | Proc  |
      | DARR, MOLLY | %Current Date MMDDYY% | Free Text Error | 01462 |
    When I click the "Free Text Error" link in the "Holding Bin Results" pane
    Then the text "Free text values are not allowed for Referring" should appear in the "Charge Entry" pane
    Then the text "freetexterror" should appear in the "Charge Entry" pane
    And I click the "Send To Outbox Holding Bin" button in the "Charge Entry" pane
    Then the text "The charge transaction has been saved as a COMPLETED transaction, but cannot be sent to Outbox due to errors. Choose the next step." should appear in the "Confirm" pane
    And I click the "Save As Is" button in the "Confirm" pane if it exists

  @ChargeCapture
  Scenario: 8.3.0.14: DEV-76905- searching in Note from Add/Edit charge screen causes session to freeze (IE11 only)
    #This scenarios requires a quick text to be created with very long text to add in the note
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "PatientnarrativeABCQTV2" element in the "NoteWriter" pane
    When I click on the text "longText" in the "ClickToInsert" pane
    Then the following text should appear in the "NoteWriter" pane
      | HISTORY OF PRESENT ILLNESS |
    And I sign/submit the "Progress Note" note
    And I select "Charges" from clinical navigation
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value            |
      | Bill Area    | Verve            |
      | Billing Prov | USER3, ADDCHARGE |
      | Svc Site     | Inpatient        |
    And I click the "Clinical Note" button in the "Charge Entry" pane
    When I select "Progress Note" from the "Note Type" column in the "ClinicalNotesListTable" table
    Then the "ClinicalNoteBody" pane should load
    And I enter the following text in the "NoteSearch" field
      | and    |
      | the    |
      | car    |
      | pat    |
      | ill    |
      | not    |
      | see    |
      | all    |
      | sim    |
      | medica |
      | with   |
      | day    |
    And I click the "CloseSettings" button
    And I click the "Cancel Add Charge" button