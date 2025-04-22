@HCANoteWriterQTV2
Feature: HCA NoteWriter Quick Text V2 Progress Note

  Background:
    Given I am logged into the portal with user "hplevel3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized

  Scenario: Enable QuickText v2
    Given I am logged into the portal with user "nwadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "true" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
    And I select "true" from the "Enable Spell Check" radio list in the "Note Writer Settings" pane
    And I select "None" from the "Validation" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box

  Scenario: Subjective Section in HCA Progress note template
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "HCA Progress Note" template note for the selected patient
    And I wait "10" seconds
    And I enter "This is a test quick text" in the "PatientNarrativeQTV2" rich text field
    And I sign/submit the "HCA Progress Note" note
    And I load the "HCA Progress Note" template note for the selected patient
    And I click the "PatientNarrative" insert previous link in the "NoteWriter" pane
#        And I wait "5" seconds
    And I click the "InsertSelectionQTV2" button
    And I press the "backspace" key "5" times in the "PatientNarrativeQTV2" rich text field
    Then the text "This is a test quick" should appear in the "PatientNarrativeQTV2" pane
    And I enter "Manually entered text" in the "PatientNarrativeQTV2" rich text field
    And I enter "PN01" in the "PatientNarrativeQTV2" rich text field
    And I click the "space" key in the "PatientNarrativeQTV2" rich text field
    And the text "This is a QTv2 entry for Progress Note. This is Free Text and this is the List of the current visit." should appear in the "PatientNarrativeQTV2" pane
    When I click the "Free Text" textbox in the rich text field
    And I enter "the third time patient has visited this hospital" in the "Free Text" free text field in the "PatientNarrativeQTV2" pane
    And I click the "List" list in the rich text field
    And I select "1" option from the "ListSelect" list
    And I wait "2" seconds
    And I click the "ROS EYES Normal" button in the "NoteWriter" pane
    And I click the "ROSGINormal" button in the "NoteWriter" pane
    And I click the "ROS NEURO Normal" button in the "NoteWriter" pane
#		And I mouse over and click the "ROS NEURO Normal" button in the "ROSHistory" pane
    Then the following text should appear in the "NoteWriter" pane
      | Negative for blurry vision. No diplopia.                       |
      | Negative for abdominal pain or nausea. No emesis. No diarrhea. |
      | Negative for headache. No vertigo. Denies paresthesias.        |
    And I wait "3" seconds
    And I mouse over and click the "ROSCVAbnormal" button in the "NoteWriter" pane
#		When I click the "ROSCVAbnormal" button in the "NoteWriter" pane
    And I click the "ROSCVABCQTV2" button in the "NoteWriter" pane
    And I wait "2" seconds
    And I click on the text "chest pain" in the "ClickToInsertV2" pane
    And I click on the text "palpitation" in the "ClickToInsertV2" pane
    Then the following text should appear in the "NoteWriter" pane
      | chest pain |
    And I enter "PND and orthopnea" in the "ROSCardiovascularAbnormalQTV2" rich text field
    And I sign/submit the "HCA Progress Note" note

  Scenario: Objective Section in HCA Progress note template
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "HCA Progress Note" template note for the selected patient
    Then I select the note "Objective" section
    And I click the "Exam General Normal" element in the "NoteWriter" pane
    And I sign/submit the "HCA Progress Note" note
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Objective" section
    And the "VitalsQTV2" table should have at least "1" row
    And the "I/OQTV2" table should have at least "1" row
		#commented the below step as per manual team
#		And the following text should appear in the "Note Writer" pane
#			|Net: 1,482 Intake: 3,240 Output: 1,758|
    And I click the "ExamTarget" insert previous link in the "NoteWriter" pane
    And I wait "2" seconds
    And I click the "InsertSelectionQTV2" button
    Then the following text should appear in the "NoteWriter" pane
      | Well developed, well nourished, in no apparent distress. |
    And I click the "Exam Eyes Normal" element in the "NoteWriter" pane
    And I click the "Exam Neck Normal" element in the "NoteWriter" pane
    And the following text should appear in the "NoteWriter" pane
      | PERRL, EOM intact, conjunctiva and sclera clear, without nystagmus, lids normal. |
      | No masses, no thyromegaly, no abnormal cervical nodes, trachea midline.          |
