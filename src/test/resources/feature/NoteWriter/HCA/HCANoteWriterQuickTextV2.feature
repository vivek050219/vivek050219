@HCANoteWriterQTV2
Feature: HCA NoteWriter Quick Text V2

  Background:
    Given I am logged into the portal with user "nwlevel3" using the default password
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
    Given I am logged into the portal with user "nwlevel3" using the default password
    When I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "HCA Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    Then I select the note "Subjective" section
    When I click the "PatientnarrativeABCQTV2" element in the "NoteWriter" pane
    And the "ClickToInsertV2" pane should load
    Then the following fields should display in the "ClickToInsertV2" pane
      | Name              | Type   |
      | Manage Quick Text | button |
    When I click the "ManageQuickText" button
    And I wait "2" seconds
    Then the "Add Quick Text" pane should load
    When I click the "Close" button in the "Add Quick Text" pane
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Yes" button

  Scenario: Pre-requisite step
    Given I am logged into the portal with user "nwadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    When I search for the user "nwlevel3"
    And I select the user "nwlevel3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "NoteWriter" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I click the "Quick Text (Summary View)" edit link in the "NoteWriterSettings" pane
    And I wait up to "20" seconds for the "ResetUserPickers" field of type "BUTTON" to be clickable
    And I click the "ResetUserPickers" button
    And I click the "DeleteAll" button
    And I click the "Close" button in the "QuickTextEditorContent" pane
    And I wait "5" seconds
    Then the "NoteWriterSettings" pane should load
    And I select the "Department" subtab
    When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Summary View)" edit link in the NoteWriter pane
		#And I wait "3" seconds
    Then the "Department Quick Text Editor" pane should load
		#And I wait "3" seconds
    And I click the "Delete All Pickers" button in the "DepartmentQuickTextEditorContentQTV2" pane
    And I click the "Yes" button in the "Question" pane

  Scenario:Verify Keyboard shortcut are case-sensitive[Dev-57039]
    Given I am logged into the portal with user "nwlevel3" using the default password
    And I am on the "Patient List V2" tab
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I enter "ShortcutTest" in the "NameQTV2" field
    And I enter "sct" in the "Keyboard Shortcut" field
    And I click the "SaveNw" button in the "Add Quick Text Content" pane
    Then the text "ShortcutTest" should appear in the "AddQuickTextV2left" pane
    When I click the "Close" button in the "Add Quick Text" pane
    Then the "Note Writer" pane should load
    When I enter "sct" in the "PatientNarrativeQTV2" rich text field
    And I click the "space" key in the "PatientNarrativeQTV2" rich text field
    Then the text "ShortcutTest" should appear in the "NoteWriter" pane
    When I enter "SCT" in the "PatientNarrativeQTV2" rich text field
    And I click the "enter" key in the "PatientNarrativeQTV2" rich text field
    Then the text "ShortcutTest" should appear in the "NoteWriter" pane
    When I enter "ScT" in the "PatientNarrativeQTV2" rich text field
    And I click the "enter" key in the "PatientNarrativeQTV2" rich text field
    Then the text "ShortcutTest" should appear in the "NoteWriter" pane
    And I sign/submit the "HCA Progress Note" note

  Scenario:Verify quicktext is trigger, tab will bring user to the first smart tag[Dev-66639]
    Given I am logged into the portal with user "nwlevel3" using the default password
    And I am on the "Patient List V2" tab
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I enter "Tab selection test" in the "NameQTV2" field
    And I enter "tst" in the "Keyboard Shortcut" field
    And I click the "Insert Free Text" element
    And I click the "Insert Select List" element
    Then I click the "Select One" list in the rich text field
    And I enter "List" in the "ListLabel" field
    And I enter "Option 1" in the "ListOption" field
		#And I wait "2" seconds
    And I enter "Option 2" in the "ListOption1" field
    And I click the "SaveNw" button in the "Add Quick Text Content" pane
    When I click the "Close" button in the "Add Quick Text" pane
    Then the "Note Writer" pane should load
    When I enter "tst" in the "PatientNarrativeQTV2" rich text field
    And I click the "space" key in the "PatientNarrativeQTV2" rich text field
    And I click the "TAB" key in the "PatientNarrativeQTV2" rich text field
    And I verify "Insert Text" is selected
    And I click the "TAB" key in the "PatientNarrativeQTV2" rich text field
    When I click the "Insert Text" textbox in the rich text field
    And I enter "Free text without label" in the "Free Text" free text field in the "Note Writer" pane
    And I click the "List" list in the rich text field
    And I select "Option 1" option from the "ListSelect" list
    And I sign/submit the "HCA Progress Note" note

  Scenario: Verify the contents of Add Quick Text Page
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    Then the following fields should display in the "Add Quick Text Content" pane
      | Name               | Type    |
      | NameQTV2           | text    |
      | Is This a Group    | radio   |
      | Keyboard Shortcut  | text    |
      | DefaultQTV2        | check   |
      | Hide From Popup    | check   |
      | Bold               | element |
      | Italic             | element |
			#numbered list is removed from 8.4.2 onwards as per DEV-77181
