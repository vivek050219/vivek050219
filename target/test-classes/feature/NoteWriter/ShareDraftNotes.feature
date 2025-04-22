@842Enhancements
  Feature: Sharing draft notes
    #confluence link : https://confluence/display/infrastructure/Sharing+Draft+Notes
    #Epic jira link : https://jira/browse/DEV-77979

    Scenario: Prerequisite : Enable "Allow User To Share Draft Note" setting  to the user "sharedraftlvl3"
      Given I am logged into the portal with user "pkadminv2" using the default password
      And I am on the "Admin" tab
      And I select the "Institution" subtab
      And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
      And I wait "2" seconds
      And I select "true" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
      And I select "true" from the "Enable Spell Check" radio list in the "Note Writer Settings" pane
      And I select "true" from the "CoSignature" radio list in the "Note Writer Settings" pane
      And I select "Password" from the "Validation" dropdown
      And I select "true" from the "AllowAuthorToEditNoteInSignedStatus" radio list in the "Note Writer Settings" pane
      And I select "false" from the "Restrict Shared Drafts To Attending" radio list in the "Note Writer Settings" pane
      And I click the "Save" button
      And I click "OK" in the confirmation box
      And I select the "User" subtab
      And I search for the user "sharedraftlvl3"
      And I select the user "sharedraftlvl3"
      And I click the "Edit" button in the "Quick Details" pane
      And I select "NoteWriter" from the "Edit User Settings" dropdown in the "User Preferences" pane
      And I wait "3" seconds
      And I select "true" from the "AllowUserToShareDraftNote" radio list in the "NoteWriterSettings" pane
      And I click the "Save" button
      And I click "OK" in the confirmation box

    Scenario: Bulk User Enable Shared Draft Notes
      Given I am logged into the portal with user "pkadminv2" using the default password
      And I am on the "Admin" tab
      And I select the "Bulk User Edit" subtab
      And I wait "2" seconds
      Then the "User Search" pane should load
      When I enter "sdlvl" in the "UserName/ID" field in the "User Search" pane
      And I click the "SearchBulkUser" button
      Then the "BulkUserSearchResults" table should load
      And the following text should appear in the "Bulk User Search Results" pane
        |sdlvl1u1   |
        |sdlvl1u2   |
        |sdlvl3u1   |
        |sdlvl3u2   |
      And the user "sdlvl1u1" should appear in the "Bulk User Search Results" pane
      And the user "sdlvl3u1" should appear in the "Bulk User Search Results" pane
      And I click the "SelectAll" button in the "Bulk User Search Results" pane
      And I click the "Add Selected Users" button
      Then the "BulkUserListResults" table should load
      And the user "sdlvl1u1" should appear in the "Users to Edit" pane
      And the user "sdlvl3u1" should appear in the "Users to Edit" pane
      When I check the "AllowUserToShareDraft" checkbox in the "Preference Settings" pane
      And I select "Yes" from the "AllowSharing" dropdown in the "Preference Settings" pane
      And I click the "Set Preferences" button
      And I wait "2" seconds
      Then the text "This will set the 1 selected preference(s) for the 4 user(s) you have chosen." should appear in the "Question" pane
      When I click the "Yes" button in the "Question" pane
      Then the text "All preferences were set successfully!" should appear in the "Information" pane
      When I click the "OK" button in the "Information" pane
      #verify if the above users have share button enabled

    Scenario Outline: Verify if share draft enabled for all users after bulk user settings
      Given I am logged into the portal with user "<user>" using the default password
      And I am on the "Patient List V2" tab
      And I select "Card Group" from the "Patient List" menu
      And "Molly Darr" is on the patient list
      And I select patient "Molly Darr" from the patient list
      And I load the "Progress Note" template note for the selected patient
      And I select the note "Subjective" section
      And I enter "verifying bulk user settings for <user>" in the "PatientNarrativeQTV2" rich text field
      And The following fields should be display in the "Note Writer Main" pane
        |Type       |Name           |
        |button     |Share Draft    |
      And I click the "Share Draft" button in the "Note Writer Main" pane
      And I click the "Yes" button in the "Question" pane if it exists

      Examples:
        |user       |
        |sdlvl1u1   |
        |sdlvl1u2   |
        |sdlvl3u1   |
        |sdlvl3u2   |

    Scenario: Prerequisite : Create shared note
      Given I am logged into the portal with user "sharedraftlvl3" using the default password
      And I am on the "Patient List V2" tab
      And the patient list is maximized
      And I select "shareDraftPL" from the "Patient List" menu
      And I refresh the patient list
      And "Molly Darr" is on the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      And I load the "Progress Note" template note for the selected patient
      And I select the note "Subjective" section
      And I enter "prerequired shared note" in the "PatientNarrativeQTV2" rich text field
      And I click the "Share Draft" button in the "Note Writer Main" pane
      And I click the "Yes" button in the "Question" pane if it exists
      And I refresh the patient list
      And I select patient "Molly Darr" from the patient list
      When I select "Clinical Notes" from clinical navigation
      And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
      Then rows starting with the following should appear in the "Clinical Notes" table
        |Date/Time             |Note Type             |Author            |
        |%Current Date MMDDYY% |*SHARED* Progress Note|LVL3, SHAREDRAFT  |

    Scenario: Shared Notes in Note Search as author and other user[DEV-79678]
      #search for shared draft by logging as author
      Given I am logged into the portal with user "sharedraftlvl3" using the default password
      And I am on the "Note Search" tab
      And I click the "Reset Criteria" button if it exists
      And I select "Draft" from the "PKStatus" dropdown
      And I select "Today" from the "Timeframe" dropdown
      And I enter "sharedraftlvl3" in the "Author" field
      And I click the "SearchAuthor" image
      And I click the "Search" button
      And I wait "2" seconds
      Then rows containing the following should appear in the "NoteSearchResults" table
        |Patient     |Type               |PK Status           |Author             |Note Date             |
        |DARR, MOLLY |Progress Note      |Shared Draft        |LVL3, SHAREDRAFT   |%Current Date MMDDYY% |
      #search for share draft as any other user
      Given I am logged into the portal with user "pkadminv2" using the default password
      And I am on the "Note Search" tab
      And I click the "Reset Criteria" button if it exists
      And I select "Draft" from the "PKStatus" dropdown
      And I select "Today" from the "Timeframe" dropdown
      And I enter "sharedraftlvl3" in the "Author" field
      And I click the "Search" button
      And I wait "2" seconds
      Then rows containing the following should appear in the "NoteSearchResults" table
        |Patient     |Type               |PK Status           |Author             |Note Date             |
        |DARR, MOLLY |Progress Note      |Shared Draft        |LVL3, SHAREDRAFT   |%Current Date MMDDYY% |

    Scenario: Shared Notes cannot be Un-shared by author [DEV-79678]
      #verify using note created be prerequisite scenario
      Given I am logged into the portal with user "sharedraftlvl3" using the default password
      And I am on the "Patient List V2" tab
      And the patient list is maximized
      And I select "shareDraftPL" from the "Patient List" menu
      And I refresh the patient list
      And "Molly Darr" is on the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      Then I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
      Then The button "Delete" should be disabled in the "Note Details" pane
      And I click the "Edit" button
      And I select the note "Subjective" section
      And I wait "3" seconds
      And I enter "testing save as draft as author" in the "PatientNarrativeQTV2" rich text field
      #save button will not be available when shared draft is being edited as per DEV-80803
      #And I save the template as Draft
      And The following fields should be not display in the "Note Details" pane
        |Type       |Name             |
        |button     |Save as Draft    |
      And I click the "Share Draft" button in the "Note Writer Main" pane
      And I click the "Yes" button in the "Question" pane if it exists
      And I refresh the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
      Then rows starting with the following should appear in the "Clinical Notes" table
        |Date/Time             |Note Type             |Author            |
        |%Current Date MMDDYY% |*SHARED* Progress Note|LVL3, SHAREDRAFT  |
      Then I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
      And the text "Shared Draft" should appear in the "Note Details" pane
      Then Text "testing save as draft as author" should appear in the "Note Details" pane

    Scenario: Shared Notes cannot be Deleted
      Given I am logged into the portal with user "sharedraftlvl3" using the default password
      And I am on the "Patient List V2" tab
      And the patient list is maximized
      And I select "shareDraftPL" from the "Patient List" menu
      And I refresh the patient list
      And "Molly Darr" is on the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      And I load the "Progress Note" template note for the selected patient
      And I select the note "Subjective" section
      And I enter "prerequired shared note" in the "PatientNarrativeQTV2" rich text field
      And I click the "Share Draft" button in the "Note Writer Main" pane
      And I click the "Yes" button in the "Question" pane if it exists
      And I refresh the patient list
      And I select patient "Molly Darr" from the patient list
      When I select "Clinical Notes" from clinical navigation
      And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
      Then rows starting with the following should appear in the "ClinicalNotes" table
        |Date/Time             |Note Type             |Author            |
        |%Current Date MMDDYY% |*SHARED* Progress Note|LVL3, SHAREDRAFT  |
      And I wait "2" seconds
      #verify in clinical note detail pane
      Then I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
      Then The button "Delete" should be disabled in the "Note Details" pane
      #verify in note search tab
      And I am on the "Note Search" tab
      And I select "Today" from the "Timeframe" dropdown
      And I enter "sharedraftlvl3" in the "Author" field
      And I click the "SearchAuthor" image
      And I click the "Search" button
      And I wait "2" seconds
      And I sort the "Note Search Results" table chronologically by the "Note Date" column in "Descending" order
      Then rows containing the following should appear in the "NoteSearchResults" table
        |Patient     |Type               |PK Status           |Author             |Note Date             |
        |DARR, MOLLY |Progress Note      |Shared Draft        |LVL3, SHAREDRAFT   |%Current Date MMDDYY% |
      And I select "the first item" in the "Note Search Results" table
      And I click on the link "Note Details" in the "SearchResults" pane
      And I wait "3" seconds
      Then The button "Delete" should be disabled in the "Note Header" pane
      And I click the "Close" button in the "Closing Options" pane
      #verify in patient search
      And I am on the "Patient Search" tab
      And I click the "Clear Criteria" button
      And I uncheck the "Include Cancelled Visits" checkbox
      And I uncheck the "Include Past Visits" checkbox
      When I enter "darr" in the "Last" field in the "Patient Search Criteria" pane
      When I enter "molly" in the "First" field in the "Patient Search Criteria" pane
      And I click the "Search for Patients" button in the "Patient Search Criteria" pane
      Then I click the "ViewDetail" button in the "Search Results" pane
      And I wait "2" seconds
      And I click the "Clinical Notes Left Nav" element in the "Patient Clinical Navigation" pane
      When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
      Then rows starting with the following should appear in the "ClinicalNotes" table
        |Date/Time             |Note Type             |Author            |
        |%Current Date MMDDYY% |*SHARED* Progress Note|LVL3, SHAREDRAFT  |
      And I wait "2" seconds
      Then I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
      Then The button "Delete" should be disabled in the "Progress Note" pane
      And I click the "Close" button in the "PatientDetails" pane
      #verify in inbox
      And I am on the "Inbox" tab
      When I select the "eSig and PK Mail" subtab
      And I click the "Refresh" button
      Then the "Messages" table should load
      And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
      When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table
      Then the "eSig Note Content" pane should load
      Then the "Delete" "button" should not be visible
      And I click the "Xclose" button
      #Note: Provider directory search function is not implemented for the reason of data's not present in the table

    Scenario: Shared Draft Notes are maintained only by Author - create note with clinical data [DEV-79678]
      Given I am logged into the portal with user "sharedraftlvl3" using the default password
      And I am on the "Patient List V2" tab
      And the patient list is maximized
      And I select "shareDraftPL" from the "Patient List" menu
      And I refresh the patient list
      And "Molly Darr" is on the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      Then I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
      And The following fields should be display in the "Note Details" pane
      |Type       |Name           |
      |button     |Edit           |
      |button     |Delete         |
      |element    |DraftWatermark |
      Then The button "Delete" should be disabled in the "Note Details" pane
      And The following fields should be not display in the "Note Details" pane
        |Type       |Name             |
        |button     |Add Addendum    |
      And I click the "Edit" button
      And I select the note "Subjective" section
      And I wait "3" seconds
      And I enter "first copy of shared draft" in the "PatientNarrativeQTV2" rich text field
      And I wait "3" seconds
      And I click the "ROS RESP Normal" element in the "Note Writer" pane
      Then I select the note "Exam" section
      And I click the "Exam CONST Normal" element in the "Note Writer" pane
      And I select the note "A/P" section
      And I click the "Add Problem" button in the "Note Writer" pane if it exists
      And I wait "2" seconds
      And I enter "L60.9" in the "Problem Dx Search" field
      And I wait "2" seconds
      And I click the "Share Draft" button in the "Note Writer Main" pane
      And I click the "Yes" button in the "Question" pane if it exists
      And I load the "Progress Note" template note for the selected patient
      And I select the note "Data" section
      And I wait "3" seconds
      When I click the "Allergies" link in the "NoteWriter" pane
      And I wait "2" seconds
      And I click the "NoteWriterPreselectionIcon" element
      And I click the "CopytoNote" button
      When I click the "Medications" link in the "NoteWriter" pane
      And I wait "2" seconds
      And I click the "NoteWriterPreselectionIcon" element in the "MedicationList" pane
      And I click the "Copy to Note" button
      When I click the "Lab Results" link in the "NoteWriter" pane
      And I wait "2" seconds
      And I click the "NoteWriterPreselectionIcon" element in the "LabList" pane
      And I click the "Copy to Note" button
      When I click the "Test Results" link in the "NoteWriter" pane
      And I wait "2" seconds
      And I click the "NoteWriterPreselectionIcon" element in the "TestResultList" pane
      And I click the "Copy to Note" button
      When I click the "Vitals" link in the "NoteWriter" pane
      And I wait "2" seconds
      And I click the "NoteWriterPreselectionIcon" element in the "VitalList" pane
      And I click the "Copy to Note" button
      And I click the "Share Draft" button in the "Note Writer Main" pane
      And I click the "Yes" button in the "Question" pane if it exists

    Scenario: Shared Draft Notes are maintained only by Author - cannot edit in undocked mode [DEV-79678]
      Given I am logged into the portal with user "sharedraftlvl3" using the default password
      And I am on the "Patient List V2" tab
      And the patient list is maximized
      And I select "shareDraftPL" from the "Patient List" menu
      And I refresh the patient list
      And "Molly Darr" is on the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      And I click the "ClinicalNotes+" button
      And I select "Progress Note" from the select template list
      And I wait "1" seconds
      And I pop out note writer
      And I switch the focus to the "portalWindow" window
      Then I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
      And The following fields should be not display in the "Note Details" pane
        |Type       |Name      |
        |button     |Delete    |
      And I click the "Edit" button
      Then the following text should appear in the "Information" pane
        | Cannot create note on this patient while a note is undocked |
      And I click the "OK" button in the "Information" pane
      And I switch the focus to the "popoutWindow" window
      And I pop in note writer
      And I wait "2" seconds
      And I click the "NoteWriterCancelNote" button in the "ClinicalNote" pane
      Then I click the "Yes" button in the "Information" pane
      And I switch the focus to the "portalWindow" window
      Then I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
      And I delete the draft note in the "NoteDetails" pane

    Scenario: Shared Draft Notes are maintained only by Author - verify insert previous [DEV-79678]
      Given I am logged into the portal with user "sharedraftlvl3" using the default password
      And I am on the "Patient List V2" tab
      And the patient list is maximized
      And I select "shareDraftPL" from the "Patient List" menu
      And I refresh the patient list
      And "Molly Darr" is on the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      Then I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
      And I click the "ClinicalNotes+" button
      And I sort the "Notes In Draft Status" table chronologically by the "Date/Time" column in "Descending" order
      Then rows starting with the following should appear in the "NotesInDraftStatus" table
        |Date/Time             |Template Name         |
        |%Current Date MMDDYY% |Progress Note         |
      Then the "Edit" button should be shown in the following rows in the "Notes In Draft Status" table
        |Displayed  |Template Name   |
        |true       |Progress Note   |
      Then the "Disabled Delete" button should be shown in the following rows in the "Notes In Draft Status" table
        |Displayed  |Template Name   |
        |true       |Progress Note   |
      And I click the "Edit Draft" button in the row with "Progress Note" as the value under "Template Name" in the "Notes In Draft Status" table
      And I select the note "Subjective" section
      And I wait "3" seconds
      And I enter "editing shared note after adding clinical data" in the "PatientNarrativeQTV2" rich text field
      And I click the "ROS" insert previous link in the "Note Writer" pane
      And I click the "My Notes" element in the "Data To Insert From Previous Notes" pane
      And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
      Then the text "Negative for dyspnea or wheeze. No cough." should appear in the "Note Writer" pane
      Then I select the note "Exam" section
      And I click the "Exam Target" insert previous link in the "Note Writer" pane
      And I click the "My Notes" element in the "Data To Insert From Previous Notes" pane
      And I click the "InsertSelectionQTV2" button
      Then the text "Alert, in NAD." should appear in the "Note Writer" pane
      And I select the note "A/P" section
      And I click the "Problem List" insert previous link in the "Note Writer" pane
      And I click the "My Notes" element in the "Data To Insert From Previous Notes" pane
      And I click the "InsertSelectionQTV2" button
      Then the text "Nail disorder" should appear in the "Note Writer" pane
      And I select the note "A/P" section
      And I select "Moderate" from the "LevelOfDecision" dropdown in the "Note Writer" pane
      And I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
      And I enter "123" in the "PasswordField" field in the "Submit Note" pane
      And I click the "OK" button in the "Submit Note" pane
      And I refresh the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
      Then rows starting with the following should appear in the "Clinical Notes" table
        |Date/Time             |Note Type             |Author            |
        |%Current Date MMDDYY% |Progress Note         |LVL3, SHAREDRAFT  |
      Then I select "Progress Note" from the "Note Type" column in the "Clinical Notes" table
      And the text "Final" should appear in the "Note Details" pane
      Then Text "editing shared note after adding clinical data" should appear in the "Note Details" pane

    Scenario: Shared Draft Notes in Clinical Note Detail
      Given I am logged into the portal with user "sharedraftlvl3" using the default password
      And I am on the "Patient List V2" tab
      And the patient list is maximized
      And I select "shareDraftPL" from the "Patient List" menu
      And I refresh the patient list
      And "Molly Darr" is on the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      And I load the "Progress Note" template note for the selected patient
      And I select the note "Subjective" section
      And I enter "verify shared note in clinical note detail" in the "PatientNarrativeQTV2" rich text field
      And I click the "Share Draft" button in the "Note Writer Main" pane
      And I click the "Yes" button in the "Question" pane if it exists
      And I wait "2" seconds
      And I refresh the patient list
      Given I am logged into the portal with user "pkadminv2" using the default password
      And I am on the "Patient List V2" tab
      And I select "Card Group" from the "Patient List" menu
      And I select patient "Molly Darr" from the patient list
      When I select "Clinical Notes" from clinical navigation
      And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
      Then rows starting with the following should appear in the "Clinical Notes" table
        |Date/Time             |Note Type             |Author            |
        |%Current Date MMDDYY% |*SHARED* Progress Note|LVL3, SHAREDRAFT  |
      Then I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
      And the text "Shared Draft" should appear in the "Note Details" pane
      Then Text "verify shared note in clinical note detail" should appear in the "Note Details" pane

    Scenario: Prerequisite : Create shared note and assign to co-signer
      Given I am logged into the portal with user "sdlvl3u1" using the default password
      And I am on the "Patient List V2" tab
      And the patient list is maximized
      And I select "Card Group" from the "Patient List" menu
      And I refresh the patient list
      And "Molly Darr" is on the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      And I load the "History and Physical" template note for the selected patient
      And I select the note "History" section
      And I wait "3" seconds
      Then I enter "adding test to check insertprevious in HPI field" in the "HPI QTV2" rich text field
      Then I enter "prerequired co-signed shared note" in the "Chief Complaint" rich text field
      And I select the note "ROS" section
      And I click the "ROS GI Normal" element in the "ROSHistory" pane
      Then the text "Negative for abdominal pain or nausea. No emesis. No diarrhea." should appear in the "ROSHistory" pane
      And I select the note "Exam" section
      And I enter "101.2" in the "VitalTemp" field
      Then the value in the "VitalTemp" field should be "101.2"
      When I click the "ExamEyesNormal" element
      Then the text "PERL. Sclerae nonicteric. Conjunctivae pink." should appear in the "ExamHistory" pane
      And I select the note "A/P" section
      And I click the "AddProblem" button if it exists
      And I enter "Chest pain radiating to arm" in the "Diagnosis Search" field in the "NoteWriterAPDXSearchQTV2" pane
      And I select the "R07.89" code in the Diagnoses search list in the "NoteWriterAPDXSearchQTV2" pane
      And the following text should appear in the "Note Writer" pane
        |Chest pain radiating to arm |
      And I share draft with the co-signer "sdlvl1u1"
      And I refresh the patient list
      And I select patient "Molly Darr" from the patient list
      When I select "Clinical Notes" from clinical navigation
      And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
      Then rows starting with the following should appear in the "Clinical Notes" table
        |Date/Time             |Note Type                    |Author                             |
        |%Current Date MMDDYY% |*SHARED* History and Physical|LEVEL3, SDLVL3U1 LEVEL1, SDLVL1U1 |

    Scenario: Shared Draft Notes are not Quotable by the co-signer
      #using note assigned by previous scenario
      Given I am logged into the portal with user "sdlvl1u1" using the default password
      And I am on the "Patient List V2" tab
      And the patient list is maximized
      And I select "Card Group" from the "Patient List" menu
      And I refresh the patient list
      And "Molly Darr" is on the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
      Then the "Disabled" checkbox should be shown in the following rows in the "Clinical Notes" table
        |Displayed  |Note Type                      |
        |true       |*SHARED* History and Physical  |
      Then I select "*SHARED* History and Physical" from the "Note Type" column in the "Clinical Notes" table
      Then Text "prerequired co-signed shared note" should appear in the "Note Details" pane
      And The following fields should be display in the "Note Details" pane
        |Type       |Name    |
        |button     |Edit    |
        |button     |Delete  |
      Then The button "Delete" should be disabled in the "Note Details" pane
      And The following fields should be not display in the "Note Details" pane
        |Type       |Name            |
        |button     |Add Addendum    |
      And I load the "Progress Note" template note for the selected patient
      And I wait "2" seconds
      And I click the "ROS" insert previous link in the "Note Writer" pane
      And I click the "My Department Notes" element in the "Data To Insert From Previous Notes" pane
      Then Text "Negative for dyspnea or wheeze. No cough." should not appear in the "Data To Insert From Previous Notes" pane
      And I click the "My Notes" element in the "Data To Insert From Previous Notes" pane
      Then Text "Negative for dyspnea or wheeze. No cough." should not appear in the "Data To Insert From Previous Notes" pane
      And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane

      Then I select the note "Exam" section
      And I click the "Exam Target" insert previous link in the "Note Writer" pane
      And I click the "My Department Notes" element in the "Data To Insert From Previous Notes" pane
      Then Text "Alert, in NAD." should not appear in the "Data To Insert From Previous Notes" pane
      And I click the "My Notes" element in the "Data To Insert From Previous Notes" pane
      Then Text "Alert, in NAD." should not appear in the "Data To Insert From Previous Notes" pane
      And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane

      And I select the note "A/P" section
      And I click the "Problem List" insert previous link in the "Note Writer" pane
      And I click the "My Department Notes" element in the "Data To Insert From Previous Notes" pane
      Then Text "Chest pain radiating to arm" should not appear in the "Data To Insert From Previous Notes" pane
      And I click the "My Notes" element in the "Data To Insert From Previous Notes" pane
      Then Text "Chest pain radiating to arm" should not appear in the "Data To Insert From Previous Notes" pane
      And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
      And I click the "NoteWriterCancelNote" button in the "ClinicalNote" pane
      Then I click the "Yes" button in the "Information" pane
      #TODO: copy-paste and selected text is pending

    Scenario: Shared Draft Notes are maintained only by Author - verify as co-signer [DEV-79678]
      Given I am logged into the portal with user "sdlvl1u1" using the default password
      And I am on the "Patient List V2" tab
      And the patient list is maximized
      And I select "Card Group" from the "Patient List" menu
      And I refresh the patient list
      And "Molly Darr" is on the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      And I click the "ClinicalNotes+" button
      Then rows starting with the following should appear in the "NotesInDraftStatus" table
        |Date/Time             |Template Name                |
        |%Current Date MMDDYY% |History and Physical         |
      Then the "Edit" button should be shown in the following rows in the "Notes In Draft Status" table
        |Displayed  |Template Name          |
        |true       |History and Physical   |
      Then the "Disabled Delete" button should be shown in the following rows in the "Notes In Draft Status" table
        |Displayed  |Template Name          |
        |true       |History and Physical   |
      And I select "Progress Note" from the select template list
      And I wait "1" seconds
      And I pop out note writer
      And I switch the focus to the "portalWindow" window
      Then I select "*SHARED* History and Physical" from the "Note Type" column in the "Clinical Notes" table
      And The following fields should be not display in the "Note Details" pane
        |Type       |Name      |
        |button     |Delete    |
      And I click the "Edit" button
      Then the following text should appear in the "Information" pane
        | Cannot create note on this patient while a note is undocked |
      And I click the "OK" button in the "Information" pane
      And I switch the focus to the "popoutWindow" window
      And I pop in note writer
      And I wait "2" seconds
      And I click the "NoteWriterCancelNote" button in the "ClinicalNote" pane
      Then I click the "Yes" button in the "Information" pane
      And I switch the focus to the "portalWindow" window
      Then I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
      And I delete the draft note in the "NoteDetails" pane

    Scenario: Shared Notes cannot be Un-shared by author  - when co-signer saves draft, note continues to be shared
      Given I am logged into the portal with user "sdlvl1u1" using the default password
      And I am on the "Patient List V2" tab
      And the patient list is maximized
      And I select "Card Group" from the "Patient List" menu
      And I refresh the patient list
      And "Molly Darr" is on the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
      Then I select "*SHARED* History and Physical" from the "Note Type" column in the "Clinical Notes" table
      And I click the "Edit" button
      And I select the note "History" section
      And I wait "3" seconds
      Then I enter "adding text as co-signer" in the "HPI QTV2" rich text field
      #save button will not be available when shared draft is being edited as per DEV-80803
      #And I save the template as Draft
      And The following fields should be not display in the "Note Details" pane
        |Type       |Name             |
        |button     |Save as Draft    |
      And I click the "Share Draft" button in the "Note Writer Main" pane
      And I click the "Yes" button in the "Question" pane if it exists
      And I refresh the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
      Then rows starting with the following should appear in the "Clinical Notes" table
        |Date/Time             |Note Type                    |Author                              |
        |%Current Date MMDDYY% |*SHARED* History and Physical|LEVEL3, SDLVL3U1 LEVEL1, SDLVL1U1  |
      Then I select "*SHARED* History and Physical" from the "Note Type" column in the "Clinical Notes" table
      And the text "Shared Draft" should appear in the "Note Details" pane
      Then Text "adding text as co-signer" should appear in the "Note Details" pane

    Scenario: Revising the Attending when Sharing
