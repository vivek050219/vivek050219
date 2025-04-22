@HCANoteWriterQTV2
Feature: HCA NoteWriter Quick Text V2 History and Physical

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
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "History" section
    Then I enter "Patient complains of severe headache and chest pain." in the "Chief Complaint" field
    And I enter "HPI" in the "HPI QTV2" rich text field
    And I click the "enter" key in the "HPI QTV2" rich text field
    And I click the "list" list in the rich text field
    And I select "2" option from the "ListSelect" list
    When I click the "Free text" textbox in the rich text field
    And I enter "This is manually entered text" in the "Free Text" free text field in the "Note Writer" pane
    And I click the "2" list in the rich text field
    And I select "1" option from the "ListSelect" list
    Then I click the "This is manually entered text" textbox in the rich text field
    And I enter "PACU for recovery" in the "Free Text" free text field in the "Note Writer" pane
    And I select "Current" from the "TobaccoUseStatus" dropdown
    And I select "still smoking" from the "Date Last Smoked" dropdown
    And I enter "10" in the "TobaccoUseAmount" field
    And I enter "1" in the "NoofYears" field
    And I enter "Chain Smoker" in the "TobaccoUseComments" field
    Then the value in the "TobaccoUseAmount" field should be "10"
    And the value in the "NoofYears" field should be "1"
    And the value in the "TobaccoUseComments" field should be "Chain Smoker"
    And I select "Former" from the "AlcoholUseStatus" dropdown
    And I enter "Occasionally" in the "AlcoholUseComment" field
    Then the value in the "AlcoholUseComment" field should be "Occasionally"
    And I select "Never" from the "DrugUseStatus" dropdown
    And I enter "Never" in the "DrugUseComment" field
    When I select "Married" from the "Marital Status" dropdown
    Then the "Marital Status" dropdown should be "Married"
    When I enter "Lives at home independently" in the "Living Situation" field
    Then the value in the "Living Situation" field should be "Lives at home independently"
    When I enter "Daughter and son live nearby and check in on patient regularly. Patient's wife died 2 years ago" in the "Additional Social History Info" field
    And I click the "NoteWriterSign/Submit" button
    And I click the "OK" button in the "NoteWriterWizard" pane

  Scenario: Verify A/P section in History and Physical template
    And I am on the "Patient List V2" tab
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "A/P" section
    And I click the "AddProblem" button if it exists
    And I enter "Chest pain radiating to arm" in the "Problem Dx Search" field in the "NoteWriterAPDXSearch" pane
    And I wait "2" seconds
    And I select the "R07.89" code in the Diagnoses search list in the "NoteWriterAPDXSearch" pane
    And the following text should appear in the "Note Writer" pane
      | Chest pain radiating to arm |
    And I click the "Plan Field ABCQTV2" element in the "Note Writer" pane
    And I wait "2" seconds
    And I click on the text "Unchanged" in the "Click To Insert V2" pane
    And I click the "CloseQT" button in the "Click To Insert V2" pane
    And the following text should appear in the "Note Writer" pane
      | Unchanged |
    And I enter "patient given aspirin, iv fluids and blood platelets" in the "Plan QTV2" rich text field
    And I click the "TrashDX" element
    And I wait "2" seconds
    When I click the "Add all" link in the "NoteWriter AP DX Search" pane
