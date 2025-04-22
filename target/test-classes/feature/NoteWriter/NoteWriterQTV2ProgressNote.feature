@NoteWriterQTV2
Feature: NoteWriter Quick Text V2 Progress Note

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

	Scenario: Subjective Section in Progress note template
		When "Molly Darr" is on the patient list
		And I select patient "Molly Darr" from the patient list
		And I load the "Progress Note" template note for the selected patient
		And I click the "OK" button in the "Information" pane if it exists
		And I enter "This is a test quick text" in the "PatientNarrativeQTV2" rich text field
		And I sign/submit the "Progress Note" note
		And I load the "Progress Note" template note for the selected patient
		And I click the "PatientNarrative" insert previous link in the "Note Writer Main" pane
        And I wait "3" seconds
        And I click the "InsertSelected" button
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
        When I check the "SeverityQTV2" checkbox in the dashboard mode
        When I check the "ContextQTV2" checkbox in the dashboard mode
        When I check the "ModifyingFactorsQTV2" checkbox in the dashboard mode
        When I check the "QualityQTV2" checkbox in the dashboard mode
		And I wait "2" seconds
        And I click the "ROS EYES Normal" button in the "Note Writer Main" pane
        And I click the "ROSGINormal" button in the "Note Writer Main" pane
#        And I click the "ROS NEURO Normal" button in the "Note Writer Main" pane
		And I mouse over and click the "ROS NEURO Normal" button in the "ROSHistory" pane
        Then the following text should appear in the "Note Writer Main" pane
          |Negative for blurry vision. No diplopia.                        |
          |Negative for abdominal pain or nausea. No emesis. No diarrhea.  |
          |Negative for headache. No vertigo. Denies paresthesias.         |
        When I click the "ROS CV Abnormal" button in the "ROSHistory" pane
        And I click the "ROSCVABCQTV2" button in the "Note Writer Main" pane
		And I wait "2" seconds
		And I click on the text "chest pain" in the "ClickToInsertV2" pane
		And I click on the text "palpitation" in the "ClickToInsertV2" pane
		Then the following text should appear in the "Note Writer Main" pane
			|chest pain   |
		And I enter "PND and orthopnea" in the "ROSCardiovascularAbnormalQTV2" rich text field
		And I sign/submit the "Progress Note" note

	Scenario: Exam Section in Progress note template
		When "Molly Darr" is on the patient list
		And I select patient "Molly Darr" from the patient list
		And I load the "Progress Note" template note for the selected patient
		And I click the "OK" button in the "Information" pane if it exists
		Then I select the note "Exam" section
		And I click the "Exam CONST Normal" element in the "Note Writer" pane
		And I sign/submit the "Progress Note" note
		And I load the "Progress Note" template note for the selected patient
		And I click the "OK" button in the "Information" pane if it exists
		And I select the note "Exam" section
#		And the "VitalsQTV2" table should have at least "1" row
#		And the "I/OQTV2" table should have at least "1" row
        Then The "RecentVitals" element should contain with the text "HR" in the "Note Writer Main" pane
        Then The "RecentIO" element should contain with the text "Net" in the "Note Writer Main" pane
		#commented the below step as per manual team 
#		And the following text should appear in the "Note Writer" pane
#			|Net: 1,482 Intake: 3,240 Output: 1,758|
        And I click the "ExamTarget" insert previous link in the "Note Writer Main" pane
        And I wait "2" seconds
        And I click the "InsertSelected" button
		Then the following text should appear in the "Note Writer Main" pane
			|Alert, in NAD. |
		And I click the "Exam Eyes Normal" element in the "Note Writer Main" pane
		And I click the "Exam Resp Normal" element in the "Note Writer Main" pane
		And the following text should appear in the "Note Writer Main" pane
			|PERL. Sclerae nonicteric. Conjunctivae pink. |
			|Lungs clear to auscultation, no distress.    |
        And I click the "Exam CONST Normal" element in the "Note Writer Main" pane
		And the text "CONSTITUTIONAL:" should not appear in the "Exam Target Table" section in the "Note Writer Main" pane
		And I enter "This is manually entered text" in the "ExamRespNormalQTV2" rich text field
		And I click the "Exam Neuro Normal" element in the "Note Writer Main" pane
		Then the following text should appear in the "Note Writer Main" pane
			|Negative for headache. No vertigo. Denies paresthesias. |
        And I enter "This is manually entered text" in the "ExamNeuroNormalQTV2" rich text field
		When I click the "Exam CV Abnormal" element in the "Note Writer Main" pane
		And I click the "ExamCVABCQTV2" element
		And I click on the text "chest pain" in the "ClickToInsertV2" pane
		And I click on the text "palipitation" in the "ClickToInsertV2" pane
		Then the following text should appear in the "Note Writer Main" pane
			|chest pain   |
		And I enter "PND and orthopnea" in the "ExamCVQTV2" rich text field in the "Note Writer Main" pane
		And I sign/submit the "Progress Note" note

	Scenario: Verify Billing section in Progress Note template
		When "Molly Darr" is on the patient list
		And I select patient "Molly Darr" from the patient list
		And I add "Typhoid Fever" problems to the "MOLLY DARR" patient
		And I load the "Progress Note" template note for the selected patient
		And I click the "OK" button in the "Information" pane if it exists
		And I select the note "Billing" section
        And I wait "3" seconds
		When I select "35 min" from the "Approximate time spent" dropdown
