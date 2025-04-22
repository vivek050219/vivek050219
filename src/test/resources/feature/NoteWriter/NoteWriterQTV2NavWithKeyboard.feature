@NoteWriterQTV2
Feature: NoteWriter Quick Text V2 Navigate With Keyboard
  This feature contains scenarios for dev-issue 72756: An enhancement for Baylor to be able to navigate QTs with
  multiple choices with the keyboard.

  Background:
    Given I am logged into the portal with user "nwadminv2" using the default password
    Given I am on the "Patient List V2" tab
    Then I select "qtv2" from the "Patient List" menu
    And "Roy Blazer" is on the patient list
    When I select patient "Roy Blazer" from the patient list


  Scenario: Pre-req - Enable QuickText v2
    Given I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "true" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
    And I select "true" from the "Enable Spell Check" radio list in the "Note Writer Settings" pane
    And I select "None" from the "Validation" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box


  Scenario: Pre-req - Delete Any User and Dept QuickTexts Set Previously
    Given I am on the "Admin" tab
    Then I select the "User" subtab
    When I search for the user "nwadminv2"
    Then I select the user "nwadminv2"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "NoteWriter" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I click the "Quick Text (Summary View)" edit link in the "NoteWriter Settings" pane
    And I wait up to "20" seconds for the "Reset User Pickers" field of type "BUTTON" in the "QuickText Editor Content" pane to be clickable
    And I click the "Reset User Pickers" button
    And I click the "Delete All" button
    When I click the "Close" button in the "QuickText Editor Content" pane
    Then the "NoteWriter Settings" pane should load
    When I select the "Department" subtab
    Then I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Summary View)" edit link in the NoteWriter pane
    And the "Department Quick Text Editor" pane should load
    And I click the "Delete All Pickers" button in the "Department QuickText Editor Content QTV2" pane
    Then I click the "Yes" button in the "Question" pane
    And I click the "Close" button in the "Department QuickText Editor ContentQTV2" pane

  Scenario: Pre-req - Create QuickText V2 With Multiple Choices
#    Given I am on the "Patient List V2" tab
#    Then I select "qtv2" from the "Patient List" menu
#    And "Roy Blazer" is on the patient list
#    When I select patient "Roy Blazer" from the patient list
    Then I click the "Patient narrative ABC QTV2" abc link in the "Subjective" section of the "Progress Note" template
    And I enter "QT Multi Choice" in the "Name QTV2" field
    And I select "false" from the "Is This a Group" radio list
    And I enter "multi" in the "Keyboard Shortcut" field
    And I click the "Insert Select List" element
    When I click the "Select One" list in the rich text field
    Then I enter "Multi Choice List" in the "List Label" field
    Then I enter "Option 1" in the "ListOption" field
    And I wait "2" seconds
    Then I enter "Option 2" in the "ListOption1" field
    And I click the "SaveNw" button in the "Add Quick Text Content" pane
    And I click the "Close" button in the "Add Quick Text" pane
    Then the "Note Writer Main" pane should load
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane
  #   #No. 1
#   #Scenario: ENTER before Selecting a Quick Text
  Scenario: Press Enter After Navigating to QT Selection With the Keyboard
    Then I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    When I enter "multi" in the "Patient Narrative QTV2" rich text field
    And I click the "space" key in the "Patient Narrative QTV2" rich text field
    And I click the "Multi Choice List" list in the rich text field
    And I click the "ARROW_DOWN" key in the "Patient Narrative QTV2" rich text field
    And I click the "ENTER" key in the "Patient Narrative QTV2" rich text field
#    Then the value in the "Patient Narrative QTV2" field should be "Option 1 QT Multi Choice"
    Then The "Patient Narrative QTV2" text field should appear with the text "Option 1 QT Multi Choice" in the "NoteWriter Main" pane
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane

    #   #No. 2
#   #Scenario: AFTER before Selecting a Quick Text
  Scenario: Press Enter After Clicking QT Selection
    Then I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    When I enter "multi" in the "Patient Narrative QTV2" rich text field
    And I click the "space" key in the "Patient Narrative QTV2" rich text field
    And I click the "Multi Choice List" list in the rich text field
    And I select "Option 1" option from the "List Select" list
    And I click the "ENTER" key in the "Patient Narrative QTV2" text field
#    Then the value in the "Patient Narrative QTV2" field should be "Option 1 QT Multi Choice"
    Then I verify if the following text is displayed in multiple lines in the field "Patient Narrative QTV2" in the "NoteWriter Main" pane
      | Option 1       |
      |QT Multi Choice |
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane

    #   #No. 3
#   #Scenario: UP/DOWN before Selecting a Quick Text
  Scenario: Use Up/Down Arrow Keys to Traverse QT Selection List
    Then I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    When I enter "multi" in the "Patient Narrative QTV2" rich text field
    And I click the "space" key in the "Patient Narrative QTV2" rich text field
    And I click the "TAB" key in the "Patient Narrative QTV2" text field
    And I press the "ARROW_DOWN" key "2" times in the "Patient Narrative QTV2" rich text field
    And I click the "ARROW_UP" key in the "Patient Narrative QTV2" text field
    And I click the "ARROW_DOWN" key in the "Patient Narrative QTV2" text field
    And I click the "ENTER" key in the "Patient Narrative QTV2" text field