#        And I click the "Exam CONST Normal" element in the "Note Writer Main" pane
#		And the text "CONSTITUTIONAL:" should not appear in the "Exam Target Table" section in the "Note Writer Main" pane
    And I enter "This is manually entered text" in the "ExamNeckNormalQTV2" rich text field
    And I click the "Exam Neuro Normal" element in the "NoteWriter" pane
    Then the following text should appear in the "NoteWriter" pane
      | No focal deficits, cranial nerves II-XII grossly intact, normal sensation, normal reflexes, normal coordination, normal muscle strength, normal tone. |
    And I enter "This is manually entered text" in the "ExamNeuroNormalQTV2" rich text field
    When I click the "Exam Skin Abnormal Findings" element
    And I click the "ExamSkinABCQTV2" element
    And I click on the text "itching present" in the "ClickToInsertV2" pane
    And I click on the text "jaundice present" in the "ClickToInsertV2" pane
    Then the following text should appear in the "NoteWriter" pane
      | itching present |
    And I enter "PND and orthopnea" in the "ExamSkinAbnormalQTV2" rich text field in the "NoteWriter" pane
    And I sign/submit the "HCA Progress Note" note

  Scenario: Verify Data section in Progress Note template
    When "SUSAN WALSH" is on the patient list
    And I select patient "SUSAN WALSH" from the patient list
    And I add "Typhoid Fever" problems to the "SUSAN WALSH" patient
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Data" section
    Then the "Data" pane should load
    And the following links should display in the "Data" pane
      | Allergies      |
      | Clinical Notes |
      | Lab Results    |
      | Test Results   |
      | Vitals         |
      | Orders         |
      | Medications    |
    When I click the "Allergies" link in the "NoteWriter" pane
    And I wait "2" seconds
    And I click the "NoteWriterPreselectionIcon" element
    And I click the "CopytoNote" button
    Then the text "Penicillin" should appear in the "Data" pane
    When I click the "Clinical Notes" link in the "Note Writer" pane
    And I select "Consult - Renal" from the "Note Type (\d of \d)" column in the "Clinical Notes Results" table
    And I enter "1. Monitor BS q4h, renal function daily." in the "Note Search Text QTV2" field
    And I click the "SearchTextQTV2" image
    Then I highlight the search text in the "Search Details" pane
    And I click the "AddSelectedText" element in the "Clinical Note Details" pane
    Then the text "1. Monitor BS q4h, renal function daily" should appear in the "Test Selection Nw Qtv2" pane
    When I click the "Copy to Note" button
    When I click the "Clinical Notes" link in the "NoteWriter" pane
    And I wait "2" seconds
    When I select "Nursing Assessment" from the "Note Type (\d of \d)" column in the "Clinical Notes Results" table
    And I wait "2" seconds
    And I enter "HISTORY" in the "Note Search Text QTV2" field
    And I click the "SearchTextQTV2" image
    Then I doubleClick on the searchtext in the "Search Details" pane
    And I click the "AddSelectedText" element in the "Clinical Note Details" pane
    Then the text "HISTORY" should appear in the "Test Selection Nw Qtv2" pane
    When I click the "Copy to Note" button
    Then the following text should appear in the "Data" pane
      | 1. Monitor BS q4h, renal function daily |
      | HISTORY                                 |
    When I click the "Medications" link in the "Note Writer" pane
    And I wait "2" seconds
    And I click the "NoteWriter Preselection Icon" element in the "MedicationList" pane
    And I click the "Copy to Note" button
    And I wait "2" seconds
    When I select "Lab Results" from clinical navigation in the "Note Writer" pane
    And I click the "NoteWriter Preselection Icon" element in the "LabList" pane
    When I select "CBC" from the "Panel (\d of \d)" column in the "LabResults" table
    And I wait "2" seconds
    And I click the "Lab Result NoteWriter Preselection Icon" element in the "Lab Details" pane
    And I click the "Copy to Note" button
    Then the "MedicationsData" table should have at least "1" rows containing the text "Medications"
    And the "LabResultsData" table should have at least "1" rows containing the text "Lab Results"
    And I sign/submit the "HCA Progress Note" note

  Scenario: Disable Quick text V2
    Given I am logged into the portal with user "nwadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "false" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box

