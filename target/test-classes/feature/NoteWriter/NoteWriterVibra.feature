@NoteWriterVibra
Feature:NoteWriterVibra
  Background:
    Given I am logged into the portal with user "VibraUser3" using the default password
    And I am on the "Patient List V2" tab

  Scenario: Enable QuickText v2
    Given I am logged into the portal with user "nwadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I select "None" from the "Validation" dropdown
    And I wait "2" seconds
    And I select "true" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
    And I select "true" from the "Enable Spell Check" radio list in the "Note Writer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box

  Scenario:Verify Vibra - Entering Free Text diagnosis with special characters with Progress note CST template [DEV-68820].
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Vibra Progress Note CST" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "A/P" section
    And I click the "ToggleDxSearch" button
    And I enter "Disposition & follow up" in the "Diagnosis Search" field in the "NoteWriterHistoryDXSearch" pane
    And I click the "Add as Free Text" link in the "NoteWriterHistoryDXSearch" pane
    And the text "An error occurred processing your request." should not appear in the "Warning" pane
    Then I sign/submit the note for vibra template

  Scenario:Verify Vibra - Entering Free Text diagnosis with special characters with Progress note PST template [DEV-68820].
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Vibra Progress Note PST" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "A/P" section
    And I click the "ToggleDxSearch" button
    And I enter "Disposition & follow up" in the "Diagnosis Search" field in the "NoteWriterHistoryDXSearch" pane
    And I click the "Add as Free Text" link in the "NoteWriterHistoryDXSearch" pane
    And the text "An error occurred processing your request." should not appear in the "Warning" pane
    Then I sign/submit the note for vibra template

  Scenario:Verify Vibra - Insert Previous with specific data cause script error  [DEV-68712]
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Vibra Progress Note CST" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "A/P" section
    And I click the "ToggleDxSearch" button
    And I enter "Disposition" in the "Diagnosis Search" field in the "NoteWriterHistoryDXSearch" pane
    And I click the "Add as Free Text" link in the "NoteWriterHistoryDXSearch" pane
    And I enter "Long Line:This is a very long line. This is a very long line. This is a very long line. This is a very long line. This is a very long line. This is a very long line. This is a very long line. This is a very long line. This is a very long line. This is a very long line. This is a very long line. This is a very long line. This is a very long line. This is a very long line. This is a very long line. This is a very long line. This is a very long line. This is a very long line.  Test case for long line:7/27  WBCs incr from 7.7 to 9 to 11. Segs 89%. No f/c. Check UCx, CXR. CBC in AM. Poss some degree of hemoconc from dehydration. CXR initially obtained on wrong pt due to pt changing rooms w/ room labels being checked. Repeat CXR pending. 7/28  still no repeat CXR. Re-ordered. No f/c. WBCs/left shift improved w/ IVFs. Suspect was due to hemoconc. Will still get CXR as had clinical reason to obtain initially. 7/31  prior CXR w/o acute finding. UCX  E. faecalis and P. mirabilis. Suspect colonized. No f/c. VSS. Will not tx yet unless change in clinical condition/fever/incr WBCs. D/W ID. Follow CBC/VSS. 8/1  Discussed UCx w/ ID and Dr. Thomas agreed w/ no tx at present. Follow clinically. No f/c. 8/7 - stable.Bold Italics UnderlinedDiv dangerousThis is plain text.firstsecondthirdr0c0	r0c1	r0c2r1c0	r1c1	r1c2span nobrouter divinner div7/27 - WBCs incr from 7.7 to 9 to 11. Segs 89%. No f/c. Check UCx, CXR. CBC in AM. Oss degree of hemoconc from dehydration. CXR initially obtained on wrong pt due to pt changing rooms w/ room labels being checked. Repeat CXR pending. 7/28 - still no repeat CXR. Re-ordered. No f/c. WBCs/left shift improved w/ IVFs. Suspect was due to hemoconc. Will still get CXR as had clinical reason to obtain initially. 7/31 - prior CXR w/o acute finding. UCX + E. faecalis and P. mirabilis. Suspect colonized. No f/c. VSS. Will not tx yet unless change in clinical condition/fever/incr WBCs. D/W ID. Follow CBC/VSS. 8/1 - Discussed UCx+ w/ ID and Dr. Thomas agreed w/ no tx at present. Follow clinically. No f/c. 8/7 - stable.gentium" in the "AssessmentAndPlan" rich text field
    Then I sign/submit the note for vibra template

  Scenario:Verify Vibra - Insert Previous with specific data cause script error with PST template [DEV-68712]
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Vibra Progress Note PST" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "A/P" section
    And I click the "InsertPreviousA/P" element
    And I click the "InsertSelectionQTV2" button
    Then I sign/submit the note for vibra template

  Scenario:Verify Vibra - Insert Previous with specific data cause script error with CST template [DEV-68712]
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Vibra Progress Note CST" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "A/P" section
    And I click the "InsertPreviousA/P" element
    And I click the "InsertSelectionQTV2" button
    Then I sign/submit the note for vibra template

  Scenario:Verify Vibra - Free text problems are duplicating in Discharge Summary when using Insert Previous[DEV-69093]
    When "HELEN BAMBERGER" is on the patient list
    And I select patient "HELEN BAMBERGER" from the patient list
    And I load the "Vibra Progress Note CST" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "A/P" section
    And I click the "ToggleDxSearch" button
    And I enter "aaaaa" in the "Diagnosis Search" field in the "NoteWriterHistoryDXSearch" pane
    And I click the "Add as Free Text" link in the "NoteWriterHistoryDXSearch" pane
    And I enter "bbbbb" in the "Diagnosis Search" field in the "NoteWriterHistoryDXSearch" pane
    And I click the "Add as Free Text" link in the "NoteWriterHistoryDXSearch" pane
    Then I sign/submit the note for vibra template
    When "HELEN BAMBERGER" is on the patient list
    And I select patient "HELEN BAMBERGER" from the patient list
    And I load the "Vibra Progress Note PST" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "A/P" section
    And I click the "InsertPreviousA/P" element
    And I click the "InsertSelectionQTV2" button
    Then I sign/submit the note for vibra template
    When "HELEN BAMBERGER" is on the patient list
    And I select patient "HELEN BAMBERGER" from the patient list
    And I load the "Discharge Summary" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "Problems/Procedures" section
    Then the following text should appear in the "AdmittingDiagnoses" pane and count should be "2"
      |aaaaa |
      |bbbbb |
    Then the following text should appear in the "DischargeDiagnoses" pane and count should be "2"
      |aaaaa |
      |bbbbb |
    Then I sign/submit the note for vibra template

  Scenario:Verify Vibra - HTML should not appear in note from insert previous action with CST template[DEV-68746]
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Vibra Progress Note CST" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "A/P" section
    And I click the "ToggleDxSearch" button
    And I enter "Chronic ulcer of left foot with fat layer exposed" in the "Diagnosis Search" field in the "NoteWriter History DX Search" pane
    And I click the "Add as Free Text" link in the "NoteWriter History DX Search" pane
    And I enter "2/2 rigid ankle brace. L dorsal foot wound, noted when saw blood about 3 weeks ago. Seen in South Strand ER initially." in the "Assessment And Plan" rich text field
    Then I sign/submit the note for vibra template
    Then I select patient "Molly Darr" from the patient list
    And I load the "Vibra Progress Note CST" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "A/P" section
    And I click the "InsertPreviousA/P" element
    And I click the "InsertSelectionQTV2" button
    And the text "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "Problem Target" pane
    And I click the "NoteWriter Cancel Note" button in the "Clinical Note" pane
    Then I click the "Yes" button in the "Information" pane

  Scenario:Verify Vibra - HTML should not appear in note from insert previous action with PST template[DEV-68746]
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Vibra Progress Note PST" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "A/P" section
    And I click the "ToggleDxSearch" button
    And I enter "Chronic ulcer of left foot with fat layer exposed" in the "Diagnosis Search" field in the "NoteWriter History DX Search" pane
    And I click the "Add as Free Text" link in the "NoteWriter History DX Search" pane
    And I enter "2/2 rigid ankle brace. L dorsal foot wound, noted when saw blood about 3 weeks ago. Seen in South Strand ER initially." in the "Assessment And Plan" rich text field
    Then I sign/submit the note for vibra template
    Then I select patient "Molly Darr" from the patient list
    And I load the "Vibra Progress Note PST" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "A/P" section
    And I click the "InsertPreviousA/P" element
    And I click the "InsertSelectionQTV2" button
    And the text "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "Problem Target" pane
    And I click the "NoteWriter Cancel Note" button in the "Clinical Note" pane
    Then I click the "Yes" button in the "Information" pane

  Scenario:Verify Vibra NWTE- White space is not created and additional text details are not missing in clinical notes pane when large/ long text is added to note with PST template[DEV-68892]
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Vibra Progress Note PST" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "Data" section
    And I click the "Allergies" link in the "NoteWriter" pane
    Then the "Patient Data" pane should load
    When I click the "NoteWriter Preselection Icon" image in the "Allergy List" pane
    And I click the "Lab Results" link in the "Patient Data Clinical Navigation" pane
    And I click the "NoteWriter Preselection Icon" image in the "Lab List" pane
    And I click the "Copy to Note" button in the "Patient Data" pane
    And I wait "2" seconds
    Then I get content from "VibraLongText" html file and set in the "Data Additional Results" field
    Then I get text from "Data Additional Results" field to use later
    Then I get content from "VibraLongText" html file and set in the "Data Summary" field
    And I select the note "A/P" section
    And I click the "ToggleDxSearch" button
    And I enter "Chronic ulcer of left foot with fat layer exposed" in the "Diagnosis Search" field in the "NoteWriter History DX Search" pane
    And I click the "Add as Free Text" link in the "NoteWriter History DX Search" pane
    Then I get content from "VibraLongText" html file and set in the "Assessment And Plan" field
    Then I sign/submit the note for vibra template
    When I select "Clinical Notes" from clinical navigation
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the "Vibra Progress Note PST" pane should load
    And  the "Data Additional Results" "PANE_SECTION" should be visible
    And the text collected from field should appear in the "Data Additional Results" section in the "Vibra Progress Note PST" pane
    And There should not be "5" line spaces in the "Data" section in the "Vibra Progress Note PST" pane

  Scenario:Verify Vibra NWTE- White space is not created and additional text details are not missing in clinical notes pane when large/ long text is added to note with CST template[DEV-68892]
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Vibra Progress Note CST" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "Data" section
    And I click the "Allergies" link in the "NoteWriter" pane
    Then the "Patient Data" pane should load
    When I click the "NoteWriter Preselection Icon" image in the "Allergy List" pane
    And I click the "Lab Results" link in the "Patient Data Clinical Navigation" pane
    And I click the "NoteWriter Preselection Icon" image in the "Lab List" pane
    And I click the "Copy to Note" button in the "Patient Data" pane
    And I wait "2" seconds
    Then I get content from "VibraLongText" html file and set in the "Data Additional Results" field
    Then I get text from "Data Additional Results" field to use later
    Then I get content from "VibraLongText" html file and set in the "Data Summary" field
    And I select the note "A/P" section
    And I click the "ToggleDxSearch" button
    And I enter "Chronic ulcer of left foot with fat layer exposed" in the "Diagnosis Search" field in the "NoteWriter History DX Search" pane
    And I click the "Add as Free Text" link in the "NoteWriter History DX Search" pane
    Then I get content from "VibraLongText" html file and set in the "Assessment And Plan" field
    Then I sign/submit the note for vibra template
    When I select "Clinical Notes" from clinical navigation
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the "Vibra Progress Note CST" pane should load
    And  the "Data Additional Results" "PANE_SECTION" should be visible
    And the text collected from field should appear in the "Data Additional Results" section in the "Vibra Progress Note CST" pane
    And There should not be "5" line spaces in the "Data" section in the "Vibra Progress Note CST" pane

  Scenario: Disable Quick text V2
    Given I am logged into the portal with user "nwadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "false" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box