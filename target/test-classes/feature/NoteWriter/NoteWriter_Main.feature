@PortalSmoke
Feature: NoteWriter Main
  First draft of NoteWriter Main cucumber cases.  Only includes Portal Smoke cases at the moment.

  Background:
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    When "Molly Darr" is on the patient list
    Then I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation


  Scenario: 1a. Prereq - Enable QuickText v2
    Given I am on the "Admin" tab
    Then I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "true" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
    And I select "true" from the "Enable Spell Check" radio list in the "Note Writer Settings" pane
    And I select "None" from the "Validation" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box


  Scenario: 1b. Test Setup
    Given the following Notewriter templates should be loaded
      | HCA History and Physical |
      | HCA Progress Note        |
      | History and Physical     |
      | Progress Note            |
    Then I am on the "Admin" tab
    When I select the "Department" subtab
    And I select the department "Verve"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "NoteWriter" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
    And I click the "Note Pickers" edit link in the "Note Writer Settings" pane
    Then the following note pickers should be available for the "Verve" department
      | Progress Note            |
      | History and Physical     |
      | HCA Progress Note        |
      | HCA History and Physical |
    And I click the "Close" button in the "Department Note Pickers" pane
    And I select the "Institution" subtab
    Then the "Institution Settings" pane should load
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I select "None" from the "Validation" dropdown
    And I wait "2" seconds
    And I select "false" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box


  Scenario: 2. Note Template Selection Loads
    When I select patient "Molly Darr" from the patient list
    And I select "Write Note" from the "Patient Header Actions" menu
    And I wait "2" seconds
#    And I click the "Write A Note Expand" button if it exists
    And the "Write A Note" toggle is open
    Then the "Write A Note" pane should load
    When I click the "Cancel Template Select" button


  Scenario: 3a. Sign Submit an HCA Note
    When I select patient "Molly Darr" from the patient list
    And I load the "HCA Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "Subjective" section
    And I wait "2" seconds
    And I sign/submit the "HCA Progress Note" note
    Then rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type     | Author          |
      | %Current Date MMDDYY% | Progress Note | KADMINV2, PERRY |
		#make sure we're looking at the most recent
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the text "Final" should appear in the "Progress Note" pane


#  Marking as @donotrun for now until we're back to using the the responsive design NW templates
  @donotrun
  Scenario: 3b. Sign Submit Note[DEV-44354]
    When I select patient "Molly Darr" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "Subjective" section
    And I wait "2" seconds
    And I sign/submit the "Progress Note" note
    Then rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type     | Author          |
      | %Current Date MMDDYY% | Progress Note | KADMINV2, PERRY |
		#make sure we're looking at the most recent
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the "Progress Note" pane should load
    And the text "Final" should appear in the "Progress Note" pane


  Scenario: 4a. Draft an HCA Note
    When I select patient "Molly Darr" from the patient list
    And I load the "HCA Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "Subjective" section
    And I enter "Draft an HCA Note" in the "Chief Complaint" field
    And I click the "Save as Draft" button
    And I click the "Yes" button
    Then rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type             | Author          |
      | %Current Date MMDDYY% | *DRAFT* Progress Note | KADMINV2, PERRY |
		#make sure we're looking at the most recent
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the text "Draft" should appear in the "Progress Note" pane


    #  Marking as @donotrun for now until we're back to using the the responsive design NW templates
  @donotrun
  Scenario: 4b. Draft Note
    When I select patient "Molly Darr" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "Subjective" section
    And I enter "Draft a Note" in the "Patient Narrative" field
    And I click the "Save as Draft" button
    And I click the "Yes" button in the "NW Question Dialog" pane
    Then rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type             | Author          |
      | %Current Date MMDDYY% | *DRAFT* Progress Note | KADMINV2, PERRY |
		#make sure we're looking at the most recent
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "*DRAFT* Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the "Progress Note" pane should load
    And the text "Draft" should appear in the "Progress Note" pane


  Scenario: 5a. Enter QuickText in an HCA Note
    When I select patient "Molly Darr" from the patient list
    And I load the "HCA Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "Subjective" section
    And I enter "Patient Narrative manual text entry" in the "HCA Patient Narrative" field
    And I click the "ENTER" key in the "HCA Patient Narrative" text field
    And I click the "PatientNarrativeQT" button
    And I wait "2" seconds
    And I click on the text "classic" in the "Click To Insert Patient Narrative" pane
    And I click the "CloseQuickText" button
    And I wait "2" seconds
    And I sign/submit the "HCA Progress Note" note
    Then rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type     | Author          |
      | %Current Date MMDDYY% | Progress Note | KADMINV2, PERRY |
		#make sure we're looking at the most recent
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the text "Patient Narrative manual text entry" should appear in the "Patient Narrative" section in the "Progress Note" pane
    Then the text "classic mode quick text" should appear in the "Patient Narrative" section in the "Progress Note" pane