#			|Numbered List      |element |
      | Bullet List        | element |
      | Insert Free Text   | element |
      | Insert Select List | element |
      | WikiSource         | element |
      | Information Icon   | element |
      | SaveNw             | button  |
      | DeleteNw           | button  |
    And the following fields should display in the "Add Quick Text" pane
      | Name  | Type   |
      | Close | button |
    When I click the "Close" button in the "Add Quick Text" pane
    And I sign/submit the "HCA Progress Note" note

      #adding prerequisite scenario to delete quick texts created in above scenarios
  Scenario: Pre-requisite step to delete user quick texts
    Given I am logged into the portal with user "nwadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    When I search for the user "nwlevel3"
    And I select the user "nwlevel3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "NoteWriter" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I click the "Quick Text (Summary View)" edit link in the "NoteWriterSettings" pane
    And I wait up to "20" seconds for the "ResetUserPickers" field of type "BUTTON" to be clickable
    And I click the "ResetUserPickers" button
    And I click the "DeleteAll" button
    And I click the "Close" button in the "QuickTextEditorContent" pane
    Then the "NoteWriterSettings" pane should load

  Scenario: Add a Quick Text and Group
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
#		And I enter "Group QTV2" in the "NameQTV2 " field
    And I select "true" from the "IsThisaGroup" radio list
    Then the following fields should display in the "Add Quick Text Content" pane
      | Name     | Type   |
      | NameQTV2 | text   |
      | SaveNw   | button |
      | DeleteNw | button |
    When I enter "Group QTV2" in the "NameQTV2 " field
		#And I click the "SaveNw" button in the "Add Quick Text Content" pane
    And I mouse over and click the "SaveNw" button in the "Add Quick Text Content" pane
    And the "Group QTV2" group should be saved
    Then the text "Group QTV2" should appear in the "AddQuickTextV2left" pane
	  #Work around for Dev 56483 issue
#		When I click the "Close" button in the "Add Quick Text" pane
#		When I click the "PatientnarrativeABCQTV2" element in the "NoteWriter" pane
#		And the "ClickToInsertV2" pane should load
#		And I click the "ManageQuickText" button
    And I enter "Group QTV1" in the "NameQTV2 " field
    And I select "true" from the "IsThisaGroup" radio list
	#	And I click the "SaveNw" button in the "Add Quick Text Content" pane
    And I mouse over and click the "SaveNw" button in the "Add Quick Text Content" pane
    And the "Group QTV1" group should be saved
    Then the text "Group QTV1" should appear in the "AddQuickTextV2left" pane
    When I enter "Quick Text V2" in the "NameQTV2 " field
    And I enter "QTV2" in the "Keyboard Shortcut" field
    And I click the "SaveNw" button in the "Add Quick Text Content" pane
    Then the text "Quick Text V2" should appear in the "AddQuickTextV2left" pane
    And the following fields should display in the "AddQuickTextV2left" pane
      | Name | Type    |
      | Sort | element |
    When I click the "Close" button in the "Add Quick Text" pane
    When I click the "PatientnarrativeABCQTV2" element in the "NoteWriter" pane
    Then the following text should appear in the "ClickToInsertV2" pane
      | Group QTV2 |
      | Group QTV1 |
    When I click the "GroupPlusIcon" element in the "ClickToInsertV2" pane
    Then the following text should appear in the "ClickToInsertV2" pane
      | Quick Text V2 |
    And I sign/submit the "HCA Progress Note" note

  Scenario: Modification and Deletion of Group
    When "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    And I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I click the "QuickTextGroup" element in the "AddQuickTextV2left" pane
    Then the following fields should display in the "AddQuickTextV2left" pane
      | Name        | Type    |
      | DeleteGroup | element |
    When I click the "DeleteGroup" element in the "AddQuickTextV2left" pane
    And I click the "Delete Highlighted Groups" button in the "Delete Quick Text Group" pane
    Then the "AddQuickTextV2left" pane should load