#      If an Author assigned to multiple co-signers sequentially,
#      a. 1st co-signer edited data should reflect to the Author
#      b. If Author shares with 2nd co-signer --> all the information should reflect to the 2nd co-signer
#      c. 2nd co-signer edited data should reflect to the Author
      Given I am logged into the portal with user "sdlvl3u1" using the default password
      And I am on the "Patient List V2" tab
      And the patient list is maximized
      And I select "Card Group" from the "Patient List" menu
      And I refresh the patient list
      And "Molly Darr" is on the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      And I load the "Progress Note" template note for the selected patient
      And I enter "assigning note to be revised" in the "Patient NarrativeQTV2" rich text field
      And I share draft with the co-signer "sdlvl1u1"
      Given I am logged into the portal with user "sdlvl1u1" using the default password
      And I am on the "Inbox" tab
      When I select the "eSig and PK Mail" subtab
      And I click the "Co-Sign" element
      And I click the "Refresh" button
      Then the "Messages" table should load
      And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
      When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table
      Then the "eSig Note Content" pane should load
      Then Text "assigning note to be revised" should appear in the "eSig Note Content" pane
      And I click the "EDIT/SIGN" button
      And I wait for loading to complete
      And I select the note "Subjective" section in the "CoSigNote" pane
      And I wait "5" seconds
      And I enter "editing note as 1st co-signer" in the "PatientNarrativeQTV2" rich text field in the "CoSigNoteContents" pane
      And I click the "Share Draft" button in the "CoSigNote" pane
      And I click the "Yes" button in the "Question" pane if it exists
      And I click the "Xclose" button if it exists
      #after 1st co-signer edits, data should reflect for the author
      Given I am logged into the portal with user "sdlvl3u1" using the default password
      And I am on the "Patient List V2" tab
      And I refresh the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
      Then I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
      Then Text "assigning note to be revised" should appear in the "Note Details" pane
      Then Text "editing note as 1st co-signer" should appear in the "Note Details" pane
      #author edits and shares note with 2nd co-signer
      And I click the "Edit" button
      And I select the note "Subjective" section
      And I wait "3" seconds
      And I enter "sharing the note again to another provider" in the "Patient NarrativeQTV2" rich text field
      And I share draft with the co-signer "sdlvl1u2"
      And I refresh the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      Then I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
      Then Text "sharing the note again to another provider" should appear in the "Note Details" pane
      #all the info from author and 1st cosigner should reflect for the 2nd cosigner
      Given I am logged into the portal with user "sdlvl1u2" using the default password
      And I am on the "Inbox" tab
      When I select the "eSig and PK Mail" subtab
      And I click the "Co-Sign" element
      And I click the "Refresh" button
      Then the "Messages" table should load
      And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
      When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table
      Then the "eSig Note Content" pane should load
      Then Text "assigning note to be revised" should appear in the "eSig Note Content" pane
      Then Text "editing note as 1st co-signer" should appear in the "eSig Note Content" pane
      Then Text "sharing the note again to another provider" should appear in the "eSig Note Content" pane
      And I click the "EDIT/SIGN" button
      And I wait for loading to complete
      And I select the note "Subjective" section in the "CoSigNote" pane
      And I wait "3" seconds
      And I enter "editing note as 2nd co-signer" in the "Patient NarrativeQTV2" rich text field in the "CoSigNoteContents" pane
      And I click the "Share Draft" button in the "CoSigNote" pane
      And I click the "Yes" button in the "Question" pane if it exists
      And I click the "Xclose" button if it exists
      #2nd co-signer edited info should reflect for the author
      Given I am logged into the portal with user "sdlvl3u1" using the default password
      And I am on the "Patient List V2" tab
      And I refresh the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
      Then I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
      Then Text "editing note as 2nd co-signer" should appear in the "Note Details" pane

    Scenario: Shared Drafts ONLY for Attending
      # verify that only the Resident and Attending can access the Shared Draft Note
      #using shared note created by previous scenario
      Given I am logged into the portal with user "pkadminv2" using the default password
      And I am on the "Patient List V2" tab
      And the patient list is maximized
      And I select "Card Group" from the "Patient List" menu
      And I refresh the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
      Then I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
      Then Text "assigning note to be revised" should appear in the "Note Details" pane
      Then Text "editing note as 1st co-signer" should appear in the "Note Details" pane
      Then Text "editing note as 2nd co-signer" should appear in the "Note Details" pane
      And The following fields should be not display in the "Note Details" pane
        |Type       |Name    |
        |button     |Edit    |
        |button     |Delete  |

    Scenario: Shared Drafts for All Providers
      Given I am logged into the portal with user "pkadminv2" using the default password
      And I am on the "Admin" tab
      And I select the "User" subtab
      And I search for the user "sdlvl1u1"
      And I select the user "sdlvl1u1"
      And I click the "Edit" button in the "Quick Details" pane
      And I select "NoteWriter" from the "Edit User Settings" dropdown in the "User Preferences" pane
      And I wait "3" seconds
      And I select "false" from the "AllowUserToShareDraftNote" radio list in the "NoteWriterSettings" pane
      And I click the "Save" button
      And I click "OK" in the confirmation box
      Given I am logged into the portal with user "sdlvl3u1" using the default password
      And I am on the "Patient List V2" tab
      And I select "Card Group" from the "Patient List" menu
      And I refresh the patient list
      And "Molly Darr" is on the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      And I load the "Progress Note" template note for the selected patient
      And I enter "assigning note to be revised" in the "Patient NarrativeQTV2" rich text field
      And I share draft with the co-signer "sdlvl1u1"
      And I refresh the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      Then I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
      Then Text "assigning note to be revised" should appear in the "Note Details" pane
      Given I am logged into the portal with user "sdlvl1u1" using the default password
      And I am on the "Inbox" tab
      When I select the "eSig and PK Mail" subtab
      And I click the "Co-Sign" element
      And I click the "Refresh" button
      Then the "Messages" table should load
      And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
      When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table
      Then the "eSig Note Content" pane should load
      Then Text "assigning note to be revised" should appear in the "eSig Note Content" pane
      And I click the "Xclose" button if it exists

    Scenario: Resident's Shared Drafts in Attending's Inbox [DEV-80431]
      #create a draft note in attending inbox as prereqisite
      Given I am logged into the portal with user "sdlvl1u1" using the default password
      And I am on the "Patient List V2" tab
      And the patient list is maximized
      And I select "Card Group" from the "Patient List" menu
      And I refresh the patient list
      And "Molly Darr" is on the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      And I load the "Progress Note" template note for the selected patient
      And I enter "a draft note to load the messages table" in the "Patient NarrativeQTV2" rich text field
      And I save the template as Draft
      Given I am logged into the portal with user "sdlvl3u1" using the default password
      And I am on the "Patient List V2" tab
      And I select "Card Group" from the "Patient List" menu
      And I refresh the patient list
      And "Molly Darr" is on the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      And I load the "History and Physical" template note for the selected patient
      And I select the note "History" section
      And I wait "3" seconds
      Then I enter "checking shared drafts in inbox" in the "HPI QTV2" rich text field
      Then I enter "prerequired co-signed shared note" in the "Chief Complaint" rich text field
      And I select the note "ROS" section
      And I click the "ROS GI Normal" element in the "ROSHistory" pane
      Then the text "Negative for abdominal pain or nausea. No emesis. No diarrhea." should appear in the "ROSHistory" pane
      And I select the note "Exam" section
      When I click the "ExamEyesNormal" element
      Then the text "PERL. Sclerae nonicteric. Conjunctivae pink." should appear in the "ExamHistory" pane
      And I share draft with the co-signer "sdlvl1u1"
      Given I am logged into the portal with user "sdlvl1u1" using the default password
      And I am on the "Inbox" tab
      When I select the "eSig and PK Mail" subtab
      #shared note should not be listed under drafts
      And I click the "Drafts" element
      And I click the "Refresh" button
      Then the "Messages" table should load
      And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
      When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table if it exists
      Then Text "checking shared drafts in inbox" should not appear in the "eSig Note Content" pane
      And I click the "Xclose" button if it exists
      #shared notes should be listed under co-sign but not able to sign the note
      And I click the "Co-Sign" element
      And I click the "Refresh" button
      Then the "Messages" table should load
      And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
      When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table
      Then the "eSig Note Content" pane should load
      Then Text "checking shared drafts in inbox" should appear in the "eSig Note Content" pane
      And I click the "EDIT/SIGN" button
      And I wait for loading to complete
      Then The following fields should be display in the "CoSigNote" pane
      |Name         |Type   |
      |DisabledSign |button |
      And I click the "NoteWriterCancelNote" button in the "CoSigNote" pane
      And I click the "Yes" button in the "Question" pane

    Scenario: Enable Attending to Edit Shared Draft Notes
      Given I am logged into the portal with user "pkadminv2" using the default password
      And I am on the "Admin" tab
      And I select the "Institution" subtab
      And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
      And I wait "2" seconds
      And I select "true" from the "Allow CoSigner To Edit Resident Shared Drafts" radio list in the "Note Writer Settings" pane
      And I click the "Save" button
      And I click "OK" in the confirmation box
     #reverting back the setting disabled in Scenario: Shared Drafts for All Providers
      And I select the "User" subtab
      And I search for the user "sdlvl1u1"
      And I select the user "sdlvl1u1"
      And I click the "Edit" button in the "Quick Details" pane
      And I select "NoteWriter" from the "Edit User Settings" dropdown in the "User Preferences" pane
      And I wait "3" seconds
      And I select "true" from the "AllowUserToShareDraftNote" radio list in the "NoteWriterSettings" pane
      And I click the "Save" button
      And I click "OK" in the confirmation box
      #below scenario covers : Attending edits shared draft through Inbox>>edit option

    Scenario: Attending Modifies Shared Drafts
      #using shared draft created by previous scenario
      Given I am logged into the portal with user "sdlvl1u1" using the default password
      And I am on the "Inbox" tab
      When I select the "eSig and PK Mail" subtab
      And I click the "Co-Sign" element
      And I click the "Refresh" button
      Then the "Messages" table should load
      And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
      When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table
      Then the "eSig Note Content" pane should load
      Then Text "checking shared drafts in inbox" should appear in the "eSig Note Content" pane
      Then The following fields should be not display in the "CoSigNote" pane
        |Name         |Type   |
        |Decline      |button |
      And I click the "EDIT/SIGN" button
      And I wait for loading to complete
      And I select the note "History" section in the "CoSigNote" pane
      And I wait "3" seconds
      Then I enter "updating hpi field as co-signer" in the "HPI" rich text field in the "CoSigNoteContents" pane
      And I select the note "Family/Social History" section in the "CoSigNote" pane
      And I wait "2" seconds
      Then I enter "updating social history field as co-signer" in the "Additional Social History Info" rich text field in the "CoSigNoteContents" pane
      And I select the note "ROS" section in the "CoSigNote" pane
      And I click the "ROSGITrash" element in the "CoSigNoteContents" pane
      And I click the "ROSCVNormal" element in the "CoSigNoteContents" pane
      Then the text "Negative for chest pain or palpitations. No extremity swelling." should appear in the "CoSigNoteContents" pane
      And I select the note "Exam" section in the "CoSigNote" pane
      And I click the "ExamEyesTrash" element in the "CoSigNoteContents" pane
      And I click the "ExamMSKNormal" element in the "CoSigNoteContents" pane
      Then the text "Negative for joint stiffness, pain, or arthralgias." should appear in the "CoSigNoteContents" pane
      And I select the note "Diagnostics" section in the "CoSigNote" pane
      When I click the "Lab Results" link in the "CoSigNoteContents" pane
      And I wait "2" seconds
      And I click the "NoteWriterPreselectionIcon" element in the "LabList" pane
      And I click the "Copy to Note" button
      When I click the "Test Results" link in the "CoSigNoteContents" pane
      And I wait "2" seconds
      And I click the "NoteWriterPreselectionIcon" element in the "TestResultList" pane
      And I click the "Copy to Note" button
      And I wait "2" seconds
      And I select the note "A/P" section in the "CoSigNote" pane
      And I click the "Add Problem" button in the "CoSigNoteContents" pane if it exists
      And I wait "2" seconds
      And I enter "R53.1" in the "Problem Dx Search" field
      Then The following fields should be display in the "CoSigNote" pane
        |Name         |Type   |
        |DisabledSign |button |
      And I click the "Share Draft" button in the "CoSigNote" pane
      And I click the "Yes" button in the "Question" pane if it exists
      And I click the "Xclose" button if it exists

     Scenario: Prerequisite : Disable Restrict Shared Drafts To Attending [DEV-80456]
       Given I am logged into the portal with user "pkadminv2" using the default password
       And I am on the "Admin" tab
       And I select the "Institution" subtab
       And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
       And I wait "2" seconds
       And I select "true" from the "Restrict Shared Drafts To Attending" radio list in the "Note Writer Settings" pane
       And I click the "Save" button
       And I click "OK" in the confirmation box

    Scenario: Restrict Co-Sig Sharing of Draft Notes only with Author [DEV-80456]
      Given I am logged into the portal with user "sdlvl3u2" using the default password
      And I am on the "Patient List V2" tab
      And the patient list is maximized
      And I select "Card Group" from the "Patient List" menu
      And "Molly Darr" is on the patient list
      And I select patient "Molly Darr" from the patient list
      And I load the "Discharge Summary" template note for the selected patient
      And I select the note "Hospital Course" section
      And I wait "2" seconds
      And I enter "verifying sharing draft notes only with author" in the "HospitalCourseQTV2" rich text field
      And The following fields should be display in the "Note Writer Main" pane
        |Type       |Name           |
        |button     |Share Draft    |
      And I click the "Share Draft" button in the "Note Writer Main" pane
      And I click the "Yes" button in the "Question" pane if it exists
      And I refresh the patient list
      And I select patient "Molly Darr" from the patient list
      When I select "Clinical Notes" from clinical navigation
      Then rows starting with the following should appear in the "Clinical Notes" table
        |Date/Time             |Note Type                    |Author            |
        |%Current Date MMDDYY% |*SHARED* Discharge Summary   |LEVEL3, SDLVL3U2  |
      Given I am logged into the portal with user "pkadminv2" using the default password
      And I am on the "Patient List V2" tab
      And I select "Card Group" from the "Patient List" menu
      And "Molly Darr" is on the patient list
      And I select patient "Molly Darr" from the patient list
      When I select "Clinical Notes" from clinical navigation
      Then rows starting with the following should appear in the "Clinical Notes" table
        |Date/Time             |Note Type                    |Author            |
        |%Current Date MMDDYY% |*SHARED* Discharge Summary   |LEVEL3, SDLVL3U2  |

      Scenario: Restrict Co-Sig Sharing of Draft Notes only with Attending and Co-signer [DEV-80456]
        Given I am logged into the portal with user "sdlvl3u1" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        And I select "Card Group" from the "Patient List" menu
        And "Molly Darr" is on the patient list
        And I select patient "Molly Darr" from the patient list
        And I load the "Chart Notation AM" template note for the selected patient
        Then I select the note "Notation" section
        When I enter "This is the Title field." in the "TitleField" rich text field
        And I enter "verifying sharing draft notes only with author and co-signer" in the "NotationQTV2" rich text field
        And The following fields should be display in the "Note Writer Main" pane
          |Type       |Name           |
          |button     |Share Draft    |
        And I share draft with the co-signer "sdlvl1u1"
        And I refresh the patient list
        And I select patient "Molly Darr" from the patient list
        When I select "Clinical Notes" from clinical navigation
        Then rows starting with the following should appear in the "Clinical Notes" table
          |Date/Time             |Note Type                    |Author            |
          |%Current Date MMDDYY% |*SHARED* Chart Notation      |LEVEL3, SDLVL3U1  |
        #shared draft should be visible to co-signer
        Given I am logged into the portal with user "sdlvl1u1" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        And I select "Card Group" from the "Patient List" menu
        And "Molly Darr" is on the patient list
        And I select patient "Molly Darr" from the patient list
        When I select "Clinical Notes" from clinical navigation
        Then rows starting with the following should appear in the "Clinical Notes" table
          |Date/Time             |Note Type                    |Author            |
          |%Current Date MMDDYY% |*SHARED* Chart Notation      |LEVEL3, SDLVL3U1  |
        #shared draft should not appear for other user
        Given I am logged into the portal with user "pkadminv2" using the default password
        And I am on the "Patient List V2" tab
        And I select "Card Group" from the "Patient List" menu
        And "Molly Darr" is on the patient list
        And I select patient "Molly Darr" from the patient list
        When I select "Clinical Notes" from clinical navigation
        Then rows starting with the following should not appear in the "Clinical Notes" table
          |Date/Time             |Note Type                    |Author            |
          |%Current Date MMDDYY% |*SHARED* Chart Notation      |LEVEL3, SDLVL3U1 |

      Scenario: Sharing Non-Templated Addendums
        Given I am logged into the portal with user "sharedraftlvl3" using the default password
        And I am on the "Patient List V2" tab
        And I select "shareDraftPL" from the "Patient List" menu
        And "Molly Darr" is on the patient list
        And I select patient "Molly Darr" from the patient list
        Then I select "Clinical Notes" from clinical navigation
        And I load the "Progress Note" template note for the selected patient
        And I select the note "Subjective" section
        And I wait "3" seconds
        And I enter "verifying non-template addendum" in the "Patient NarrativeQTV2" rich text field in the "Note Writer" pane
        And I select the note "A/P" section
        And I select "Moderate" from the "LevelOfDecision" dropdown
        And I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
        And I enter "123" in the "PasswordField" field in the "Submit Note" pane
        And I click the "OK" button in the "Submit Note" pane
        Then I select "Progress Note" from the "Note Type" column in the "Clinical Notes" table
        Then Text "verifying non-template addendum" should appear in the "Note Details" pane
        And I click the "Add Addendum" button
        And I wait "3" seconds
        And I enter "addendum comments" in the "AddendumCommentsQTV2" rich text field in the "Note Writer" pane
        And I click the "Share Draft" button in the "Note Writer Main" pane
        And I click the "Yes" button in the "Question" pane if it exists
        And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
        Then rows starting with the following should appear in the "Clinical Notes" table
          |Date/Time             |Note Type                              |Author            |
          |%Current Date MMDDYY% |Progress Note - with *SHARED* Addendum |LVL3, SHAREDRAFT  |
        Then I select "Progress Note - with *SHARED* Addendum " from the "Note Type" column in the "Clinical Notes" table
        And The following fields should not display in the "Note Details" pane
          |Type       |Name           |
          |button     |Delete         |
          |element    |DraftWatermark |
        And the text "Shared Draft" should appear in the "Addendum Detail" section in the "Note Details" pane
        And the text "addendum comments" should appear in the "Addendum Detail" section in the "Note Details" pane
        Given I am logged into the portal with user "pkadminv2" using the default password
        And I am on the "Patient List V2" tab
        And "Molly Darr" is on the patient list
        And I select patient "Molly Darr" from the patient list
        Then I select "Clinical Notes" from clinical navigation
        And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
        #Shared addendum will be visible as just an addendum in clinical notes table for non-author as per jira DEV-80919
        Then rows starting with the following should appear in the "Clinical Notes" table
          |Date/Time             |Note Type                              |Author            |
          |%Current Date MMDDYY% |Progress Note - with Addendum |LVL3, SHAREDRAFT  |
        Then I select "Progress Note - with Addendum " from the "Note Type" column in the "Clinical Notes" table
        And The following fields should not display in the "Note Details" pane
          |Type       |Name           |
          |button     |Delete         |
          |element    |DraftWatermark |
        And the text "Shared Draft" should appear in the "Addendum Detail" section in the "Note Details" pane
        And the text "addendum comments" should appear in the "Addendum Detail" section in the "Note Details" pane

    Scenario Outline: Disable "Allow User To Share Draft Note" setting  to all the users
      Given I am logged into the portal with user "pkadminv2" using the default password
      And I am on the "Admin" tab
      And I open "NoteWriter" settings page for the user "<users>"
      And I select "false" from the "AllowUserToShareDraftNote" radio list in the "NoteWriterSettings" pane
      And I click the "Save" button
      And I click "OK" in the confirmation box
      And I click the "Return to Choose Users" link in the "User Preferences" pane

       Examples:
       |users      |
       |sharedraftlvl3 |
       |sharedraftlvl1 |
       |sdlvl1u1   |
       |sdlvl1u2   |
       |sdlvl3u1   |
       |sdlvl3u2   |

    Scenario: Verify that Share draft button not displayed when "AllowUserToShareDraftNote" setting is set to false
      Given I am logged into the portal with user "sharedraftlvl3" using the default password
      And I am on the "Patient List V2" tab
      And the patient list is maximized
      And I select "shareDraftPL" from the "Patient List" menu
      And I refresh the patient list
      And "Molly Darr" is on the patient list
      And I select patient "Molly Darr" from the patient list
      Then I select "Clinical Notes" from clinical navigation
      And I load the "Progress Note" template note for the selected patient
      And I select the note "Subjective" section
      And I enter "final check" in the "PatientNarrativeQTV2" rich text field
      And The following fields should be not display in the "Note Details" pane
        |Type       |Name           |
        |button     |Share Draft    |
      And I click the "NoteWriterCancelNote" button in the "ClinicalNote" pane
      Then I click the "Yes" button in the "Information" pane

    Scenario: Postrequisite : Disable QTV2 and Co-signature
      Given I am logged into the portal with user "pkadminv2" using the default password
      And I am on the "Admin" tab
      And I select the "Institution" subtab
      And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
      And I wait "2" seconds
      And I select "false" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
      And I select "false" from the "Enable Spell Check" radio list in the "Note Writer Settings" pane
      And I select "None" from the "Validation" dropdown
      And I select "false" from the "CoSignature" radio list in the "Note Writer Settings" pane
      And I click the "Save" button
      And I click "OK" in the confirmation box