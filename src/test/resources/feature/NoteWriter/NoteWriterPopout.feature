@NoteWriterPopOut
Feature: NoteWriter Manual Pop Out/In

  Background:
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And "NEIL HEATH" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation

    Scenario: Pre-requisite - Disable QTV2
      Given I am logged into the portal with user "pkadminv2" using the default password
      And I am on the "Admin" tab
      And I select the "Institution" subtab
      And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
      And I wait "2" seconds
      And I select "false" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
      And I select "false" from the "Enable Spell Check" radio list in the "Note Writer Settings" pane
      And I click the "Save" button
      And I click "OK" in the confirmation box

  Scenario: Insert previous UI
    And I click the "ClinicalNotes+" button
    #creating draft note to verify insert previous UI
    And I select "Progress Note" from the select template list
    And I wait up to "3" seconds for the "PopOut" field of type "BUTTONS" in the "Note Writer" pane to be visible
    And I save the template as Draft
    And I click the "Refresh Patient List" button
    And I select patient "Molly Darr" from the patient list
    And I click the "ClinicalNotes+" button
    And I select "Progress Note" from the select template list
    And I wait up to "3" seconds for the "PopOut" field of type "BUTTONS" in the "Note Writer" pane to be visible
    And I pop out note writer
#    And I click the "Keep" button in the "Question" pane if it exists
    And I select the note "A/P" section
    And I wait "1" seconds
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    Then the "Insert Previous" "pane" should be visible
    And I click the "Add Order Cancel" button in the "Insert Previous" pane
    And I click the "Save as Draft" button in the "Clinical Note Pop Out" pane
    Then I click the "Yes" button in the "Information" pane
    And I switch the focus to the "portal Window" window
    And I select "*DRAFT* Progress Note" in the "Notes" table
    And I delete the draft note in the "Note Details" pane

  Scenario: Data selection in a note
    And I click the "ClinicalNotes+" button
    And I select "Progress Note" from the select template list
    And I wait up to "3" seconds for the "PopOut" field of type "BUTTONS" in the "Note Writer" pane to be visible
    And I pop out note writer
    And I select the note "Data" section
    And I wait "1" seconds
    And I switch the focus to the "portal Window" window
    And I select "Allergies" from clinical navigation
    And I uncheck the "Penicillin" checkbox
    And I check the "Penicillin" checkbox
    And I switch the focus to the "popoutWindow" window
    And the following text should appear in the "PopoutForm" pane
      | Allergies  |
      | Penicillin |
    And I click the "SaveasDraft" button in the "Clinical Note Pop Out" pane
    Then I click the "Yes" button in the "Information" pane
    And I wait "2" seconds
    And I switch the focus to the "portalWindow" window
    And I select "Clinical Notes" from clinical navigation
    And I select "*DRAFT* Progress Note" in the "Notes" table
    And the following text should appear in the "NoteDetails" pane
      | Allergies  |
      | Penicillin |
#    And I click the "RemoveClinicalDataCategory" image in the "NoteDetails" pane
    And I select "Allergies" from clinical navigation
    And I click the "Refresh" button
    And I select "Clinical Notes" from clinical navigation
    And I select "*DRAFT* Progress Note" in the "Notes" table
    And I delete the draft note in the "NoteDetails" pane

#    Need to clear any previously selected problems before running this scenario
  Scenario: Add problem from A/P
    And I click the "ClinicalNotes+" button
    And I select "Progress Note" from the select template list
    And I wait up to "3" seconds for the "PopOut" field of type "BUTTONS" in the "Note Writer" pane to be visible
    And I pop out note writer
    And I select the note "A/P" section
    And I wait "1" seconds
    #And I click the "ToggleDxSearch" button in the "PopoutForm" pane
#    And I click the "Add all" link in the "NoteWriterPopoutHistoryDXSearch" pane
    And I enter "D64.0" in the "ProblemDxSearch" field
    And I wait "1" second
    And I enter "J11.1" in the "ProblemDxSearch" field
    And I wait "1" second
    And I click the "SaveasDraft" button in the "Clinical Note Pop Out" pane
    Then I click the "Yes" button in the "Information" pane
    And I wait "2" seconds
    And I switch the focus to the "portalWindow" window
    And I select "Clinical Notes" from clinical navigation
    And I select "*DRAFT* Progress Note" in the "Notes" table
    And the following text should appear in the "NoteDetails" pane
      | Assessment/Plan                                                                   |
      | Influenza due to unidentified influenza virus with other respiratory manifestations |
      | Hereditary sideroblastic anemia                                                     |
    And I delete the draft note in the "NoteDetails" pane

  Scenario: Basic popout popin (Manual popout)
    And I click the "Clinical Notes+" button
    And I wait "2" seconds
    And I pop out note writer
    And I pop in note writer
    And I wait "2" seconds
    And I click the "Cancel" button in the "Clinical Note" pane