#    Then the value in the "Patient Narrative QTV2" field should be "Option 2 QT Multi Choice"
    Then The "Patient Narrative QTV2" text field should appear with the text "Option 2 QT Multi Choice" in the "NoteWriter Main" pane
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane

    #   #No. 4
#   #Scenario: UP/DOWN after Selecting a Quick Text
  Scenario: Use Up/Down Arrow Keys After Clicking QT Selection
    Then I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    When I enter "multi" in the "Patient Narrative QTV2" rich text field
    And I click the "space" key in the "Patient Narrative QTV2" rich text field
    And I click the "Multi Choice List" list in the rich text field
    And I select "Option 1" option from the "List Select" list
    And I click the "ARROW_DOWN" key in the "Patient Narrative QTV2" text field
#    Then the value in the "Patient Narrative QTV2" field should be "Option 2 QT Multi Choice"
    Then The "Patient Narrative QTV2" text field should appear with the text "Option 1 QT Multi Choice" in the "NoteWriter Main" pane
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane

    #   #No. 5
#  #Scenario: Force UP/DOWN after Selecting a Quick Text
  Scenario: Use Control + Up/Down Arrow Keys After Clicking QT Selection
    Then I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    When I enter "multi" in the "Patient Narrative QTV2" rich text field
    And I click the "space" key in the "Patient Narrative QTV2" rich text field
    And I click the "Multi Choice List" list in the rich text field
    And I select "Option 1" option from the "List Select" list
    And I click the "SHIFT + TAB" key in the "Patient Narrative QTV2" text field
    And I click the "CONTROL + ARROW_DOWN" key in the "Patient Narrative QTV2" text field
    And I click the "ENTER" key in the "Patient Narrative QTV2" text field
#    Then the value in the "Patient Narrative QTV2" field should be "Option 2 QT Multi Choice"
    Then The "Patient Narrative QTV2" text field should appear with the text "Option 2 QT Multi Choice" in the "NoteWriter Main" pane
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane

    #   #No. 6
#   #Scenario: Forced ENTER after Selecting a Quick Text
  Scenario: Use Control + Enter Keys After Clicking QT Selection
    Then I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    When I enter "multi" in the "Patient Narrative QTV2" rich text field
    And I click the "space" key in the "Patient Narrative QTV2" rich text field
    And I click the "Multi Choice List" list in the rich text field
    And I click the "ARROW_DOWN" key in the "Patient Narrative QTV2" text field
    And I click the "CONTROL + ENTER" key in the "Patient Narrative QTV2" text field
#    Then the value in the "Patient Narrative QTV2" field should be "Option 1 QT Multi Choice"
    Then The "Patient Narrative QTV2" text field should appear with the text "Option 1 QT Multi Choice" in the "NoteWriter Main" pane
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane

    #   #No. 7
#   #Scenario: Trigger QT w/ shortcut > Click List > Click QT option > start typing > press ENTER -- Enter key to enter
#   #new line
  Scenario: Click Quick Text Option, Start Typing, Then Hit Enter Key
    Then I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    When I enter "multi" in the "Patient Narrative QTV2" rich text field
    And I wait "1" second
    And I click the "space" key in the "Patient Narrative QTV2" rich text field
    And I wait "1" second
    And I click the "Multi Choice List" list in the rich text field
    And I wait "1" second
    And I select "Option 1" option from the "List Select" list
    And I wait "1" second
    When I enter "test" in the "Patient Narrative QTV2" rich text field
    And I click the "ENTER" key in the "Patient Narrative QTV2" rich text field
    And I wait "1" second
#    Then the value in the "Patient Narrative QTV2" field should be "Option 1 test#QT Multi Choice"
    Then I verify if the following text is displayed in multiple lines in the field "Patient Narrative QTV2" in the "NoteWriter Main" pane
    |Option 1 test  |
    |               |
    |QT Multi Choice|
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane

#   #No. 8
#   #Scenario: Trigger QT w/ shortcut > Click List > Arrow down to option > hit ENTER (enter key to enter QT) >
#   #start typing > press ENTER -- Enter key to enter new line
  Scenario: Keyboard Navigate to Select Quick Text Option, Start Typing, Then Hit Enter Key
    Then I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    When I enter "multi" in the "Patient Narrative QTV2" rich text field
    And I wait "1" second
    And I click the "space" key in the "Patient Narrative QTV2" rich text field
    And I wait "1" second
    And I click the "Multi Choice List" list in the rich text field
    And I click the "ARROW_DOWN" key in the "Patient Narrative QTV2" text field
    And I click the "ENTER" key in the "Patient Narrative QTV2" text field
    And I wait "1" second
    When I enter "test" in the "Patient Narrative QTV2" rich text field
    And I click the "ENTER" key in the "Patient Narrative QTV2" rich text field
    And I wait "1" second
#    Then the value in the "Patient Narrative QTV2" field should be "Option 1 test#QT Multi Choice"
    Then I verify if the following text is displayed in multiple lines in the field "Patient Narrative QTV2" in the "NoteWriter Main" pane
      |Option 1 test  |
      |               |
      |QT Multi Choice|
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Confirm" button in the "Note Writer Main" pane

  Scenario: Post-req - Disable Quick text V2
    Given I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "false" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