#  Marking as @donotrun for now until we're back to using the the responsive design NW templates
  @donotrun
  Scenario: 5b. Enter QuickText in a Note
    When I select patient "Molly Darr" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "Subjective" section
    And I enter "patient narrative manual text entry" in the "Patient Narrative" field
    And I click the "ENTER" key in the "Patient Narrative" text field
    And I click the "PatientnarrativeABCQTV2" element in the "Note Writer" pane
    And I wait "2" seconds
    And I click on the text "classic" in the "Click To Insert V2" pane
    And I click the "CloseQuickText" button
    And I wait "2" seconds
    And I sign/submit the "Progress Note" note
    Then rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type     | Author          |
      | %Current Date MMDDYY% | Progress Note | KADMINV2, PERRY |
		#make sure we're looking at the most recent
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the "Progress Note" pane should load
    And the text "patient narrative manual text entry" should appear in the "Subjective" section in the "Progress Note" pane
    And the text "classic mode quick text" should appear in the "Subjective" section in the "Progress Note" pane


  Scenario: 6a. Verify Post-selection of Clinicals in Data tab of an HCA Note
    When I select patient "Molly Darr" from the patient list
    And I load the "HCA Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "Data" section
    And I click the "Allergies" link in the "NoteWriter" pane
    Then the "Patient Data" pane should load
    When I click the "NoteWriter Preselection Icon" image in the "Allergy List" pane
    And I click the "Lab Results" link in the "Patient Data Clinical Navigation" pane
    And I click the "NoteWriter Preselection Icon" image in the "Lab List" pane
    And I click the "Copy to Note" button in the "Patient Data" pane
    And the following text should appear in the "NoteWriter" pane
      | Text         |
      | Bee sting    |
      | Penicillin   |
      | Sulfonamides |
      | CBC          |
    And I wait "2" seconds
    And I sign/submit the "HCA Progress Note" note
    Then rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type     | Author          |
      | %Current Date MMDDYY% | Progress Note | KADMINV2, PERRY |
		#make sure we're looking at the most recent
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "Progress Note" from the "Note Type" column in the "Clinical Notes" table
    And the following text should appear in the "Progress Note" pane
      | Bee sting    |
      | Penicillin   |
      | Sulfonamides |
      | CBC          |



#  Marking as @donotrun for now until we're back to using the the responsive design NW templates
  @donotrun
  Scenario: 6b. Verify Post-selection of Clinicals in Data tab of Note
#      blocked by [DEV-81805]
    When I select patient "Molly Darr" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "Data" section
    And I click the "Allergies" link in the "NoteWriter" pane
    Then the "Patient Data" pane should load
    When I click the "NoteWriter Preselection Icon" image in the "Allergy List" pane
    And I click the "Lab Results" link in the "Patient Data Clinical Navigation" pane
    And I click the "NoteWriter Preselection Icon" image in the "Lab List" pane
    And I click the "Copy to Note" button in the "Patient Data" pane
    And the following text should appear in the "NoteWriter" pane
      | Text         |
      | Bee sting    |
      | Penicillin   |
      | Sulfonamides |
      | CBC          |
    And I wait "2" seconds
    And I sign/submit the "Progress Note" note
    Then rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type     | Author          |
      | %Current Date MMDDYY% | Progress Note | KADMINV2, PERRY |
		#make sure we're looking at the most recent
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the "Progress Note" pane should load
    And the following text should appear in the "Progress Note" pane
      | Section | Text         |
      | Data    | Bee sting    |
      | Data    | Penicillin   |
      | Data    | Sulfonamides |
      | Data    | CBC          |


  Scenario: 7a. Add Problems to an HCA History and Physical Note
    Given I select patient "Molly Darr" from the patient list
    Then I load the "HCA History and Physical" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    When I select the note "History" section
    And I enter "Pain in throat" in the "Past Medical History" field
    And I enter "None" in the "Past Surgical History" field
    When I check the "Coded Diagnosis" checkbox
    Then I click the "Past Medical History" radio in the "NoteWriterForm" pane
    When I enter "R07.0" in the "HCA History Diagnosis Search" field
    And I wait "1" second
    Then the text "Pain in throat" should appear in the "Past Medical History" section
    And I select the note "A/P" section
    When I enter "L98.8" in the "HCA AP Diagnosis Search" field
    Then the text "Other specified disorders of the skin and subcutaneous tissue" should appear in the "Problem Description" section
    And I wait "2" seconds
    And I sign/submit the "HCA History and Physical" note
    Then rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type          | Author          |
      | %Current Date MMDDYY% | History & Physical | KADMINV2, PERRY |
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History & Physical" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Progress Note" pane
      | Past Medical History  |
      | Pain in throat        |
      | Past Surgical History |
      | None                  |


    #  Marking as @donotrun for now until we're back to using the the responsive design NW templates
  @donotrun
  Scenario: 7b. Add Problems to History and Physical Note
    When I select patient "Molly Darr" from the patient list
    And I load the "History and Physical" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "History" section