#		And I click the "QuickTextGroup" element in the "AddQuickTextV2left" pane
#		When I click the "DeleteGroup" element in the "AddQuickTextV2left" pane
#		And I click the "Delete Highlighted Groups" button in the "Delete Quick Text Group" pane
    And I click the "Close" button in the "Add Quick Text" pane
    When I click the "PatientnarrativeABCQTV2" element in the "NoteWriter" pane
    Then the text "Group QTV2" should not appear in the "ClickToInsertV2" pane
    And I click the "ManageQuickText" button
    And the text "Group QTV2" should not appear in the "AddQuickTextV2left" pane
    When I click the "QuickTextGroup" element in the "AddQuickTextV2left" pane
    And I enter "Edit Quick Text V2" in the "QuickTextGroup" field
    And I click the "Bold" element in the "Add Quick Text Content" pane
    Then the text "Edit Quick Text V2" should appear in the "AddQuickTextV2left" pane
    When I click the "Close" button in the "Add Quick Text" pane
    When I click the "PatientnarrativeABCQTV2" element in the "NoteWriter" pane
    Then the text "Edit Quick Text V2" should appear in the "ClickToInsertV2" pane
    When I click the "ManageQuickText" button
    And I click the "QuickTextGroup" element in the "AddQuickTextV2left" pane
    And I enter "Group1" in the "QuickTextGroup" field
    And I click the "Bold" element in the "Add Quick Text Content" pane
    Then the text "Group1" should appear in the "AddQuickTextV2left" pane
    And I click the "Close" button in the "Add Quick Text" pane
    And I sign/submit the "HCA Progress Note" note

  Scenario: Verify the Keyboard Shortcut
    Given "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I enter "PaulWalker" in the "NameQTV2" field
    And I enter "PW" in the "Keyboard Shortcut" field
    And I click the "SaveNw" button in the "Add Quick Text Content" pane
    Then the text "PaulWalker" should appear in the "AddQuickTextV2left" pane
    When I click the "Close" button in the "Add Quick Text" pane
    Then the "Note Writer" pane should load
    When I enter "PW" in the "PatientNarrativeQTV2" rich text field
    And I click the "space" key in the "PatientNarrativeQTV2" rich text field
    And I click the "enter" key in the "PatientNarrativeQTV2" rich text field
    Then the following text should appear in the "PatientNarrativeQTV2" pane
      | Name       | Type |
      | PaulWalker | text |
    And I sign/submit the "HCA Progress Note" note

  Scenario: Drag and Drop the quick text from one Group to another Group
    Given "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I enter "Group2" in the "NameQTV2" field
    And I select "true" from the "IsThisaGroup" radio list
        #And I click the "SaveNw" button in the "Add Quick Text Content" pane
    And I mouse over and click the "SaveNw" button in the "Add Quick Text Content" pane
    And the "Group2" group should be saved
    Then the text "Group2" should appear in the "AddQuickTextV2left" pane
    When I enter "Quick Text DD" in the "NameQTV2" field
    And I enter "DD" in the "Keyboard Shortcut" field
    And I click the "SaveNw" button in the "Add Quick Text Content" pane
    And I click the "PaulWalker" quicktext in the "AddQuickTextV2left" pane
    When I click the "Close" button in the "Add Quick Text" pane
    When I click the "PatientnarrativeABCQTV2" element in the "NoteWriter" pane
    Then the following text should appear in the "ClickToInsertV2" pane
      | Group1 |
      | Group2 |
    When I click the "GroupPlusIcon" element in the "ClickToInsertV2" pane
    Then the following text should appear in the "ClickToInsertV2" pane
      | Quick Text DD |
    And I sign/submit the "HCA Progress Note" note

  Scenario: Default Hide From Popup
    Given "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I enter "QuickText1" in the "NameQTV2 " field
    And I enter "QT1" in the "Keyboard Shortcut" field
    And I clear the "QTV2Description" rich text field
    And I enter "Text1" in the "QTV2Description" rich text field
    And I click the "SaveNw" button in the "Add Quick Text Content" pane
    Then the text "QuickText1" should appear in the "AddQuickTextV2left" pane
    And I enter "QuickText2" in the "NameQTV2 " field
    And I enter "QT2" in the "Keyboard Shortcut" field
    And I clear the "QTV2Description" rich text field
    And I enter "Text2" in the "QTV2Description" rich text field
    And I click the "SaveNw" button in the "Add Quick Text Content" pane
    Then the text "QuickText2" should appear in the "AddQuickTextV2left" pane
    When I click the "QuickText2" quicktext in the "AddQuickTextV2left" pane
    Then the text "Not Set" should appear in the "AddQuickTextV2Right" pane
    When I check the "DefaultQTV2" checkbox
    And I click the "SaveNw" button in the "Add Quick Text Content" pane
    Then the text "QuickText2" should appear in the "AddQuickTextV2Right" pane
    When I click the "QuickText1" quicktext in the "AddQuickTextV2left" pane
    And I check the "DefaultQTV2" checkbox
    And I click the "SaveNw" button in the "Add Quick Text Content" pane
    Then the text "QuickText1" should appear in the "AddQuickTextV2Right" pane
    When I click the "QuickText2" quicktext in the "AddQuickTextV2left" pane
    And I click the "QuickText1" link in the "AddQuickTextV2Right" pane
    Then the following text should appear in the "AddQuickTextV2Right" pane
      | QuickText1 |
    When I click the "Close" button in the "Add Quick Text" pane
    When I click the "PatientnarrativeABCQTV2" element in the "NoteWriter" pane
    Then the following text should appear in the "ClickToInsertV2" pane
      | QuickText1 |
      | QuickText2 |
    When I click the "ManageQuickText" button
    And I wait "3" seconds
    And I click the "QuickText1" quicktext in the "AddQuickTextV2left" pane
    And I check the "Hide From Popup" checkbox
    And I click the "SaveNw" button in the "Add Quick Text Content" pane
    And I click the "Close" button in the "Add Quick Text" pane
    When I click the "PatientnarrativeABCQTV2" element in the "NoteWriter" pane
    Then the text "QuickText1" should not appear in the "ClickToInsertV2" pane
    And I sign/submit the "HCA Progress Note" note

  Scenario: Verify deletion of a Quick Text
    Given "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
	    #And I wait "2" seconds
    Then the "AddQuickTextV2left" pane should load
    And I wait "2" seconds
    And I click the "QuickText1" quicktext in the "AddQuickTextV2left" pane
    And I clear the "QTV2Description" rich text field
    And I click the "DeleteNw" button in the "AddQuickTextV2left" pane
    And I click the "Yes" button in the "Question" pane
    And I click the "Close" button in the "Add Quick Text" pane
    When I click the "PatientnarrativeABCQTV2" element in the "NoteWriter" pane
    And I click the "ManageQuickText" button
    Then the "AddQuickTextV2left" pane should load
    And I wait "2" seconds
    When I click the "QuickText2" quicktext in the "AddQuickTextV2left" pane
    And I wait "2" seconds
    And I clear the "QTV2Description" rich text field
    And I click the "DeleteNw" button in the "AddQuickTextV2left" pane
    And I click the "Yes" button in the "Question" pane
    And I click the "Close" button in the "Add Quick Text" pane
    When I click the "PatientnarrativeABCQTV2" element in the "NoteWriter" pane
    And I click the "ManageQuickText" button
    And I wait "2" seconds
    Then Text exact "QuickText2" should not appear in the "ManageQuickText" section in the "AddQuickTextV2left" pane
    And I click the "Close" button in the "Add Quick Text" pane
    When I click the "PatientnarrativeABCQTV2" element in the "NoteWriter" pane
    And I wait "2" seconds
    And I click the "ManageQuickText" button
    Then Text exact "QuickText1" should not appear in the "ManageQuickText" section in the "AddQuickTextV2left" pane
    When I click the "Close" button in the "Add Quick Text" pane
    When I click the "PatientnarrativeABCQTV2" element in the "NoteWriter" pane
    Then the text "QuickText2" should not appear in the "Subjective" section in the "ClickToInsertV2" pane
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Yes" button

  Scenario: Insert and Edit Free Rich Text Markup without label and Verify in Note Detail page
    Given "HELEN BAMBERGER" is on the patient list
    And I select patient "HELEN BAMBERGER" from the patient list
    When I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I enter "Quick Text 1" in the "NameQTV2" field
    And I enter "qt1" in the "Keyboard Shortcut" field
    And I click the "Insert Free Text" element
    And I click the "SaveNw" button in the "Add Quick Text Content" pane
    And I click the "Close" button in the "AddQuickText" pane
    Then the "Note Writer" pane should load
    When I enter "qt1" in the "PatientNarrativeQTV2" rich text field
    And I click the "space" key in the "PatientNarrativeQTV2" rich text field
    Then the text "Insert Text" should appear in the "PatientNarrativeQTV2" pane
    And the underlined color of the text should be red before editing
    When I click the "Insert Text" textbox in the rich text field
    And I enter "Free text without label" in the "Free Text" free text field in the "PatientNarrativeQTV2" pane
    Then the underlined color of the text should be blue on editing
    When I click the "PatientnarrativeABCQTV2" element in the "NoteWriter" pane
    And I click the "ManageQuickText" button
    And I wait "2" seconds
    And I click the "Quick Text 1" quicktext in the "AddQuickTextV2left" pane
    Then I click the "Insert Text" textbox in the rich text field
    And I enter "New Label" in the "Insert Text" free text field in the "QTV2Description" pane
    And I click the "SaveNw" button
    And I click the "Close" button in the "AddQuickText" pane
    And the "Note Writer" pane should load
    When I enter "New text" in the "PatientNarrativeQTV2" rich text field
    And I click the "enter" key in the "PatientNarrativeQTV2" rich text field
    When I enter "qt1" in the "PatientNarrativeQTV2" rich text field
    And I click the "space" key in the "PatientNarrativeQTV2" rich text field
    And the underlined color of the text should be red before editing
    And I click the "New Label" textbox in the rich text field
    And I enter "This is after editing the Free Text tag name" in the "Free Text" free text field in the "PatientNarrativeQTV2" pane
    Then the underlined color of the text should be blue on editing
    And I sign/submit the "HCA Progress Note" note
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the following text should appear in the "NoteWriterContentDiv" pane
      | Free text without label                      |
      | This is after editing the Free Text tag name |

  Scenario: Insert Free Rich Text Markup with label
    Given "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    When I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I wait "2" seconds
    And I enter "Quick Text 2" in the "NameQTV2" field
    And I enter "qt2" in the "Keyboard Shortcut" field
    And I click the "Insert Free Text" element
    Then I click the "Insert Text" textbox in the rich text field
    And I enter "Labeled" in the "Insert Text" free text field in the "QTV2Description" pane
    And I click the "SaveNw" button
    And I click the "Close" button in the "AddQuickText" pane
    Then the "Note Writer" pane should load
    When I enter "qt2" in the "PatientNarrativeQTV2" rich text field
    And I click the "space" key in the "PatientNarrativeQTV2" rich text field
    Then the underlined color of the text should be red before editing
    When I click the "Labeled" textbox in the rich text field
    And I enter "Free text with label" in the "Free Text" free text field in the "PatientNarrativeQTV2" pane
    Then the underlined color of the text should be blue on editing
    And I sign/submit the "HCA Progress Note" note

  Scenario: Select List Rich Text Markup[DEV-56445]
    Given "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    When I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I enter "Quick Text 3" in the "NameQTV2" field
    And I enter "qt3" in the "Keyboard Shortcut" field
    And I click the "Insert Select List" element
    Then I click the "Select One" list in the rich text field
    And I enter "List" in the "ListLabel" field
    And I enter "Option 1" in the "ListOption" field
    And I wait "2" seconds
    And I enter "Option 2" in the "ListOption1" field
    And I click the "SaveNw" button
    And I click the "Close" button in the "AddQuickText" pane
    Then the "Note Writer" pane should load
    And I wait "2" seconds
    When I enter "qt3" in the "PatientNarrativeQTV2" rich text field
    And I click the "space" key in the "PatientNarrativeQTV2" rich text field
    Then the underlined color of the list should be red before editing
    And I click the "List" list in the rich text field
    And I select "Option 1" option from the "ListSelect" list
    And the underlined color of the list should be blue on editing
    And I sign/submit the "HCA Progress Note" note

  Scenario: Create Select List with only one option
    Given "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    When I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I enter "Quick Text 3" in the "NameQTV2" field
    And I enter "qt3" in the "Keyboard Shortcut" field
    And I click the "Insert Free Text" element
    And I click the "Wiki Source" element
    Then the text "######[[Insert Text]]######" should appear in the "QTV2Description" pane
    And I enter "###[[List]]{Option 1}{Option 2}###" in the "QTV2Description" rich text field
    And I click the "Wiki Source" element
    When I click the "List" list in the rich text field
    Then the text "Option 2" should appear in the "QTV2Description" pane
    When I click the "Close" button in the "AddQuickText" pane
    And the "Note Writer" pane should load
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Yes" button

  Scenario: Verify the Tag Conversion
    Given "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    When I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I enter "Quick Text 4" in the "NameQTV2" field
    And I enter "qt4" in the "Keyboard Shortcut" field
    And I click the "Insert Free Text" element
    And I click the "Wiki Source" element
    Then the text "######[[Insert Text]]######" should appear in the "QTV2Description" pane
    And I enter "###[[List]]{Option 1}{Option 2}###" in the "QTV2Description" rich text field
    And I click the "Wiki Source" element
    When I click the "List" list in the rich text field
    Then the text "Option 2" should appear in the "QTV2Description" pane
    When I click the "Close" button in the "AddQuickText" pane
    And the "Note Writer" pane should load
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Yes" button

  Scenario: Verify the Free text and List in Note detail field
    Given "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    When I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I enter "Quick Text 5" in the "NameQTV2" field
    And I enter "qt5" in the "Keyboard Shortcut" field
    And I enter "######[[Labeled]]######" in the "QTV2Description" rich text field
    And I enter "###[[]]{1}{2}###" in the "QTV2Description" rich text field
    And I click the "SaveNw" button
    And I click the "Close" button in the "AddQuickText" pane
    Then the "Note Writer" pane should load
    And I enter "qt5" in the "PatientNarrativeQTV2" rich text field
    And I click the "enter" key in the "PatientNarrativeQTV2" rich text field
    When I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    Then the text "The red Quick Texts in the following fields must be completed: Patient Narrative" should appear in the "WarningList" pane
    And I click the "OK" button in the "WarningList" pane
    And the underlined color of the list should be red before editing
    And the underlined color of the text should be red before editing
    And I click the "Select One" list in the rich text field
    And I select "2" option from the "ListSelect" list
    When I click the "Labeled" textbox in the rich text field
    And I enter "Free text with label" in the "Free Text" free text field in the "PatientNarrativeQTV2" pane
    Then the underlined color of the list should be blue on editing
    And the underlined color of the text should be blue on editing
    And I sign/submit the "HCA Progress Note" note
    And I select "Clinical Notes" from clinical navigation
    And I wait "3" seconds
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the following text should appear in the "NoteWriterContentDiv" pane
      | Free text with label |
      | 2                    |

  Scenario: Verify the modification of text and list fields using Wiki Tags
    Given "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    When I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I wait "3" seconds
    And I click the "Quick Text 5" quicktext in the "AddQuickTextV2left" pane
    And I click the "Wiki Source" element
        #Commenting the replace text step as there is no complete Javascript support for IE-11
		#Then I replace the text "Labeled" with the text "New Label" in the "QTV2..Description" pane
    And I click the "Wiki Source" element
    And I click the "SaveNw" button
    And I click the "Close" button in the "AddQuickText" pane
    Then the "Note Writer" pane should load
    When I enter "qt5" in the "PatientNarrativeQTV2" rich text field
    And I click the "enter" key in the "PatientNarrativeQTV2" rich text field
    Then the following text should appear in the "PatientNarrativeQTV2" pane
      | Select One |
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Yes" button

  Scenario: Verify the text in the Description field
    Given "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    When I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I wait "3" seconds
    And I enter "Quick Text 5" in the "NameQTV2" field
    And I enter "qt5" in the "Keyboard Shortcut" field
    Then I verify if the text is bold
    And I verify if the text is italics
#		And I verify if the text is numbered list
    And I verify if the text is bullet list
    And I click the "Close" button in the "Add Quick Text" pane
    And I sign/submit the "HCA Progress Note" note

  Scenario: Verify Wiki Source page
    Given "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    When I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I click the "Wiki Source" element
    And I enter "######" in the "QTV2Description" rich text field
    And I enter "######[[Labeled]]######" in the "QTV2Description" rich text field
    And I enter "###[[]]1,2###" in the "QTV2Description" rich text field
    And I enter "###[[List 1]]{3}{4}###" in the "QTV2Description" rich text field
    And I enter "###[[List 2]]5,6###" in the "QTV2Description" rich text field
    And I click the "Wiki Source" element
    Then the following text should appear in the "QTV2Description" pane
      | Insert Text |
      | Labeled     |
      | Select One  |
      | List 1      |
      | List 2      |
    And I click the "Close" button in the "Add Quick Text" pane
    And I sign/submit the "HCA Progress Note" note

  Scenario: Edit Keyboard Shortcut
    Given "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    When I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I enter "Internet Explorer" in the "NameQTV2" field
    And I enter "IE" in the "Keyboard Shortcut" field
    And I click the "SaveNw" button
    Then the text "Internet Explorer" should appear in the "AddQuickTextV2left" pane
    When I click the "Close" button in the "Add Quick Text" pane
    When I enter "IE" in the "PatientNarrativeQTV2" rich text field
    And I click the "space" key in the "PatientNarrativeQTV2" rich text field
    Then the text "Internet Explorer" should appear in the "NoteWriter" pane
    When I click the "PatientnarrativeABCQTV2" element in the "NoteWriter" pane
    And I click the "ManageQuickText" button
    And I wait "2" seconds
    And I click the "Internet Explorer" quicktext in the "AddQuickTextV2left" pane
    And I enter "IE9" in the "Keyboard Shortcut" field
    And I click the "SaveNw" button in the "Add Quick Text Content" pane
    When I click the "Close" button in the "Add Quick Text" pane
    When I enter "IE9" in the "PatientNarrativeQTV2" rich text field
    And I click the "space" key in the "PatientNarrativeQTV2" rich text field
    Then the text "Internet Explorer" should appear in the "NoteWriter" pane
    And I sign/submit the "HCA Progress Note" note

  Scenario: Verify contents of Add Quick Text Page of Advancedmode
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I wait "3" seconds
#		And I click the "NotationABCQTV2" abc link in the "Notation" section of the "Chart Notation AM" template
    When I load the "HCA Progress Note" template note for the selected patient
    Then I select the note "Subjective" section
    And I click the "PatientnarrativeABCQTV2" element in the "NoteWriter" pane
    And the "ClickToInsertV2" pane should load
    And I mouse over and click the "ManageQuickText" button in the "ClickToInsertV2" pane
    And I wait "2" seconds
    Then the following fields should display in the "Add Quick Text Content" pane
      | Name               | Type    |
      | NameQTV2           | text    |
      | Is This a Group    | radio   |
      | Keyboard Shortcut  | text    |
      | DefaultQTV2        | check   |
      | Hide From Popup    | check   |
      | Bold               | element |
      | Italic             | element |
#			|Numbered List      |element |
      | Bullet List        | element |
      | Insert Free Text   | element |
      | Insert Select List | element |
      | WikiSource         | element |
      | Information Icon   | element |
      | SaveNw             | button  |
      | DeleteNw           | button  |
    And the following fields should display in the "Add Quick Text" pane
      | Name  | Type   |
      | Close | button |
    And I click the "Close" button in the "Add Quick Text" pane
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Yes" button

  Scenario: Keyboard Shortcut in Advanced Mode template
    Given "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
#		And I click the "NotationABCQTV2" abc link in the "Notation" section of the "Chart Notation AM" template
    And I wait "2" seconds
    When I load the "HCA Progress Note" template note for the selected patient
    Then I select the note "Subjective" section
    And I click the "PatientnarrativeABCQTV2" element in the "NoteWriter" pane
    And the "ClickToInsertV2" pane should load
    And I mouse over and click the "ManageQuickText" button in the "ClickToInsertV2" pane
    And I wait "2" seconds
    And I enter "Patient Keeper" in the "NameQTV2" field
    And I enter "PK" in the "Keyboard Shortcut" field
    And I click the "SaveNw" button
    Then the text "Patient Keeper" should appear in the "AddQuickTextV2left" pane
    When I click the "Close" button in the "Add Quick Text" pane
    When I enter "PK" in the "PatientNarrativeQTV2" rich text field
    And I click the "space" key in the "PatientNarrativeQTV2" rich text field
    Then the text "Patient Keeper" should appear in the "NoteWriter" pane
    And I wait "2" seconds
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Yes" button

  Scenario: Sort the Quick Texts
    Given "Mona Angeline" is on the patient list
    And I select patient "Mona Angeline" from the patient list
    When I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I wait "2" seconds
    And I add the following quick texts
      | Name         | Shortcut |
      | A quick text | aq       |
      | B quick text | bq       |
      | C quick text | cq       |
      | D quick text | dq       |
    And I click the "Sort" element
    And I wait "2" seconds
    When I click the "Close" button in the "Add Quick Text" pane
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Yes" button

  Scenario: Verify the quick text order of creation
    Given "Mona Angeline" is on the patient list
    And I select patient "Molly Darr" from the patient list
    When I load the "HCA Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    Then I select the note "Subjective" section
    And I click the "PatientnarrativeABCQTV2" element in the "NoteWriter" pane
    And the "ClickToInsertV2" pane should load
    And I click the "GroupPlusIcon" element in the "ClickToInsertV2" pane
    And I verify the newly created "A quick text" quick text is first in the click to insert list
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Yes" button

  Scenario: Verify duplicate quick text warning
    Given "Mona Angeline" is on the patient list
    And I select patient "Mona Angeline" from the patient list
    When I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I enter "A quick text" in the "NameQTV2" field
    And I enter "aq" in the "Keyboard Shortcut" field
    And I click the "SaveNw" button
    Then the text "The following shortcuts are duplicate on the department or user level: aq" should appear in the "WarningQT" pane
    And I click the "WarningOK" button in the "WarningQT" pane
    And I click the "Close" button in the "AddQuickText" pane
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Yes" button

  Scenario: Verify quick text gets highlighted after creating
    Given "Mona Angeline" is on the patient list
    And I select patient "Mona Angeline" from the patient list
    When I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I enter "E quick text" in the "NameQTV2" field
    And I enter "eq" in the "Keyboard Shortcut" field
    And I click the "SaveNw" button
    Then the "E quick text" quicktext should be saved
    Then the text "E quick text" should appear in the "AddQuickTextV2left" pane
    And I click the "Close" button in the "AddQuickText" pane
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Yes" button

  Scenario: Verify Formated Text in Normal Mode
    Given "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    When I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I enter "Quick text style" in the "NameQTV2" field
    And I enter "qts" in the "Keyboard Shortcut" field
    And I click the "Bold" element
    And I enter "This text is bold" in the "QTV2Description" rich text field
    And I click the "Bold" element
    And I click the "Italic" element
    And I enter "This text is italics" in the "QTV2Description" rich text field
    And I click the "Italic" element
    And I click the "SaveNw" button
    Then I click the "Close" button in the "AddQuickText" pane
    When I enter "qts" in the "PatientNarrativeQTV2" rich text field
    And I click the "enter" key in the "PatientNarrativeQTV2" rich text field
    Then I sign/submit the "HCA Progress Note" note
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I wait "2" seconds
    Then I verify the text "This text is bold" is bold in advanced mode
    And I verify the text "This text is italics" is italic in advanced mode

  Scenario: Verify Numbered and Bulleted list in Normal Mode
    Given "Mona Angeline" is on the patient list
    And I select patient "Mona Angeline" from the patient list
    When I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I enter "Quick text list" in the "NameQTV2" field
    And I enter "qtl" in the "Keyboard Shortcut" field
        #Numbered lists are not supported 8.4.2 onwards
#		And I click the "Numbered List" element
#		And I enter "This text is numbered" in the "QTV2Description" rich text field
#		And I click the "Numbered List" element
    And I click the "Bullet List" element
    And I enter "This text is bulleted" in the "QTV2Description" rich text field
    And I click the "SaveNw" button
    Then I click the "Close" button in the "AddQuickText" pane
    When I enter "qtl" in the "PatientNarrativeQTV2" rich text field
    And I click the "enter" key in the "PatientNarrativeQTV2" rich text field
    Then I sign/submit the "HCA Progress Note" note
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
#		Then I verify the text "This text is numbered" is numbered in advanced mode
    And I verify the text "This text is bulleted" is bulleted in advanced mode

  Scenario: Verify Formated Text in Advanced Mode
    Given "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    When I load the "HCA Progress Note" template note for the selected patient
    Then I select the note "Subjective" section
    And I click the "PatientNarrative Bold" element in the "NoteWriter" pane
    And I enter "This text is bold" in the "PatientNarrativeQTV2" rich text field
    And I click the "PatientNarrative Bold" element in the "NoteWriter" pane
    And I click the "PatientNarrative Italic" element in the "NoteWriter" pane
    And I enter "This text is italics" in the "PatientNarrativeQTV2" rich text field
    And I click the "Italic" element in the "NoteWriter" pane
    Then I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I wait "2" seconds
    And I click the "OK" button in the "NoteWriterWizard" pane
    And I wait "2" seconds
    When I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then I verify the text "This text is bold" is bold in advanced mode
    And I verify the text "This text is italics" is italic in advanced mode

  Scenario: Verify Numbered and Bulleted list in Advanced Mode
    Given "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    When I load the "HCA Progress Note" template note for the selected patient
    Then I select the note "Subjective" section
    And I wait "2" seconds
         #Numbered lists are not supported 8.4.2 onwards
