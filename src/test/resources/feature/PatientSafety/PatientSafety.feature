@PatientSafety
Feature: Patient Safety

#  Work-around for: # DEV-84913 -- HCA Progress Note template text boxes not displaying when click exam buttons, like Eyes, ENT, Ears, etc
  #No: 1a
  Scenario: 1a. Setup - Enable QuickText v2 [DEV-84913]
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "true" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
    And I select "true" from the "Enable Spell Check" radio list in the "Note Writer Settings" pane
    And I select "None" from the "Validation" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box

# IE has trouble with sendKeys().  It can't react as fast as sendkeys() and sometimes the whole word doesn't get entered.
#  It leaves random letters out of the word, like tet, tes, tst, etc.
#  Changed "Test" to all lower case which sometimes helps.
  #No: 1b
  Scenario: 1b. Modified Medication orders associated with custom field sets do not send updated field responses
    Given I am logged into the portal with user "pkadmin" using the default password
    Then I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    When I enter "jcoffman patient safety" in the "Add Order" field in the "Enter Orders" pane
    And I select "jcoffman patient safety Amni Daily 30 MLS/HR" from the "NonFormulary Med Orders" list in the search results
    Then I enter "test" in the "Special Instructions" field
    And I click the "Done" button in the "Edit Order" pane
    And I wait "1" second
    When I select "jcoffman patient safety Amni Daily 30 MLS/HR (test)" in the "NewOrders" table
    And I change the custom order's IV drip rate from "30 MLS/HR" to "50 MLS/HR"
    And I click the "Done" button in the "Edit Order" pane
    And I wait "1" second
    Then the following rows should appear in the "NewOrders" table
      | New Orders                                          |
      | jcoffman patient safety Amni Daily 50 MLS/HR (test) |
    And I click the "Add Order Cancel" button
    And I click the "Yes" button


#  HCA NW templates are old non-responsive design templates -- look lke old 8x templates
  #No: 2a
  Scenario: 2a. Progress note data is saved when note is saved as draft in HCA NW template
    Given I am logged into the portal with user "pkadmin" using the default password
    Then I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I wait "1" second
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Objective" section
    And I wait "2" seconds
    And I save the timestamp of the HCA note under "note_timestamp" in persistent state
    When I click the "Exam Eyes Normal" button in the "NoteWriterForm" pane
    Then I enter "PERL. Sclerae nonicteric. Conjunctivae pink. extra text" in the "Exam Eyes" field in the "NoteWriterForm" pane
    When I click the "Exam Nose Normal" button in the "NoteWriterForm" pane
    Then I enter "Mucous membranes moist. Oropharynx without enanthem nor. extra text" in the "Exam Nose" field in the "NoteWriterForm" pane
    And I click the "Save as Draft" button
    And I click the "Yes" button
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    Then I select the item under the "Date/Time" column in the "Clinical Notes" table that matches the value under "note_timestamp" in persistent state
    And I click the "Edit Note" button
    When I select the note "Objective" section
    And I wait "2" seconds
    Then the value in the "Exam Eyes" field in the "NoteWriterForm" pane should be "PERL. Sclerae nonicteric. Conjunctivae pink. extra text"
    Then the value in the "Exam Nose" field in the "NoteWriterForm" pane should be "Mucous membranes moist. Oropharynx without enanthem nor. extra text"
    And I click the "NoteWriterCancelNote" button
    And I click the "Yes" button


# DEV-84448 #9x Classic: Note date-time is off by a day or 12 hours
  #No: 2b
#  Marking as @donotrun for now until we're back to using the the responsive design NW templates
  @donotrun
  Scenario: 2b. Progress note data is saved when note is saved as draft[DEV-84448]
    Given I am logged into the portal with user "pkadmin" using the default password
    Then I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Exam" section
    And I wait "2" seconds
    And I save the timestamp of the note under "note_timestamp" in persistent state
    When I click the "ExamEyesNormal" button
    Then I enter "PERL. Sclerae nonicteric. Conjunctivae pink. extra text" in the "Exam Eyes" field
    When I click the "ExamENTNormal" button
    Then I enter "Mucous membranes moist. Oropharynx without enanthem nor. extra text" in the "Exam ENT Mouth" field
    And I click the "Save as Draft" button
    And I click the "Yes" button in the "NW Question Dialog" pane
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    Then I select the item under the "Date/Time" column in the "Clinical Notes" table that matches the value under "note_timestamp" in persistent state
    And I click the "Edit Note" button
    And the "Note Writer" pane should load
    When I select the note "Exam" section
    And I wait "2" seconds
    Then the value in the "Exam Eyes" field should be "PERL. Sclerae nonicteric. Conjunctivae pink. extra text"
    Then the value in the "Exam ENT Mouth" field should be "Mucous membranes moist. Oropharynx without enanthem nor. extra text"
    And I click the "NoteWriterCancelNote" button
    And I click the "Confirm" button in the "NW Question Dialog" pane


  #No: 3
  Scenario: 3. Validate Lab Comments
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Lab Results" from clinical navigation
    And I select "Panel Summary" from the "Lab Results View" menu
    When I select a lab result with a comment
    And I select the corresponding lab result in the Panel Table
    Then the content of the "Comment Inner Div" div should match the value stored at "tooltip" in persistent state

    #No: 4a
  Scenario: 4a. Preselected labs and tests populate an HCA NoteWriter template with associated dates
    Given I am logged into the portal with user "pkadmin" using the default password
    Then I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    When I select "Lab Results" from clinical navigation
    And I select "Expanded Panels" from the "Lab Results View" menu
    And I wait "1" second
    Then I select "the first item" in the "Lab Panels" table
    And I save column "2" through "3" under name "lab_result" in persistent state
    And I "check" the following
      | Include Lab/Note |
    When I select "Test Results" from clinical navigation
    And I wait "1" second
    Then I select "the first item" in the "Test Results" table
    And I wait "2" seconds
    And I save column "2" through "3" under name "test_result" in persistent state
    And I "check" the following
      | Include Test Result |
    And I select some text to add to the note
    And I click the "Add Selected Text" element
    And I wait "2" seconds
    When I select "Clinical Notes" from clinical navigation
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Data" section
    And I wait "2" seconds
    Then there should be a lab matching the lab I found with the proper date in the HCA note
    Then there should be a test result matching the test I found with the proper date in the HCA note
    And I click the "NoteWriterCancelNote" button
    And I click the "Yes" button
    And I clear or empty the HashMap


  #No: 4b
  #  Marking as @donotrun for now until we're back to using the the responsive design NW templates
  @donotrun
  Scenario: 4b. Preselected labs and tests populate NoteWriter template with associated dates
    Given I am logged into the portal with user "pkadmin" using the default password
    Then I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    When I select "Lab Results" from clinical navigation
    And I select "Expanded Panels" from the "Lab Results View" menu
    Then I select "the first item" in the "Lab Panels" table
    And I save column "2" through "3" under name "lab_result" in persistent state
    And I "check" the following
      | Include Lab/Note |
    When I select "Test Results" from clinical navigation
    Then I select "the first item" in the "Test Results" table
    And I save column "2" through "3" under name "test_result" in persistent state
    And I select some text to add to the note