#        And I select "true" from the "Past Medical History" radio list
    And I click the "Past Medical History Radio" element
    And I enter "R07.0" in the "History Diagnosis Search" field
    And I wait "1" second
    Then the text "Pain in throat" should appear in the "New Note" pane
    When I select the note "A/P" section
    And I enter "L98.8" in the "AP Diagnosis Search" field
    And I select "Other specified disorders of the skin and subcutaneous tissue" option from the "AP Problem Picker" list
    Then the text "Other specified disorders of the skin and subcutaneous tissue" should appear in the "New Note" pane
    And I wait "2" seconds
    And I sign/submit the "History and Physical" note
    Then rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type            | Author          |
      | %Current Date MMDDYY% | History and Physical | KADMINV2, PERRY |
		#make sure we're looking at the most recent
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the text "Past Medical History" should appear in the "Progress Note" pane
    And the text "Pain in throat" should appear in the "Progress Note" pane
    And the text "Assessment/Plan" should appear in the "Progress Note" pane
    And the text "Other specified disorders of the skin and subcutaneous tissue" should appear in the "Progress Note" pane
    And the text "Pain" should appear in the "Progress Note" pane


  Scenario: 8a. CC Integration in an HCA Note
    Given I am logged into the portal with user "addchargeuser1" using the default password
    Then I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    When "Molly Darr" is on the patient list
    Then I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA Progress Note" template note for the selected patient
    When I select the note "Add Charge" section
    Then the "NoteWriter Charge Entry" pane should load
    And I set the following charge headers in the "NoteWriter Charge Entry" pane
      | Name         | Value           |
      | Billing Prov | KADMINV2, PERRY |
      | Svc Site     | Inpatient       |
      | Bill Area    | Verve           |
    And I enter the ICD-10 code "H02.519" in the "NoteWriter Charge Entry" pane
    And I enter the CPT code "87101" in the "NoteWriter Charge Entry" pane
    And I wait "2" seconds
    And I sign/submit the "HCA Progress Note" note
    And I wait "2" seconds
    Then the "Note Writer Main" pane should close
    And rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type     | Author           |
      | %Current Date MMDDYY% | Progress Note | USER1, ADDCHARGE |
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the text "Final" should appear in the "Progress Note" pane
    When I select "Charges" from clinical navigation
    Then the following rows should appear in the "Charges" table
      | Date/Time             | Prov/Team       | Proc                     | Qty | Diag    |
      | %Current Date MMDDYY% | KADMINV2, PERRY | 87101 skin fungi culture | 1   | H02.519 |


