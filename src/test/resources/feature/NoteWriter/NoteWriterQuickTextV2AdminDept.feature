@NoteWriterQTV2
Feature: NoteWriter Quick Text V2 Department

	Background:
		Given I am logged into the portal with user "nwadminv2" using the default password
		And I am on the "Admin" tab
		And I select the "Department" subtab

	Scenario: Enable QuickText V2
		Given I am logged into the portal with user "nwadminv2" using the default password
		And I am on the "Admin" tab
		And I select the "Institution" subtab
		And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
		And I wait "3" seconds
		And I select "true" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
		And I select "None" from the "Validation" dropdown
		And I click the "Save" button
		And I click "OK" in the confirmation box

	Scenario: Pre-requisite step to delete user quicktext
		And I am on the "Admin" tab
		And I select the "User" subtab
		When I search for the user "nwadminv2"
		And I select the user "nwadminv2"
		And I click the "Edit" button in the "Quick Details" pane
		And I select "NoteWriter" from the "Edit User Settings" dropdown in the "User Preferences" pane
		And I click the "Quick Text (Summary View)" edit link in the "NoteWriterSettings" pane
		And I wait up to "20" seconds for the "ResetUserPickers" field of type "BUTTON" to be clickable
		And I click the "ResetUserPickers" button
		And I click the "DeleteAll" button
		And I click the "Close" button in the "QuickTextEditorContent" pane

	Scenario: QTV2 and Group Creation in SummaryView
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Summary View)" edit link in the NoteWriter pane
		And I wait "3" seconds
		Then the "Department Quick Text Editor" pane should load
		And I wait "3" seconds
		And I click the "Delete All Pickers" button in the "DepartmentQuickTextEditorContentQTV2" pane
		And I click the "Yes" button in the "Question" pane
		And I click the "Department Pickers" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		Then the "EditQuickTextV2" pane should load within "5" seconds
		When I enter "Quick Text V2" in the "NameQTV2Quick" field
		And I enter "QTV2" in the "Keyboard Shortcut" field
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		Then the text "Quick Text V2" should appear in the "AddQuickTextV2left" pane
		When I click the "Close" button in the "EditQuickTextV2" pane
		Then the following links should display in the "DepartmentQuickTextEditorContentQTV2" pane
			|Quick Text V2|
		When I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane
		Then the "Department NoteWriter Settings" pane should load
		And I wait "3" seconds
		When I select "Progress Note (Dept)" from the "QuickText Template View" dropdown in the "Department NoteWriter Settings" pane
		And I click the "Quick Text (Template View)" edit link in the "Department General Settings" pane
		#And I wait "8" seconds
		And I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		Then the "SubjectiveQTV2" pane should load
		And I wait "3" seconds
		When I click the "PatientnarrativeABCQTV2" element in the "NoteInstanceEdit" pane
		Then the "ClickToInsertV2" pane should load
   #		When I click the "GroupPlusIcon" element in the "ClickToInsertV2" pane
   #        Then the following text should appear in the "ClickToInsertV2" pane
   #          |Quick Text V2 |
		And I click the "Global Text" quicktext in the "ClickToInsertV2" pane
		Then the quicktext "Quick Text V2" should appear under the group "Global Text" in the "ClickToInsertV2" pane
		When I enter "QTV2" in the "PatientNarrativeQTV2" rich text field
		And I click the "space" key in the "PatientNarrativeQTV2" rich text field
		And I wait "3" seconds
		Then the following text should appear in the "PatientNarrativeQTV2" pane
			|Quick Text V2 |
		When I click the "Cancel Note Template View" button in the "NoteWriter QuickText Admin View Content" pane
		Then the "Note Writer Quick Text Admin View" pane should close
		When I click the "Quick Text (Summary View)" edit link in the "Department General Settings" pane
		And I wait "4" seconds
		And I click the "Department Pickers" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		Then the "EditQuickTextV2" pane should load within "5" seconds
		And I enter "Group QTV1" in the "NameQTV2Quick " field
		When I select "true" from the "IsThisaGroup" radio list
	 #And I click the "Save" button in the "EditQuickTextV2Content" pane
		And I mouse over and click the "Save" button in the "Edit Quick TextV2 Content" pane
		And the "Group QTV1" group should be saved
		Then the text "Group QTV1" should appear in the "AddQuickTextV2left" pane
		And I wait "3" seconds
		When I drag the "Quick Text V2" quick text from group "Question" to group "Group QTV1"
	 #Then the "Quick Text V2" quick text should be moved from "Question" to "Group QTV1"
		When I click the "Close" button in the "EditQuickTextV2" pane
		Then the following links should display in the "DepartmentQuickTextEditorContentQTV2" pane
			|Group QTV1|
		When I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane
		Then the "Department NoteWriter Settings" pane should load
		When I select "Progress Note (Dept)" from the "QuickText Template View" dropdown in the "Department NoteWriter Settings" pane
		And I click the "Quick Text (Template View)" edit link in the "Department General Settings" pane
		And I wait "3" seconds
		And I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		And I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		And I click the "Global Text" quicktext in the "ClickToInsertV2" pane
		Then the following text should appear in the "ClickToInsertV2" pane
			|Group QTV1 |
		When I click the "Cancel Note Template View" button in the "NoteWriter QuickText Admin View Content" pane
		Then the "Note Writer Quick Text Admin View" pane should close

	Scenario: QTV2 and Group Modification in SummaryView
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Summary View)" edit link in the NoteWriter pane
		Then the "Department Quick Text Editor" pane should load
		And I wait "4" seconds
		And I click the "Group QTV1" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		Then the "EditQuickTextV2" pane should load within "5" seconds
		Then the "AddQuickTextV2left" pane should load within "3" seconds
		When I click the "Quick Text V2" quicktext in the "AddQuickTextV2left" pane
		And I enter "Edit Quick Text V2" in the "NameQTV2Quick " field
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		Then the text "Edit Quick Text V2" should appear in the "AddQuickTextV2left" pane
		When I click the "Close" button in the "EditQuickTextV2" pane
		Then the following links should display in the "DepartmentQuickTextEditorContentQTV2" pane
			|Edit Quick Text V2|
		When I click the "Group QTV1" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		Then the "EditQuickTextV2" pane should load within "5" seconds
		And I wait "2" seconds
		When I click the "QuickTextGroup" element in the "AddQuickTextV2left" pane
		And I enter "Edit Group QTV1" in the "QuickTextGroup" field
		And I click the "Bold" element in the "AddQuickTextV2Right" pane
		Then the text "Edit Quick Text V2" should appear in the "AddQuickTextV2left" pane
		When I click the "Close" button in the "EditQuickTextV2" pane
		Then the following links should display in the "DepartmentQuickTextEditorContentQTV2" pane
			|Edit Group QTV1|
		When I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane
		Then the "Department NoteWriter Settings" pane should load
		When I select "Progress Note (Dept)" from the "QuickText Template View" dropdown in the "Department NoteWriter Settings" pane
		And I click the "Quick Text (Template View)" edit link in the "Department General Settings" pane
		And I wait "3" seconds
		And I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		And I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		Then the following text should appear in the "ClickToInsertV2" pane
			|Edit Group QTV1 |
   #		When I click the "GroupPlusIcon" element in the "ClickToInsertV2" pane
		And I click the "Global Text" quicktext in the "ClickToInsertV2" pane
		Then the following text should appear in the "ClickToInsertV2" pane
			|Edit Quick Text V2|
		When I click the "Cancel Note Template View" button in the "NoteWriter QuickText Admin View Content" pane
		Then the "Note Writer Quick Text Admin View" pane should close

	Scenario: QTV2 and Group Deletion in SummaryView
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Summary View)" edit link in the NoteWriter pane
		Then the "Department Quick Text Editor" pane should load
		And I wait "5" seconds
		And I click the "Edit Group QTV1" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		Then the "EditQuickTextV2" pane should load within "5" seconds
		Then the "AddQuickTextV2left" pane should load within "3" seconds
		When I click the "Edit Quick Text V2" quicktext in the "AddQuickTextV2left" pane
	 #And I click the "DeleteQuickText" element in the "EditQuickTextV2Content" pane
		And I mouse over and click the "DeleteQuickText" element in the "Edit Quick TextV2 Content" pane
		And I click the "Yes" button in the "Question" pane
		And I click the "Close" button in the "EditQuickTextV2" pane
		And I click the "Edit Group QTV1" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And I wait "3" seconds
		Then the text "Edit Quick Text V2" should not appear in the "AddQuickTextV2left" pane
		When I click the "QuickTextGroup" element in the "AddQuickTextV2left" pane
		And I click the "DeleteGroup" element in the "AddQuickTextV2left" pane
		And I click the "Delete Highlighted Groups" element in the "Delete Quick Text Group" pane
		And I click the "OK" button in the "Information" pane if it exists
		And I click the "Close" button in the "EditQuickTextV2" pane if it exists
		Then the text "Edit Group QTV1" should not appear in the "DepartmentQuickTextEditorContentQTV2" pane
		When I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane
		And I select "Progress Note (Dept)" from the "QuickText Template View" dropdown in the "Department NoteWriter Settings" pane
		And I click the "Quick Text (Template View)" edit link in the "Department General Settings" pane
		And I wait "3" seconds
		And I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		And I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		And I wait "3" seconds
		Then the text "Edit Group QTV1" should not appear in the "ClickToInsertV2" pane
		When I click the "Cancel Note Template View" button in the "NoteWriter QuickText Admin View Content" pane
		Then the "Note Writer Quick Text Admin View" pane should close

	Scenario: AutoCreatedCategories in SummaryView
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Summary View)" edit link in the NoteWriter pane
		And I wait "5" seconds
		Then the "Department Quick Text Editor" pane should load
		And I wait "4" seconds
		And I click the "Create Categories From Note Template" button in the "Department Quick Text Editor Content" pane
		And I wait "3" seconds
		Then the "Select Note Template" pane should load
		When I enter "Progress Note" in the "Template" field in the "Select Note Template Content" pane
		And I click the "Select Note Template Search" button in the "Select Note Template Content" pane
		And I click the "OK" button in the "Select Note Template Content" pane
		And I click the "OK" button in the "Select Note Template Content" pane if it exists
		And I wait "3" seconds
		And I click the "QuestionPatientNarrative" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And I wait "3" seconds
		And I enter "Summary View" in the "NameQTV2Quick " field
		And I enter "SV" in the "Keyboard Shortcut" field
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		Then the text "Summary View" should appear in the "AddQuickTextV2left" pane
		When I click the "Close" button in the "EditQuickTextV2" pane
		Then the following links should display in the "DepartmentQuickTextEditorContentQTV2" pane
			|Summary View|
		When I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane
		Then the "Department NoteWriter Settings" pane should load
		When I select "Progress Note (Dept)" from the "QuickText Template View" dropdown in the "Department NoteWriter Settings" pane
		And I click the "Quick Text (Template View)" edit link in the "Department General Settings" pane
		And I wait "3" seconds
		And I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		Then the "SubjectiveQTV2" pane should load
		When I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		Then the following text should appear in the "ClickToInsertV2" pane
			|Summary View|
		And I click the "CloseQuickText" button in the "ClickToInsertV2" pane
		When I enter "SV" in the "PatientNarrativeQTV2" rich text field
		And I click the "space" key in the "PatientNarrativeQTV2" rich text field
		Then the following text should appear in the "PatientNarrativeQTV2" pane
			|Summary View|
		When I click the "Cancel Note Template View" button in the "NoteWriter QuickText Admin View Content" pane
		And I select "Progress Note (Dept)" from the "QuickText Template View" dropdown in the "Department NoteWriter Settings" pane
		And I click the "Quick Text (Template View)" edit link in the "Department General Settings" pane
		And I wait "3" seconds
		And I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		And I click the "ROS CONST Normal" button in the "NoteInstanceEdit" pane
		And I click the "CONSTROSABCQTV2" element in the "Note Instance Edit" pane
		Then the text "Summary View" should not appear in the "ClickToInsertV2" pane
		When I click the "Cancel Note Template View" button in the "NoteWriter QuickText Admin View Content" pane
		Then the "Note Writer Quick Text Admin View" pane should close

	Scenario: Negative Default in SummaryView
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Summary View)" edit link in the NoteWriter pane
		Then the "Department Quick Text Editor" pane should load
		And I wait "3" seconds
		And I click the "Department Pickers" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		Then the "EditQuickTextV2" pane should load within "5" seconds
		And the text "This group can not have a default Quick Text" should appear in the "AddQuickTextV2Right" pane
		And the following fields should not display in the "EditQuickTextV2Content" pane
			|Name               |Type    |
			|DefaultQTV2        |check   |
		When I click the "Close" button in the "EditQuickTextV2" pane
		Then the "Department Quick Text Editor" pane should load
		When I click the "Create Categories From Note Template" button in the "Department Quick Text Editor Content" pane
		And I wait "3" seconds
		Then the "Select Note Template" pane should load
		When I enter "Progress Note" in the "Template" field in the "Select Note Template Content" pane
		And I wait "3" seconds
		And I click the "Select Note Template Search" button in the "Select Note Template Content" pane
		And I click the "OK" button in the "Select Note Template Content" pane
		And I click the "OK" button in the "Select Note Template Content" pane if it exists
		And I wait "3" seconds
		And I click the "Subjective" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And I wait "3" seconds
		Then the text "This group can not have a default Quick Text" should appear in the "AddQuickTextV2Right" pane
		And the following fields should not display in the "EditQuickTextV2Content" pane
			|Name               |Type    |
			|DefaultQTV2        |check   |
		When I click the "Close" button in the "EditQuickTextV2" pane
		Then the "Department Quick Text Editor" pane should load
		When I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane
		Then the "Department NoteWriter Settings" pane should load

	Scenario: Pre-requisite step
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Summary View)" edit link in the NoteWriter pane
		Then the "Department Quick Text Editor" pane should load
		And I wait "5" seconds
		And I click the "Delete All Pickers" button in the "DepartmentQuickTextEditorContentQTV2" pane
		And I click the "Yes" button in the "Question" pane
		And I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane
  #Then the "Department Quick Text Editor" pane should close

	Scenario: Default SummaryView Dept
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Summary View)" edit link in the NoteWriter pane
		And I wait "5" seconds
		Then the "Department Quick Text Editor" pane should load
		And I wait "3" seconds
		And I click the "Create Categories From Note Template" button in the "Department Quick Text Editor Content" pane
		And I wait "3" seconds
		And I enter "Progress Note" in the "Template" field in the "Select Note Template Content" pane
		And I click the "Select Note Template Search" button in the "Select Note Template Content" pane
        And I wait "3" seconds
		And I select "Progress Note" in the "LookUpSearchResults" table
		And I click the "OK" button in the "Select Note Template Content" pane
        And I wait "5" seconds
		And I click the "QuestionROSConstitutional" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And I wait "3" seconds
		And I enter "QTV1" in the "NameQTV2Quick" field
		And I enter "V1" in the "Keyboard Shortcut" field
		And I wait "3" seconds
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		And I wait "3" seconds
		Then the text "QTV1" should appear in the "AddQuickTextV2left" pane
		And I wait "3" seconds
	 #When I click the "QTV1" quicktext in the "AddQuickTextV2..left" pane
		And I enter "QTV2" in the "NameQTV2Quick " field
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		Then the text "QTV2" should appear in the "AddQuickTextV2left" pane
		When I click the "QTV2" quicktext in the "AddQuickTextV2left" pane
		When I check the "DefaultQTV2" checkbox
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		Then the following fields should display in the "AddQuickTextV2Right" pane
			|Name |Type |
			|QTV2 |link |
		When I click the "QTV1" quicktext in the "AddQuickTextV2left" pane
		And I click the "QTV2" link in the "AddQuickTextV2Right" pane
		Then the following text should appear in the "AddQuickTextV2Right" pane
			|QTV2 |
		When I click the "QTV1" quicktext in the "AddQuickTextV2left" pane
		And I check the "DefaultQTV2" checkbox
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		Then the following fields should display in the "AddQuickTextV2Right" pane
			|Name |Type |
			|QTV1 |link |
		When I click the "Close" button in the "EditQuickTextV2" pane
		And I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane
		Then the "Department NoteWriter Settings" pane should load
		When I select "Progress Note (Dept)" from the "QuickText Template View" dropdown in the "Department NoteWriter Settings" pane
		And I click the "Quick Text (Template View)" edit link in the "Department General Settings" pane
		And I wait "3" seconds
		And I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		And I click the "ROS CONST Normal" button in the "NoteInstanceEdit" pane
		Then the following text should appear in the "NoteInstanceEdit" pane
			|QTV1 |
		When I click the "Cancel Note Template View" button in the "NoteWriter QuickText Admin View Content" pane
  #Then the "Note Writer Quick Text Admin View" pane should close

	Scenario: Default EndToEnd in SummaryView
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Summary View)" edit link in the NoteWriter pane
		And I wait "5" seconds
		Then the "Department Quick Text Editor" pane should load
		And I wait "3" seconds
		And I click the "Create Categories From Note Template" button in the "Department Quick Text Editor Content" pane
		And I wait "3" seconds
		And I enter "Progress Note" in the "Template" field in the "Select Note Template Content" pane
		And I click the "Select Note Template Search" button in the "Select Note Template Content" pane
        And I wait "3" seconds
        And I select "Progress Note" in the "LookUpSearchResults" table
        And I click the "OK" button in the "Select Note Template Content" pane
        And I wait "5" seconds
		And I click the "QuestionROSConstitutional" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And I wait "3" seconds
		And I enter "Text" in the "NameQTV2Quick " field
		And I check the "DefaultQTV2" checkbox
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		Then the following fields should display in the "AddQuickTextV2Right" pane
			|Name |Type |
			|Text |link |
		When I click the "Close" button in the "EditQuickTextV2" pane
		And I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane
		Then the "Department NoteWriter Settings" pane should load
		When I select the "User" subtab
		And I search for the user "nwadminv2"
		And I select the user "nwadminv2"
		And I click the "Edit" button in the "QuickDetails" pane
		And I select "NoteWriter" from the "EditUserSettings" dropdown in the "UserPreferences" pane
		And I click the "Quick Text (Summary View)" edit link in the "UserNoteWriterSettings" pane
		And I wait "3" seconds
		And I click the "Create Categories From Note Template" button in the "Department Quick Text Editor Content" pane
		And I wait "3" seconds
		And I enter "Progress Note" in the "Template" field in the "Select Note Template Content" pane
		And I click the "Select Note Template Search" button in the "Select Note Template Content" pane
        And I wait "3" seconds
        And I select "Progress Note" in the "LookUpSearchResults" table
        And I click the "OK" button in the "Select Note Template Content" pane
        And I wait "5" seconds
		And I click the "QuestionROSConstitutional" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And I wait "8" seconds
		And I enter "Text1" in the "NameQTV2Quick " field
		And I check the "DefaultQTV2" checkbox
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		Then the following fields should display in the "AddQuickTextV2Right" pane
			|Name  |Type |
			|Text1 |link |
		When I click the "Close" button in the "EditQuickTextV2" pane
		And I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane
		And I select "Progress Note (Dept)" from the "QuickText Template View" dropdown in the "Department NoteWriter Settings" pane
		And I click the "Quick Text (Template View)" edit link in the "Department General Settings" pane
		And I wait "3" seconds
		And I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		And I click the "ROS CONST Normal" button in the "NoteInstanceEdit" pane
		Then the following text should appear in the "NoteInstanceEdit" pane
			|Text1 |
		When I click the "Cancel Note Template View" button in the "NoteWriter QuickText Admin View Content" pane
  #Then the "Note Writer Quick Text Admin View" pane should close

	Scenario: HideFromPopup SummaryView
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Summary View)" edit link in the NoteWriter pane
		Then the "Department Quick Text Editor" pane should load
		And I wait "3" seconds
		And I click the "Delete All Pickers" button in the "DepartmentQuickTextEditorContentQTV2" pane
		And I click the "Yes" button in the "Question" pane
		And I click the "Department Pickers" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And I wait "3" seconds
		And I enter "Quick Text" in the "NameQTV2Quick " field
		And I check the "HideFromPopupQTV2" checkbox
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		Then the text "Quick Text" should appear in the "AddQuickTextV2left" pane
		When I click the "Close" button in the "EditQuickTextV2" pane
		Then the following links should display in the "DepartmentQuickTextEditorContentQTV2" pane
			|Quick Text |
		When I click the "Create Categories From Note Template" button in the "Department Quick Text Editor Content" pane
		And I wait "3" seconds
		And I enter "Progress Note" in the "Template" field in the "Select Note Template Content" pane
		And I click the "Select Note Template Search" button in the "Select Note Template Content" pane
		And I click the "OK" button in the "Select Note Template Content" pane
		And I click the "OK" button in the "Select Note Template Content" pane if it exists
		And I click the "QuestionPatientNarrative" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And I wait "3" seconds
		And I enter "Text1" in the "NameQTV2Quick " field
		And I check the "HideFromPopupQTV2" checkbox
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		And I click the "Close" button in the "EditQuickTextV2" pane
		And I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane
		Then the "Department NoteWriter Settings" pane should load
		When I select "Progress Note (Dept)" from the "QuickText Template View" dropdown in the "Department NoteWriter Settings" pane
		And I click the "Quick Text (Template View)" edit link in the "Department General Settings" pane
		And I wait "3" seconds
		When I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		Then the text "Text1" should not appear in the "PatientNarrativeQTV2" pane
		When I click the "Cancel Note Template View" button in the "NoteWriter QuickText Admin View Content" pane
		And I click the "Quick Text (Summary View)" edit link in the "Department General Settings" pane
		And I wait "3" seconds
		And I click the "QuestionPatientNarrative" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And  I wait "3" seconds
		And I click the "Text1" quicktext in the "AddQuickTextV2left" pane
		And I uncheck the "HideFromPopupQTV2" checkbox
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		And I click the "Close" button in the "EditQuickTextV2" pane
		And I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane
		Then the "Department NoteWriter Settings" pane should load
		When I select "Progress Note (Dept)" from the "QuickText Template View" dropdown in the "Department NoteWriter Settings" pane
		And I click the "Quick Text (Template View)" edit link in the "Department General Settings" pane
		And  I wait "3" seconds
		When I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		Then the following text should appear in the "PatientNarrativeQTV2" pane
			|Text1 |
		And I wait "3" seconds
		When I click the "Cancel Note Template View" button in the "NoteWriter QuickText Admin View Content" pane
  #Then the "Note Writer Quick Text Admin View" pane should close

	Scenario: Category Deletion SummaryView
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Summary View)" edit link in the NoteWriter pane
		And I wait "3" seconds
		Then the "Department Quick Text Editor" pane should load
		When I click the "Delete All Pickers" button in the "DepartmentQuickTextEditorContentQTV2" pane
		And I click the "Yes" button in the "Question" pane
		And I click the "Department Pickers" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And I wait "3" seconds
		And I enter "Deletion Text" in the "NameQTV2Quick" field
		And I enter "DT" in the "Keyboard Shortcut" field
		And I wait "3" seconds
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		And I wait "3" seconds
		Then the text "Deletion Text" should appear in the "AddQuickTextV2left" pane
		When I click the "Close" button in the "EditQuickTextV2" pane if it exists
		And I wait "3" seconds
		Then the following links should display in the "DepartmentQuickTextEditorContentQTV2" pane
			|Deletion Text |
		When I click the "Department Pickers" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And I wait "3" seconds
		And I click the "QuickTextGroup" element in the "AddQuickTextV2left" pane
		And I click the "DeleteGroup" element in the "AddQuickTextV2left" pane
		And I click the "Delete Highlighted Groups" element in the "Delete Quick Text Group" pane
		And I click the "OK" button in the "Information" pane if it exists
		And I click the "Close" button in the "EditQuickTextV2" pane if it exists
		And I wait "3" seconds
		Then the text "Deletion Text" should not appear in the "DepartmentQuickTextEditorContentQTV2" pane
		When I click the "Create Categories From Note Template" button in the "Department Quick Text Editor Content" pane
		And I wait "3" seconds
		And I enter "Progress Note" in the "Template" field in the "Select Note Template Content" pane
		And I click the "Select Note Template Search" button in the "Select Note Template Content" pane
        And I wait "3" seconds
        And I select "Progress Note" in the "LookUpSearchResults" table
        And I click the "OK" button in the "Select Note Template Content" pane
        And I wait "5" seconds
		And I click the "QuestionROSConstitutional" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And I wait "3" seconds
		And I click the "QuickTextGroup" element in the "AddQuickTextV2left" pane
		And I click the "DeleteGroup" element in the "AddQuickTextV2left" pane
		And I click the "Delete Highlighted Groups" element in the "Delete Quick Text Group" pane
		And I click the "OK" button in the "Information" pane if it exists
		And I click the "Close" button in the "EditQuickTextV2" pane if it exists
   #		And I click the "QuestionROSConstitutional" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
   #	    And I wait "3" seconds
   #	    And I click the "QuickTextGroup" element in the "AddQuickTextV2left" pane
   #		And I click the "DeleteGroup" element in the "AddQuickTextV2left" pane
   #		And I click the "Delete Highlighted Groups" element in the "Delete Quick Text Group" pane
   #		And I click the "OK" button in the "Information" pane if it exists
		Then Text exact "QuestionROSConstitutional" should not appear in the "DepartmentQuickTextEditorContentQTV2" pane
		When I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane
		Then the "Department NoteWriter Settings" pane should load

	Scenario: RichTagCreation SummaryView Dept
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Summary View)" edit link in the NoteWriter pane
		Then the "Department Quick Text Editor" pane should load
		And I wait "3" seconds
		And I click the "Delete All Pickers" button in the "DepartmentQuickTextEditorContentQTV2" pane
		And I click the "Yes" button in the "Question" pane
		And I click the "Department Pickers" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And I wait "3" seconds
		And I enter "Rich Tag" in the "NameQTV2Quick" field
		And I enter "RT" in the "Keyboard Shortcut" field
		And I click the "Insert Free Text" element
		Then I click the "Insert Text" textbox in the rich text field
		And I enter "Labeled" in the "Insert Text" free text field in the "QTV2Description" pane
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		And I click the "Close" button in the "EditQuickTextV2" pane
		Then the following links should display in the "DepartmentQuickTextEditorContentQTV2" pane
			|Rich Tag|
		And I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane
		Then the "Department NoteWriter Settings" pane should load
		When I select "Progress Note (Dept)" from the "QuickText Template View" dropdown in the "Department NoteWriter Settings" pane
		And I click the "Quick Text (Template View)" edit link in the "Department General Settings" pane
		And I wait "5" seconds
		And I enter "RT" in the "PatientNarrativeQTV2" rich text field
		And I click the "space" key in the "PatientNarrativeQTV2" rich text field
		Then the underlined color of the text should be red before editing
		When I click the "Labeled" textbox in the rich text field
		And I enter "Free text without label" in the "Free Text" free text field in the "PatientNarrativeQTV2" pane
		When I click the "Cancel Note Template View" button in the "NoteWriter QuickText Admin View Content" pane
  #Then the "Note Writer Quick Text Admin View" pane should close

	Scenario: WikiTagCreation SummaryView
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Summary View)" edit link in the NoteWriter pane
		Then the "Department Quick Text Editor" pane should load
		And I wait "8" seconds
		Then the "Department Quick Text Editor" pane should load
		When I click the "Delete All Pickers" button in the "DepartmentQuickTextEditorContentQTV2" pane
		And I click the "Yes" button in the "Question" pane
		And I click the "Department Pickers" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And I wait "3" seconds
		And I click the "Wiki Source" element
		And I enter "Wiki Tag" in the "NameQTV2Quick" field
		And I enter "WT" in the "Keyboard Shortcut" field
		And I enter "######" in the "QTV2Description" rich text field
		And I enter "######[[Labeled]]######" in the "QTV2Description" rich text field
		And I enter "###[[]]1,2###" in the "QTV2Description" rich text field
		And I enter "###[[List 1]]{3}{4}###" in the "QTV2Description" rich text field
		And I enter "###[[List 2]]5,6###" in the "QTV2Description" rich text field
		And I click the "Wiki Source" element
		Then the following text should appear in the "QTV2Description" pane
			|Insert Text |
			|Labeled     |
			|Select One  |
			|List 1      |
			|List 2      |
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		And I click the "Close" button in the "EditQuickTextV2" pane
		Then the following links should display in the "DepartmentQuickTextEditorContentQTV2" pane
			|Wiki Tag|
		When I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane
		Then the "Department NoteWriter Settings" pane should load
		When I select "Progress Note (Dept)" from the "QuickText Template View" dropdown in the "Department NoteWriter Settings" pane
		And I click the "Quick Text (Template View)" edit link in the "Department General Settings" pane
		And I wait "3" seconds
		And I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		Then the "SubjectiveQTV2" pane should load
		When I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		And I enter "WT" in the "PatientNarrativeQTV2" rich text field
		And I click the "space" key in the "PatientNarrativeQTV2" rich text field
		Then the following text should appear in the "PatientNarrativeQTV2" pane
			|Insert Text |
			|Labeled     |
			|Select One  |
			|List 1      |
			|List 2      |
		When I click the "Cancel Note Template View" button in the "NoteWriter QuickText Admin View Content" pane
  #Then the "Note Writer Quick Text Admin View" pane should close

	Scenario: FormatText in SummaryView
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Summary View)" edit link in the NoteWriter pane
		Then the "Department Quick Text Editor" pane should load
		And I wait "3" seconds
		And I click the "Delete All Pickers" button in the "DepartmentQuickTextEditorContentQTV2" pane
		And I click the "Yes" button in the "Question" pane
		And I click the "Department Pickers" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And I wait "3" seconds
		And I verify if the text is bold
		And I verify if the text is italics
   #		And I verify if the text is numbered list
		And I verify if the text is bullet list
		And I enter "Format Text" in the "NameQTV2Quick" field
		And I enter "FT" in the "Keyboard Shortcut" field
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		And I click the "Close" button in the "EditQuickTextV2" pane
		Then the following links should display in the "DepartmentQuickTextEditorContentQTV2" pane
			|Format Text |
		When I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane
		Then the "Department NoteWriter Settings" pane should load
		When I select "Progress Note (Dept)" from the "QuickText Template View" dropdown in the "Department NoteWriter Settings" pane
		And I click the "Quick Text (Template View)" edit link in the "Department General Settings" pane
		And I wait "3" seconds
		And I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		Then the "SubjectiveQTV2" pane should load
		When I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		And I enter "FT" in the "PatientNarrativeQTV2" rich text field
		And I click the "space" key in the "PatientNarrativeQTV2" rich text field
		Then the following text should appear in the "PatientNarrativeQTV2" pane
			|Bold          |
			|Italics       |
   #			|Numbered      |
		When I click the "Cancel Note Template View" button in the "NoteWriter QuickText Admin View Content" pane
  #Then the "Note Writer Quick Text Admin View" pane should close

	Scenario: Pre-requisite step
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Summary View)" edit link in the NoteWriter pane
		Then the "Department Quick Text Editor" pane should load
		And I wait "3" seconds
		And I click the "Delete All Pickers" button in the "DepartmentQuickTextEditorContent..QTV2" pane
		And I click the "Yes" button in the "Question" pane
		And I click the "Close" button in the "DepartmentQuickTextEditorContent..QTV2" pane
  #Then the "Department Quick Text Editor" pane should close

	Scenario: Create Group and Quick Text in Template view
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Template View)" edit link in the NoteWriter pane
		And I wait "5" seconds
		Then the "Note Writer Quick Text Admin View" pane should load
		When I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		Then the "SubjectiveQTV2" pane should load
		And I wait "3" seconds
		When I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		And the "ClickToInsertV2" pane should load
		And I click the "ManageQuickText" button
		And I wait "3" seconds
		Then I select "true" from the "IsThisaGroup" radio list
		When I enter "Group1" in the "NameQTV2Quick " field
	 #And I click the "Save" button in the "EditQuickTextV2Content" pane
		And I mouse over and click the "Save" button in the "Edit Quick TextV2 Content" pane
		And the "Group1" group should be saved
		And I wait "3" seconds
		Then the text "Group1" should appear in the "AddQuickTextV2left" pane
		When I select "true" from the "IsThisaGroup" radio list
		And I enter "Group2" in the "NameQTV2Quick " field
	 #And I click the "Save" button in the "EditQuickTextV2Content" pane
		And I mouse over and click the "Save" button in the "Edit Quick TextV2 Content" pane
		And the "Group2" group should be saved
		And I wait "3" seconds
		Then the text "Group2" should appear in the "AddQuickTextV2left" pane
		When I add the following admin quick texts
			|Name        |Shortcut|
			|A quick text|aq      |
			|B quick text|bq      |
			|C quick text|cq      |
			|D quick text|dq      |
			|E quick text|eq      |
			|F quick text|fq      |
		And I click the "Close" button in the "EditQuickTextV2" pane
		And I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		Then the "ClickToInsertV2" pane should load
   #		When I click the "GroupPlusIcon" element in the "ClickToInsertV2" pane
		And I click the "Group1" quicktext in the "ClickToInsertV2" pane
		Then the following text should appear in the "ClickToInsertV2" pane
			|Group1       |
			|F quick text |
			|E quick text |
			|D quick text |
			|C quick text |
			|B quick text |
			|A quick text |
			|Group2       |
		When I click the "Cancel Note Template View" button in the "Note Writer Quick Text Admin View Content" pane
  #Then the "Note Writer Quick Text Admin View" pane should close

  #TODO : blocked by DEV-83666
	Scenario: Verify the created Group and Quick Text in Summary View
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Summary View)" edit link in the NoteWriter pane
		And I wait "3" seconds
		Then the "Department Quick Text Editor" pane should load
		And I wait "3" seconds
		And I click the "Subjective" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And the "EditQuickTextV2" pane should load within "5" seconds
		And the following text should appear in the "AddQuickTextV2left" pane
			|Group1       |
			|F quick text |
			|E quick text |
			|D quick text |
			|C quick text |
			|B quick text |
			|A quick text |
			|Group2       |
		   #And the quick texts under the group "Group1" should be in the following order
	  #|F quick text |
	  #|E quick text |
	  #|D quick text |
	  #|C quick text |
	  #|B quick text |
	  #|A quick text |
		And I click the "Close" button in the "EditQuickTextV2" pane
		And I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane

	  #TODO : blocked by DEV-83666
	Scenario: Modify quick text in Template View and verify in Summary View
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Template View)" edit link in the NoteWriter pane
		And I wait "3" seconds
		Then the "Note Writer Quick Text Admin View" pane should load
		When I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		Then the "SubjectiveQTV2" pane should load
		When I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		And the "ClickToInsertV2" pane should load
		And I click the "ManageQuickText" button
		And I wait "4" seconds
		Then I click the "F quick text" quicktext in the "AddQuickTextV2left" pane
		And I enter "Modified quick text" in the "NameQTV2Quick" field
		And I enter "mqt" in the "Keyboard Shortcut" field
		And I clear the "QTV2Description" rich text field
		And I enter "Modified quick text" in the "QTV2Description" rich text field
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		And Text exact "Modified quick text was Updated" should appear in the "AddQuickTextV2Right" pane
		And I click the "Close" button in the "EditQuickTextV2" pane
		When I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		And the "ClickToInsertV2" pane should load
   #		And I click the "GroupPlusIcon" element in the "ClickToInsertV2" pane
		And I click the "Group1" quicktext in the "ClickToInsertV2" pane
		And Text exact "Modified quick text" should appear in the "ClickToInsertV2" pane
		And I click the "Cancel Note Template View" button in the "Note Writer Quick Text Admin View Content" pane
		And the "Note Writer Quick Text Admin View" pane should close
		And I click the "Quick Text (Summary View)" edit link in the "Department General Settings" pane
		And I wait "8" seconds
		Then the "Department Quick Text Editor" pane should load
		And I click the "Subjective" edit category link in the "DepartmentQuickTextEditorContent..QTV2" pane
		And the "EditQuickTextV2" pane should load within "5" seconds
		And Text exact "Modified quick text" should appear in the "AddQuickTextV2left" pane
		And Text exact "F quick text" should not appear in the "AddQuickTextV2left" pane
		And I click the "Close" button in the "EditQuickTextV2" pane
		And I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane

	  #TODO : blocked by DEV-83666
	Scenario: Delete quick text in Template View and verify in Summary View
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Template View)" edit link in the NoteWriter pane
		And I wait "3" seconds
		Then the "Note Writer Quick Text Admin View" pane should load
		When I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		Then the "SubjectiveQTV2" pane should load
		When I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		And the "ClickToInsertV2" pane should load
		And I click the "ManageQuickText" button
		And I wait "3" seconds
		Then I click the "Modified quick text" quicktext in the "AddQuickTextV2left" pane
		And I mouse over and click the "DeleteQuickText" element in the "Add QuickTextV2 left" pane
	 #And I click the "DeleteQuickText" element in the "EditQuickTextV2Content" pane
		And I click the "Yes" button in the "Question" pane
	 #And Text exact "Modified quick text was Deleted" should appear in the "AddQuickTextV2..Right" pane
		And I click the "Close" button in the "EditQuickTextV2" pane
		When I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		And the "ClickToInsertV2" pane should load
   #		And I click the "GroupPlusIcon" element in the "ClickToInsertV2" pane
		And I click the "Global Text" quicktext in the "ClickToInsertV2" pane
		And Text exact "Modified quick text" should not appear in the "ClickToInsertV2" pane
		And I click the "Close" button in the "Note Writer Quick Text Admin View Content" pane
		And the "Note Writer Quick Text Admin View" pane should close
		And I click the "Quick Text (Summary View)" edit link in the "Department General Settings" pane
		And I wait "8" seconds
		Then the "Department Quick Text Editor" pane should load
		And I click the "Subjective" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And the "EditQuickTextV2" pane should load within "5" seconds
		And Text exact "Modified quick text" should not appear in the "AddQuickTextV2left" pane
		And I click the "Close" button in the "EditQuickTextV2" pane
		And I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane

	  #TODO : blocked by DEV-83666
	Scenario: Drag and Drop the quick text in Template View
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Template View)" edit link in the NoteWriter pane
		And I wait "3" seconds
		Then the "Note Writer Quick Text Admin View" pane should load
		And I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		Then the "SubjectiveQTV2" pane should load
		When I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		And the "ClickToInsertV2" pane should load
		And I click the "ManageQuickText" button
		And I wait "3" seconds
		Then I drag the "A quick text" quick text from group "Group1" to group "Group2"
	 #And the "A quick text" quick text should be moved from "Group1" to "Group2"
		And I wait "3" seconds
		When I drag and drop the "B quick text" quick text on to the "D quick text" quick text within the "Group1" group
		And I click the "Close" button in the "EditQuickTextV2" pane
		And I click the "Cancel Note Template View" button in the "Note Writer Quick Text Admin View Content" pane
		Then the "Note Writer Quick Text Admin View" pane should close
		When I click the "Quick Text (Summary View)" edit link in the "Department General Settings" pane
		And I wait "8" seconds
		Then the "Department Quick Text Editor" pane should load
		And I wait "3" seconds
		And I click the "Subjective" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And the "EditQuickTextV2" pane should load within "5" seconds
		And I wait "3" seconds
		And the quicktext "A quick text" should appear under the group "Group2" in the "EditQuickTextV2" pane
	 #And the quick texts under the group "Group1" should be in the following order
	  #|E quick text |
	  #|B quick text |
	  #|D quick text |
	  #|C quick text |
		And I click the "Close" button in the "EditQuickTextV2" pane
		And I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane

	Scenario: Create Free Text box and Select List using Wiki Text
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Template View)" edit link in the NoteWriter pane
		And I wait "3" seconds
		Then the "Note Writer Quick Text Admin View" pane should load
		When I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		Then the "SubjectiveQTV2" pane should load
		When I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		And the "ClickToInsertV2" pane should load
		And I click the "ManageQuickText" button
		And I wait "3" seconds
		And I enter "Wiki quick text" in the "NameQTV2Quick" field
		And I enter "wiki" in the "Keyboard Shortcut" field
		And I click the "Wiki Source" element
		And I enter "######" in the "QTV2Description" rich text field
		And I enter "######[[Labeled]]######" in the "QTV2Description" rich text field
		And I enter "###[[List]]{1}{2}{3}###" in the "QTV2Description" rich text field
		And I click the "Wiki Source" element
		Then the following text should appear in the "QTV2Description" pane
			|Insert Text |
			|Labeled     |
			|List        |
		And I wait "3" seconds
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		And I click the "Close" button in the "EditQuickTextV2" pane
		When I enter "wiki" in the "PatientNarrativeQTV2" rich text field
		And I click the "space" key in the "PatientNarrativeQTV2" rich text field
		Then the underlined color of the text should be red before editing
		And the underlined color of the list should be red before editing
		And I click the "List" list in the rich text field
		And I select "1" option from the "ListSelect" list
		When I click the "Labeled" textbox in the rich text field
		And I enter "Free text with label" in the "Free Text" free text field in the "PatientNarrativeQTV2" pane
		And I click the "enter" key in the "PatientNarrativeQTV2" rich text field
		When I click the "Cancel Note Template View" button in the "Note Writer Quick Text Admin View Content" pane
  #Then the "Note Writer Quick Text Admin View" pane should close

	Scenario: Create Select List tag using Rich Text
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Template View)" edit link in the NoteWriter pane
		And I wait "3" seconds
		And I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		Then the "SubjectiveQTV2" pane should load
		When I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		And the "ClickToInsertV2" pane should load
		And I click the "ManageQuickText" button
		And I wait "3" seconds
		And I enter "Rich select list" in the "NameQTV2Quick" field
		And I enter "rl" in the "Keyboard Shortcut" field
		And I enter "Unique" in the "QTV2Description" field
		Then I click the "Insert Select List" element
		And I click the "Select One" list in the rich text field
		When I enter "List" in the "ListLabel" field
		And I enter "Option 1" in the "ListOption" field in the "Qtv2" pane
		And I enter "Option 2" in the "ListOption1" field
		And I wait "3" seconds
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		Then I click the "Close" button in the "EditQuickTextV2" pane
		When I enter "rl" in the "PatientNarrativeQTV2" rich text field
		And I click the "space" key in the "PatientNarrativeQTV2" rich text field
		And the underlined color of the list should be red before editing
		And I click the "enter" key in the "PatientNarrativeQTV2" rich text field
		And I click the "List" list in the rich text field
		And I select "Option 1" option from the "ListSelect" list
		And the underlined color of the list should be blue on editing
		Then I click the "Cancel Note Template View" button in the "Note Writer Quick Text Admin View Content" pane
  #And the "Note Writer Quick Text Admin View" pane should close

	Scenario: Create Free Text tag using Rich Text
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Template View)" edit link in the NoteWriter pane
		And I wait "3" seconds
		Then the "Note Writer Quick Text Admin View" pane should load
		When I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		Then the "SubjectiveQTV2" pane should load
		When I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		And the "ClickToInsertV2" pane should load
		And I click the "ManageQuickText" button
		And I wait "3" seconds
		And I enter "Rich quick text" in the "NameQTV2Quick" field
		And I enter "rt" in the "Keyboard Shortcut" field
		And I click the "Insert Free Text" element
		And I wait "3" seconds
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		And I click the "Close" button in the "EditQuickTextV2" pane
		When I enter "rt" in the "PatientNarrativeQTV2" rich text field
		And I click the "space" key in the "PatientNarrativeQTV2" rich text field
		Then the underlined color of the text should be red before editing
		When I click the "Insert Text" textbox in the rich text field
		And I enter "Free text without label" in the "Free Text" free text field in the "PatientNarrativeQTV2" pane
		And I click the "Cancel Note Template View" button in the "Note Writer Quick Text Admin View Content" pane
  #Then the "Note Writer Quick Text Admin View" pane should close


	Scenario: Verify the text styles in the created quick text
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Template View)" edit link in the NoteWriter pane
		And I wait "3" seconds
		Then the "Note Writer Quick Text Admin View" pane should load
		When I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		Then the "SubjectiveQTV2" pane should load
		When I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		And the "ClickToInsertV2" pane should load
		And I click the "ManageQuickText" button
		And I wait "3" seconds
		Then I enter "Quick text style" in the "NameQTV2Quick" field
		And I enter "qts" in the "Keyboard Shortcut" field
		And I click the "Bold" element
		And I enter "This text is bold" in the "QTV2Description" rich text field
		And I click the "Bold" element
		And I click the "Italic" element
		And I enter "This text is italics" in the "QTV2Description" rich text field
		And I click the "Italic" element
		And I wait "3" seconds
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		And I click the "Close" button in the "EditQuickTextV2" pane
		When I enter "qts" in the "PatientNarrativeQTV2" rich text field
		And I click the "enter" key in the "PatientNarrativeQTV2" rich text field
		Then I verify the text "This text is bold" is bold in other mode in the "PatientNarrativeQTV2" pane
		And I verify the text "This text is italics" is italic in other mode in the "PatientNarrativeQTV2" pane
		And I click the "Cancel Note Template View" button in the "Note Writer Quick Text Admin View Content" pane
  #And the "Note Writer Quick Text Admin View" pane should close

	Scenario: Verify the Numbered and Bulleted in the created quick text
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Template View)" edit link in the NoteWriter pane
		And I wait "3" seconds
		Then the "Note Writer Quick Text Admin View" pane should load
		When I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		Then the "SubjectiveQTV2" pane should load
		When I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		And the "ClickToInsertV2" pane should load
		And I click the "ManageQuickText" button
		And I wait "3" seconds
		Then I enter "Quick text list" in the "NameQTV2Quick" field
		And I enter "qtl" in the "Keyboard Shortcut" field
   #		And I click the "Numbered List" element
   #	    And I enter "This text is numbered" in the "QTV2Description" rich text field
   #		And I click the "Numbered List" element
		And I click the "Bullet List" element
		And I enter "This text is bulleted" in the "QTV2Description" rich text field
		And I wait "3" seconds
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		And I click the "Close" button in the "EditQuickTextV2" pane
		When I enter "qtl" in the "PatientNarrativeQTV2" rich text field
		And I click the "enter" key in the "PatientNarrativeQTV2" rich text field
   #		Then I verify the text "This text is numbered" is numbered in other mode in the "PatientNarrativeQTV2" pane
		And I verify the text "This text is bulleted" is bulleted in other mode in the "PatientNarrativeQTV2" pane
		And I click the "Cancel Note Template View" button in the "Note Writer Quick Text Admin View Content" pane
  #And the "Note Writer Quick Text Admin View" pane should close

	Scenario: Default Quick Text Template View
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Template View)" edit link in the NoteWriter pane
		And I wait "3" seconds
		Then the "Note Writer Quick Text Admin View" pane should load
		When I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		Then the "SubjectiveQTV2" pane should load
		And I click the "ROS RESP Normal" button in the "Note Instance Edit" pane
		And I click the "ROSRespABCQTV2" element in the "Note Instance Edit" pane
		And the "ClickToInsertV2" pane should load
		And I mouse over and click the "ManageQuickText" button
#		And I click the "ManageQuickText" button
		And I wait "3" seconds
		Then I enter "Quick text list" in the "NameQTV2Quick" field
		And I enter "qtl" in the "Keyboard Shortcut" field
		And I wait "3" seconds
		And I click the "Save" button in the "EditQuickTextV2Content" pane
	 #And I click the "Quick text list" quicktext in the "AddQuickTextV2..left" pane
		And I enter "Default quick text" in the "NameQTV2Quick" field
		And I enter "ds" in the "Keyboard Shortcut" field
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		And I click the "Default quick text" quicktext in the "AddQuickTextV2left" pane
		When I check the "DefaultQTV2" checkbox
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		And the "Default quick text" quicktext should be updated
		And I click the "Default quick text" quicktext in the "AddQuickTextV2left" pane
		And the following should be checked in the "AddQuickTextV2Right" pane
			|DefaultQTV2 |
		Then the following fields should display in the "AddQuickTextV2Right" pane
			|Name               |Type |
			|Default quick text |link |
		And I click the "Quick text list" quicktext in the "AddQuickTextV2left" pane
		And the following fields should display in the "AddQuickTextV2Right" pane
			|Name               |Type |
			|Default quick text |link |
		And I click the "Default quick text" link in the "AddQuickTextV2Right" pane
	 #And the default quick text "Default quick text" should be selected
		When I click the "Close" button in the "EditQuickTextV2" pane
		And I click the "enter" key in the "ROSRespQTV2" rich text field
		And I enter "ds" in the "ROSRespQTV2" rich text field
		And I click the "enter" key in the "ROSRespQTV2" rich text field
		And the following text should appear in the "ROSRespQTV2" pane
			|Default quick text |
		And I click the "Cancel Note Template View" button in the "Note Writer Quick Text Admin View Content" pane
		Then I click the "Quick Text (Summary View)" edit link in the "Department General Settings" pane
		And I wait "8" seconds
		And the "Department Quick Text Editor" pane should load
		And I click the "QuestionROSResp" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And the "EditQuickTextV2" pane should load within "5" seconds
		And I wait "3" seconds
		And the "AddQuickTextV2left" pane should load
		When I click the "Default quick text" quicktext in the "AddQuickTextV2left" pane
		Then the following should be checked in the "AddQuickTextV2Right" pane
			|DefaultQTV2 |
		And the following fields should display in the "AddQuickTextV2Right" pane
			|Name               |Type |
			|Default quick text |link |
		And I click the "Close" button in the "EditQuickTextV2" pane
		And I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane

	Scenario: Pre-requisite
		When I select the "User" subtab
		And I search for the user "nwlevel2"
		And I select the user "nwlevel2"
		And I click the "Edit" button in the "Quick Details" pane
		And I select "NoteWriter" from the "Edit User Settings" dropdown in the "User Preferences" pane
		And I click the "Quick Text (Summary View)" edit link in the "Department General Settings" pane
		And I wait "3" seconds
		And I click the "ResetUserPickers" button in the "DepartmentQuickTextEditorContentQTV2" pane
		And I click the "DeleteAll" button in the "Question" pane
		And I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane

	Scenario: Default Quick Text End-to-End Template View
		When I select the "User" subtab
		And I search for the user "nwadminv2"
		And I select the user "nwadminv2"
		And I click the "Edit" button in the "Quick Details" pane
		And I select "NoteWriter" from the "Edit User Settings" dropdown in the "User Preferences" pane
		And I select "Progress Note (Dept)" from the "QuickText Template View" dropdown in the "Department NoteWriter Settings" pane
		And I click the "Quick Text (Template View)" edit link in the "Department General Settings" pane
		And I wait "3" seconds
		Then the "Note Writer Quick Text Admin View" pane should load
		And I wait "3" seconds
		When I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		Then the "SubjectiveQTV2" pane should load
		And I click the "ROS RESP Normal" button in the "Note Instance Edit" pane
		And I click the "enter" key in the "ROSRespQTV2" rich text field
		And I enter "ds" in the "ROSRespQTV2" rich text field
		And I click the "enter" key in the "ROSRespQTV2" rich text field
		And the following text should appear in the "ROSRespQTV2" pane
			|Default quick text |
		And I click the "ROSRespABCQTV2" element in the "Note Instance Edit" pane
		And the "ClickToInsertV2" pane should load
		And I click the "ManageQuickText" button
		And I wait "3" seconds
		When I enter "Default quick text User Level" in the "NameQTV2Quick" field
		And I enter "dqt2" in the "Keyboard Shortcut" field
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		Then I click the "Close" button in the "EditQuickTextV2" pane
		And I click the "enter" key in the "ROSRespQTV2" rich text field
		And I enter "dqt2" in the "ROSRespQTV2" rich text field
		And I click the "enter" key in the "ROSRespQTV2" rich text field
		And the following text should appear in the "ROSRespQTV2" pane
			|Default quick text User Level |
		And I click the "Cancel Note Template View" button in the "Note Writer Quick Text Admin View Content" pane
	 # Unchecking default checkbox for "Default quick text" quicktext as a precondition for further scenarios.
		And I select the "Department" subtab
		And I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Summary View)" edit link in the NoteWriter pane
		And I click the "QuestionROSResp" edit category link in the "DepartmentQuickTextEditorContentQTV2" pane
		And the "EditQuickTextV2" pane should load within "5" seconds
		And the "AddQuickTextV2left" pane should load
		And I click the "Default quick text" quicktext in the "AddQuickTextV2left" pane
		And I uncheck the "DefaultQTV2" checkbox
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		And the "Default quick text" quicktext should be updated
		And I click the "Close" button in the "EditQuickTextV2" pane
		And I click the "Close" button in the "DepartmentQuickTextEditorContentQTV2" pane

	Scenario: Quick text HideFromPopup
		When I select the "QTV2" department and "Progress Note (Dept)" template and click "Quick Text (Template View)" edit link in the NoteWriter pane
		And I wait "3" seconds
		Then the "Note Writer Quick Text Admin View" pane should load
		And I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		And the "SubjectiveQTV2" pane should load
		When I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		And the "ClickToInsertV2" pane should load
		And I click the "ManageQuickText" button
		And I wait "3" seconds
		Then I enter "Quick text hidden" in the "NameQTV2Quick" field
		And I enter "qth" in the "Keyboard Shortcut" field
		And I check the "HideFromPopupQTV2" checkbox
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		When I click the "Close" button in the "EditQuickTextV2" pane
		And I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		And the "ClickToInsertV2" pane should load
		And I wait "3" seconds
   #		And I click the "GroupPlusIcon" element in the "ClickToInsertV2" pane if it exists
		And I click the "Group1" quicktext in the "ClickToInsertV2" pane
		Then Text exact "Quick text hidden" should not appear in the "ClickToInsertV2" pane
		And I click the "ManageQuickText" button
		And I wait "3" seconds
		And I click the "Quick text hidden" quicktext in the "AddQuickTextV2left" pane
		And I uncheck the "HideFromPopupQTV2" checkbox
		And I click the "Save" button in the "EditQuickTextV2Content" pane
		When I click the "Close" button in the "EditQuickTextV2" pane
		And I click the "PatientnarrativeABCQTV2" element in the "Note Instance Edit" pane
		And the "ClickToInsertV2" pane should load
   #		And I click the "GroupPlusIcon" element in the "ClickToInsertV2" pane if it exists
		And I click the "Group1" quicktext in the "ClickToInsertV2" pane
		Then Text exact "Quick text hidden" should appear in the "ClickToInsertV2" pane
		And I click the "Cancel Note Template View" button in the "Note Writer Quick Text Admin View Content" pane

	Scenario: Disable Quick text V2
		Given I am logged into the portal with user "nwadminv2" using the default password
		And I am on the "Admin" tab
		And I select the "Institution" subtab
		And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
		And I wait "3" seconds
		And I select "false" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
		And I click the "Save" button
		And I click "OK" in the confirmation box