#    And I select the "" window

  Scenario: Selecting a template and create a draft and delete it
    And I click the "ClinicalNotes+" button
    And I wait "2" seconds
    And I select "Progress Note" from the select template list
    And I wait "2" seconds
    And I pop out note writer
    And I pop in note writer
    And I wait "2" seconds
    And I click the "NoteWriterCancelNote" button in the "ClinicalNote" pane
    Then I click the "Yes" button in the "Information" pane
    And I switch the focus to the "portalWindow" window

  Scenario: Enter orders tab disables pop out option
    And I click the "ClinicalNotes+" button
    And I wait "2" seconds
    And I select "Progress Note" from the select template list
    And I wait "2" seconds
    And I select the note "Enter Orders" section
    And I wait "1" seconds
#    Then The "PopOut" "button" should be disabled
    And The following field should be disabled in the "ClinicalNote" pane
      | Name   | Type   |
      | PopOut | button |
    And I select the note "Subjective" section
    And I wait "1" seconds
    And The following field should be disabled in the "ClinicalNote" pane
      | Name   | Type   |
      | PopOut | button |
    And I click the "NoteWriterCancelNote" button in the "ClinicalNote" pane
    Then I click the "Yes" button in the "Information" pane

  Scenario: Cancel a note in popout window
    And I click the "ClinicalNotes+" button
    And I select "Progress Note" from the select template list
    And I wait up to "3" seconds for the "PopOut" field of type "BUTTONS" in the "Note Writer" pane to be visible
    And I pop out note writer
    And I enter "12:02PM" in the "NoteTime" field
    And the following fields should display in the "Clinical Note Pop Out" pane
      | Name      | Type     |
      | Specialty | dropdown |
    And I select "ER Note" from the "NoteType" dropdown
    And I click the "Cancel" button in the "Clinical Note Pop Out" pane
    Then I click the "Yes" button in the "Information" pane
    And I switch the focus to the "portalWindow" window

  Scenario: Save as draft in popout window and verify whether its status is draft
    And I click the "ClinicalNotes+" button
    And I wait "2" seconds
    And I select "Progress Note" from the select template list
    And I wait "2" seconds
    And I pop out note writer
    And I click the "SaveasDraft" button in the "Clinical Note Pop Out" pane
    Then I click the "Yes" button in the "Information" pane
    And I wait "2" seconds
    And I switch the focus to the "portalWindow" window
    And I select "*DRAFT* Progress Note" in the "Notes" table
    And the following text should appear in the "NoteDetails" pane
      | Status |
      | Draft  |
    And I delete the draft note in the "NoteDetails" pane

  Scenario: Sign/Submit the note
    And I click the "ClinicalNotes+" button
    And I wait "2" seconds
    And I select "Progress Note" from the select template list
    And I wait "2" seconds
    And I pop out note writer
    And I select the note "A/P" section in the "Clinical Note Pop Out" pane
    And I wait "1" seconds
    And I select "Moderate" from the "LevelOfDecision" dropdown in the "PopoutForm" pane
    And I sign/submit the note
    And I wait "2" seconds
    And I switch the focus to the "portalWindow" window
    And I select "Clinical Notes" from clinical navigation
    And I select "Progress Note" in the "Notes" table
    And the following text should appear in the "NoteDetails" pane
      | Final                                   |
      | Electronically signed by PERRY KADMINV2 |

  Scenario: Switching tabs after opening a new note
    And I click the "ClinicalNotes+" button
    And I wait "2" seconds
    And I select "Progress Note" from the select template list
    And I wait "2" seconds
    And I pop out note writer
    And I switch the focus to the "portalWindow" window
    And I am on the "Schedule" tab
    And I am on the "Patient List V2" tab
    And the "ClinicalNote" "Pane" should be visible
    And I click the "Cancel" button in the "ClinicalNote" pane
    Then I click the "Yes" button in the "Information" pane

  Scenario: Hide orders tab
    And I click the "ClinicalNotes+" button
    And I wait "2" seconds
    And I select "Progress Note" from the select template list
    And I wait "2" seconds
    And I pop out note writer
    And the text "Enter Orders" should not appear in the "Clinical Note Pop Out" pane
    And I pop in note writer
    And I wait "2" seconds
    And I click the "NoteWriterCancelNote" button in the "ClinicalNote" pane
    Then I click the "Yes" button in the "Information" pane

