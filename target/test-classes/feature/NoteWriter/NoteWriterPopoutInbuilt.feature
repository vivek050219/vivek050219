@NoteWriterPopOut
Feature: NoteWriter Auto Pop Out/In

  Background:
    Given I am logged into the portal with user "nwpopout" and password "123"
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list

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

  Scenario: Basic popout popin (Auto popout)
    And I click the "ClinicalNotes+" button
    And I wait "2" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I pop in note writer
    And I wait "2" seconds
    And I switch the focus to the "portalWindow" window
    And I click the "Cancel" button in the "ClinicalNote" pane
#    And I select the "" window

  Scenario: Draft note opens in pop out window if Edit button is clicked
    And I click the "ClinicalNotes+" button
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I enter "Progress Note" in the "Filter" field
    And I click the "Template" element in the "Clinical Note Pop Out" pane
    And I click the "SaveasDraft" button in the "Clinical Note Pop Out" pane
    Then I click the "Yes" button in the "Information" pane
    And I switch the focus to the "portalWindow" window
    And I select "Clinical Notes" from clinical navigation
    And I select "*DRAFT* Progress Note" in the "Notes" table
    And I click the "Edit" button in the "NoteDetails" pane
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I pop in note writer
    And I wait "2" seconds
    And I switch the focus to the "portalWindow" window
    And I click the "Cancel" button in the "ClinicalNote" pane
    And I click the "Yes" button in the "Information" pane
#    And I select "Photos" from clinical navigation
    And I switch the focus to the "portalWindow" window
    And I select "Clinical Notes" from clinical navigation
    And I select "*DRAFT* Progress Note" in the "Notes" table
    And I delete the draft note in the "NoteDetails" pane

  Scenario: Switching tabs after opening a new note
    And I click the "ClinicalNotes+" button
    And I wait "2" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I enter "Progress Note" in the "Filter" field
    And I click the "Template" element
    And I wait "2" seconds
    And I switch the focus to the "portalWindow" window
    And I am on the "Patient Search" tab
    And I am on the "Patient List V2" tab
    And the "ClinicalNote" "Pane" should be visible
    And I click the "Cancel" button in the "ClinicalNote" pane
    And I click the "Yes" button in the "Information" pane
    And I switch the focus to the "portalWindow" window

#  Scenario: Addendum pop out
#    And I select " ProgressNoteHTML5DragAndDrop - with Addendum" in the "Notes" table
#    And I click the "AddAddendum" button
#    And I enter "AddendumTest123" in the "AddendumComments" field in the "PopoutForm" pane
#    And I pop out note writer
#    And I click the "NoteWriterSign/Submit" button in the "Clinical Note Pop Out" pane
#    Then I click the "OK" button in the "SubmitNote" pane
##    And I sign/submit the note
#    And I wait "2" seconds
#    And I switch the focus to the "portalWindow" window
#    And I select "Clinical Notes" from clinical navigation
#    And I select " ProgressNote - with Addendum" in the "Notes" table
#    And the following text should appear in the "NoteDetails" pane
#      | Status        |
#      | Final         |
#      | AddendumTest1 |

  Scenario: Addendum pop out
    And I click the "ClinicalNotes+" button
    And I wait "2" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I enter "Progress Note" in the "Filter" field
    And I click the "Template" element in the "Clinical Note Pop Out" pane
#    And I select "Progress Note" from the select template list
#    And I popout note writer
    And I select the note "A/P" section in the "Clinical Note Pop Out" pane
    And I select "Moderate" from the "LevelOfDecision" dropdown in the "PopoutForm" pane
    And I sign/submit the note
    And I wait "2" seconds
    And I switch the focus to the "portalWindow" window
    And I select " Progress Note" in the "Notes" table
    And I click the "AddAddendum" button
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I enter "AddendumTest1" in the "AddendumComments" field
#    And I popout note writer
    And I click the "NoteWriterSign/Submit" button in the "Clinical Note Pop Out" pane
    Then I click the "OK" button in the "SubmitNote" pane
    And I wait "2" seconds
    And I switch the focus to the "portalWindow" window
    And I select "Clinical Notes" from clinical navigation
    And I select " Progress Note - with Addendum" in the "Notes" table
    And the following text should appear in the "NoteDetails" pane
      | Status        |
      | Final         |
      | AddendumTest1 |