#  Marking as @donotrun for now until we're back to using the the responsive design NW templates
  @donotrun
  Scenario: 8b. CC Integration in a Note
   #		blocked by DEV-82289
    Given I am logged into the portal with user "addchargeuser1" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And the text "DARR, MOLLY" should appear in the "New Note" pane
    And I select the note "Add Charge" section
    Then the "NoteWriter Charge Entry" pane should load
    And I set the following charge headers in the "NoteWriter Charge Entry" pane
      | Name         | Value           |
      | Bill Area    | Verve           |
      | Billing Prov | KADMINV2, PERRY |
      | Svc Site     | Inpatient       |
    And I enter the ICD-10 code "H02.519" in the "NoteWriter Charge Entry" pane
    And I enter the CPT code "87101" in the "NoteWriter Charge Entry" pane
    And I wait "2" seconds
    And I select the note "A/P" section
    And I select "Moderate" from the "LevelOfDecision" dropdown if it exists
    Then I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I click the "Warning OK" button in the "Warning Message" pane
    Then I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I click the "OK" button in the "Submit Note" pane
    And I wait "2" seconds
    Then the "Note Writer Main" pane should close
    And rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type     | Author           |
			#|%Current Date MMDDYY%  |Progress Note        |KADMINV2, PERRY |
      | %Current Date MMDDYY% | Progress Note | USER1, ADDCHARGE |
		#make sure we're looking at the most recent
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the text "Final" should appear in the "Progress Note" pane
    When I select "Charges" from clinical navigation
    Then the following rows should appear in the "Charges" table
      | Date/Time             | Prov/Team       | Proc                     | Qty | Diag    |
      | %Current Date MMDDYY% | KADMINV2, PERRY | 87101 skin fungi culture | 1   | H02.519 |


  Scenario: 9a. Edit an HCA Draft Note
    When I select patient "Molly Darr" from the patient list
    And I load the "HCA Progress Note" template note for the selected patient
    And I wait "2" seconds
    And I select the note "Subjective" section
    And I enter "Draft" in the "HCA Patient Narrative" field
    And I click the "Save as Draft " button
    And I click the "Yes" button
    And rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type             | Author          |
      | %Current Date MMDDYY% | *DRAFT* Progress Note | KADMINV2, PERRY |
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    When I click the "Edit" button in the "Progress Note" pane
    And I select the note "Subjective" section
    And I enter "Status" in the "HCA Patient Narrative" field
    And I wait "2" seconds
    And I sign/submit the "HCA Progress Note" note
    And rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type     | Author          |
      | %Current Date MMDDYY% | Progress Note | KADMINV2, PERRY |
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the text "Status" should appear in the "Progress Note" pane
    And the text "Final" should appear in the "Progress Note" pane


#  Marking as @donotrun for now until we're back to using the the responsive design NW templates
  @donotrun
  Scenario: 9b. Edit Draft Note
    When I select patient "Molly Darr" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I wait "2" seconds
    Then the "New Note" pane should load
    And the text "DARR, MOLLY" should appear in the "New Note" pane
    And I select the note "Subjective" section
    And I enter "Draft" in the "Patient Narrative" field in the "NewNote" pane
    And I click the "Save as Draft " button
    And I click the "Yes" button in the "NW Question Dialog" pane
    Then the "New Note" pane should close
    And rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type             | Author          |
      | %Current Date MMDDYY% | *DRAFT* Progress Note | KADMINV2, PERRY |
		#make sure we're looking at the most recent
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "*DRAFT* Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the "Progress Note" pane should load
    When I click the "Edit" button in the "Progress Note" pane
    And I select the note "Subjective" section
    And I enter "Status" in the "Patient Narrative" field in the "NewNote" pane
    And I wait "2" seconds
    And I sign/submit the "Progress Note" note
    Then the "Note Writer Main" pane should close
    And rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type     | Author          |
      | %Current Date MMDDYY% | Progress Note | KADMINV2, PERRY |
		#make sure we're looking at the most recent
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the text "Status" should appear in the "Progress Note" pane
    And the text "Final" should appear in the "Progress Note" pane


  Scenario: 10a. Delete an HCA Draft Note
    Given I select patient "Molly Darr" from the patient list
    Then I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I enter "Delete This" in the "HCA Patient Narrative" field
    And I click the "Save as Draft " button
    And I click the "Yes" button
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    And I click the "DeleteNote" button
    And I click the "Yes" button in the "Question" pane
    When I select patient "Molly Darr" from the patient list
    Then the "Clinical Notes" table should have at least "1" rows not containing the text "*DRAFT* Progress Note"