#    The following scenario may not always execute properly. Please see the patients in the patient list and make sure the
#  required patients are available
  Scenario: Switching between patients when a note is popped out for first patient
    And I click the "ClinicalNotes+" button
    And I wait "2" seconds
    And I select "Progress Note" from the select template list
    And I wait "2" seconds
    And I pop out note writer
    And I switch the focus to the "portalWindow" window
    And I select patient "NEIL HEATH" from the patient list
    And I select patient "Molly Darr" from the patient list
    Then the "ClinicalNote" "pane" should be visible
    And I pop out note writer
    And I switch the focus to the "popoutWindow" window
    And I click the "NoteWriterCancelNote" button in the "Clinical Note Pop Out" pane
    Then I click the "Yes" button in the "Information" pane
    And I switch the focus to the "portalWindow" window

  Scenario: Change in the name of the popout/popin button
    And I click the "ClinicalNotes+" button
    And I wait "2" seconds
    And I "PopOut" "Button" should be labelled as "Pop Out"
    And I pop out note writer
    And I "PopIn" "Button" should be labelled as "PopIn"
    And I pop in note writer
    And I wait "2" seconds
    And I click the "Cancel" button in the "ClinicalNote" pane

  Scenario: Cannot insert data using data tab link when Un-docked
    And I click the "ClinicalNotes+" button
    And I wait "2" seconds
    And I select "Progress Note" from the select template list
    And I wait "2" seconds
    And I pop out note writer
    And I switch the focus to the "popoutWindow" window
    And I select the note "Data" section
    And I wait "1" seconds
    And I click the "Allergies" link in the "PopoutForm" pane
    And I click the "OK" button in the "Information" pane
    And I wait "2" seconds
    And I click the "Clinical Notes" link in the "PopoutForm" pane
    And I click the "OK" button in the "Information" pane
    And I wait "2" seconds
    And I click the "Medications" link in the "PopoutForm" pane
    And I click the "OK" button in the "Information" pane
    And I wait "2" seconds
    And I click the "Lab Results" link in the "PopoutForm" pane
    And I click the "OK" button in the "Information" pane
    And I wait "2" seconds
    And I click the "Orders" link in the "PopoutForm" pane
    And I click the "OK" button in the "Information" pane
    And I wait "2" seconds
    And I click the "Test Results" link in the "PopoutForm" pane
    And I click the "OK" button in the "Information" pane
    And I wait "2" seconds
    And I click the "NoteWriterCancelNote" button in the "ClinicalNote" pane
    Then I click the "Yes" button in the "Information" pane
    And I switch the focus to the "portalWindow" window

  Scenario: Edit the note in popout window
    And I click the "ClinicalNotes+" button
    And I select "Progress Note" from the select template list
    And I wait up to "3" seconds for the "PopOut" field of type "BUTTONS" in the "Note Writer" pane to be visible
    And I pop out note writer
    And I pop in note writer
    And I wait "2" seconds
    And I click the "NoteWriterCancelNote" button in the "ClinicalNote" pane
    Then I click the "Yes" button in the "Information" pane
    And I switch the focus to the "portalWindow" window

  Scenario: User can create only one note in popout mode for a patient
    And I click the "ClinicalNotes+" button
    And I select "Progress Note" from the select template list
    And I wait up to "3" seconds for the "PopOut" field of type "BUTTONS" in the "Note Writer" pane to be visible
    And I pop out note writer
    And I switch the focus to the "portalWindow" window
    And I select patient "Molly Darr" from the patient list
    And I select "*DRAFT* Progress Note" in the "Notes" table
    And I click the "Edit" button in the "NoteDetails" pane
    Then the following text should appear in the "Information" pane
      | Cannot create note on this patient while a note is undocked |
    And I click the "OK" button in the "Information" pane
    And I switch the focus to the "popoutWindow" window
    And I pop in note writer
    And I wait "2" seconds
    And I click the "NoteWriterCancelNote" button in the "ClinicalNote" pane
    Then I click the "Yes" button in the "Information" pane
    And I switch the focus to the "portalWindow" window

  Scenario: User cannot create a new note if undocked for one patient (almost similar to the above scenario)
    And I click the "ClinicalNotes+" button
    And I select "Progress Note" from the select template list
    And I wait "1" seconds
    And I pop out note writer
    And I switch the focus to the "portalWindow" window
    And I click the "ClinicalNotes+" button
    Then the following text should appear in the "Information" pane
      | Cannot create note on this patient while a note is undocked |
    And I click the "OK" button in the "Information" pane
    And I switch the focus to the "popoutWindow" window
    And I pop in note writer
    And I wait "2" seconds
    And I click the "NoteWriterCancelNote" button in the "ClinicalNote" pane
    Then I click the "Yes" button in the "Information" pane
    And I switch the focus to the "portalWindow" window