#    Then I press "CTRL + A" to highlight all the text in the detail's "ContentDiv" div
    And I click the "Add Selected Text" element
    And I wait "2" seconds
    When I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Data" section
    And I wait "2" seconds
    Then there should be a lab matching the lab I found with the proper date
    Then there should be a test result matching the test I found with the proper date
    And I click the "NoteWriterCancelNote" button
    And I click the "Confirm" button in the "NW Question Dialog" pane
    And I clear or empty the HashMap


  #No: 5
  Scenario: 5. Patient demographics display correctly
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Patient Detail" from clinical navigation
    Then these rows should appear in the "Demographic Info" table
      | Name | DARR, MOLLY |
      | DOB  | 12/22/1938  |
    And I check the patient's MRN against the database
    And the text "5G.501.A.PKHospital-Central" should appear in the "Location" field in the "InFacility Visit" section of the "Patient Detail" table


  #No: 6
  Scenario: 6. Verify the full body of text appears in the test result
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Test Results" from clinical navigation
    And I select "the first item" in the "Test Results" table
    And I save column "2" through "3" under name "my_test_result" in persistent state
    And I store the "DOC_TXT" column from the "PatientTests" query with the following additional columns and filtered by the currently selected patient, the following additional filters on the value stored at "my_test_result" under name "test_result_query"
      | DOC_TXT | end_eff_dttm   |
      |         | typ_cd.cd_desc |
    When I add the title of the test to the value stored at "test_result_query" in persistent state
    Then the content of the "TestResultTextDiv" div should match the value stored at "test_result_query" in persistent state


  #No: 7
  Scenario: 7. Verify Units in Vitals
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Vitals" from clinical navigation
    Then these rows should appear in the "Vital Signs" table
      |  | Temp    | F     |
      |  | Weight  | kg    |
      |  | FSBG    | mg/dL |
      |  | HR      | /min  |
      |  | Height  | cm    |
      |  | O2sat   | %     |
      |  | RR      | /min  |
      |  | SBP/DBP | mmHg  |


  #No: 8. For the following two scenarios:
  #TODO: Still need to check that the value in the 'Vital Signs' table matches the value in the table displaying vitals over a period of time
  Scenario: 8. Verify Time/Date displays in Vitals
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Vitals" from clinical navigation
    Then each row in the "Vital Signs" table in the "Most Recent" column should match the regex "\d\d\/\d\d\/\d\d \d\d:\d\d(AM|PM)"
  #And the values of the following vitals in the "Most Recent" column should


  #No: 9
  Scenario: 9. Verify blood pressure formatting
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Vitals" from clinical navigation
    Then rows containing the following should appear in the "Vital Signs" table
      | SBP/DBP |
    And the patient's "Most Recent" "SBP/DBP" vitals should match their values in the database


  #No: 10
  Scenario: 10. Verify most recent vitals
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Vitals" from clinical navigation
    Then the patient's "Most Recent" vitals should match their values in the database


#    DEV-84511 -- The most current Previous Vital for FSBG vital sign is not listed correctly and doesn't match the Db
  #No: 11
  Scenario: 11. Verify previous (second most recent) vitals[DEV-84511]
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Vitals" from clinical navigation
    Then the patient's "Previous" vitals should match their values in the database


  #No: 12
  Scenario: 12. Validate Allergy Data in CPOE and MedRec
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I store the "Allergy" column from the "PatientAllergies" query run using the currently selected patient under name "allergies"
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    Then the "Enter Orders" pane should load
    Then the "OrderEntryAllergiesPreview" allergy div should match the value stored at "allergies" in persistent state
    And I click the "AddOrderCancel" button
    And I wait "2" seconds
    When I select "Admission Med Rec" from the "Patient Header Actions" menu
    Then the "Admission Medication Reconciliation" pane should load
#  within "5" seconds
    Then the "MedRecAllergiesPreview" allergy div should match the value stored at "allergies" in persistent state
    And I click the "MedRecCancel" button
    And I click the "Yes" button in the "Question" pane


  #No: 13
  Scenario: 13. Labs - Validate CBC fishbone diagram
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    When I select "Lab Results" from clinical navigation
    And I select "Expanded Panels" from the "Lab Results View" menu
    Then I select a lab with a blood content diagram and save the diagram's contents to persistent state under name "portal_bloodlab"
    And I save column "2" through "3" under name "bloodlab_datetime" in persistent state
    And I store the results of the "PatientBloodLabMostRecent" query and filtered by the currently selected patient, the following additional filters on the value stored at "bloodlab_datetime" under name "db_bloodlab"
      |  | end_eff_dttm     |
      |  | panel_cd.cd_desc |
    Then the contents of the selected fishbone table stored at "portal_bloodlab" should match the database values stored at "db_bloodlab" in persistent state


  #No: 14
  Scenario: 14. Labs - Validate BMP fishbone diagram
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    When I select "Lab Results" from clinical navigation
    And I select "Expanded Panels" from the "Lab Results View" menu
    Then I select a lab with a chemical diagram and save the diagram's contents to persistent state under name "portal_chemlab"
    And I save column "2" through "3" under name "chemlab_datetime" in persistent state
    And I store the results of the "PatientLabMostRecent" query and filtered by the currently selected patient, the following additional filters on the value stored at "chemlab_datetime" under name "db_chemlab"
      |  | end_eff_dttm     |
      |  | panel_cd.cd_desc |
    Then the contents of the selected fishbone table stored at "portal_chemlab" should match the database values stored at "db_chemlab" in persistent state


  #No: 15
  Scenario: 15. Labs - Validate UI against database
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Lab Results" from clinical navigation
    And I select "Panel Summary" from the "Lab Results View" menu