#    And I choose the "Typhoid Fever" code description in the "Existing" list in the "HP AP Diagnosis Search Section" search section in the "Note Writer AP DX Search" pane
    And the following text should appear in the "NoteWriter" pane
      | Typhoid Fever |
    And I click the "Plan Field ABCQTV2" element in the "Note Writer" pane
    And I click on the text "Quick text" in the "Click To Insert V2" pane
    And I wait "2" seconds
    And I click the "CloseQT" button in the "Click To Insert V2" pane
    And the following text should appear in the "Note Writer" pane
      | Quick text |
    And I click the "Plan Field ABCQTV2" element in the "Note Writer" pane
    And I click on the text "Quick text1" in the "Click To Insert V2" pane
    And the following text should appear in the "Note Writer" pane
      | Quick text1 |
    And I click the "NoteWriterSign/Submit" button
    And I click the "OK" button in the "NoteWriterWizard" pane

  Scenario: Verify ROS section in History and Physical template
    And I am on the "Patient List V2" tab
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "ROS Resp Normal" button in the "Note Writer" pane
    Then the text "Negative for dyspnea or wheeze. No cough." should appear in the "Note Writer" pane
    When I click the "ROS CV Abnormal" button in the "Note Writer" pane
    Then the text "" should appear in the "Note Writer" pane
    When I click the "ROSCVABCQTV2" button in the "Note Writer" pane
    When I click on the text "chest pain" in the "ClickToInsertV2" pane
    Then the following text should appear in the "Note Writer" pane
      | chest pain |
    When I click on the text "palpitation" in the "ClickToInsertV2" pane
    Then the following text should appear in the "Note Writer" pane
      | palpitation |
    And I click the "ROS GI Normal" button in the "Note Writer" pane
    Then the text "Negative for abdominal pain or nausea. No emesis. No diarrhea." should appear in the "Note Writer" pane
    And I mouse over and click the "ROS Skin Findings" button in the "Note Writer" pane
    Then the text "" should appear in the "Note Writer" pane
    When I click the "ROSSkinAbnormalABCQTV2" button in the "Note Writer" pane
    When I click on the text "jaundice present" in the "ClickToInsertV2" pane
    Then the following text should appear in the "Note Writer" pane
      | jaundice present |
    When I click on the text "itching present" in the "ClickToInsertV2" pane
    Then the following text should appear in the "Note Writer" pane
      | itching present |
    And I click the "NoteWriterSign/Submit" button
    And I click the "OK" button in the "NoteWriterWizard" pane

  Scenario: Verify Exam section in History and Physical template
    And I am on the "Patient List V2" tab
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Objective" section
    And I enter "101.2" in the "VitalTemp" field
    Then the value in the "VitalTemp" field should be "101.2"
    When I click the "ExamEyesNormal" element in the "Note Writer" pane
    Then the text "PERRL, EOM intact, conjunctiva and sclera clear, without nystagmus, lids normal." should appear in the "Note Writer" pane
    When I click the "Exam Skin Abnormal Findings" element in the "Note Writer" pane
    Then the text "" should appear in the "Note Writer" pane
    When I click the "ExamSkinABCQTV2" element in the "Note Writer" pane
    And I click on the text "jaundice present" in the "ClickToInsertV2" pane
    Then the following text should appear in the "Note Writer" pane
      | jaundice present |
    When I click on the text "itching present" in the "ClickToInsertV2" pane
    Then the following text should appear in the "Note Writer" pane
      | itching present |
    When I click the "Exam Psych Normal" element in the "Note Writer" pane
    Then the text "Alert and oriented to time, person, place. Normal mood and affect, intact judgment and insight." should appear in the "Note Writer" pane
    And I click the "NoteWriterSign/Submit" button
    And I click the "OK" button in the "NoteWriterWizard" pane

  Scenario: Verify Data section in History and Physical template
    And I am on the "Patient List V2" tab
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Data" section
    Then the following links should display in the "Note Writer" pane
      | Lab Results  |
      | Test Results |
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
      | Name                 | Type    |
      | Remove Selected Text | element |
      | Remove All           | element |
    And the text "Finding" should appear in the "TestSelectionNwQtv2" pane
    Then I highlight the text in the "TestSelectionNwQtv2" pane
    And I mouse over and click the "Remove Selected Text" element in the "TestSelectionNwQtv2" pane
    And I click the "Remove Selected Text" element in the "TestSelectionNwQtv2" pane
    And the text "Finding" should appear in the "TestSelectionNwQtv2" pane
    And I select "EKG" from the "Test (\d of \d)" column in the "Patient List TestResults" table
    Then the following fields should display in the "TestSelectionNwQtv2" pane
      | Name | Type    |
      | Undo | element |
    When I click the "Undo" element in the "TestSelectionNwQtv2" pane
    And I select "EKG" from the "Test (\d of \d)" column in the "Patient List TestResults" table
    And the text "Finding" should appear in the "TestSelectionNwQtv2" pane
    Then I highlight the text in the "TestSelectionNwQtv2" pane
    And I wait "2" seconds
#    And I click the "Remove All" element in the "TestSelectionNwQtv2" pane
    And I mouse over and click the "Remove All" element in the "TestSelectionNwQtv2" pane
    Then the text "Finding" should not appear in the "TestSelectionNwQtv2" pane
    When I enter "Fin" in the "NoteSearchTextQTV2" field
    #And I click the "SearchTextQTV2" image
    And I mouse over and click the "SearchTextQTV2" image
    Then I doubleClick on the searchtext in the "SearchDetails" pane
    And I click the "AddSelectedTextV3" element
    And I click the "Copy to Note" button
    And I click the "OK" button in the "Warning" pane if it exists
    Then the following fields should display in the "NoteWriter" pane
      | Name       | Type    |
      | Annotation | element |
    And I click the "NoteWriterSign/Submit" button
    And I click the "OK" button in the "NoteWriterWizard" pane

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
    And I load the "HCA Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    Then I select the note "Subjective" section
    When I click the "HCA PatientNarrative QT link" element in the "NoteWriter" pane
    And I wait "2" seconds
    Then the following text should appear in the "ClickToInsert" pane
      | Add   |
      | Edit  |
      | Close |
    And the text "Manage Quick Text" should not appear in the "ClickToInsert" pane
    And I click the "NoteWriterCancel" button in the "NoteWriter Main" pane
    And I click the "Yes" button in the "Question" pane