#  Scenario: Addendum pop out
#    And I click the "ClinicalNotes+" button
#    And I wait "2" seconds
#    And I popout note writer
#    And I switch the focus to the "popoutWindow" window
#    And I enter "Progress Note" in the "Filter" field
#    And I click the "Template" element in the "Clinical Note Pop Out" pane
##    And I select "Progress Note" from the select template list
##    And I popout note writer
#    And I select the note "A/P" section in the "Clinical Note Pop Out" pane
#    And I select "Moderate" from the "LevelOfDecision" dropdown in the "PopoutForm" pane
#    And I sign/submit the note
#    And I wait "2" seconds
#    And I switch the focus to the "portalWindow" window
#    And I select " Progress Note" in the "Notes" table
#    And I click the "AddAddendum" button
#    And I popout note writer
#    And I switch the focus to the "popoutWindow" window
#    And I enter "AddendumTest1" in the "AddendumComments" field
##    And I popout note writer
#    And I click the "NoteWriterSign/Submit" button in the "Clinical Note Pop Out" pane
#    Then I click the "OK" button in the "SubmitNote" pane
#    And I wait "2" seconds
#    And I switch the focus to the "portalWindow" window
#    And I select "Clinical Notes" from clinical navigation
#    And I select " Progress Note - with Addendum" in the "Notes" table
#    And the following text should appear in the "NoteDetails" pane
#      | Status        |
#      | Final         |
#      | AddendumTest1 |

  Scenario: Cannot create a note when undocked from the actions menu
    And I click the "ClinicalNotes+" button
    And I select "Progress Note" from the select template list
    And I wait up to "3" seconds for the "PopOut" field of type "BUTTONS" in the "Note Writer" pane to be visible
    And I pop out note writer
    And the following text should appear in the "Clinical Note Pop Out" pane
      | DARR, MOLLY |
    And I switch the focus to the "portalWindow" window
    And I select "Write Note" from the "Patient Header Actions" menu
    Then the following text should appear in the "Information" pane
      | Cannot create note on this patient while a note is undocked |
    And I click the "OK" button in the "Information" pane
    And I switch the focus to the "popoutWindow" window
    And I pop in note writer
    And I wait "2" seconds
    And I click the "NoteWriterCancelNote" button in the "ClinicalNote" pane
    Then I click the "Yes" button in the "Information" pane
    And I switch the focus to the "portalWindow" window

  Scenario: Note writer does not pop up from Patient Search menu
    And I am on the "Patient Search" tab
    And I enter "Darr" in the "Last" field
    And I enter "Molly" in the "First" field
    And I click the "Search for Visits" button
    And I click the "View Detail" button
    And I wait "3" seconds
    And I click the "AddNotes" button in the "ClinNav" pane
    And I wait "2" seconds
    And the text "Pop Out" should not appear in the "NewNote" pane
    And I click the "Cancel" button in the "NewNote" pane
    And I click the "Close" button in the "Patient Details" pane

  Scenario: Data selection in a note cancel
    And I click the "ClinicalNotes+" button
    And I select "Progress Note" from the select template list
    And I wait up to "3" seconds for the "PopOut" field of type "BUTTONS" in the "Note Writer" pane to be visible
    And I pop out note writer
    And I select the note "Data" section
    And I wait "1" seconds
    And I switch the focus to the "portalWindow" window
    And I select "Allergies" from clinical navigation
    And I uncheck the "Penicillin" checkbox
    And I check the "Penicillin" checkbox
    And I switch the focus to the "popoutWindow" window
    And the following text should appear in the "PopoutForm" pane
      | Allergies  |
      | Penicillin |
    And I click the "Cancel" button in the "Clinical Note Pop Out" pane
    Then I click the "Yes" button in the "Information" pane
    And I switch the focus to the "portalWindow" window
    And I select "Allergies" from clinical navigation
    And I click the "Refresh" button
    Then the following should be unchecked
      | Penicillin |
    And I select "Clinical Notes" from clinical navigation

  Scenario: uncheck does not delete data from popout window
    And I click the "ClinicalNotes+" button
    And I select "Progress Note" from the select template list
    And I wait up to "3" seconds for the "PopOut" field of type "BUTTONS" in the "Note Writer" pane to be visible
    And I pop out note writer
    And I select the note "Data" section
    And I wait "1" seconds
    And I switch the focus to the "portalWindow" window
    And I select "Allergies" from clinical navigation
    And I uncheck the "Penicillin" checkbox
    And I check the "Penicillin" checkbox
    And I uncheck the "Penicillin" checkbox
    And I switch the focus to the "popoutWindow" window
    And the following text should appear in the "PopoutForm" pane
      | Allergies  |
      | Penicillin |
    And I click the "SaveasDraft" button in the "Clinical Note Pop Out" pane
    Then I click the "Yes" button in the "Information" pane
    And I wait "2" seconds
    And I switch the focus to the "portalWindow" window
    And I select "Clinical Notes" from clinical navigation
    And I select "*DRAFT* Progress Note" in the "Notes" table
    And the following text should appear in the "NoteDetails" pane
      | Allergies  |
      | Penicillin |
    And I delete the draft note in the "NoteDetails" pane

  Scenario: QT insert text
    And I click the "ClinicalNotes+" button
    And I select "Progress Note" from the select template list
    And I wait up to "3" seconds for the "PopOut" field of type "BUTTONS" in the "Note Writer" pane to be visible
    And I pop out note writer
    And I select the note "Subjective" section
    And I wait "1" seconds
    And I click the "PatientnarrativeABC" image in the "PopoutForm" pane
    And I click the "test" link in the "PopoutForm" pane
    And I click the "CloseQuickText" button in the "PopoutForm" pane
    Then the following text should appear in the "PopoutForm" pane
      | testing this QT in pkadminv2 |
    And I click the "SaveasDraft" button in the "Clinical Note Pop Out" pane
    Then I click the "Yes" button in the "Information" pane
    And I wait "2" seconds
    And I switch the focus to the "portalWindow" window
    And I select "Clinical Notes" from clinical navigation
    And I select "*DRAFT* Progress Note" in the "Notes" table
    And the following text should appear in the "NoteDetails" pane
      | testing this QT in pkadminv2 |
    And I delete the draft note in the "NoteDetails" pane

  Scenario: Note does not popout when opened fron the note search tab
    And I click the "ClinicalNotes+" button
    And I wait "2" seconds
    And I select "Progress Note" from the select template list
    And I wait "2" seconds
    And I click the "SaveasDraft" button in the "ClinicalNote" pane
    Then I click the "Yes" button in the "Information" pane
    And I am on the "Note Search" tab
    And I select "Draft" from the "PKStatus" dropdown
    And I select "Today" from the "Timeframe" dropdown
    And I enter "kadminv2" in the "Author" field
    And I click the "SearchAuthor" image
    And I enter "Progress Note" in the "TemplateName" field
    And I click the "SearchTemplate" image
    And I click the "Search" button
    And I wait "2" seconds
    And I click the "ViewDetails" image
    And I click the "AddNotes" button in the "ClinNav" pane
    And I wait "2" seconds
    And the text "Pop Out" should not appear in the "NewNote" pane
    And I click the "Cancel" button in the "NewNote" pane
    And I click the "Close" button in the "ClosingOptions" pane
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I select "*DRAFT* Progress Note" in the "Notes" table
    And I delete the draft note in the "NoteDetails" pane

  Scenario: User preference for pop in and out NW window
    And I am on the "Admin" tab
    And I select the "Preferences" subtab
    And I select "NoteWriter" from the "EditPreferencesSettings" dropdown
    Then the following text should appear in the "ContentPane" pane
      | Always Display Note Entry in Pop-Out Mode |
    Then the following fields should display in the "ContentPane" pane
      | Name      | Type  |
      | AutoPopNW | radio |
      | ManPopNW  | radio |
    Then I select the "Bulk User Edit" subtab
    And I wait "2" seconds
    Then the following text should appear in the "PreferenceSettings" pane
      | Always Display Note In Pop-Out Mode |
    Then the following fields should display in the "PreferenceSettings" pane
      | Name           | Type  |
      | AlwaysUndocked | check |

  Scenario: Autosave
    And I click the "ClinicalNotes+" button
    And I select "Progress Note" from the select template list
    And I wait up to "3" seconds for the "PopOut" field of type "BUTTONS" in the "Note Writer" pane to be visible
    And I pop out note writer
    And I select the note "Subjective" section
    And I wait "1" seconds
    And I enter "AutoSaveCheck" in the "PatientNarrativeSubjective" field
    And I wait "75" seconds
    And I close the "popoutWindow" window and switch to the "portalWindow" window
    And I switch the focus to the "portalWindow" window
    And I select "Clinical Notes" from clinical navigation
    And I select "*DRAFT* Progress Note" in the "Notes" table
    And the following text should appear in the "NoteDetails" pane
      | Subjective    |
      | AutoSaveCheck |
    And I delete the draft note in the "NoteDetails" pane