#    And I select "Last 30 Days" from the "Clinical Timeframe" menu
    Then the contents of the "LabPanels" clinical table should match the results of the "Patient Labs" query


  #No: 16
  Scenario: 16. Validate Net I/O Calculation
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "I/O" from clinical navigation
    Then the difference between each value in row Intake and row Output should equal the value in row Net in the I/O table


  #No: 17
  Scenario: 17. Validate Clinical Note Body
    Given I am logged into the portal with user "pkadmin" using the default password
    Then I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    When "Roy Blazer" is on the patient list
    And I refresh the patient list
    And I wait "2" seconds
    Then I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
#    And I select "Last 30 Days" from the "Clinical Timeframe" menu
    And I click the "Clinical Notes Filter" button in the "Clinical Notes Detail" pane
    And I wait "2" seconds
    And I "check" the following checkbox in the "Clinical Filter" pane
      | Select All/Select None |
    And I click the "OK Filter" button
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Ascending" order
    When I select "the first item" in the "Clinical Notes" table
    And I save column "2" through "3" under name "note_info" in persistent state
    When I store the "DOC_TXT" column from the "PatientNotesBody" query with the following additional columns and filtered by the currently selected patient, the following additional filters on the value stored at "note_info" under name "notes_query"
      |  | c_obs.end_eff_dttm |
      |  | nte_code.cd_desc   |
    Then the content of the "NoteContentDiv" div should match the value stored at "notes_query" in persistent state


  #No: 18
  #TODO: Review scenario after investigation of DEV-69129 is resolved.
  #Unable to compare Med strings to DB due to complicated logic that builds the string at run-time.
  #May be possible to validate strings in the future based on outcome of DEV-69129.
  @donotrun
  Scenario: 18. Validate Active Medications Filter
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Roy Blazer", admitted in the last "5" days, is on the patient list
    And I select patient "Roy Blazer" from the patient list
    And I select "Medications" from clinical navigation
#    And I select "Last 5 Years" from the "Clinical Timeframe" menu
    #And I check the "Show Active Only" checkbox
    And I "check" the following
      | Show Active Only |
    Then the contents of the "Medication Orders" clinical table should match the results of the "Patient Active Medications" query
    #And I uncheck the "Show Active Only" checkbox
    And I "uncheck" the following
      | Show Active Only |
    Then the contents of the "Medication Orders" clinical table should match the results of the "Patient All Medications" query


#  DEV-85655 -- Automation: 9x Classic: Existing meds are not getting loaded into environment from simpk
#TODO: refactor the query in this test, in the last step, to not be getting all of the patients, just the one patient you're looking at
  #No: 19
  Scenario: 19. Validate order list is correct after patient context switch[DEV-85655]
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And "Roy Blazer", admitted in the last "5" days, is on the patient list
    And I select patient "Roy Blazer" from the patient list
    And I select "Orders" from clinical navigation
    And I "uncheck" the following checkbox in the "Orders" pane
      | Show Active Only |
    And I select "Yesterday" from the "Past Order Date" dropdown
    And I select "All Future" from the "Future Order Date" dropdown
    And I select patient "Molly Darr" from the patient list
    #Only validates orders from the DB that have a pre-generated string in the CPOE_DESCRIPTION column of c_order.
    Then the contents of the "Orders" clinical table should contain the results of the "Patient Orders Since Yesterday" query


  #No: 20
#  IE keeps failing to enter text in textboxes b/c sendkeys() types faster than it can react.
#  ** Especially when that text is transformed and reactively added to other elements on screen.
#  ** Made word "Test" all lower, which usually helps, but is still failing in IE.
#  ** Random letters with no apparent pattern are left out of words.  For ex, here it enters "test"; sometimes it'll enter "tst", "tes", or "tet", etc.
#  ** Removing step to enter "test" in Special Instructions b/c is not needed to test this scenario.
#  ** Which means now needed new PDFs