#		Then "35 min" should be selected in the "Approximate time spent" dropdown
#		And I check the following checkboxes in the "Billing" pane
#			|ReviewedHistory    |
#			|ExaminedPatient    |
#			|ReviewedProgress   |
#			|DiscussedCondition |
        And I check the "ReviewedHistory" checkbox in the dashboard mode
        And I check the "ExaminedPatient" checkbox in the dashboard mode
        And I check the "ReviewedProgress" checkbox in the dashboard mode
        And I check the "DiscussedCondition" checkbox in the dashboard mode
		Then the following should be checked in the "Billing" pane in dashboard mode
			|ReviewedHistory    |
			|ExaminedPatient    |
			|ReviewedProgress   |
			|DiscussedCondition |
		When I click the "View Charge Validation" button
         #TODO : bloked by https://jira/browse/DEV-83859
		And I click on the text "99231" in the "Charge Code Validation" pane
		And the text "99231" should appear in the "Add Charge" pane
		And I select the note "A/P" section
        And I select "Moderate" from the "LevelOfDecision" dropdown if it exists
		Then I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
        And I click the "Warning OK" button in the "Warning Message" pane
        Then I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
        And I click the "SaveAsIs" button
		And I click the "OK" button in the "Submit Note" pane
		And I click the logout button

	@donotrun
	Scenario: Pre-Requisite
		When "Molly Darr" is on the patient list
		And I select patient "Molly Darr" from the patient list
		And I add "Typhoid Fever" problems to the "Molly Darr" patient
		And I load the "Progress Note" template note for the selected patient
		And I click the "OK" button in the "Information" pane if it exists
		And I select the note "A/P" section
		Then the "AP" pane should load
		And I click the "ToggleDxSearch" button
		And I enter "Z90.49" in the "Diagnosis Search" field in the "NoteWriterHistoryDXSearch" pane
		And I enter "Z95.1" in the "Diagnosis Search" field in the "NoteWriterHistoryDXSearch" pane
		And I enter "R52" in the "Diagnosis Search" field in the "NoteWriterHistoryDXSearch" pane
		And I sign/submit the note

      #TODO : blocked by DEV-84387
	Scenario: Verify Data section in Progress Note template
		When "SUSAN WALSH" is on the patient list
		And I select patient "SUSAN WALSH" from the patient list
		And I add "Typhoid Fever" problems to the "SUSAN WALSH" patient
		And I load the "Progress Note" template note for the selected patient
		And I click the "OK" button in the "Information" pane if it exists
		And I select the note "Data" section
		Then the "Data" pane should load
		And the following links should display in the "Data" pane
			|Allergies      |
			|Clinical Notes |
	  		|Lab Results    |
			|Test Results   |
			|Vitals         |
			|Orders         |
			|Medications    |
		When I click the "Allergies" link in the "NoteWriter Main" pane
		And I wait "2" seconds
		And I click the "NoteWriterPreselectionIcon" element
		And I click the "CopytoNote" button
		Then the text "Penicillin" should appear in the "Data" pane
		When I click the "Clinical Notes" link in the "Note Writer Main" pane
		And I select "Consult - Renal" from the "Note Type (\d of \d)" column in the "Clinical Notes Results" table
		And I enter "1. Monitor BS q4h, renal function daily." in the "Note Search Text QTV2" field
		And I click the "SearchTextQTV2" image
        Then I highlight the search text in the "Search Details" pane
		And I click the "AddSelectedText" element in the "Clinical Note Details" pane
		Then the text "1. Monitor BS q4h, renal function daily" should appear in the "Test Selection Nw Qtv2" pane
		When I click the "Copy to Note" button
		When I click the "Clinical Notes" link in the "NoteWriter Main" pane
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
			|1. Monitor BS q4h, renal function daily  |
			|HISTORY                                  |
		When I click the "Medications" link in the "Note Writer Main" pane
		And I wait "2" seconds
		And I click the "NoteWriter Preselection Icon" element in the "MedicationList" pane
        And I click the "Copy to Note" button
        And I wait "2" seconds
		When I select "Lab Results" from clinical navigation in the "Note Writer Main" pane
		And I click the "NoteWriter Preselection Icon" element in the "LabList" pane
		When I select "CBC" from the "Panel (\d of \d)" column in the "LabResults" table
		And I wait "2" seconds
		And I click the "Lab Result NoteWriter Preselection Icon" element in the "Lab Details" pane
		And I click the "Copy to Note" button
#		Then the "ClinicalData" table should have at least "1" rows containing the text "Orders"
#		And the "ClinicalData" table should have at least "1" rows containing the text "Lab Results"
		Then the "MedicationsView" pane should load
        Then the "LabsView" pane should load
        And I sign/submit the "Progress Note" note

	Scenario: Disable Quick text V2
		Given I am logged into the portal with user "nwadminv2" using the default password
		And I am on the "Admin" tab
		And I select the "Institution" subtab
		And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
		And I wait "2" seconds
		And I select "false" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
		And I click the "Save" button
		And I click "OK" in the confirmation box