#		And I click the "NumberedListChartAM" element in the "NoteWriter" pane
#		And I enter "This text is numbered" in the "NotationQTV2" rich text field
#		And I click the "NumberedListChartAM" element in the "NoteWriter" pane
    And I click the "PatientNarrative BulletedList" element in the "NoteWriter" pane
    And I enter "This text is bulleted" in the "PatientNarrativeQTV2" rich text field
    Then I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I wait "2" seconds
    And I click the "OK" button in the "NoteWriterWizard" pane
    When I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
#		Then I verify the text "This text is numbered" is numbered in advanced mode
    And I verify the text "This text is bulleted" is bulleted in advanced mode

  Scenario: Verify Tool tip
    Given "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    When I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
    And I wait "2" seconds
    And I move the mouse over the "wiki_info_icon" image in the "AddQuickTextV2Right" pane
    And I verify the tool tip image "wiki_info_icon" in the "AddQuickTextV2Right" pane
    And I move the mouse over the "Quick Text DD" text in the "AddQuickTextV2left" pane
    And I verify the tool tip text "Shortcut: DD Text: Quick Text DD" for quicktext "Quick Text DD" in the "AddQuickTextV2left" pane
    Then I click the "Close" button in the "AddQuickText" pane
    And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
    Then I click the "Yes" button

#	Scenario: Disable Quick text V2
#		Given I am logged into the portal with user "nwadminv2" using the default password
#		And I am on the "Admin" tab
#		And I select the "Institution" subtab
#		And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
#		And I wait "2" seconds
#		And I select "false" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
#		And I select "false" from the "Enable Spell Check" radio list in the "Note Writer Settings" pane
#		And I click the "Save" button
#		And I click "OK" in the confirmation box
#		Given I am logged into the portal with user "nwlevel3" using the default password
#		And I am on the "Patient List V2" tab
#		And "Molly Darr" is on the patient list
#		And I select patient "Molly Darr" from the patient list
#		When I click the "PatientnarrativeABCQTV2" abc link in the "Subjective" section of the "HCA Progress Note" template
#		Then the following text should appear in the "AddQuickText" pane
#			|Add   |
#			|Edit  |
#			|Close |
#		And the text "Manage Quick Text" should not appear in the "ClickToInsert" pane
#         When I click the "Close" button in the "Add Quick Text" pane
#		And I click the "NoteWriterCancelNote" button in the "Note Writer Main" pane
#		Then I click the "Yes" button