#  DEV-85873 -- Dose multiselect for IV orders does not list the dose or "Special Instructions" options
  Scenario: 20. Validate Order Fields in PDF print-out when Other field populated with numeric value (DEV-51709)[DEV-85873]
    Given I am logged into the portal with user "pkadmin" using the default password
    Then I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Mona Angeline", admitted in the last "5" days, is on the patient list
    And I select patient "Mona Angeline" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I click the "OK" button in the "Warning" pane if it exists
    When I enter "Morphine 30 mg" in the "Add Order" field in the "Enter Orders" pane
#    And I select "morphine 30 mg/30 mL (1 mg/mL) IV PCA Syringe IV" from the "NonFormulary Med Orders" list in the search results
    And I select "morphine 30 mg/30 mL (1 mg/mL) IV PCA Syringe" from the "NonFormulary Med Orders" list in the search results
#    And I select "Special Instruction" from the "Dose" multiselect
    And I select "30 mg" from the "Dose" multiselect
    And I select "Daily" from the "Frequency" multiselect
    When I click the "Doses" radio
    Then I enter "10" in the "Doses Textbox" field in the "Enter Orders" pane
#    And I enter "test" in the "Special Instructions" field
    When I click the "Other" radio
    Then the "Enter Other Choice Text" pane should load within "3" seconds
    And I enter "10" in the "Other Choice" field
    And I click the "OK Dialog" button in the "Enter Other Choice Text" pane
    And I click the "Done" button in the "Edit Order" pane
    And I Submit the Orders
    #And I save the Submission Record ID for the "morphine 30 mg/30 mL (1 mg/mL) IV PCA Syringe IV Daily (Test)" order
    #When I save the Submission Record ID for the "morphine 30 mg/30 mL (1 mg/mL) IV PCA Syringe Daily X 10 doses (Test)" order
    #When I save the Submission Record ID for the "morphine 30 mg/30 mL (1 mg/mL) IV PCA Syringe IV Daily X 10 doses (test)" order
    #When I save the Submission Record ID for the "morphine 30 mg/30 mL (1 mg/mL) IV PCA Syringe IV Daily X 10 doses" order
    When I select "morphine 30 mg/30 mL (1 mg/mL) IV PCA Syringe 30 mg IV Daily X 10 doses" from the "Existing orders for" column in the "Orders" table
    Then I save the Submission Record ID for the "morphine 30 mg/30 mL (1 mg/mL) IV PCA Syringe 30 mg IV Daily X 10 doses" order
    Then I verify the "patient_safety_dev51709" PDF output using the "StandardPDFOutput" output directory and the "ExpectedOutput" expected directory


#DEV-85426 -- Discontinued hospital orders are not included on print-out pdf
  #No: 21
  Scenario: 21. Verify discontinued hospital orders are included on print-out[DEV-85426]
    Given I am logged into the portal with user "pkadmin" using the default password
    Then I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Mona Angeline", admitted in the last "5" days, is on the patient list
    And I select patient "Mona Angeline" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I click the "OK" button in the "Warning" pane if it exists
    When I enter "Caffeine" in the "Add Order" field in the "Enter Orders" pane
    And I wait "2" seconds
#    And I select "caffeine 200 mg tablet Oral" from the "NonFormulary Med Orders" list in the search results
#    And I select "caffeine tablet 200MG Oral" from the "NonFormulary Med Orders" list in the search results
    And I select "caffeine tablet 200MG" from the "NonFormulary Med Orders" list in the search results
    And I select "Daily" from the "Frequency" multiselect
    And I click the "Done" button in the "Edit Order" pane
    And I Submit the Orders
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link in the "Admission Medication Reconciliation" pane
#    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then I enter "caffeine tablet 200 mg" in the "Search for order" field in the "Search for order" pane
#    And I select "caffeine 200 mg tablet Oral" from the "Searched Combined Med Orders" list in the search results
#    And I select "caffeine tablet 200MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I select "caffeine tablet 200MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                      | Action for Hospitalization | Hospital Orders*                            |
      | New: caffeine tablet 200 mg Oral Daily | Continue / Change          | Existing: caffeine tablet 200 mg Oral Daily |
#    And I choose "Discontinue" option by clicking "Edit" icon against "Existing: caffeine tablet 200 mg Oral Daily" text in the row with "New: caffeine tablet 200 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I choose "Discontinue" option by clicking "Edit" icon against "Existing: caffeine tablet 200 mg Oral Daily" text in the row with "New: caffeine tablet 200 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Yes" button if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Home Medications*                      | Action for Hospitalization | Hospital Orders*                                |
      | New: caffeine tablet 200 mg Oral Daily | Stop                       | Discontinued: caffeine tablet 200 mg Oral Daily |
    And I click the "Reconcile and Submit" button
    And I wait "2" seconds
    And I click the "Submit Partial Med Rec" button if it exists
    And I wait "4" seconds
    When I select "caffeine tablet 200 mg Oral Daily" from the "Existing orders for" column in the "Orders" table
    Then I save the Submission Record ID for the "caffeine tablet 200 mg Oral Daily" order
#    01/07/20 @4:21am run: Got the correct Submission Record ID: 145165 (@ 3:56am) the first time, but then this step below failed.
#    And I wait for the updated PDF to generate
    Then I verify the "RouteSubmission" PDF output using the "StandardPDFOutput" output directory and the "ExpectedOutput" expected directory


 #No: 22
  Scenario: 22. Verify previously reconciled hospital orders are included on print-out (DEV-73010)
    Given I am logged into the portal with user "pkadmin" using the default password
    Then I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Alfred VerveMoon", admitted in the last "5" days, is on the patient list
    And I select patient "Alfred VerveMoon" from the patient list
    And I select "Orders" from clinical navigation
    When I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link in the "Admission Medication Reconciliation" pane
    Then I enter "caffeine tablet" in the "Search for order" field in the "Search for order" pane
#    And I select "caffeine 200 mg tablet Oral" from the "Searched Combined Med Orders" list in the search results
#    And I select "caffeine tablet 200MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I select "caffeine tablet 200MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane
    And I select the "Continue" radio in the row with "New: caffeine tablet 200 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
#    And I select the "Continue" radio in the row with "New: caffeine tablet 200 mg Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Yes" button if it exists
    And I click the "Reconcile and Submit" button
    And I click the "Submit Partial Med Rec" button if it exists
    When I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link in the "Admission Medication Reconciliation" pane
    And I wait "2" seconds
    Then I enter "caffeine tablet" in the "Search for order" field in the "Search for order" pane
#    #And I select "caffeine 200 mg tablet Oral" from the "Searched Combined Med Orders" list in the search results
#    #And I select "caffeine tablet 200MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I select "caffeine tablet 200MG" from the "Searched Combined Med Orders" list in the search results
    And I select "Weekly" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    And I move the mouse over the "Continue / Change" text in the row with "New: caffeine tablet 200 mg Oral Weekly" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with "New: caffeine tablet 200 mg Oral Weekly" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Yes" button if it exists
    And I click the "Reconcile and Submit" button
    And I wait "1" second
    And I click the "Submit Partial Med Rec" button if it exists
    And I wait "1" second
    When I select "caffeine tablet 200 mg Oral Daily" from the "Existing orders for" column in the "Orders" table
    And I wait "3" seconds
    And I save the Submission Record ID for the "caffeine tablet 200 mg Oral Daily" order
    Then I verify the "patient_safety_dev73010_pdf1" PDF output using the "StandardPDFOutput" output directory and the "ExpectedOutput" expected directory
    And I wait for the updated PDF to generate
    Then I verify the "patient_safety_dev73010_pdf2" PDF output using the "StandardPDFOutput" output directory and the "ExpectedOutput" expected directory


#    DEV-85388 -- HCA Discharge Note added via the UI not listed in Clinical Notes but is listed in db
#  A Progress Note with a Discharge Note added as an addendum was added to Molly Darr.  Addenda do not show up in the Clinical Notes as separate notes.
#  But, they do show up in the db as separate notes.  This is as-designed and the addendum is not a typical workflow per Lisa Nolan.
#  Switching this patient to get around this.
    #No: 23
  Scenario: 23. Validate Clinical Notes
    Given I am logged into the portal with user "pkadmin" using the default password
    Then I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I refresh the clinical display
    And I click the "Load More Notes Data" button
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I delete all the draft notes
    And I wait "2" seconds
#    This step below keeps failing if there are any draft notes in the list.  Added step above to delete all drafts.
#    Then the contents of the "Clinical Notes" clinical table should contain the results of the "Patient Notes + Patient NoteWriter Notes Not Draft + Patient NoteWriter Notes Users Draft" query
    Then the contents of the "Clinical Notes" clinical table should contain the results of the "Patient Notes + Patient NoteWriter Notes Not Draft" query


  #TODO: Create Clinical Notes test that uses the "Load More" functionality

  #No: 22
#  Scenario: Clinical Notes validate Last 24 Hours timeframe filter
#    Given I am logged into the portal with user "pkadmin" using the default password
#    And I am on the "Patient List V2" tab
#    And I select "Card Group" from the "Patient List" menu
#    And "Molly Darr" is on the patient list
#    And I select patient "Molly Darr" from the patient list
#    And I select "Clinical Notes" from clinical navigation
#    And I select "Last 24 Hours" from the "Clinical Timeframe" menu
#    Then the contents of the "Clinical Notes" clinical table should contain the results of the "Patient Notes + Patient NoteWriter Notes Not Draft + Patient NoteWriter Notes Users Draft" query filtered by "timeframe" of "Last 24 Hours"


  #No: 23
#  Scenario: Clinical Notes validate Last 72 Hours timeframe filter
#    Given I am logged into the portal with user "pkadmin" using the default password
#    And I am on the "Patient List V2" tab
#    And I select "Card Group" from the "Patient List" menu
#    And "Molly Darr" is on the patient list
#    And I select patient "Molly Darr" from the patient list
#    And I select "Clinical Notes" from clinical navigation
#    And I select "Last 72 Hours" from the "Clinical Timeframe" menu
#    Then the contents of the "Clinical Notes" clinical table should contain the results of the "Patient Notes + Patient NoteWriter Notes Not Draft + Patient NoteWriter Notes Users Draft" query filtered by "timeframe" of "Last 72 Hours"



#  Scenario: Clinical Notes validate Last 7 Days timeframe filter
#    Given I am logged into the portal with user "pkadmin" using the default password
#    And I am on the "Patient List V2" tab
#    And I select "Card Group" from the "Patient List" menu
#    And "Molly Darr" is on the patient list
#    And I select patient "Molly Darr" from the patient list
#    And I select "Clinical Notes" from clinical navigation
#    And I select "Last 7 Days" from the "Clinical Timeframe" menu
#    Then the contents of the "Clinical Notes" clinical table should contain the results of the "Patient Notes + Patient NoteWriter Notes Not Draft + Patient NoteWriter Notes Users Draft" query filtered by "timeframe" of "Last 7 Days"


  #No: 24a
  Scenario: 24a. Validate that NoteWriter displays the most recent visit of the patient in an HCA Note [AUTO-193]
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "Card Group" from the "Patient List" menu
    And "Mona Angeline" is on the patient list
    And I select patient "Mona Angeline" from the patient list
    And I save the patient ID under name "patientID" in persistent state
    When I select "Clinical Notes" from clinical navigation
    And I load the "HCA Progress Note" template note for the selected patient
    Then the most recent visit should be selected by default in the HCA Note "NoteVisitInfo" pane for the patient id stored at "patientID" in persistent state
    And I click the "NoteWriterCancelNote" button
    And I click the "Yes" button if it exists


    #  Marking as @donotrun for now until we're back to using the the responsive design NW templates
    #No: 24b
  @donotrun
  Scenario: 24b. Validate that NoteWriter displays the most recent visit of the patient [AUTO-193]
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "Card Group" from the "Patient List" menu
    And "Mona Angeline" is on the patient list
    And I select patient "Mona Angeline" from the patient list
    And I save the patient ID under name "patientID" in persistent state
#    When I select "Clinical Notes" from clinical navigation
    And I select "Write Note" from the "Patient Header Actions" menu
    Then the "Write A Note" pane should load
#    And I load the "Progress Note" template note for the selected patient
    Then the most recent visit should be selected by default in the Note "Write Note" pane for the patient id stored at "patientID" in persistent state
    And I click the "Cancel Template Select" button