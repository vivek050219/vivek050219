@NoteWriterQTV2
Feature: NoteWriter Quick Text V2 History and Physical

  Background:
    Given I am logged into the portal with user "hplevel3" using the default password
    And I am on the "Patient List V2" tab

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

    Scenario: Verify History section in History and Physical template
    And I am on the "Patient List V2" tab
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I add "Typhoid Fever" problems to the "Molly Darr" patient
    And I select "Problems" from clinical navigation
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    Then I enter "Patient complains of severe headache and chest pain." in the "Chief Complaint" field
    And I enter "HPI" in the "HPI QTV2" rich text field
    And I click the "enter" key in the "HPI QTV2" rich text field
    And I click the "list" list in the rich text field
    And I select "2" option from the "ListSelect" list
    When I click the "Free text" textbox in the rich text field
    And I enter "This is manually entered text" in the "Free Text" free text field in the "Patient Narrative QTV2" pane
    And I click the "2" list in the rich text field
    And I select "1" option from the "ListSelect" list
    Then I click the "This is manually entered text" textbox in the rich text field
    And I enter "PACU for recovery" in the "Free Text" free text field in the "Patient Narrative QTV2" pane
    And I select "true" from the "Past Medical History" radio list
    And I click the "Enter" key in the "History Diagnosis Search" field in the "NoteWriter History DX Search" pane
    When I click the "Add all" link in the "NoteWriter History DX Search" pane
      #TODO : blocked by DEV-84260
    And the following text should appear in the "NoteWriter History DX Search" pane
      |Typhoid Fever   |
    And I click the "OnsetDate" element in the "Past Medical History" pane
    And I click the "Today's Date" element in the "Past Medical History" pane
      #additional step to scroll the page up
    And I select "true" from the "Past Medical History" radio list
    And I remove the medical problem "Typhoid Fever" in the "Note Writer Main" pane
    And I enter "This is additional text" in the "Additional PMH Comments QTV2" rich text field
    And I select "true" from the "Past Surgical History" radio list
    And I wait "2" seconds
    And I enter "Appendectomy" in the "History Diagnosis Search" field in the "NoteWriter History DX Search" pane
    And I wait "2" seconds
    And I select "S/P appendectomy" option from the "History Problem Picker" list
    And I select the date "%2 days from now MMMMDDYYYY%" from the "SurgeryDate" calendar in the "NoteWriter History DX Search" pane
    And I select "true" from the "Past Medical History" radio list
    And I wait "2" seconds
    And I enter "CABG" in the "History Diagnosis Search" field in the "NoteWriter History DX Search" pane
    And I wait "2" seconds
    And I select "Hx of CABG" option from the "History Problem Picker" list
    And I wait "2" seconds
    And the following text should appear in the "Note Writer" pane
      |Hx of CABG |
      And I select the date "%Current Date MMMMDDYYYY%" from the "OnsetDate" calendar in the "NoteWriter History DX Search" pane
    #And the checkbox should be checked in all rows in the "Allergy Discharge Summary" table
#    And the checkbox should be checked in the rows with "Bee sting" cell text in the "Allergies History Section" table
    And I enter "patient had left hip replacement in 2010" in the "Additional Surgeries QTV2" rich text field
#    And I uncheck the "BeeSting" checkbox
    And I click the "Allergies ABC" element
    And I click on the text "quick text" in the "Click To Insert V2" pane
    And I click the "CloseQT" button in the "Click To Insert V2" pane
    And the following text should appear in the "NoteWriter" pane
      |quick text                             |
      |This is a quick text to test allergies |
    And I enter "No other known allergies" in the "Allergies QTV2" rich text field
    And I click the "HomeMedications ABC" element
    And I click on the text "Regular" in the "Click To Insert V2" pane
    And I wait "2" seconds
    And the following text should appear in the "NoteWriter" pane
      |conitnue regular home medications |
    And I enter "Blood pressure medicine - daughter bringing bottle in." in the "Home Medications QTV2" rich text field
    And I wait "2" seconds
    And I sign/submit the "History and Physical" note

  Scenario: Verify A/P section in History and Physical template
    And I am on the "Patient List V2" tab
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "History and Physical" template note for the selected patient
    And I select the note "A/P" section
    And I click the "AddProblem" button if it exists
    And I enter "Chest pain radiating to arm" in the "AP Diagnosis Search" field in the "NoteWriterAPDXSearchQTV2" pane
    And I wait "2" seconds
#    And I select the "R07.89" code in the Diagnoses search list in the "NoteWriterAPDXSearchQTV2" pane
    And I select "R07.89" option from the "AP Problem Picker" list
    And the following text should appear in the "Note Writer" pane
      |Chest pain radiating to arm |
    And I click the "Plan Field ABCQTV2" element in the "Note Writer Main" pane
    And I wait "2" seconds
    And I click on the text "Unchanged" in the "Click To Insert V2" pane
    And I click the "CloseQT" button in the "Click To Insert V2" pane
    And the following text should appear in the "Note Writer Main" pane
      |Unchanged |
    And I enter "patient given aspirin, iv fluids and blood platelets" in the "Plan QTV2" rich text field
    And I mouse over and click the "TrashDX" element in the "Note Writer Main" pane
#    And I click the "TrashDX" element
    And I wait "2" seconds
    And I click the "Enter" key in the "AP Diagnosis Search" field in the "NoteWriter AP DX Search QTV2" pane
    When I click the "Add all" link in the "NoteWriter AP DX Search QTV2" pane
#    And I choose the "Typhoid fever" code description in the "Existing" list in the "HP AP Diagnosis Search Section" search section in the "Note Writer AP DX Search QTV2" pane
#    And I click on the text "Typhoid fever" in the "NoteWriterAPDXSearchQTV2" pane
    #TODO : blocked by DEV-84260
    And the following text should appear in the "NoteWriterAPDXSearchQTV2" pane
      |Typhoid fever |
    And I click the "Plan Field ABCQTV2" element in the "Note Writer Main" pane
    And I click on the text "Quick text" in the "Click To Insert V2" pane
    And I wait "2" seconds
    And I click the "CloseQT" button in the "Click To Insert V2" pane
    And the following text should appear in the "Note Writer Main" pane
      |Quick text |
    And I click the "Plan Field ABCQTV2" element in the "Note Writer Main" pane
    And I click on the text "Quick text1" in the "Click To Insert V2" pane
    And the following text should appear in the "Note Writer Main" pane
      |Quick text1 |
    And I sign/submit the "History and Physical" note

  Scenario: Verify Family Social History in History and Physical template
    And I am on the "Patient List V2" tab
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "History and Physical" template note for the selected patient
    And I select the note "Family/Social History" section
    Then the "FamilySocialHistory" pane should load
    When I check the "TobaccoUse" checkbox in the dashboard mode
    And I select "Current" from the "TobaccoUseStatus" dropdown
    And I enter "10" in the "PacksPerDay" field
    And I enter "1" in the "NoofYears" field
    And I enter "Chain Smoker" in the "TobaccoUseComments" field
    Then the value in the "PacksPerDay" field should be "10"
    And the value in the "NoofYears" field should be "1"
    And the value in the "TobaccoUseComments" field should be "Chain Smoker"
    When I check the "AlcoholUse" checkbox in the dashboard mode
    And I select "Few times a month" from the "Frequency" dropdown
    And I enter "Occuasionaly" in the "AlcoholUseComment" field
    Then the value in the "AlcoholUseComment" field should be "Occuasionaly"
    And I check the "DrugUse" checkbox in the dashboard mode
    And I enter "Never" in the "DrugUseComment" field
    When I select "Married" from the "Marital Status" dropdown
    Then the "Marital Status" dropdown should be "Married"
    When I enter "Lives at home independently" in the "Living Situation" field
    Then the value in the "Living Situation" field should be "Lives at home independently"
    When I enter "Daughter and son live nearby and check in on patient regularly. Patient's wife died 2 years ago" in the "Additional Social History Info" field
#    Then the value in the "Additional Social History Info" field should be "Daughter and son live nearby and check in on patient regularly. Patient's wife died 2 years ago"
    When I select "Full Code" from the "Code Status" dropdown
    Then the "Code Status" dropdown should be "Full Code"
    When I enter "healthcare proxy on file" in the "HealthCare Proxy" field
    Then the value in the "HealthCare Proxy" field should be "healthcare proxy on file"
    And I enter "Family History of Asthma" in the "FS Diagnosis Search" field in the "FamilySocialHistory" pane
	And I wait "2" seconds
    And I click on the link "FamilyHistoryAddAsFreeText" in the "New Note" pane
    Then the text "Family History of Asthma" should appear in the "FamilySocialHistory" pane
    When I enter "Brother" in the "DiagnosesFSHQTV2" rich text field
    Then the text "Brother" should appear in the "FamilySocialHistory" pane
    And I click the "ClearDiagnoses" element in the "FamilySocialHistoryDiagnoses" pane
    When I enter "Family history of coronary artery disease" in the "FS Diagnosis Search" field in the "FamilySocialHistory" pane
    And I wait "2" seconds
#    And I click the "Add as Free Text" link in the "FamilySocialHistoryDiagnoses" pane
    And I click on the link "FamilyHistoryAddAsFreeText" in the "New Note" pane
    Then the text "Family history of coronary artery disease" should appear in the "FamilySocialHistory" pane
    When I enter "mom" in the "DiagnosesFSHQTV2" rich text field
    And I click the "enter" key in the "DiagnosesFSHQTV2" rich text field
    Then the text "Mother" should appear in the "FamilySocialHistory" pane
    And I click the "FamilyDiagnosesABCQTV2" element in the "FamilySocialHistory" pane
    When I click on the text "ppfh" in the "ClickToInsertV2" pane
    And I click the "CloseQT" button in the "ClickToInsertV2" pane
    Then the text "Patient's father's family has" should appear in the "FamilySocialHistory" pane
    When I enter "h/o pancreatic cancer" in the "DiagnosesFSHQTV2" rich text field
    Then the text "h/o pancreatic cancer" should appear in the "FamilySocialHistory" pane
    And I sign/submit the "History and Physical" note

  Scenario: Verify ROS section in History and Physical template
    And I am on the "Patient List V2" tab
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "History and Physical" template note for the selected patient
    And I select the note "ROS" section
    And I click the "ROS RESP Normal" button
    Then the text "Negative for dyspnea or wheeze. No cough." should appear in the "ROSHistory" pane
    When I click the "ROS CV Abnormal" button in the "ROSHistory" pane
    Then the text "" should appear in the "ROSHistory" pane
    When I click the "ROSCVABCQTV2" button in the "ROSHistory" pane
    When I click on the text "chest pain" in the "ClickToInsertV2" pane
    Then the following text should appear in the "ROSHistory" pane
      |chest pain|
    When I click on the text "palpitation" in the "ClickToInsertV2" pane
    Then the following text should appear in the "ROSHistory" pane
      |palpitation|
    And I click the "ROS GI Normal" button in the "ROSHistory" pane
    Then the text "Negative for abdominal pain or nausea. No emesis. No diarrhea." should appear in the "ROSHistory" pane
    When I click the "ROS Skin Abnormal" button
    Then the text "" should appear in the "ROSHistory" pane
    When I click the "ROSSkinAbnormalABCQTV2" button in the "ROSHistory" pane
    When I click on the text "jaundice present" in the "ClickToInsertV2" pane
    Then the following text should appear in the "ROS Skin AbnormalQTV2" pane
      |jaundice present|
    When I click on the text "itching present" in the "ClickToInsertV2" pane
    Then the following text should appear in the "ROS Skin AbnormalQTV2" pane
      |itching present|
    And I sign/submit the "History and Physical" note

  Scenario: Verify Exam section in History and Physical template
    And I am on the "Patient List V2" tab
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "History and Physical" template note for the selected patient
    And I select the note "Exam" section
    And I enter "101.2" in the "VitalTemp" field
    Then the value in the "VitalTemp" field should be "101.2"
    When I click the "ExamEyesNormal" element
    Then the text "PERL. Sclerae nonicteric. Conjunctivae pink." should appear in the "ExamHistory" pane
    When I click the "ExamRespNormal" element
    Then the text "Lungs clear to auscultation, no distress." should appear in the "ExamHistory" pane
    When I click the "Exam CV Abnormal" element
    Then the text "" should appear in the "ExamHistory" pane
    When I click the "ExamCVABCQTV2" element
    And I click on the text "irregular rhythm" in the "ClickToInsertV2" pane
    Then the following text should appear in the "ExamHistory" pane
      |irregular rhythm|
    When I click on the text "weak carotid pulses" in the "ClickToInsertV2" pane
    Then the following text should appear in the "ExamHistory" pane
      |weak carotid pulses|
    When I click on the text "weak pedal pulses" in the "ClickToInsertV2" pane
    Then the following text should appear in the "ExamHistory" pane
      |weak pedal pulses|
    And I click the "CloseQT" button
    When I click the "ExamGINormal" element
    Then the text "Soft, no tenderness. No masses. No guarding. Bowel sounds present." should appear in the "ExamHistory" pane
    When I click the "ExamSkinAbnormal" element
    Then the text "" should appear in the "ExamHistory" pane
    When I click the "ExamSkinABCQTV2" element
    And I click on the text "jaundice present" in the "ClickToInsertV2" pane
    Then the following text should appear in the "ExamHistory" pane
      |jaundice present|
    When I click on the text "itching present" in the "ClickToInsertV2" pane
    Then the following text should appear in the "ExamHistory" pane
      |itching present|
    When I click the "Exam Psych Normal" element
    Then the text "Negative for specific complaints" should appear in the "ExamHistory" pane
    And I sign/submit the "History and Physical" note

    #TODO : blocked by DEV-84387
  Scenario: Verify Diagnostics section in History and Physical template
    And I am on the "Patient List V2" tab
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "History and Physical" template note for the selected patient
    And I select the note "Diagnostics" section
    Then the following links should display in the "DiagnosticsHistory" pane
      |Lab Results  |
      |Test Results |
    When I click the "Lab Results" link in the "NoteWriter" pane
    Then the "Patient Data" pane should load
    And I click the "NoteWriter Preselection Icon" image in the "LabList" pane
    And I wait "2" seconds
    And I click the "Copy to Note" button
    And I click the "OK" button in the "Warning" pane if it exists
    And the "ClinicalData" table should load
    When I click the "Test Results" link in the "NoteWriter" pane
    Then the "Patient Data" pane should load
    And I wait "2" seconds
    And the "Patient List TestResults" table should load
    When I select "EKG" from the "Test (\d of \d)" column in the "Patient List TestResults" table
    And I enter "Fin" in the "NoteSearchTextQTV2" field