#  Marking as @donotrun for now until we're back to using the the responsive design NW templates
  @donotrun
  Scenario: 10b. Delete Draft Note
    Given I select patient "Molly Darr" from the patient list
    Then I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I enter "Delete This" in the "Patient Narrative" field in the "NewNote" pane
    And I click the "Save as Draft " button
    And I click the "Yes" button in the "NW Question Dialog" pane
		#make sure we're looking at the most recent
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "*DRAFT* Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I click the "DeleteNote" button
    And I click the "Yes" button in the "Question" pane
    When I select patient "Molly Darr" from the patient list
    Then the "Clinical Notes" table should have at least "1" rows not containing the text "*DRAFT* Progress Note"


  Scenario: 11a. Create and Edit an HCA Note from Patient Search Actions Button
    Given I am on the "Patient Search" tab
    Then I click the "Clear Criteria" button in the "Patient Search Criteria" pane
    And I enter "darr" in the "Last" field in the "Patient Search Criteria" pane
    And I enter "molly" in the "First" field in the "Patient Search Criteria" pane
    When I click the "Search for Visits" button in the "Patient Search Criteria" pane
    Then I sort the "Visit Search Results" table chronologically by the "Admit/Appt" column in "Descending" order
    And I select patient "DARR, MOLLY" from the "Name" column in the "Visit Search Results" table
    And I select "Write Note" from the "Actions" menu
    And I wait "3" seconds
#   #This step below is not working. This 'button' is always there, but it's a show/hide or an accordion that is not always open.
#    And I click the "Write A Note Expand" button if it exists
    When the "Write A Note" toggle is open
    Then I select "HCA Progress Note" from the select template list in the "NoteWriter Wizard" pane
    And I select the note "A/P" section in the "NoteWriter Wizard" pane
    And I wait "2" seconds
    And I enter "R52" in the "HCA AP Diagnosis Search" field
    And I enter "R68.89" in the "HCA AP Diagnosis Search" field
    And I wait "2" seconds
    And I click the "Save As Draft" button in the "NoteWriter Wizard" pane
    And I click the "YesSaveDraft" button
    When I click the "View Detail" button
    And I wait "3" seconds
    Then I click the "Clinical Notes Left Nav" element in the "Patient Clinical Navigation" pane
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    Then I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    When I click the "Edit Note" button in the "Progress Note" pane
    And I wait "5" seconds
    Then I select the note "A/P" section in the "NoteWriter Wizard" pane
    And I enter "R07.0" in the "HCA AP Diagnosis Search" field
	 #		adding this step as sometimes, diagnosis search pain will not close due to sync
    When I select the note "A/P" section in the "NoteWriter Wizard" pane
    Then I click the "NoteWriterSign/Submit" button in the "NoteWriter Wizard" pane
    Then I click the "OKSign" button


#  Marking as @donotrun for now until we're back to using the the responsive design NW templates
  @donotrun
  Scenario: 11b. Create and Edit Note from Patient Search Actions Button[DEV-77495][DEV-77843]
#      blocked by DEV-82287
    Given I am on the "Patient Search" tab
    And I click the "Clear Criteria" button in the "Patient Search Criteria" pane
    And I enter "darr" in the "Last" field in the "Patient Search Criteria" pane
    And I enter "molly" in the "First" field in the "Patient Search Criteria" pane
    Then I click the "Search for Visits" button in the "Patient Search Criteria" pane
    When I sort the "Visit Search Results" table chronologically by the "Admit/Appt" column in "Descending" order
    And I select patient "DARR, MOLLY" from the "Name" column in the "Visit Search Results" table
    Then I select "Write Note" from the "Actions" menu
    And I wait "3" seconds
#    And I click the "Write A Note Expand" button if it exists
    When the "Write A Note" toggle is open
    Then I select "Progress Note" from the select template list in the "NoteWriter Wizard" pane
    And I select the note "A/P" section in the "NoteWriter Wizard" pane
    When I wait "2" seconds
    Then I enter "R52" in the "Diagnoses Search" field in the "NW Wizard DX Search" pane
    And I enter "R68.89" in the "Diagnoses Search" field in the "NW Wizard DX Search" pane
    And I wait "2" seconds
    And I click the "Save As Draft" button in the "NoteWriter Wizard" pane
    And I click the "Yes" button in the "NW Question Dialog" pane
    Then I click the "View Detail" button
    And I wait "3" seconds
    And I click the "Clinical Notes Left Nav" element in the "Patient Clinical Navigation" pane
		#Then I click the "Refresh" button
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    Then I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    When I click the "Edit Note" button in the "Progress Note" pane
    And I wait "5" seconds
    And I select the note "A/P" section in the "NoteWriter Wizard" pane
    And I enter "R07.0" in the "Diagnoses Search" field in the "NW Wizard DX Search" pane
	 #		adding this step as sometimes, diagnosis search pain will not close due to sync
    And I select the note "A/P" section in the "NoteWriter Wizard" pane
    And I sign/submit the "Progress Note" note in the "NoteWriter Wizard" pane