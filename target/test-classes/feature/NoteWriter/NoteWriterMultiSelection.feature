@NWMultiselection
Feature: NoteWriter multi section of notes in inbox
 #ALM Path : Notewriter (PK)>> ALM >>Inbox >> MultiSelection

  Scenario: Pre-requsite : Enable QTV2 and co-signature
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
    And I open "NoteWriter" settings page for the user "sdlvl3u1"
    And I wait "3" seconds
    And I select "true" from the "Allow User To Share Draft Note" radio list in the "NoteWriter Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the "Return to Choose Users" link in the "User Preferences" pane
    And I open "NoteWriter" settings page for the user "sdlvl3u2"
    And I wait "3" seconds
    And I select "true" from the "Allow User To Share Draf tNote" radio list in the "NoteWriter Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box

    #Testcase : 001_Multi selection of Drafts_DELETE
  Scenario: 25517. Verify Delete of multi selected draft notes
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection note 1" in the "Patient Narrative QTV2" rich text field
    And I save the template as Draft
    #And I wait "20" seconds
    #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection note 2" in the "Chief Complaint" rich text field
    And I save the template as Draft
    #navigate to inbox and perform required action
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Drafts" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
#    And I click the "Select Note Checkbox" element in the row with "Chart Notation" as the value under "Description" in the "Messages" table
#    And I click the "Select Note Checkbox" element in the row with "History and Physical" as the value under "Description" in the "Messages" table
    When I verify the note count of the "Messages" table and click the "Delete" button
    Then the "Messages" table should load

    #TC Name-004_Multi selection of Drafts_EDIT/SIGN_Sign
  Scenario: 25520. Verify Signing of multi selected draft notes
    Given I am logged into the portal with user "sdlvl3u2" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I enter "PN-Note-Note-1" in the "Patient Narrative QTV2" rich text field
    And I save the template as Draft
    #And I wait "20" seconds
   #Adding "HP-Note-Note-2" note to patient
    And I select patient "DARR, MOLLY" from the patient list
    And I load the "History and Physical" template note for the selected patient
    And I enter "HP-Note-Note-2" in the "HPI QTV2" rich text field
    And I save the template as Draft
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Drafts" element
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "First Note Checkbox" in the "eSig Note Content" pane
    And I click on the element "Second Note Checkbox" in the "eSig Note Content" pane
    And the following fields should display in the "eSig Note Content" pane
      |  Name 	   |  Type    |
      |  Delete      |  button  |
      |  EDIT/SIGN   |  button  |
    And I click the "EDIT/SIGN" button
    #History and Physical of NoteWriter Wizard Pane
    And I wait up to "5" seconds for loading to complete
    And I select the note "History" section in the "CoSig Note" pane
    And I enter "welcome-2" in the "HPI" rich text field in the "CoSig Note Contents" pane
    And I select the note "A/P" section in the "NoteWriter Wizard" pane
    And I select "High" from the "Level Of Decision" dropdown
    Then I verify the note count of the "Messages" table and click the "Sign/Submit" button with "123" password
    #Progress Note of NoteWriter Wizard Pane
    And I wait for loading to complete
    And I select the note "Subjective" section in the "CoSig Note" pane
    And I enter "welcome-1" in the "Patient NarrativeQTV2" rich text field in the "CoSig Note Contents" pane
    And I select the note "A/P" section in the "NoteWriter Wizard" pane
    And I select "Moderate" from the "Level Of Decision" dropdown if it exists
    Then I verify the note count of the "Messages" table and click the "Sign/Submit" button with "123" password
    And I am on the "Patient List V2" tab
    And I select patient "DARR, MOLLY" from the patient list
    And I select "Clinical Notes" from clinical navigation
    Then the "Clinical Notes" table should load
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "Progress Note" from the "Note Type" column in the "Clinical Notes" table
    And the following text should appear in the "Note Details" pane
      | Patient Narrative |
      | PN-Note-Note-1    |
      | welcome-1         |
      | Final			    |
    And I select "History and Physical" from the "Note Type" column in the "Clinical Notes" table
    And the following text should appear in the "Note Details" pane
      | HPI:            |
      | HP-Note-Note-2  |
      | welcome-2       |
      | Final			  |

   #TC Name-005_Multi selection of Drafts_EDIT/SIGN_SaveDraft
  Scenario: 25521. Verify Savfe as draft of multi selected draft notes
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I enter "PN-Note-1" in the "Patient Narrative QTV2" rich text field
    And I save the template as Draft
    #And I wait "20" seconds
     #Adding "HP-Note-2" note to patient
    And I select patient "HEATH, NEIL" from the patient list
    And I load the "History and Physical" template note for the selected patient
    And I enter "HP-Note-2" in the "HPI QTV2" rich text field
    And I save the template as Draft
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Drafts" element
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "First Note Checkbox" in the "eSig Note Content" pane
    And I click on the element "Second Note Checkbox" in the "eSig Note Content" pane
    And the following fields should display in the "eSig Note Content" pane
      |  Name 	   |  Type    |
      |  Delete      |  button  |
      |  EDIT/SIGN   |  button  |
    And I click the "EDIT/SIGN" button
     #History and Physical of NoteWriter Wizard Pane
    And I wait for loading to complete
    And I select the note "History" section in the "CoSig Note" pane
    And I wait "3" seconds
    And I enter "Patient-info-2" in the "HPI" rich text field in the "CoSig Note Contents" pane
    Then I click the "SaveasDraft" button in the "NoteWriter Wizard" pane
    And I click the "Yes" button in the "Question" pane if it exists
     #Progress Note of NoteWriter Wizard Pane
    And I wait "3" seconds
    And I select the note "Subjective" section in the "CoSig Note" pane
    And I enter "Patient-info-1" in the "Patient NarrativeQTV2" rich text field in the "CoSig Note Contents" pane
    Then I click the "SaveasDraft" button in the "NoteWriter Wizard" pane
    And I wait up to "3" seconds for loading to complete
    And I click the "Yes" button in the "Question" pane if it exists
    And I wait "3" seconds
    Then the following elements should be unchecked in the "eSig Note Content" pane
      |FirstNote Checkbox |
      |SecondNote Checkbox |

    And I am on the "Patient List V2" tab
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Clinical Notes" from clinical navigation
    Then the "Clinical Notes" table should load
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "*DRAFT* Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the following text should appear in the "Note Details" pane
      | Patient Narrative |
      | PN-Note-1         |
      | Patient-info-1    |
      | Draft			    |
    And I select "*DRAFT* History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the following text should appear in the "Note Details" pane
      | HPI:            |
      | HP-Note-2       |
      | Patient-info-2  |
      | Draft			  |

 #TC Name-006_Multi selection of Drafts_EDIT/SIGN_BackToInbox
  Scenario: 25522. Verify Back to Inbox of multi selected draft notes
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Drafts" element
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "First Note Checkbox" in the "eSig Note Content" pane
    And I click on the element "Second Note Checkbox" in the "eSig Note Content" pane
    And the following fields should display in the "eSig Note Content" pane
      |  Name 	   |  Type    |
      |  Delete      |  button  |
      |  EDIT/SIGN   |  button  |
    And I click the "EDIT/SIGN" button
     #History and Physical of NoteWriter Wizard Pane
    And I wait up to "5" seconds for loading to complete
    And I select the note "History" section in the "CoSig Note" pane
    And I click the "BackToInbox" button in the "NoteWriter Wizard" pane
    And I click the "Yes" button in the "Question" pane if it exists
    Then the following elements should be unchecked in the "eSig Note Content" pane
      |FirstNote Checkbox |
      |SecondNote Checkbox |

 #TC Name-07_Multi selection of Drafts_EDIT/SIGN_BackToInbox_No_Skip
  Scenario: 25523. Verfiy Back to Inbox on first note and Skip second note of multi selected draft notes
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I wait up to "3" seconds for loading to complete
    And I click the "Drafts" element
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "First Note Checkbox" in the "eSig Note Content" pane
    And I click on the element "Second Note Checkbox" in the "eSig Note Content" pane
    And the following fields should display in the "eSig Note Content" pane
      |  Name 	   |  Type    |
      |  Delete      |  button  |
      |  EDIT/SIGN   |  button  |
    And I click the "EDIT/SIGN" button
     #History and Physical of NoteWriter Wizard Pane
    And I wait up to "5" seconds for loading to complete
    And I select the note "History" section in the "CoSig Note" pane
    And I click the "BackToInbox" button in the "NoteWriter Wizard" pane
    And I click the "No" button in the "Question" pane if it exists
    And I wait for loading to complete
    And I select the note "History" section in the "CoSig Note" pane
    And I click the "NW ProgressNote Skip" button in the "NoteWriter Wizard" pane
     #Progress Note of NoteWriter Wizard Pane
    And I wait up to "3" seconds for loading to complete
    And I select the note "Subjective" section in the "CoSig Note" pane
    And I click the "NW ProgressNote Skip" button in the "NoteWriter Wizard" pane
    Then the following elements should be unchecked in the "eSig Note Content" pane
      |FirstNote Checkbox |
      |SecondNote Checkbox |

  #TC Name-08_Multi selection of Drafts_EDIT/SIGN_SkipOfFirstNote_SignOnNextNote
  Scenario: 25524. Verify Skipping Of First Note and Sign On Next Note of multi selected draft notes
    Given I am logged into the portal with user "sdlvl3u2" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I enter "PN-Note-Note-1" in the "Patient Narrative QTV2" rich text field
    And I save the template as Draft
    #And I wait "20" seconds
   #Adding "HP-Note-Note-2" note to patient
    And I select patient "DARR, MOLLY" from the patient list
    And I load the "History and Physical" template note for the selected patient
    And I enter "HP-Note-2" in the "HPI QTV2" rich text field
    And I save the template as Draft
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I wait up to "3" seconds for loading to complete
    And I click the "Drafts" element
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "First Note Checkbox" in the "eSig Note Content" pane
    And I click on the element "Second Note Checkbox" in the "eSig Note Content" pane
    And the following fields should display in the "eSig Note Content" pane
      |  Name 	   |  Type    |
      |  Delete      |  button  |
      |  EDIT/SIGN   |  button  |
    And I click the "EDIT/SIGN" button
 #	   History and Physical of NoteWriter Wizard Pane
    And I wait up to "5" seconds for loading to complete
    And I select the note "History" section in the "CoSig Note" pane
    And I click the "NW ProgressNote Skip" button in the "NoteWriter Wizard" pane
    And I wait up to "3" seconds for loading to complete
    And I select the note "Subjective" section in the "CoSig Note" pane
    And I enter "Writer-1" in the "Patient NarrativeQTV2" rich text field in the "CoSig Note Contents" pane
    And I select the note "A/P" section in the "NoteWriter Wizard" pane
    And I select "Moderate" from the "Level Of Decision" dropdown if it exists
    Then I verify the note count of the "Messages" table and click the "Sign/Submit" button with "123" password
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    Then the following text should appear in the "eSig Note Content" pane
      | HPI:           |
      | HP-Note-2      |
    And I click the "Xclose" button
    And I am on the "Patient List V2" tab
    And I select patient "DARR, MOLLY" from the patient list
    And I select "Clinical Notes" from clinical navigation
    Then the "Clinical Notes" table should load
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "Progress Note" from the "Note Type" column in the "Clinical Notes" table
    And the following text should appear in the "Note Details" pane
      | Patient Narrative |
      | PN-Note-Note-1    |
      | Writer-1          |
      | Final			    |

      #Testcase : 011_Multi selection of Drafts_EDIT/SIGN_Save Draft of first note_Skip on next note
  Scenario: 25527.Verify Save Draft of first note and Skip on next note of multi selected draft notes
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection note 1" in the "Patient Narrative QTV2" rich text field
    And I save the template as Draft
    #And I wait "20" seconds
    #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection note 2" in the "Chief Complaint" rich text field
    And I save the template as Draft
    #navigate to inbox and perform required action
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Drafts" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    Then I click the "EDIT/SIGN" button
    And I wait for loading to complete
    And I select the note "History" section in the "CoSig Note" pane
    And I wait "3" seconds
    Then I enter "save draft on 1st note" in the "HPI" rich text field in the "CoSig Note Contents" pane
    Then I click the "Save as Draft" button in the "CoSig Note" pane
    And I click the "Yes" button in the "Question" pane if it exists
    And I wait for loading to complete
    And I select the note "Subjective" section in the "CoSig Note" pane
    And I wait "3" seconds
    And I enter "skipping 2nd note" in the "Patient Narrative QTV2" rich text field in the "CoSig Note Contents" pane
    Then I click the "NW ProgressNote Skip" button in the "CoSig Note" pane
    Then the "Messages" table should load
    #verify entered text for each note in patient list tab -> clinical notes
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select patient "DARR, MOLLY" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*DRAFT* History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "save draft on 1st note" should appear in the "Note Details" pane
    When I select "*DRAFT* Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "skipping 2nd note" should not appear in the "Note Details" pane

   #Testcase : 012_Multi selection of Drafts_EDIT/SIGN_Save Draft of first note_Sign on next note
  Scenario: 25528. Verify Save Draft of first note and Sign on next note of multi selected draft notes
    Given I am logged into the portal with user "sdlvl3u2" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection note 1" in the "Patient Narrative QTV2" rich text field
    And I save the template as Draft
    #And I wait "20" seconds
    #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection note 2" in the "Chief Complaint" rich text field
    And I save the template as Draft
     #navigate to inbox and perform required action
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Drafts" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    Then I click the "EDIT/SIGN" button
    And I wait for loading to complete
    And I select the note "History" section in the "CoSig Note" pane
    And I wait "3" seconds
    And I enter "save draft on 1st note scenario 08" in the "HPI" rich text field in the "CoSig Note Contents" pane
    Then I click the "Save as Draft" button
    And I click the "Yes" button in the "Question" pane if it exists
    And I wait for loading to complete
    And I select the note "Subjective" section in the "CoSig Note" pane
    And I wait "3" seconds
    Then I enter "signing 2nd note scenario 08" in the "Patient Narrative QTV2" rich text field in the "CoSig Note Contents" pane
    And I select the note "A/P" section in the "CoSig Note" pane
    And I select "Moderate" from the "Level Of Decision" dropdown
    Then I verify the note count of the "Messages" table and click the "Sign/Submit" button with "123" password
    Then the "Messages" table should load
    #verify entered text for each note in patient list tab -> clinical notes
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select patient "DARR, MOLLY" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*DRAFT* History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "save draft on 1st note scenario 08" should appear in the "Note Details" pane
    When I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "signing 2nd note scenario 08" should appear in the "Note Details" pane
    And the text "Final" should appear in the "Note Details" pane

   #Testcase : 014_Multi selection of Drafts_EDIT/SIGN_Share Draft
  Scenario: 25530. Verify sharing draft of multi selected draft notes
    Given I am logged into the portal with user "sdlvl3u2" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
      #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection note 1" in the "Patient Narrative QTV2" rich text field
    And I save the template as Draft
    #And I wait "20" seconds
    #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection note 2" in the "Chief Complaint" rich text field
    And I save the template as Draft
    #navigate to inbox and perform required action
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Drafts" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    Then I click the "EDIT/SIGN" button
    And I wait for loading to complete
    And I enter "sharing HP draft note scenario 09" in the "HPI" rich text field in the "CoSig Note Contents" pane
    And I click the "Share Draft" button in the "CoSig Note" pane
    And I click the "Yes" button in the "Question" pane if it exists
    And I wait for loading to complete
    Then I enter "sharing PN draft note scenario 09" in the "Patient Narrative QTV2" rich text field in the "CoSig Note Contents" pane
    And I click the "Share Draft" button in the "CoSig Note" pane
    And I click the "Yes" button in the "Question" pane if it exists
    Then the "Messages" table should load
    And I click the "Refresh" button
    Then the 1st row of the "Messages" table should have the text "Shared" in the "Status" column
    Then the 2nd row of the "Messages" table should have the text "Shared" in the "Status" column
    #verify the status as shared in clinical notes table
    And I am on the "Patient List V2" tab
    And I refresh the patient list
    And I select patient "DARR, MOLLY" from the patient list
    Then I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*SHARED* History and Physical" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
    |sharing HP draft note scenario 09 |
    |Shared                            |
    When I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |sharing PN draft note scenario 09 |
      |Shared                            |

    #Testcase : 015_Multi selection of Drafts_EDIT/SIGN_Share Draft (i.e. Co-sign required)
  Scenario: 25531. Verify sharing draft with co-signer of multi selected draft notes
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection note 1" in the "Patient Narrative QTV2" rich text field
    And I save the template as Draft
    #And I wait "20" seconds
    #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection note 2" in the "Chief Complaint" rich text field
    And I save the template as Draft
    #navigate to inbox and perform required action
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Drafts" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    Then I click the "EDIT/SIGN" button
    And I wait for loading to complete
    And I select the note "History" section in the "CoSig Note" pane
    And I wait "3" seconds
    Then I enter "sharing HP draft note scenario 10" in the "HPI" rich text field in the "CoSig Note Contents" pane
    And I share draft with the co-signer "sdlvl1u1"
    And I wait for loading to complete
    And I select the note "Subjective" section in the "CoSig Note" pane
    And I wait "3" seconds
    And I enter "sharing PN draft note scenario 10" in the "Patient Narrative QTV2" rich text field in the "CoSig Note Contents" pane
    And I share draft with the co-signer "sdlvl1u1"
    Then the "Messages" table should load
    And I click the "Refresh" button
    Then the 1st row of the "Messages" table should have the text "Shared" in the "Status" column
    Then the 2nd row of the "Messages" table should have the text "Shared" in the "Status" column
     #verify the status as shared in clinical notes table
    And I am on the "Patient List V2" tab
    And I refresh the patient list
    And I select patient "DARR, MOLLY" from the patient list
    Then I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*SHARED* History and Physical" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |sharing HP draft note scenario 10 |
      |Shared                  |
    When I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |sharing PN draft note scenario 10 |
      |Shared                  |
    #verify as co-signer
    Given I am logged into the portal with user "sdlvl1u1" using the default password
    And I am on the "Patient List V2" tab
    And I refresh the patient list
    And I select patient "DARR, MOLLY" from the patient list
    Then I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*SHARED* History and Physical" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |sharing HP draft note scenario 10 |
      |Shared                            |
    When I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |sharing PN draft note scenario 10 |
      |Shared                            |

    #Testcase : 016_Multi selection of Drafts_EDIT/SIGN_Sign on first note_Share Draft of next note
  Scenario: 25532. Verify signing first note and sharing second note of multi selected draft notes
    Given I am logged into the portal with user "sdlvl3u2" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection note 1" in the "Patient Narrative QTV2" rich text field
    And I save the template as Draft
    #And I wait "20" seconds
    #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection note 2" in the "Chief Complaint" rich text field
    And I save the template as Draft
    #navigate to inbox and perform required action
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Drafts" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    Then I click the "EDIT/SIGN" button
    And I wait for loading to complete
    And I select the note "History" section in the "CoSig Note" pane
    And I wait "3" seconds
    Then I enter "signing HP draft note scenario 11" in the "HPI" rich text field in the "CoSig Note Contents" pane
    And I select the note "A/P" section in the "CoSig Note" pane
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I verify the note count of the "Messages" table and click the "Sign/Submit" button with "123" password
    And I wait for loading to complete
    And I select the note "Subjective" section in the "CoSig Note" pane
    And I wait "3" seconds
    And I enter "sharing PN draft note scenario 11" in the "Patient Narrative QTV2" rich text field in the "CoSig Note Contents" pane
    And I click the "Share Draft" button in the "CoSig Note" pane
    And I click the "Yes" button in the "Question" pane if it exists
    Then the "Messages" table should load
    And I click the "Refresh" button
    Then the 1st row of the "Messages" table should have the text "Shared" in the "Status" column
    And I am on the "Patient List V2" tab
    And I refresh the patient list
    And I select patient "DARR, MOLLY" from the patient list
    Then I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |signing HP draft note scenario 11 |
      |Final                            |
    When I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |sharing PN draft note scenario 11 |
      |Shared                             |

    #Testcase : 018_Multi selection of Drafts_EDIT/SIGN_Share Draft of first note_Save Draft of next note
  Scenario: 25534. Verify sharing first note and save draft second note on multi selected draft notes
    Given I am logged into the portal with user "sdlvl3u2" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection note 1" in the "Patient Narrative QTV2" rich text field
    And I save the template as Draft
    #And I wait "20" seconds
    #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection note 2" in the "Chief Complaint" rich text field
    And I save the template as Draft
    #navigate to inbox and perform required action
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Drafts" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    Then I click the "EDIT/SIGN" button
    And I wait for loading to complete
    And I select the note "History" section in the "CoSig Note" pane
    And I wait "3" seconds
    Then I enter "sharing HP draft note scenario 12" in the "HPI" rich text field in the "CoSig Note Contents" pane
    And I click the "Share Draft" button in the "CoSig Note" pane
    And I click the "Yes" button in the "Question" pane if it exists
    And I wait for loading to complete
    And I select the note "Subjective" section in the "CoSig Note" pane
    And I wait "3" seconds
    And I enter "save PN draft note scenario 12" in the "Patient Narrative QTV2" rich text field in the "CoSig Note Contents" pane
    Then I click the "Save as Draft" button
    And I click the "Yes" button in the "Question" pane if it exists
    Then the "Messages" table should load
    And I click the "Refresh" button
    Then the 1st row of the "Messages" table should have the text "Shared" in the "Status" column
    Then the 2nd row of the "Messages" table should have the text "Draft" in the "Status" column
     #verify the status as shared in clinical notes table
    And I am on the "Patient List V2" tab
    And I refresh the patient list
    And I select patient "DARR, MOLLY" from the patient list
    Then I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*SHARED* History and Physical" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |sharing HP draft note scenario 1 |
      |Shared                  |
    When I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |save PN draft note scenario 1 |
      |Draft                  |


    #Testcase : 022_Multi selection of Unsigned notes_SIGN (i.e. by Co-signing physician)
  Scenario: 25538. Verify signing of multi selected unsigned notes
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection note 1" in the "Patient Narrative QTV2" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I sign/submit the Co-sig note as cosignature "sdlvl1u1"
    #And I wait "20" seconds
    #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection note 2" in the "Chief Complaint" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I sign/submit the Co-sig note as cosignature "sdlvl1u1"
     #navigate to inbox and perform required action
    Given I am logged into the portal with user "sdlvl1u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Attest   |button |
      |Decline  |button |
      |Sign     |button |
    And I verify the note count of the "Messages" table and click the "Sign" button with "123" password
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "Patient List V2" tab
    And I refresh the patient list
    And I select patient "DARR, MOLLY" from the patient list
    Then I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |Final              |
      |multi selection note 2 |
      |Attestation message should be display end of the Note detail. |
      |Electronically signed by LEVEL1, SDLVL1U1                     |
    When I select "Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |Final              |
      |multi selection note 1 |
      |Attestation message should be display end of the Note detail. |
      |Electronically signed by LEVEL1, SDLVL1U1                     |

    #Testcase : 023_Multi selection of Unsigned notes_DECLINE (i.e. by Co-signing physician)
  Scenario: 25539. Verify decline of multi selected unsigned notes
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection note 1" in the "Patient Narrative QTV2" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I sign/submit the Co-sig note as cosignature "sdlvl1u1"
    #And I wait "20" seconds
    #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection note 2" in the "Chief Complaint" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I sign/submit the Co-sig note as cosignature "sdlvl1u1"
     #navigate to inbox and perform required action
    Given I am logged into the portal with user "sdlvl1u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Attest   |button |
      |Decline  |button |
      |Sign     |button |
      |Reassign |button|
    And I click the "Decline" button
    And I select "Edits are rquired" from the "Reason" dropdown
    And I enter "declining multi selected notes" in the "Additional Comments" field
    And I click the "OK" button in the "eSig Note Content" pane
    #verify declining comments as author in clinical notes
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "Patient List V2" tab
    And I refresh the patient list
    And I select patient "DARR, MOLLY" from the patient list
    Then I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |Signed: Awaiting Co-signature              |
      |Declining Provider: LEVEL1, SDLVL1U1       |
      |Additional Comments: declining multi selected notes|
      |multi selection note 2                             |
    When I select "Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |Signed: Awaiting Co-signature              |
      |Declining Provider: LEVEL1, SDLVL1U1       |
      |Additional Comments: declining multi selected notes|
      |multi selection note 1                             |

    #Testcase : 024_Multi selection of Unsigned notes_REASSIGN (i.e. by Co-signing physician)
  Scenario: 25540. Verify reassign of multi selected unsigned notes
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection note 1" in the "Patient Narrative QTV2" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I sign/submit the Co-sig note as cosignature "sdlvl1u1"
    #And I wait "20" seconds
    #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection note 2" in the "Chief Complaint" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I sign/submit the Co-sig note as cosignature "sdlvl1u1"
     #navigate to inbox and perform required action
    Given I am logged into the portal with user "sdlvl1u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Attest   |button |
      |Decline  |button |
      |Sign     |button |
      |Reassign |button |
    And I click the "Reassign" button
    And I enter "sdlvl1u2" in the "ProviderLOOKUP" field
    And I click the "SearchImage" image
    And I click the "OK" button in the "eSig Note Content" pane
      #navigate to inbox and perform required action
    Given I am logged into the portal with user "sdlvl1u2" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    Then the following rows should appear in the "Messages" table
    | Date                 | Patient      | Description            | Status     | Author           |
    |%Current Date MMDDYY% | DARR, MOLLY  | History and Physical   | Unsigned   | LEVEL3, SDLVL3U1 |
    |%Current Date MMDDYY% | DARR, MOLLY  | Progress Note          | Unsigned   | LEVEL3, SDLVL3U1 |

    #Testcase : 025_Multi selection of Unsigned notes_ATTEST_BackToInbox_SIGN (i.e. by Co-signing physician)
  Scenario: 25541. Verify back to inbox after Attest and then sign the multi selected unsigned notes
    Given I am logged into the portal with user "sdlvl1u2" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    #using reassigned notes from previous scenario
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And I click the "Attest" button
    And I wait for loading to complete
    And I select the note "History" section in the "CoSig Note" pane
    And I wait "3" seconds
    When I enter "verifying attest-backtoinbox" in the "CoSignature Additions Subjective" rich text field
    And I click the "BackToInbox" button in the "CoSig Note" pane
    And I click the "Yes" button in the "Question" pane if it exists
    Then the "Messages" table should load
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And I verify the note count of the "Messages" table and click the "Sign" button with "123" password
    #verify final note as author
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "Patient List V2" tab
    And I refresh the patient list
    And I select patient "DARR, MOLLY" from the patient list
    Then I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |Final              |
      |multi selection note 2 |
      |Electronically signed by LEVEL1, SDLVL1U2                     |
    When I select "Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |Final              |
      |multi selection note 1 |
      |Electronically signed by LEVEL1, SDLVL1U2                     |

     #Testcase : 026_Multi selection of Unsigned notes_ATTEST_Skip of first note_Sign on next note (i.e. by Co-signing physician)
  Scenario: 25542. Verify skip first note after Attest and then sign the multi selected unsigned notes
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection note 1" in the "Patient Narrative QTV2" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I sign/submit the Co-sig note as cosignature "sdlvl1u1"
    #And I wait "20" seconds
    #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection note 2" in the "Chief Complaint" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I sign/submit the Co-sig note as cosignature "sdlvl1u1"
     #navigate to inbox and perform required action
    Given I am logged into the portal with user "sdlvl1u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Attest   |button |
      |Decline  |button |
      |Sign     |button |
      |Reassign |button |
    And I click the "Attest" button
    And I wait for loading to complete
    And I select the note "History" section in the "CoSig Note" pane
    And I wait "3" seconds
    When I enter "verifying attest-skip" in the "CoSignature Additions Subjective" rich text field
    And I click the "NW ProgressNote Skip" button in the "CoSig Note" pane
    And I select the note "Subjective" section in the "CoSig Note" pane
    When I enter "signing second note" in the "CoSignature Additions Subjective" rich text field
    And I verify the note count of the "Messages" table and click the "Sign/Submit" button with "123" password
     #verify final note as author
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "Patient List V2" tab
    And I refresh the patient list
    And I select patient "DARR, MOLLY" from the patient list
    Then I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |Signed: Awaiting Co-signature              |
      |multi selection note 2                     |
    And Text "verifying attest-skip" should not appear in the "Note Details" pane
    When I select "Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |Final              |
      |multi selection note 1 |
      |Electronically signed by LEVEL1, SDLVL1U1 |

    #Testcase : 028_Multi selection of Unsigned notes_ATTEST_Skip_Sign (i.e. by Co-signing physician)
  Scenario: 25544. Verify skip first note after Attest and then sign the multi selected unsigned notes
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
     #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection note 1" in the "Patient Narrative QTV2" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I sign/submit the Co-sig note as cosignature "sdlvl1u1"
    #And I wait "20" seconds
     #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection note 2" in the "Chief Complaint" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I sign/submit the Co-sig note as cosignature "sdlvl1u1"
      #navigate to inbox and perform required action
    Given I am logged into the portal with user "sdlvl1u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Attest   |button |
      |Decline  |button |
      |Sign     |button |
      |Reassign |button |
    And I click the "Attest" button
    And I wait for loading to complete
    And I select the note "History" section in the "CoSig Note" pane
    And I wait "3" seconds
    When I enter "skipping note 2" in the "CoSignature Additions Subjective" rich text field
    And I click the "NW ProgressNote Skip" button in the "CoSig Note" pane
    And I select the note "Subjective" section in the "CoSig Note" pane
    When I enter "skipping note 1" in the "CoSignature Additions Subjective" rich text field
    And I click the "NW ProgressNote Skip" button in the "CoSig Note" pane
    #multi select notes again and sign
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Attest   |button |
      |Decline  |button |
      |Sign     |button |
    And I verify the note count of the "Messages" table and click the "Sign" button with "123" password
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "Patient List V2" tab
    And I refresh the patient list
    And I select patient "DARR, MOLLY" from the patient list
    Then I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |Final              |
      |multi selection note 2 |
      |Attestation message should be display end of the Note detail. |
      |Electronically signed by LEVEL1, SDLVL1U1                     |
    When I select "Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |Final              |
      |multi selection note 1 |
      |Attestation message should be display end of the Note detail. |
      |Electronically signed by LEVEL1, SDLVL1U1                     |

    #Testcase : 034_Multi selection of Shared Drafts_EDIT/SIGN_SIGN (i.e. Author)
  Scenario: 25550. Verify signing of multi selected shared draft notes
    Given I am logged into the portal with user "sdlvl3u2" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
     #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection note 1" in the "Patient Narrative QTV2" rich text field
    And I click the "Share Draft" button in the "Note Writer Main" pane
    And I click the "Yes" button in the "Question" pane if it exists
    #And I wait "20" seconds
     #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection note 2" in the "Chief Complaint" rich text field
    And I click the "Share Draft" button in the "Note Writer Main" pane
    And I click the "Yes" button in the "Question" pane if it exists
      #navigate to inbox and perform required action
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Drafts" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Delete   |button |
      |EDIT/SIGN  |button |
    Then I click the "EDIT/SIGN" button
    And I wait for loading to complete
    And I select the note "History" section in the "CoSig Note" pane
    And I wait "3" seconds
    Then I enter "signing HP shared draft note scenario 19" in the "HPI" rich text field in the "CoSig Note Contents" pane
    And I select the note "A/P" section in the "CoSig Note" pane
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I verify the note count of the "Messages" table and click the "Sign/Submit" button with "123" password
    And I wait for loading to complete
    And I select the note "Subjective" section in the "CoSig Note" pane
    And I wait "3" seconds
    And I enter "signing PN shared draft note scenario 19" in the "Patient Narrative QTV2" rich text field in the "CoSig Note Contents" pane
    And I select the note "A/P" section in the "CoSig Note" pane
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I verify the note count of the "Messages" table and click the "Sign/Submit" button with "123" password
    Then the "Messages" table should load
    #verify in clinical notes
    And I am on the "PatientListV2" tab
    And I refresh the clinical display
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |signing HP shared draft note scenario 19 |
      |Final                                    |
      |Electronically signed by SDLVL3U2 LEVEL3 |
    When I select "Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |signing PN shared draft note scenario 19 |
      |Final                                    |
      |Electronically signed by SDLVL3U2 LEVEL3 |

    #Testcase : 035_Multi selection of Shared Drafts_EDIT/SIGN_Share Draft (i.e. Author)
  Scenario: 25551. Verify sharing draft of multi selected shared draft notes
    Given I am logged into the portal with user "sdlvl3u2" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
     #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection note 1" in the "Patient Narrative QTV2" rich text field
    And I click the "Share Draft" button in the "Note Writer Main" pane
    And I click the "Yes" button in the "Question" pane if it exists
    #And I wait "20" seconds
     #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection note 2" in the "Chief Complaint" rich text field
    And I click the "Share Draft" button in the "Note Writer Main" pane
    And I click the "Yes" button in the "Question" pane if it exists
      #navigate to inbox and perform required action
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Drafts" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    Then I click the "EDIT/SIGN" button
    And I wait for loading to complete
    And I select the note "History" section in the "CoSig Note" pane
    And I wait "3" seconds
    Then I enter "sharing HP shared draft note scenario 20" in the "HPI" rich text field in the "CoSig Note Contents" pane
    And I click the "Share Draft" button in the "CoSig Note" pane
    And I click the "Yes" button in the "Question" pane if it exists
    And I wait for loading to complete
    And I select the note "Subjective" section in the "CoSig Note" pane
    And I wait "3" seconds
    And I enter "sharing PN shared draft note scenario 20" in the "Patient Narrative QTV2" rich text field in the "CoSig Note Contents" pane
    And I click the "Share Draft" button in the "CoSig Note" pane
    And I click the "Yes" button in the "Question" pane if it exists
    Then the "Messages" table should load
    And I click the "Refresh" button
    Then the following rows should appear in the "Messages" table
      | Date                 | Patient      | Description            | Status        |
      |%Current Date MMDDYY% | DARR, MOLLY  | History and Physical   | Shared Draft  |
      |%Current Date MMDDYY% | DARR, MOLLY  | Progress Note          | Shared Draft  |
    When I select "History and Physical" from the "Description" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    Then Text "sharing HP shared draft note scenario 20" should appear in the "eSig Note Content" pane
    And I click the "Xclose" button
    When I select "Progress Note" from the "Description" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    Then Text "sharing PN shared draft note scenario 20" should appear in the "eSig Note Content" pane
    And I click the "Xclose" button
    #verify in clinical notes
    And I am on the "PatientListV2" tab
    And I refresh the clinical display
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*SHARED* History and Physical" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |sharing HP shared draft note scenario 20 |
      |Shared Draft                            |
    When I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |sharing PN shared draft note scenario 20 |
      |Shared Draft                             |

    #Testcase : 036_Multi selection of Shared Drafts_DELETE (i.e. Author)
  Scenario: 25552. Verify deletion of multi selected shared drafts
    Given I am logged into the portal with user "sdlvl3u2" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
     #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection PN note 1 scenario 21" in the "Patient Narrative QTV2" rich text field
    And I click the "Share Draft" button in the "Note Writer Main" pane
    And I click the "Yes" button in the "Question" pane if it exists
    #And I wait "20" seconds
     #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection HP note 2 scenario 21" in the "Chief Complaint" rich text field
    And I click the "Share Draft" button in the "Note Writer Main" pane
    And I click the "Yes" button in the "Question" pane if it exists
      #navigate to inbox and perform required action
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Drafts" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    Then I click the "Delete" button
    And I click the "OK" button in the "Confirm" pane
    Then the following elements should be checked in the "eSig Note Content" pane
      |FirstNote Checkbox |
      |SecondNote Checkbox |
    #verify in clinical notes
    And I am on the "PatientListV2" tab
    And I refresh the clinical display
    Then I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*SHARED* History and Physical" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |multi selection HP note 2 scenario 21     |
      |Shared Draft                              |
    When I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |multi selection PN note 1 scenario 21       |
      |Shared Draft                              |

    #Testcase : 038_Multi selection of Shared Drafts_EDIT/SIGN_Sign on first note_Share draft of next note (i.e. Author)
  Scenario: 25554. Verify signing first note and sharing second note of multi selected shared drafts
    Given I am logged into the portal with user "sdlvl3u2" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
     #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection note 1" in the "Patient Narrative QTV2" rich text field
    And I click the "Share Draft" button in the "Note Writer Main" pane
    And I click the "Yes" button in the "Question" pane if it exists
    #And I wait "20" seconds
     #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection note 2" in the "Chief Complaint" rich text field
    And I click the "Share Draft" button in the "Note Writer Main" pane
    And I click the "Yes" button in the "Question" pane if it exists
      #navigate to inbox and perform required action
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Drafts" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    Then I click the "EDIT/SIGN" button
    And I wait for loading to complete
    And I select the note "History" section in the "CoSig Note" pane
    And I wait "3" seconds
    Then I enter "signing HP shared draft note scenario 22" in the "HPI" rich text field in the "CoSig Note Contents" pane
    And I select the note "A/P" section in the "CoSig Note" pane
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I verify the note count of the "Messages" table and click the "Sign/Submit" button with "123" password
    And I wait for loading to complete
    And I select the note "Subjective" section in the "CoSig Note" pane
    And I wait "3" seconds
    And I enter "sharing PN shared draft note scenario 22" in the "Patient Narrative QTV2" rich text field in the "CoSig Note Contents" pane
    And I click the "Share Draft" button in the "CoSig Note" pane
    And I click the "Yes" button in the "Question" pane if it exists
    And I click the "Refresh" button
    Then the "Messages" table should load
    When I select "History and Physical" from the "Description" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    #signed note should not appear in drafts
    Then Text "signing HP shared draft note scenario 22" should not appear in the "eSig Note Content" pane
    And I click the "Xclose" button
    When I select "Progress Note" from the "Description" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    Then Text "sharing PN shared draft note scenario 22" should appear in the "eSig Note Content" pane
    And I click the "Xclose" button
    #verify in clinical notes
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    Then I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |signing HP shared draft note scenario 22 |
      |Final                    |
    When I select "*SHARED* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |sharing PN shared draft note scenario 22 |
      |Shared Draft                             |

     #Testcase : 043_Multi selection of Shared Drafts_EDIT/SIGN_Share Draft of first note_Sign on next note
  Scenario: 25559. Verify sharing first note and signing second note of multi selected shared drafts
    Given I am logged into the portal with user "sdlvl3u2" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
     #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection note 1" in the "Patient Narrative QTV2" rich text field
    And I click the "Share Draft" button in the "Note Writer Main" pane
    And I click the "Yes" button in the "Question" pane if it exists
    #And I wait "20" seconds
     #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection note 2" in the "Chief Complaint" rich text field
    And I click the "Share Draft" button in the "Note Writer Main" pane
    And I click the "Yes" button in the "Question" pane if it exists
      #navigate to inbox and perform required action
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Drafts" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    Then I click the "EDIT/SIGN" button
    And I wait for loading to complete
    And I select the note "History" section in the "CoSig Note" pane
    And I wait "3" seconds
    Then I enter "sharing HP shared draft note scenario 23" in the "HPI" rich text field in the "CoSig Note Contents" pane
    And I click the "Share Draft" button in the "CoSig Note" pane
    And I click the "Yes" button in the "Question" pane if it exists
    And I wait for loading to complete
    And I select the note "Subjective" section in the "CoSig Note" pane
    And I wait "3" seconds
    And I enter "signing PN shared draft note scenario 23" in the "Patient Narrative QTV2" rich text field in the "CoSig Note Contents" pane
    And I select the note "A/P" section in the "CoSig Note" pane
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I verify the note count of the "Messages" table and click the "Sign/Submit" button with "123" password
    Then the "Messages" table should load
    When I select "History and Physical" from the "Description" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    #signed note should not appear in drafts
    Then Text "sharing HP shared draft note scenario 23" should appear in the "eSig Note Content" pane
    And I click the "Xclose" button
    When I select "Progress Note" from the "Description" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    Then Text "signing PN shared draft note scenario 23" should not appear in the "eSig Note Content" pane
    And I click the "Xclose" button
    #verify in clinical notes
    And I am on the "PatientListV2" tab
    And I refresh the clinical display
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*SHARED* History and Physical" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |sharing HP shared draft note scenario 23|
      |Shared                    |
    When I select "Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |signing PN shared draft note scenario 23 |
      |Final                  |

    #Testcase : 045_Multi selection of Shared Drafts (i.e. Co-sign required)_EDIT/SIGN_Sign on first note_Share Draft of next note
  Scenario: 25561. Verify signing first note and sharing second note of multi selected co-sign required shared drafts
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
     #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection note 1" in the "Patient Narrative QTV2" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I share draft with the co-signer "sdlvl1u1"
    #And I wait "20" seconds
     #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection note 2" in the "Chief Complaint" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I share draft with the co-signer "sdlvl1u1"
      #navigate to inbox and perform required action
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Drafts" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    Then I click the "EDIT/SIGN" button
    And I wait for loading to complete
    And I select the note "History" section in the "CoSig Note" pane
    And I wait "3" seconds
    Then I enter "signing HP shared draft note scenario 24" in the "HPI" rich text field in the "CoSig Note Contents" pane
    And I select the note "A/P" section in the "CoSig Note" pane
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I sign/submit the Co-sig note as cosignature "sdlvl1u1"
    And I wait for loading to complete
    And I select the note "Subjective" section in the "CoSig Note" pane
    And I wait "3" seconds
    And I enter "sharing PN shared draft note scenario 24" in the "Patient Narrative QTV2" rich text field in the "CoSig Note Contents" pane
    And I share draft with the co-signer "sdlvl1u1"
    Then the "Messages" table should load
    When I select "History and Physical" from the "Description" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    #signed note should not appear in drafts
    Then Text "signing HP shared draft note scenario 24" should not appear in the "eSig Note Content" pane
    And I click the "Xclose" button
    When I select "Progress Note" from the "Description" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    #signed note should not appear in drafts
    Then Text "sharing PN shared draft note scenario 24" should appear in the "eSig Note Content" pane
    And I click the "Xclose" button
    #verify in clinical notes
    Given I am logged into the portal with user "sdlvl1u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    When I select "History and Physical" from the "Description" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    #signed note should not appear in drafts
    Then Text "signing HP shared draft note scenario 24" should appear in the "eSig Note Content" pane
    And I click the "Xclose" button
    When I select "Progress Note" from the "Description" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    #signed note should not appear in drafts
    Then Text "sharing PN shared draft note scenario 24" should appear in the "eSig Note Content" pane
    And I click the "Xclose" button

    #Testcase : 046_Multi selection of Shared drafts_SIGN (i.e. by Co-signing physician)
  Scenario: 25562. Verify signing of multi selected shared draft by co-signer
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
     #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection PN note 1 scenario 25" in the "Patient Narrative QTV2" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I share draft with the co-signer "sdlvl1u1"
    #And I wait "20" seconds
     #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection HP note 2 scenario 25" in the "Chief Complaint" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I share draft with the co-signer "sdlvl1u1"
      #navigate to inbox and perform required action
    Given I am logged into the portal with user "sdlvl1u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Attest   |button |
      |Decline  |button |
      |Sign     |button |
    And I click the "Sign" button
    And I enter "123" in the "Password" field
    And I click the "OK" button in the "Confirm" pane
    Then the "Messages" table should load
    When I select "History and Physical" from the "Description" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    #sign operation is non-operational on shared draft
    Then Text "multi selection HP note 2 scenario 25" should appear in the "eSig Note Content" pane
    And I click the "Xclose" button
    When I select "Progress Note" from the "Description" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    Then Text "multi selection PN note 1 scenario 25" should appear in the "eSig Note Content" pane
    And I click the "Xclose" button
    Then the following elements should be unchecked in the "eSig Note Content" pane
      |FirstNote Checkbox |
      |SecondNote Checkbox |

  #Testcase : 047_Multi selection of Shared drafts_DECLINE (i.e. by Co-signing physician)
  Scenario: 25563. Verify decline on multi selected shared draft notes
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
     #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection PN note 1 scenario 26" in the "Patient Narrative QTV2" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I share draft with the co-signer "sdlvl1u1"
    #And I wait "20" seconds
     #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection HP note 2 scenario 26" in the "Chief Complaint" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I share draft with the co-signer "sdlvl1u1"
      #navigate to inbox and perform required action
    Given I am logged into the portal with user "sdlvl1u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Attest   |button |
      |Decline  |button |
      |Sign     |button |
    And I click the "Decline" button
    And The following fields should be not display in the "eSig Note Content" pane
      |Name     |Type   |
      |Attest   |button |
      |Decline  |button |
      |Sign     |button |
    Then the following elements should be unchecked in the "eSig Note Content" pane
      |FirstNote Checkbox |
      |SecondNote Checkbox |

  #Testcase : 048_Multi selection of Shared drafts_REASSIGN (i.e. by Co-signing physician)
  Scenario: 25564. Verify reassign on multi selected shared draft notes
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
     #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection PN note 1 scenario 27" in the "Patient Narrative QTV2" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I share draft with the co-signer "sdlvl1u1"
    #And I wait "20" seconds
     #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection HP note 2 scenario 27" in the "Chief Complaint" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I share draft with the co-signer "sdlvl1u1"
      #navigate to inbox and perform required action
    Given I am logged into the portal with user "sdlvl1u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Attest   |button |
      |Decline  |button |
      |Sign     |button |
      |Reassign |button |
    And I click the "Reassign" button
    And I enter "sdlvl1u2" in the "ProviderLOOKUP" field
    And I click the "SearchImage" image
    And I click the "OK" button in the "eSig Note Content" pane
    #login in as second co-signer
    Given I am logged into the portal with user "sdlvl1u2" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I wait "5" seconds
    Then the "Messages" table should load
    When I select "History and Physical" from the "Description" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    Then Text "multi selection HP note 2 scenario 27" should appear in the "eSig Note Content" pane
    And I click the "Xclose" button
    When I select "Progress Note" from the "Description" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    Then Text "multi selection PN note 1 scenario 27" should appear in the "eSig Note Content" pane
    And I click the "Xclose" button

    #Testcase : 053_Multi selection of Shared Drafts_ATTEST_No
  Scenario: 25569. Verify attest of multi selected shared drafts
    Given I am logged into the portal with user "pkadminv2" using the default password
    #Allow CoSigner To Edit Resident SharedDrafts should be set to false
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "false" from the "Allow CoSigner To Edit Resident SharedDrafts" radio list in the "Note Writer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    Given I am logged into the portal with user "sdlvl3u1" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
     #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection PN note 1 scenario 28" in the "Patient Narrative QTV2" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I share draft with the co-signer "sdlvl1u1"
    #And I wait "20" seconds
     #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection HP note 2 scenario 28" in the "Chief Complaint" rich text field
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision" dropdown
    And I share draft with the co-signer "sdlvl1u1"
      #navigate to inbox and perform required action
    Given I am logged into the portal with user "sdlvl1u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Attest   |button |
      |Decline  |button |
      |Sign     |button |
    And I click the "Attest" button
    And The following fields should be not display in the "eSig Note Content" pane
      |Name     |Type   |
      |Attest   |button |
      |Decline  |button |
      |Sign     |button |
    Then the following elements should be unchecked in the "eSig Note Content" pane
      |FirstNote Checkbox |
      |SecondNote Checkbox |

  #Testcase : 054_Multi selection of Drafts & Shared Drafts_DELETE
  Scenario: 25662. Verify deleted of multi selected saved and shared draft
    Given I am logged into the portal with user "sdlvl3u2" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
     #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection PN note 1 scenario 29, saving as draft" in the "Patient Narrative QTV2" rich text field
    And I save the template as Draft
    #And I wait "20" seconds
     #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection HP note 2 scenario 29, shared draft" in the "Chief Complaint" rich text field
    And I click the "Share Draft" button in the "Note Writer Main" pane
    And I click the "Yes" button in the "Question" pane if it exists
      #navigate to inbox and perform required action
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Drafts" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    Then I click the "Delete" button
    And I click the "OK" button in the "Confirm" pane
    And I click the "Refresh" button
    When I select "History and Physical" from the "Description" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    #sign operation is non-operational on shared draft
    Then Text "multi selection HP note 2 scenario 29, shared draft" should appear in the "eSig Note Content" pane
    And I click the "Xclose" button
    When I select "Progress Note" from the "Description" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    Then Text "multi selection PN note 1 scenario 29, saving as draft" should not appear in the "eSig Note Content" pane
    And I click the "Xclose" button

    #Testcase : 055_Multi selection of Drafts & Shared Drafts_EDIT/SIGN_Differentiation
  Scenario: 25660. Verify signning of multi selected saved and shared drafts
    Given I am logged into the portal with user "sdlvl3u2" using the default password
    And I am on the "PatientListV2" tab
    And I select "Card Group" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
     #note 1
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    #And I enter "%1 minute before Current Time HHMM%" in the "NoteTime" field in the "ClinicalNote" pane
    And I enter "multi selection PN note 1 scenario 29, saving as draft" in the "Patient Narrative QTV2" rich text field
    And I save the template as Draft
    #And I wait "20" seconds
     #note 2
    And I load the "History and Physical" template note for the selected patient
    And I select the note "History" section
    And I enter "multi selection HP note 2 scenario 29, shared draft" in the "Chief Complaint" rich text field
    And I click the "Share Draft" button in the "Note Writer Main" pane
    And I click the "Yes" button in the "Question" pane if it exists
      #navigate to inbox and perform required action
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Drafts" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "First Note Checkbox" in the "eSig Note Content" pane
    And I click on the element "Second Note Checkbox" in the "eSig Note Content" pane
    And I click the "EDIT/SIGN" button
    #save as draft button should not be available for shared draft
    And The following fields should be not display in the "CoSig Note" pane
      |Name          |Type   |
      |SaveasDraft   |button |
    Then I click the "NW ProgressNote Skip" button in the "CoSig Note" pane
    #save as draft button should be available for saved draft
    And The following fields should be display in the "CoSig Note" pane
      |Name          |Type   |
      |SaveasDraft   |button |
    Then I click the "NW ProgressNote Skip" button in the "CoSig Note" pane

  Scenario: Post-requisite : Disable QTV2 and co-signature
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "false" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
    And I select "false" from the "Enable Spell Check" radio list in the "Note Writer Settings" pane
    And I select "true" from the "Allow CoSigner To Edit Resident SharedDrafts" radio list in the "Note Writer Settings" pane
    And I select "false" from the "CoSignature" radio list in the "Note Writer Settings" pane
    And I select "None" from the "Validation" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I open "NoteWriter" settings page for the user "sdlvl3u1"
    And I wait "3" seconds
    And I select "false" from the "AllowUserToShareDraftNote" radio list in the "NoteWriterSettings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the "Return to Choose Users" link in the "User Preferences" pane
    And I open "NoteWriter" settings page for the user "sdlvl3u2"
    And I wait "3" seconds
    And I select "false" from the "AllowUserToShareDraftNote" radio list in the "NoteWriterSettings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box