#    And I click the "SearchTextQTV2" image
    And I mouse over and click the "SearchTextQTV2" image
    Then I doubleClick on the searchtext in the "SearchDetails" pane
    And I click the "AddSelectedTextV3" element
    Then the following fields should display in the "TestSelectionNwQtv2" pane
      |Name                 |Type    |
      |Remove Selected Text |element |
      |Remove All           |element |
    And the text "Finding" should appear in the "TestSelectionNwQtv2" pane
    Then I highlight the text in the "TestSelectionNwQtv2" pane
    And I click the "Remove Selected Text" element in the "TestSelectionNwQtv2" pane
    And the text "Finding" should appear in the "TestSelectionNwQtv2" pane
    And I select "EKG" from the "Test (\d of \d)" column in the "Test Results" table
    Then the following fields should display in the "TestSelectionNwQtv2" pane
      |Name  |Type    |
      |Undo  |element |
    When I click the "Undo" element in the "TestSelectionNwQtv2" pane
    And I select "EKG" from the "Test (\d of \d)" column in the "Test Results" table
    And the text "Finding" should appear in the "TestSelectionNwQtv2" pane
    Then I highlight the text in the "TestSelectionNwQtv2" pane
    And I wait "2" seconds
    And I click the "Remove All" element in the "TestSelectionNwQtv2" pane
    Then the text "Finding" should not appear in the "TestSelectionNwQtv2" pane
    When I enter "Fin" in the "NoteSearchTextQTV2" field
    #And I click the "SearchTextQTV2" image
    And I mouse over and click the "SearchTextQTV2" image
    Then I doubleClick on the searchtext in the "SearchDetails" pane
    And I click the "AddSelectedTextV3" element
    And I click the "Copy to Note" button
    And I click the "OK" button in the "Warning" pane if it exists
    Then the following fields should display in the "NoteWriter" pane
      |Name       |Type    |
      |Annotation |element |
    When I select "Normal" from the "Test Result" dropdown
    Then the option "Normal" should be available in the "Test Result" dropdown list
    And I sign/submit the "History and Physical" note

  Scenario: Disable Quick text V2
    Given I am logged into the portal with user "nwadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "false" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    Given I am logged into the portal with user "nwlevel3" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    Then I select the note "Subjective" section
    When I click the "PatientnarrativeABCQTV2" element in the "NoteWriter" pane
    When I click the "ManageQuickText" button
    And I wait "2" seconds
    Then the "AddQuickTextV2Right" pane should not load
    Then the "AddQuickTextV2left" pane should not load
#    Then the following text should appear in the "ClickToInsert" pane
#      |Add   |
#      |Edit  |
#      |Close |
#    And the text "Manage Quick Text" should not appear in the "ClickToInsert" pane
    When I click the "Close" button in the "Add Quick Text" pane
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane