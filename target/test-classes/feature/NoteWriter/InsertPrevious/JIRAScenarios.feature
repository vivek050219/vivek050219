@InsertPrevious
Feature: Note Writer Insert Previous Jira Scenarios
#  ALM Path: Note Writer (PK)>> 009 - Insert Previous >> JIRA Scenarios

  Background:
    Given I am logged into the portal with user "InsPrevJira3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I use the API to create a patient list named "InsPrevJira" owned by "InsPrevJira3" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I click the "Refresh Patient List" button
    And I select "InsPrevJira" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And "DARR, MOLLY" is on the patient list
    And "BLAZER, ROY" is on the patient list
    And I select "Clinical Notes" from clinical navigation

  Scenario: Enable QuickText v2
  # Pre-requisite
    Given I am logged into the portal with user "nwadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "true" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
    And I select "true" from the "Enable Spell Check" radio list in the "Note Writer Settings" pane
    And I select "None" from the "Validation" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button

  Scenario: Insert Previous should get enabled from HP to PN[DEV-63266]
    # Test Case: DEV-63266_Insert Previous should get enabled from HP to PN
    And I select patient "HEATH, NEIL" from the patient list
    And I load the "History and Physical" template note for the selected patient
    And I select the note "ROS" section
    And I click the "ROS RESP Normal" button
    Then I select the note "Exam" section
    And I click the "Exam Eyes Normal" element in the "Note Writer Main" pane
    And the following text should appear in the "Note Writer Main" pane
      |PERL. Sclerae nonicteric. Conjunctivae pink. |
    And I select the note "A/P" section
    And I enter "Chest pain radiating to arm" in the "AP Diagnosis Search" field in the "Note Writer APDX Search QTV2" pane
    And I select the "R07.89" code in the Diagnoses search list in the "Note Writer APDX Search QTV2" pane
    And I sign/submit the "History and Physical" note
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "OK" button in the "Information" pane if it exists
    And I verify if "ROS" insert previous link is enabled in the "Note Writer Main" pane
    And I click the "ROS" insert previous link in the "Note Writer Main" pane
    And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
    And I select the note "Exam" section
    And I click the "OK" button in the "Information" pane if it exists
    And I verify if "Exam Target" insert previous link is enabled in the "Note Writer Main" pane
    And I click the "Exam Target" insert previous link in the "Note Writer Main" pane
    And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
    And I select the note "A/P" section
    And I click the "ESC" key in the "PN Diagnosis Search" field in the "Note Writer Main" pane
    And I verify if "Problem List" insert previous link is enabled in the "Note Writer Main" pane
    And I click the "Problem List" insert previous link in the "Note Writer Main" pane
    And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
    And the text "Chest pain radiating to arm" should appear in the "Note Writer Main" pane
    And I click the "Note Writer Cancel Note" button in the "Clinical Note" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane

  Scenario: Insert Previous should get enabled from PN to HP[DEV-63266]
  # Test Case: DEV-63266_Insert Previous should get enabled from PN to HP
    And I select patient "BLAZER, ROY" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "ROS EYES Normal" button in the "Note Writer Main" pane
    And I select the note "Exam" section
    And I click the "Exam Eyes Normal" element in the "Note Writer Main" pane
    And I select the note "A/P" section
    And I click the "Add Problem" button in the "Note Writer Main" pane if it exists
    And I enter "R07.89" in the "PN Diagnosis Search" field
    And I enter "Burn" in the "Plan QTV2" rich text field
    And I sign/submit the "Progress Note" note
    And I am on the "Patient List V2" tab
    And I select patient "BLAZER, ROY" from the patient list
    And I load the "History and Physical" template note for the selected patient
    And I select the note "ROS" section
    And I click the "OK" button in the "Information" pane if it exists
    And I verify if "ROS" insert previous link is enabled in the "Note Writer Main" pane
    And I click the "ROS" insert previous link in the "Note Writer Main" pane
    And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
    And I select the note "Exam" section
    And I click the "OK" button in the "Information" pane if it exists
    And I verify if "ROS" insert previous link is enabled in the "Note Writer Main" pane
    And I click the "Exam Target" insert previous link in the "Note Writer Main" pane
    And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
    And the text "PERL. Sclerae nonicteric. Conjunctivae pink." should appear in the "Note Writer Main" pane
    And I select the note "A/P" section
    And I click the "ESC" key in the "AP Diagnosis Search" field in the "Note Writer Main" pane
    And I click the "Problem List" insert previous link in the "Note Writer Main" pane
    And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
    And the text "Burn" should appear in the "Note Writer Main" pane
    And I click the "Note Writer Cancel Note" button in the "Clinical Note" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane

  Scenario: Insert Previous Draft Notes are not appearing[Should appear] on Insert previous popup[DEV-68052]
 #   Test Case:   DEV-68052_Insert Previous Draft Notes are not appearing on Insert previous popup
    And I select patient "DARR, MOLLY" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Exam" section
    And I click the "Exam Eyes Normal" element in the "Note Writer Main" pane
    And I click the "Exam Resp Normal" element in the "Note Writer Main" pane
    And the following text should appear in the "Note Writer Main" pane
      |PERL. Sclerae nonicteric. Conjunctivae pink. |
      |Lungs clear to auscultation, no distress.    |
 #      |Kung Fu Panda an animated movie              |
    And I select the note "A/P" section
    And I click the "Add Problem" button in the "Note Writer Main" pane if it exists
    And I enter "R07.89" in the "PN Diagnosis Search" field
    And I enter "Burn" in the "Plan QTV2" rich text field
    And I click the "CTRL ALL" key in the "Plan QTV2" rich text field in the "Note Writer Main" pane
    And I click the "Bold" key in the "PlanQTV2" rich text field in the "Note Writer Main" pane
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I click the "SaveasDraft" button in the "Clinical Note" pane
    Then I click the "Yes" button in the "Note Writer Main" pane
    And I am on the "Patient List V2" tab
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    And I select "Clinical Notes" from clinical navigation
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "*DRAFT* Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the "Progress Note" pane should load
    And the text "Draft" should appear in the "Progress Note" pane
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Exam" section
    And I click the "OK" button in the "Information" pane if it exists
    And I wait "3" seconds
    And I click the "Exam Target" insert previous link in the "Note Writer Main" pane
    And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
    And the following text should appear in the "Note Writer Main" pane
      |PERL. Sclerae nonicteric. Conjunctivae pink. |
      |Lungs clear to auscultation, no distress.    |
 #      |Kung Fu Panda an animated movie              |
    And the text "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "Note Writer Main" pane
    And I select the note "A/P" section
    And I click the "ESC" key in the "PN Diagnosis Search" field in the "Note Writer Main" pane
    And I click the "Problem List" insert previous link in the "Note Writer Main" pane
    And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
    And the text "Burn" should appear in the "Note Writer Main" pane
    And I click the "Note Writer Cancel Note" button in the "Clinical Note" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane

  Scenario: AP text should be bold in Insert Previous[DEV-64561]
  #  Test Case: DEV-64561_AP text should be bold in Insert Previous
    And I select patient "DARR, MOLLY" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I select the note "A/P" section
    And I click the "Add Problem" button in the "Note Writer Main" pane if it exists
    And I enter "R07.89" in the "PN Diagnosis Search" field
    And I enter "Burn" in the "Plan QTV2" rich text field
    And I click the "CTRL ALL" key in the "Plan QTV2" rich text field in the "Note Writer Main" pane
    And I click the "Bold" key in the "Plan QTV2" rich text field in the "Note Writer Main" pane
    And I sign/submit the "Progress Note" note
    And I am on the "Patient List V2" tab
    And I select patient "DARR, MOLLY" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And I select the note "A/P" section
    And I click the "ESC" key in the "PN Diagnosis Search" field in the "Note Writer Main" pane
    And I click the "Problem List" insert previous link in the "Note Writer Main" pane
    And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
    Then I verify the text "Burn" is bold in other mode in the "Note Writer Main" pane
    And I click the "Note Writer Cancel Note" button in the "Clinical Note" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane

  Scenario: AP text should not be bold in Insert Previous[DEV-64561]
  # Test Case: DEV-64561_AP text shouldnt be bold in Insert Previous
    And I select patient "DARR, MOLLY" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I select the note "A/P" section
    And I click the "Add Problem" button in the "Note Writer Main" pane if it exists
    And I enter "R07.89" in the "PN Diagnosis Search" field
    And I enter "Burn" in the "Plan QTV2" rich text field
    And I sign/submit the "Progress Note" note
    And I am on the "Patient List V2" tab
    And I select patient "DARR, MOLLY" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And I select the note "A/P" section
    And I click the "ESC" key in the "PN Diagnosis Search" field in the "Note Writer Main" pane
    And I click the "Problem List" insert previous link in the "Note Writer Main" pane
    And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
    Then I verify the text "Burn" is plaintext in other mode in the "Note Writer Main" pane
    And I click the "Note Writer Cancel Note" button in the "Clinical Note" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane

  Scenario: Insert Previous link is disabled if Include Department Notes in Insert Previous is set to No[DEV-65265]
 #  Test case: DEV-65265_Insert Previous link is disabled if Include Department Notes in Insert Previous is set to No
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Department" subtab
    When I select the department "DeptNotesTest"
    And I click the "Edit" button in the "Quick Details" pane
    When I select "NoteWriter" from the "Edit Department Settings" dropdown
    Then the "Department Note Writer Settings" pane should load
    And I select "false" from the "Include Department Notes In Insert Previous" radio list in the "Department Note Writer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "nwtest3" using the default password
    And I am on the "Patient List V2" tab
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And I select the note "A/P" section
    And I click the "Add Problem" button in the "Note Writer Main" pane if it exists
    And I enter "R07.89" in the "PN Diagnosis Search" field
    And I enter "Burn" in the "Plan QTV2" rich text field
    And I click the "CTRL ALL" key in the "Plan QTV2" rich text field in the "Note Writer Main" pane
    And I click the "Bold" key in the "Plan QTV2" rich text field in the "Note Writer Main" pane
    And I sign/submit the "Progress Note" note
    And I click the logout button
    Given I am logged into the portal with user "nwtest3" using the default password
    And I am on the "Patient List V2" tab
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And I select the note "A/P" section
    And I click the "ESC" key in the "PN Diagnosis Search" field in the "Note Writer Main" pane
    And I click the "Problem List" insert previous link in the "Note Writer Main" pane
    And I click the "My Department Notes" element
   And the following fields should be disabled in the "Data To Insert From Previous Notes" pane
       |Name     |Type   |
       |Previous |element|
    And the text "This section was not filled out in this note" should appear in the "Data To Insert From Previous Notes" pane
    And I click the "Data To Insert Cancel" button in the "Data To Insert From Previous Notes" pane
    And I click the "Note Writer Cancel Note" button in the "Clinical Note" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane

  Scenario: Verify Insert Previous available for user's own notes and can insert the notes if Include Department Notes is set to No[DEV-66799]
#  Test case: DEV-66799_Insert Previous link is disabled if Include Department Notes in Insert Previous is set to No.
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Department" subtab
    When I select the department "DeptNotesTest"
    And I click the "Edit" button in the "Quick Details" pane
    When I select "NoteWriter" from the "Edit Department Settings" dropdown
    Then the "Department Note Writer Settings" pane should load
    And  I select "false" from the "Include Department Notes In Insert Previous" radio list in the "Department Note Writer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "nwtest3" using the default password
    And I am on the "Patient List V2" tab
    And "BLAZER, ROY" is on the patient list
    And I select patient "BLAZER, ROY" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And I select the note "A/P" section
    And I click the "Add Problem" button in the "Note Writer Main" pane if it exists
    And I enter "R07.89" in the "PN Diagnosis Search" field
    And I enter "Burn" in the "Plan QTV2" rich text field
    And I sign/submit the "Progress Note" note
    And I click the logout button
    Given I am logged into the portal with user "nwtest3" using the default password
    And I am on the "Patient List V2" tab
    And I select patient "BLAZER, ROY" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I select the note "A/P" section
    And I click the "ESC" key in the "PN Diagnosis Search" field in the "Note Writer Main" pane
    And I click the "Problem List" insert previous link in the "Note Writer Main" pane
    And I click the "My Notes" element
    And the following fields should be disabled in the "Data To Insert From Previous Notes" pane
       |Name      |Type  |
       |Previous  |element|
    And the text "Burn" should appear in the "Data To Insert From Previous Notes" pane
    And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
    And the text "Burn" should appear in the "Note Writer Main" pane
    And I click the "Note Writer Cancel Note" button in the "Clinical Note" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane

  Scenario: Pre-requisite-Co-Sig- Multi lines text is not displayed in the single line, When co-signer used insert previous[DEV-69249]
#     Test case: DEV-69249_Co-Sig- Multi lines text displayed in the single line; When co-signer used insert previous.
    Given I am logged into the portal with user "nwadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "true" from the "CoSignature" radio list in the "Note Writer Settings" pane
    And I select "None" from the "Validation" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box if it exists
    And I click the logout button
    Given I am logged into the portal with user "CSlvl3u3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And I select the note "A/P" section
    And I click the "ESC" key in the "PN Diagnosis Search" field in the "Note Writer Main" pane
    And I select "Moderate" from the "LevelOfDecision" dropdown
    And I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I enter "CSLVL3U1" in the "lookupField" field in the "CoSignSubmitNote" pane
    Then I select "CSLVL3U1" option from the "CoSign LookUp Search List" list
    And I click the "SubmitCoSigNoteConfirm" button in the "CoSignSubmitNote" pane

#    And I enter "CSlvl3u1" in the "lookupField" field
#    And I wait "2" seconds
#    And I click the "SearchImage" element in the "Submit Note" pane
#    And I click the "OK" button in the "Submit Note" pane
    And I click the logout button
    Given I am logged into the portal with user "CSlvl3u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    When I select "HEATH, NEIL" from the "Patient" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    And I click the "Attest" button
    And I select the note "A/P" section in the "CoSigNote" pane
    Then I click the "Yes" button in the "Information" pane if it exists
    When I enter "THIS IS FIRST LINE" in the "CoSignatureAdditionsAP" rich text field
    And I click the "ENTER" key in the "CoSignatureAdditionsAP" rich text field
    When I enter "THIS IS SECOND LINE THIS IS SECOND LINE" in the "CoSignatureAdditionsAP" rich text field
    And I click the "Sign/Submit" button
    Then I click the "OK" button in the "Sign/SubmitNote" pane

  @DEV69249
  Scenario: Verify Co-Sig- Multi lines text is not displayed in the single line, When co-signer used insert previous[DEV-69249]
#    Test case: DEV-69249_Co-Sig- Multi lines text displayed in the single line; When co-signer used insert previous.
    Given I am logged into the portal with user "CSlvl3u3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And I select the note "A/P" section
    And I click the "ESC" key in the "PN Diagnosis Search" field in the "Note Writer Main" pane
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
#    And I enter "CSlvl3u1" in the "lookupField" field
#    And I wait "2" seconds
#    And I click the "SearchImage" element in the "Submit Note" pane
#    And I click the "OK" button in the "Submit Note" pane
    And I enter "CSLVL3U1" in the "lookupField" field in the "CoSignSubmitNote" pane
    Then I select "CSLVL3U1" option from the "CoSign LookUp Search List" list
    And I click the "SubmitCoSigNoteConfirm" button in the "CoSignSubmitNote" pane
    And I click the logout button
    Given I am logged into the portal with user "CSlvl3u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    When I select "HEATH, NEIL" from the "Patient" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    And I click the "Attest" button
    And I select the note "A/P" section in the "CoSigNote" pane
    Then I click the "Yes" button in the "Information" pane if it exists
    And I click the "Co Sig Comments AP" insert previous link in the "Co Sig Note Contents" pane
    Then I click the "Yes" button in the "Information" pane if it exists
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      |THIS IS FIRST LINE                     |
      |THIS IS SECOND LINE THIS IS SECOND LINE|
    And I click the "Insert Selected" button
    Then the following text should appear in the "Co Sig Note Contents" pane
      |THIS IS FIRST LINE|
      |THIS IS SECOND LINE THIS IS SECOND LINE|
    And I click the "Note Writer Cancel Note" button
    Then I click the "Confirm" button in the "Note Writer Main" pane

  Scenario:Disable Note Writer Co-signature
    Given I am logged into the portal with user "nwadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "false" from the "CoSignature" radio list in the "Note Writer Settings" pane
    And I select "None" from the "Validation" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button

  Scenario: Progress Note AP section Insert previous functionality should work if user insert data from No Drag and Drop note[DEV-68387]
 #   Test case: DEV-68387_Progress Note AP section Insert previous functionality should work if user insert data from No drag and drop note to Drag and Drop note
    Given I am logged into the portal with user "nwtest3" using the default password
    And I am on the "Patient List V2" tab
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And I select the note "A/P" section
    And I click the "Add Problem" button in the "Note Writer Main" pane if it exists
    And I enter "A27.9" in the "PN Diagnosis Search" field
    And I enter "B99.9" in the "PN Diagnosis Search" field
    And I enter "L98.8" in the "PN Diagnosis Search" field
    And I enter "R07.89" in the "PN Diagnosis Search" field
    And the text "Leptospirosis" should appear in the "Note Writer Main" pane
    And the text "Unspecified infectious disease" should appear in the "Note Writer Main" pane
    And the text "Other specified disorders of the skin and subcutaneous tissue" should appear in the "Note Writer Main" pane
    And the text "Other chest pain" should appear in the "Note Writer Main" pane
    And I sign/submit the "Progress Note" note
    And I am on the "Patient List V2" tab
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "ProgressNoteHTML5DragAndDrop" template note for the selected patient
    And I select the note "A/P" section
    And I click the "Problem List" insert previous link in the "Note Writer Main" pane
    And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
    And the text "Leptospirosis" should appear in the "Note Writer Main" pane
    And the text "Unspecified infectious disease" should appear in the "Note Writer Main" pane
    And the text "Other specified disorders of the skin and subcutaneous tissue" should appear in the "Note Writer Main" pane
    And the text "Other chest pain" should appear in the "Note Writer Main" pane
    And I click the "Note Writer Cancel Note" button in the "Clinical Note" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane

  Scenario: Progress Note AP section Insert previous functionality should work if user insert data from Drag and Drop note[DEV-68387]
#   Test case: DEV-68387_Progress Note AP section Insert previous functionality should work if user insert data from No drag and drop note to Drag and Drop note
    And I select patient "BLAZER, ROY" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "ProgressNoteHTML5DragAndDrop" template note for the selected patient
    And I select the note "A/P" section
    And I click the "Add Problem" button in the "Note Writer" pane if it exists
    And I enter "A27.9" in the "Problem Dx Search" field
    And I enter "B99.9" in the "Problem Dx Search" field
    And I enter "L98.8" in the "Problem Dx Search" field
    And I enter "R07.89" in the "Problem Dx Search" field
    And the text "Leptospirosis" should appear in the "Note Writer" pane
    And the text "Unspecified infectious disease" should appear in the "Note Writer" pane
    And the text "Other specified disorders of the skin and subcutaneous tissue" should appear in the "Note Writer" pane
    And the text "Other chest pain" should appear in the "Note Writer" pane
    And I sign/submit the "ProgressNoteHTML5DragAndDrop" note
    And I am on the "Patient List V2" tab
    And "BLAZER, ROY" is on the patient list
    And I select patient "BLAZER, ROY" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And I select the note "A/P" section
    And I click the "ESC" key in the "PN Diagnosis Search" field in the "Note Writer Main" pane
    And I click the "Problem List" insert previous link in the "Note Writer Main" pane
    And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
    And the text "Leptospirosis" should appear in the "Note Writer Main" pane
    And the text "Unspecified infectious disease" should appear in the "Note Writer Main" pane
    And the text "Other specified disorders of the skin and subcutaneous tissue" should appear in the "Note Writer Main" pane
    And the text "Other chest pain" should appear in the "Note Writer Main" pane
    And I click the "Note Writer Cancel Note" button in the "Clinical Note" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane

  Scenario: Pre-requisite - Insert Previous Popup cut off when set Clinical Data Percent Width in Pop-Out Mode 70,60,50 percent[DEV-68224]
#  Test case: DEV-68224_Insert Previous Popup cut off when  set Clinical Data Percent Width in Pop-Out Mode 70 percent
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "History and Physical" template note for the selected patient
    And I select the note "A/P" section
    And I enter "B99.9" in the "AP Diagnosis Search" field in the "NoteWriter APDX Search QTV2" pane
    And I enter "L98.8" in the "AP Diagnosis Search" field in the "NoteWriter APDX Search QTV2" pane
    And I select "Moderate" from the "LevelOfDecision" dropdown
    And I click the "Save as Draft" button in the "ClinicalNote" pane
    Then I click the "Yes" button in the "Note Writer Main" pane
    And I click the logout button
    Given I am logged into the portal with user "InsPrevJira3" using the default password
    And I am on the "Patient List V2" tab
    And I select "InsPrevJira" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "History and Physical" template note for the selected patient
    And I select the note "A/P" section
    And I enter "R07.89" in the "AP Diagnosis Search" field in the "NoteWriter APDX Search QTV2" pane
    And I enter "R52" in the "AP Diagnosis Search" field in the "NoteWriter APDX Search QTV2" pane
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I click the "SaveasDraft" button in the "ClinicalNote" pane
    Then I click the "Yes" button in the "Note Writer Main" pane

  Scenario Outline: Verify Previous Popup cut off when set Clinical Data Percent Width in Pop-Out Mode 70,60 and 50 percent[DEV-68224]
    #  Test case: DEV-68224_Insert Previous Popup cut off when  set Clinical Data Percent Width in Pop-Out Mode 70 percent
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "InsPrevJira3"
    And I select the user "InsPrevJira3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "NoteWriter" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I wait "3" seconds
    And I select "<Pop-Out Percentage>" from the "Set Clinical Data Percent Width In PopOut Mode" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "InsPrevJira3" using the default password
    And I am on the "Patient List V2" tab
    And I select "InsPrevJira" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "History and Physical" template note for the selected patient
    And I click the "Keep" button in the "Question" pane if it exists
    And I select the note "A/P" section
    And I pop out note writer and check the pop out width as "<Pop-out Width>" percent when clinical data percent width in pop out mode is set to "<Pop-Out Percentage>" percent
    And I wait "5" seconds
    And I select the note "A/P" section
    And I click the "Problem List" insert previous link in the "Note Writer Main" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      |Other chest pain            |
      |Headache                    |
    And I click the "Page Previous Image" element in the "Data To Insert From Previous Notes" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      |Unspecified infectious disease                                            |
      |Other specified disorders of the skin and subcutaneous tissue |
    And I click the "Page Next Image" element in the "Data To Insert From Previous Notes" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      |Other chest pain            |
      |Headache                    |
    And I click the "Insert Selected" button
    Then the following text should appear in the "Note Writer Main" pane
      |Other chest pain            |
      |Headache                    |
    And I click the "Save as Draft" button in the "Clinical Note Pop Out" pane
    Then I click the "Yes" button in the "Note Writer Main" pane
    And I switch the focus to the "portalWindow" window
    And I wait "3" seconds
    And I am on the "Patient List V2" tab
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I wait "3" seconds
    Then the "Clinical Notes" table should load
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "*DRAFT* History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the following text should appear in the "NoteDetails" pane
      | Status |
      | Draft  |
    And I delete the draft note in the "Note Details" pane
    And I click the logout button

    Examples:
      |Pop-Out Percentage |Pop-out Width|
      |70                 |  30         |
      |60                 |  40         |
      |50                 |  50         |

  Scenario: Set Clinical data Pop-Out width to default 50 percent
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "InsPrevJira3"
    And I select the user "InsPrevJira3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "NoteWriter" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I wait "3" seconds
    And I select "50" from the "Set Clinical Data Percent Width In PopOut Mode" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
  @donotrun
  Scenario Outline: Verify Insert Previous Popup cut off when Clinical note Pop-Out is dragged 70,60 and 50 percent[DEV-68224]
  #  Test case: DEV-68224_Insert Previous Popup cut off when user make the main window small
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "InsPrevJira3"
    And I select the user "InsPrevJira3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "NoteWriter" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I wait "3" seconds
    And I select "50" from the "Set Clinical Data Percent Width In PopOut Mode" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button
    Given I am logged into the portal with user "InsPrevJira3" using the default password
    And I am on the "Patient List V2" tab
    And I select "InsPrevJira" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "History and Physical" template note for the selected patient
    And I click the "Keep" button in the "Question" pane if it exists
    And I select the note "A/P" section
    And I pop out note writer and check the pop out width as "<Pop-out Width>" percent when clinical data percent width in pop out mode is set to "<Pop-Out Percentage>" percent
    And I resize portal window to "<Pop-Out Percentage>" percent
    And I wait "5" seconds
    And I select the note "A/P" section
    And I click the "Problem List" insert previous link in the "Note Writer Main" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      |Other chest pain            |
      |Headache                    |
    And I click the "Page Previous Image" element in the "Data To Insert From Previous Notes" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      |Unspecified infectious disease                                            |
      |Other specified disorders of the skin and subcutaneous tissue |
    And I click the "Page Next Image" element in the "Data To Insert From Previous Notes" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      |Other chest pain            |
      |Headache                    |
    And I click the "Insert Selected" button
    Then the following text should appear in the "Note Writer Main" pane
      |Other chest pain            |
      |Headache                    |
    And I click the "Save as Draft" button in the "Clinical Note Pop Out" pane
    Then I click the "Yes" button in the "Note Writer Main" pane
    And I switch the focus to the "portalWindow" window
    And I wait "3" seconds
    And I am on the "Patient List V2" tab
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Clinical Notes" from clinical navigation
    Then the "Clinical Notes" table should load
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "*DRAFT* History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the following text should appear in the "NoteDetails" pane
      | Status |
      | Draft  |
    And I delete the draft note in the "Note Details" pane
    And I click the logout button

    Examples:
      |Pop-Out Percentage |
      |70                 |
      |60                 |
      |50                 |

  Scenario:Verify Free text problems are duplicating in Discharge Summary when using Insert Previous[DEV-69093]
#   Test case: DEV-69093_Free text problems are duplicating in Discharge Summary when using Insert Previous
    And "BONNET, LOLA" is on the patient list
    And I select patient "BONNET, LOLA" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "A/P" section
    And I click the "Add Problem" button in the "Note Writer Main" pane if it exists
    And I enter "aaaaa" in the "PN Diagnosis Search" field in the "Note Writer History DX Search" pane
    And I click the "Add as Free Text" link in the "Note Writer History DX Search" pane
    And I enter "bbbbb" in the "PN Diagnosis Search" field in the "Note Writer History DX Search" pane
    And I click the "Add as Free Text" link in the "Note Writer History DX Search" pane
    Then I sign/submit the "Progress Note" note
    When "BONNET, LOLA" is on the patient list
    And I select patient "BONNET, LOLA" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "A/P" section
    And I click the "Problem List" insert previous link in the "Note Writer Main" pane
    And I click the "Insert Selected" button
    Then I sign/submit the "Progress Note" note
    When "BONNET, LOLA" is on the patient list
    And I select patient "BONNET, LOLA" from the patient list
    And I load the "Discharge Summary" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "Problems/Procedures" section
    Then the following text should appear in the "Admitting Diagnoses" pane and count should be "2"
      |aaaaa |
      |bbbbb |
    Then the following text should appear in the "Discharge Diagnoses" pane and count should be "2"
      |aaaaa |
      |bbbbb |
    And I click the "Note Writer Cancel Note" button in the "Note Writer Main" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane
    
  Scenario: Addendum insert previous link  multi line added addendum should not be visible in single line for Progress Note Template[DEV-69191]
  #  Test case:  DEV-69191_Addendum insert previous link  multi line added addendum visible in single line in on Progress Note Template (only template where insert previous appears in addendum flow)
    And I select patient "Molly Darr" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    Then I select the note "Subjective" section
    And I sign/submit the "Progress Note" note
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the "Progress Note" pane should load
    And the text "Final" should appear in the "Progress Note" pane
    And I click the "Add Addendum" button
    And I click the "Addendum Comments ABCQTV2" element in the "Note Writer Main" pane
    And I click the "Quick Text Container" element if it exists
    And I click on the text "Multiline" in the "ClickToInsertV2" pane
    And I click the "Quick Text Close" button
    And I click the "Note Writer Sign/Submit" button in the "Note Writer Main" pane
    And I click the "OK" button in the "Submit Note" pane
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "Progress Note - with Addendum" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Final" should appear in the "Progress Note" pane
    And I click the "Add Addendum" button
    And I wait "5" seconds
    And I click the "Clinical Data Addendum" insert previous link in the "Note Writer Main" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      |THIS IS FIRST LINE |
      |THIS IS SECOND LINE|
      |1                  |
      |2                  |
    And I click the "Insert Selected" button
    Then the following text should appear in the "Note Writer Main" pane
      |THIS IS FIRST LINE |
      |THIS IS SECOND LINE|
      |1                  |
      |2                  |
    And I click the "Note WriterSign/Submit" button in the "Note Writer Main" pane
    And I click the "OK" button in the "Submit Note" pane

  Scenario: Verify horizontal scroll bar should not appear when user does insert Previous in ROS, Exam fields that contain non-breakable space long text
   #Test Case: DEV-70525_Field width change with horizontal scroll bar when user insert Previous of ROSExam fields that contain non-breakable space long text
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "Subjective" section
    And I click the "ROS RESP Abnormal" button in the "Note Writer Main" pane
    Then I get content from "VibraLongText" html file and set in the "ROS Abnormal QTV2" field
    And I select the note "Exam" section
    And I wait "2" seconds
    And I click the "Exam Resp Abnormal" element
    Then I get content from "VibraLongText" html file and set in the "Eyes Abnormal QTV2" field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I click the "SaveasDraft" button in the "Clinical Note" pane
    Then I click the "Yes" button in the "Note Writer Main" pane
    And I am on the "Patient List V2" tab
    When "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I wait "5" seconds
    And I click the "ROS" insert previous link in the "Note Writer Main" pane
    And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
    Then the horizontal scrollbar should not present for the "ROS Abnormal QTV2" field of type "text_field" in the "Note Writer Main" pane
    And I select the note "Exam" section
    And I wait "5" seconds
    And I click the "Exam Target" insert previous link in the "Note Writer Main" pane
    And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
    Then the horizontal scrollbar should not present for the "Eyes Abnormal QTV2" field of type "text_field" in the "Note Writer Main" pane
    And I click the "Note Writer Cancel Note" button in the "Clinical Note" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane

  @donotrun
  Scenario: Verify Smart tag carriage returns is respected when user does Insert Previous in ROS, Exam fields
  #  Test Case: DEV-70245_QTv2-Carriage returns not respected for Smart tags; when data inserted from draft note using Insert Previous
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "Subjective" section
    And I click the "ROS RESP Abnormal" button
    And I click the "ROS Narrative ABC" element
    And I click the "Quick Text Container" element
    And I click the "Quick Text" element
    And I click the "Quick Text Close" button
    And I select the note "Exam" section
    And I wait "2" seconds
    And I click the "Exam Resp Abnormal" element
    And I click the "Exam Narrative ABC" element
    And I click the "Quick Text Container" element
    And I click the "Quick Text" element
    And I click the "Quick Text Close" button
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I click the "Saveas Draft" button in the "Clinical Note" pane
    Then I click the "Yes" button in the "Note Writer Main" pane
    And I am on the "Patient List V2" tab
    When "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I wait "5" seconds
    And I click the "ROS" insert previous link in the "NoteWriter" pane
    And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
    And I verify "Insert Text" is selected
    And I select the note "Exam" section
    And I wait "5" seconds
    And I click the "Exam Target" insert previous link in the "NoteWriter" pane
    And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
    And I verify "Select One" is selected
    And I click the "Note Writer Cancel Note" button in the "Clinical Note" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane





