@donotrun
Feature: NoteWriter Quick Text

	Background:
		Given I am logged into the portal with user "nwadmin" using the default password
		And I am on the "Admin" tab
		And I select the "Department" subtab

	@NoteWriter
	Scenario: Pre-requisite step
		When I am on the "Admin" tab
		And I select the "Institution" subtab
		And I select "Site Administration" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
		And I select "true" from the "NoteWriter" radio list in the "Site Administration" pane
		And I click the "Save" button
		And I click "OK" in the confirmation box
		And I select the "Department" subtab
		And I create the department "Autocreated-%Current Date%-%Current Time%"
		And the user "nwadmin" is associated with the "Autocreated-%Current Date%-" department
		And I select the "Institution" subtab
		And I wait "2" seconds
		And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
		And I select "false" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
		And I select "false" from the "Enable Spell Check" radio list in the "Note Writer Settings" pane
		And I click the "Save" button
		And I click "OK" in the confirmation box
	
	@NoteWriter
	Scenario: As Admin0 Create Categories From H&P Template [DEV-47622]
		When I select the department "Autocreated-%Current Date%-"
		And I click the "Edit" button in the "Quick Details" pane
		And I select "NoteWriter" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
		Then the "Department NoteWriter Settings" pane should load
		When I click the "Quick Text (Summary View)" edit link in the "Department General Settings" pane
		And I wait "2" seconds
		Then the "Department Quick Text Editor" pane should load
		#Table holds a row even if there is no pickers, Hence checking row count(=1) to validate no Dept QT pickers available for newly created departmnet
		And the "QuickText Department Pickers" table should have "1" rows
		When I click the "Create Categories From Note Template" button in the "Department Quick Text Editor Content" pane
		And I wait "2" seconds
		Then the "Select Note Template" pane should load
		When I enter "History and Physical" in the "Template" field in the "Select Note Template Content" pane
		And I click the "Select Note Template Search" button in the "Select Note Template Content" pane
		And I click the "OK" button in the "Select Note Template Content" pane
		#Then the "Select Note Template" pane should close
		And the following links should display in the "Department Quick Text Editor Content" pane
			|History               |
			|Family/Social History |
			|ROS                   |
			|Exam                  |
			|Diagnostics           |
			|A/P                   |
		When I click the "Delete All Pickers" button in the "Department Quick Text Editor Content" pane
		And I click the "Yes" button in the "Question" pane
		When I click the "Close" button in the "Department Quick Text Editor Content" pane
		#Then the "Department Quick Text Editor" pane should close
	
	@NoteWriter
	Scenario: As Admin0 Create Categories From Progress Note Template [DEV-47622]
		When I select the department "Autocreated-%Current Date%-"
		And I click the "Edit" button in the "Quick Details" pane
		And I select "NoteWriter" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
		And I click the "Quick Text (Summary View)" edit link in the "Department General Settings" pane
		And I wait "2" seconds
		And I click the "Create Categories From Note Template" button in the "Department Quick Text Editor Content" pane
		And I wait "2" seconds
		And I enter "Progress Note" in the "Template" field in the "Select Note Template Content" pane
		And I click the "Select Note Template Search" button in the "Select Note Template Content" pane
		And I click the "OK" button in the "Select Note Template Content" pane
		Then the following links should display in the "Department Quick Text Editor Content" pane
			|Subjective |
			|Exam       |
			|Data       |
			|A/P        |
		When I click the "Delete All Pickers" button in the "Department Quick Text Editor Content" pane
		And I click the "Yes" button in the "Question" pane
		And I click the "Close" button in the "Department Quick Text Editor Content" pane
		
	@NoteWriter
	Scenario: As Admin1 Create Categories From H&P Template [DEV-47622]
		When I select the "User" subtab
		Given the user "user1 nw" with username "nwuser1" and password "!password" is in the user list
		And I select the user "nwuser1"
		And I click the "Edit" button in the "Quick Details" pane
		And I edit the following user settings and I click save
			|Page    |Name                  |Type     |Value   |
			|General |GeneralPATAccessLevel |dropdown |Level 1 |
		Given I am logged into the portal with user "nwuser1" using the default password
		And I am on the "Admin" tab
		And I select the "Department" subtab
		And I select the department "Autocreated-%Current Date%-"
		And I click the "Edit" button in the "Quick Details" pane
		And I select "NoteWriter" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
		Then the "Department NoteWriter Settings" pane should load
		When I click the "Quick Text (Summary View)" edit link in the "Department General Settings" pane
		And I wait "2" seconds
		Then the "Department Quick Text Editor" pane should load
		#Table holds a row even if there is no pickers, Hence checking row count(=1) to validate no Dept QT pickers available for newly created departmnet
		And the "QuickText Department Pickers" table should have "1" rows
		When I click the "Create Categories From Note Template" button in the "Department Quick Text Editor Content" pane
		And I wait "2" seconds
		Then the "Select Note Template" pane should load
		When I enter "History and Physical" in the "Template" field in the "Select Note Template Content" pane
		And I click the "Select Note Template Search" button in the "Select Note Template Content" pane
		And I click the "OK" button in the "Select Note Template Content" pane
		#Then the "Select Note Template" pane should close
		And the following links should display in the "Department Quick Text Editor Content" pane
			|History               |
			|Family/Social History |
			|ROS                   |
			|Exam                  |
			|Diagnostics           |
			|A/P                   |
		And I wait "2" seconds
		When I click the "Delete All Pickers" button in the "Department Quick Text Editor Content" pane
		And I click the "Yes" button in the "Question" pane
		When I click the "Close" button in the "Department Quick Text Editor Content" pane
		#Then the "Department Quick Text Editor" pane should close
			
	@NoteWriter
	Scenario: As Admin1 Create Categories From Progress Note Template [DEV-47622]
		Given I am logged into the portal with user "nwuser1" using the default password
		And I am on the "Admin" tab
		And I select the "Department" subtab
		When I select the department "Autocreated-%Current Date%-"
		And I click the "Edit" button in the "Quick Details" pane
		And I select "NoteWriter" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
		And I click the "Quick Text (Summary View)" edit link in the "Department General Settings" pane
		And I click the "Create Categories From Note Template" button in the "Department Quick Text Editor Content" pane
		And I wait "2" seconds
		And I enter "Progress Note" in the "Template" field in the "Select Note Template Content" pane
		And I click the "Select Note Template Search" button in the "Select Note Template Content" pane
		And I click the "OK" button in the "Select Note Template Content" pane
		Then the following links should display in the "Department Quick Text Editor Content" pane
			|Subjective |
			|Exam       |
			|Data       |
			|A/P        |
		And I click the "Close" button in the "Department Quick Text Editor Content" pane
	
	@NoteWriter
	Scenario: As Admin0 Add New Quick Text For New Department
		Given the following note pickers should be available for the "Autocreated-%Current Date%-" department
			|Progress Note        |
			|History and Physical |
		And I wait "2" seconds
		And I select "Progress Note (Dept)" from the "Quick Text Template View" dropdown
		And I click the "Quick Text (Template View)" edit link in the "Department General Settings" pane
		Then the "Note Writer Quick Text Admin View" pane should load
		When I select the note "Exam" section in the "NoteWriter Quick Text Admin View Content" pane
		And I wait "3" seconds
		And I click the "Exam RESP Normal" element in the "Note Instance Edit" pane
		And I click the "Exam Resp ABC" image in the "Note Instance Edit" pane
		Then the "Click To Insert" pane should load
		When I click the "Add" button in the click to insert "RESPIRATORY" popup in the "Exam" section
		And I wait "2" seconds
		Then the "Quick Text" pane should load
		And the "Quick Text" pane title should be "Quick Text for RESPIRATORY"
		And I wait "3" seconds
		When I select "All Quick Text Groupings" from the "Display" dropdown
		Then "All Quick Text Groupings" should be selected in the "Display" dropdown
		When I click the "New Quick Text" button in the "Quick Text Content" pane
		And I wait "2" seconds
		Then the "New Quick Text" pane should load
		And the "New Quick Text" pane title should be "New Quick Text for RESPIRATORY"
		When I enter "test" in the "Label" field in the "New Quick Text Content" pane
		#And I select "QuestionExamResp" from the "Grouping" dropdown
		And I click the "Text to Insert" element in the "New Quick Text Content" pane
		Then the value in the "Label" field should be "test"
		And the value in the "Text to Insert" field should be "test"
		And the value in the "Shortcut" field should be "test"
		When I click the "Add" button in the "New Quick Text Content" pane
		Then the following rows should appear in the "New Quick Text" table
			|Label |Text to Insert |Shortcut |
			|test  |test           |test     |
		When I click the "Save" button in the "New QuickText Content" pane
		#Then the "New Quick Text" pane should close
		And the following rows should appear in the "Quick Text" table
			|Label |Text to Insert |Shortcut |
			|test  |test           |test     |
		And the following links should display in the "Quick Text Content" pane
			|test |	
		When I click the "Close" button in the "Quick Text Content" pane
		Then the "Click To Insert" pane should load
		When I click the "Close" button in the "NoteWriter QuickText Admin View Content" pane
		#Then the "Note Writer Quick Text Admin View" pane should close

	@NoteWriter
	Scenario: As Admin0 Edit Quick Text
		When I select the department "Autocreated-%Current Date%-"
		And I click the "Edit" button in the "Quick Details" pane
		And I navigate to the note writer quick text admin view page for selected "Progress Note (Dept)" quick text template
		When I select the note "Exam" section in the "NoteWriter Quick Text Admin View Content" pane
		And I wait "2" seconds
		When I click the "ExamRESPNormal" element in the "Note Instance Edit" pane
		And I click the "ExamRespABC" image in the "Note Instance Edit" pane
		When I click the "Edit" button in the click to insert "RESPIRATORY" popup in the "Exam" section
		And I wait "2" seconds
		And I click the "test" link in the "Quick Text Content" pane
		Then the "QuickText" pane should load
		And the "QuickText" pane title should be "Quick Text for RESPIRATORY"
		And I click the "test" link in the "Quick Text Content" pane
		And I enter "retest" in the "Label" field
		And I click the "Text to Insert" element in the "New Quick Text Content" pane
		Then the value in the "Label" field should be "retest"
		#Verify already displayed 'Text To Insert'  text value is unchanged.
		And the value in the "Text to Insert" field should be "test"
		When I enter "retest" in the "Text to Insert" field
		Then the value in the "Text to Insert" field should be "retest"
		When I click the "Save" button in the "Edit QuickText Content" pane
		#Then the "Edit Quick Text" pane should close
		And the following rows should appear in the "Quick Text" table
			|Label  |Text to Insert |Shortcut |
			|retest |retest         |test     |
		And the following links should display in the "Quick Text Content" pane
			|retest |	
		When I click the "Close" button in the "Quick Text Content" pane
		Then the "Click To Insert" pane should load
		When I click the "Close" button in the "NoteWriter QuickText Admin View Content" pane
		#Then the "Note Writer Quick Text Admin View" pane should close
	
	@NoteWriter
	Scenario: Dept Quick Text Label Default Set And Modify
		When I select the department "Autocreated-%Current Date%-"
		And I click the "Edit" button in the "Quick Details" pane
		And I select "NoteWriter" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
		And I click the "Quick Text (Summary View)" edit link in the "Department General Settings" pane
		And I wait "2" seconds
		Then the "Department Quick Text Editor" pane should load
		When I click the "QuestionExamResp" edit category link in the "Department QuickText Editor Content" pane
		And I wait "2" seconds
		Then the "Edit Department Pickers Header" pane should load
		And the "Edit Department Pickers Header" pane title should be "Edit Department Pickers / Exam / QuestionExamResp"
		And The following fields should be enabled in the "Edit Department Pickers" pane
			|Name             |Type   |
			|Add Text         |button |
			|Add CategoryDept |button |
		When I click the "Add Text" button in the "Edit Department Pickers" pane
		And I wait "3" seconds
		Then the "Add Quick Text" pane should load
		And I enter "Kung Fu Panda" in the "AddQuickTextLabel" field
		Then the value in the "Add Quick TextLabel" field should be "Kung Fu Panda"
		When I enter "KFP" in the "Add Quick TextKeyboard Shortcut" field
		Then the value in the "Add Quick TextKeyboard Shortcut" field should be "KFP"
		And the value in the "Text to Insert" field should be "Kung Fu Panda"
		When I check the "Default" checkbox in the "Add Quick Text Content" pane
		Then the following should be checked in the "Add Quick Text Content" pane
			|Default |
		When I click the "Save" button in the "Add Quick Text Content" pane
		#Then the "Add Quick Text" pane should close
		When I click the "Save" button in the "Edit Department Pickers" pane
		#Then the "Edit Department Pickers Header" pane should close
		And the text "Kung Fu Panda" should appear in the "Department Quick Text Editor Content" pane
		When I click the "QuestionExamResp" edit category link in the "Department Quick Text Editor Content" pane
		And I wait "2" seconds
		And I click the "Kung Fu Panda" link in the "Edit Department Pickers" pane
		And I wait "2" seconds
		And I enter "Kung Fu Panda an animated movie" in the "Text to Insert" field
		And I check the "Default" checkbox in the "Add Quick Text Content" pane
		And I click the "Save" button in the "Add Quick Text Content" pane
		Then the text "Kung Fu Panda an animated movie" should appear in the "Edit Department Pickers" pane
		When I click the "Kung Fu Panda" link in the "Edit Department Pickers" pane
		And I wait "2" seconds
		Then the value in the "AddQuickTextLabel" field should be "Kung Fu Panda"
		And the value in the "Text to Insert" field should be "Kung Fu Panda an animated movie"
		And the value in the "Add Quick TextKeyboard Shortcut" field should be "KFP"
		#Then the text in the "Add Quick Text...Label" note field should be "Kung Fu Panda"
		#And the text in the "Add Quick Text...Keyboard Shortcut" note field should be "KFP"
		#And the text in the "AddQuickText...TexttoInsert" note field should be "Kung Fu Panda an animated movie"
		Then the following should be checked in the "Add Quick Text Content" pane
			|Default |
		Then The following fields should be enabled in the "Add Quick Text Content" pane
			|Name   |Type   |
			|Save   |button |
			|Cancel |button |
		When I click the "Save" button in the "Add Quick Text Content" pane
		And I click the "Save" button in the "Edit Department Pickers" pane
		And I click the "Close" button in the "Department Quick Text Editor Content" pane
		
	@NoteWriter
	Scenario: QT Label Default
		When I select the department "Autocreated-%Current Date%-"
		And I click the "Edit" button in the "Quick Details" pane
		And I select "NoteWriter" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
		And I select "Progress Note (Dept)" from the "QuickText Template View" dropdown in the "Department NoteWriter Settings" pane
		And I click the "Quick Text (Template View)" edit link in the "Department NoteWriter Settings" pane
		And I wait "2" seconds
		And I select the note "Exam" section in the "NoteWriter Quick Text Admin View Content" pane
		And I wait "3" seconds
		And I click the "Exam RESP Normal" element in the "Note Instance Edit" pane
		And I click the "Exam Resp ABC" image in the "Note Instance Edit" pane
		And I click the "Edit" button in the click to insert "RESPIRATORY" popup in the "Exam" section
		And I click the "New Quick Text" button
		And I wait "3" seconds
		#Enter less than 2 characters(minimum 1 character) into Label field and Validate Value not defaults into "Text to Insert" and Shortcut fields
		And I select "QuestionExamResp" from the "Grouping" dropdown
		When I enter "T" in the "Label" field in the "New Quick Text Content" pane
		And the value in the "Text to Insert" field should be ""
		And the value in the "Shortcut" field should be ""
		#Enter 2-5 characters (less than 6) into Label field and Validate Value defaults into "Text to Insert" and Shortcut fields
		When I enter "Test1" in the "Label" field in the "New Quick Text Content" pane
		And I select "QuestionExamResp" from the "Grouping" dropdown
		And I click the "Text to Insert" element in the "New Quick Text Content" pane
		Then the value in the "Text to Insert" field should be "Test1"
		And the value in the "Shortcut" field should be "Test1"
		When I click the "Add" button in the "New Quick Text Content" pane
		Then the following rows should appear in the "New Quick Text" table
			|Label |Text to Insert |Shortcut |Grouping         |
			|Test1 |Test1          |Test1    |QuestionExamResp |
		#Enter more than 6 characters into Label field and Validate Value defaults into "Text to Insert" but not into Shortcut fields
		When I enter "Test1236" in the "Label" field in the "New Quick Text Content" pane
		And I click the "Text to Insert" element in the "New Quick Text Content" pane
		And I select "QuestionExamResp" from the "Grouping" dropdown
		Then the value in the "Text to Insert" field should be "Test1236"
		Then the value in the "Shortcut" field should be ""
		When I click the "Add" button in the "New Quick Text Content" pane
		Then the following rows should appear in the "New Quick Text" table
			|Label    |Text to Insert |Shortcut |Grouping         |
			|Test1    |Test1          |Test1    |QuestionExamResp |
			|Test1236 |Test1236       |         |QuestionExamResp |
		When I click the "Save" button in the "New Quick Text Content" pane
		Then the following rows should appear in the "Quick Text" table
			|Label    |Text to Insert |Shortcut |
			|Test1    |Test1          |Test1    |
			|Test1236 |Test1236       |         |
		And the following links should display in the "Quick Text Content" pane
			|Test1    |
			|Test1236 |
		When I click the "Close" button in the "Quick Text Content" pane
	#	Then the "Quick Text" pane should close
		When I click the "Close" button in the "NoteWriter QuickText Admin View Content" pane
		#Then the "Note Writer Quick Text Admin View" pane should close
	
	@NoteWriter 
	Scenario: Quick Text Shortcut Keys Are Not Case Sensitive [DEV-47861]
		#Create Quick Text using lower case
		When I select the department "Autocreated-%Current Date%-"
		And I click the "Edit" button in the "Quick Details" pane
		And I navigate to the note writer quick text admin view page for selected "Progress Note (Dept)" quick text template
		And I select the note "Exam" section in the "NoteWriter Quick Text Admin View Content" pane
		And I click the "Exam RESP Normal" element in the "Note Instance Edit" pane
		And I click the "Exam Resp ABC" image in the "Note Instance Edit" pane
		And I click the "Edit" button in the click to insert "RESPIRATORY" popup in the "Exam" section
		And I click the "New Quick Text" button in the "Quick Text Content" pane
		And I wait "2" seconds
		And I enter "noteshortcut" in the "Label" field
		And I enter "nsc" in the "Shortcut" field
		#And I select "QuestionExamResp" from the "Grouping" dropdown
		And I click the "Add" button in the "New Quick Text Content" pane
		Then the following rows should appear in the "New Quick Text" table
			|Label        |Text to Insert |Shortcut |Grouping         |
			|noteshortcut |noteshortcut   |nsc      |                 |
		When I click the "Save" button in the "New QuickText Content" pane
		And I click the "Close" button in the "Quick Text Content" pane
		#Then the "Quick Text" pane should close
		#Validate Lower case Shortcut key is incasesensitive
		When I enter "nsc" in the "Exam Respiratory" field
		#press space bar to trigger short cut key then back space to remove extra space
		And I click the "space" key in the "Exam Respiratory" field
		And I click the "backspace" key in the "Exam Respiratory" field
		Then the value in the "Exam Respiratory" field should be "noteshortcut"
		#Validate Upper case Shortcut key is incasesensitive
		When I enter "NSC" in the "Exam Respiratory" field
		And I click the "space" key in the "Exam Respiratory" field
		And I click the "backspace" key in the "Exam Respiratory" field
		Then the value in the "Exam Respiratory" field should be "noteshortcut"
		#Validate Any case combination Shortcut key is incasesensitive
		When I enter "nSc" in the "Exam Respiratory" field
		And I click the "space" key in the "Exam Respiratory" field
		And I click the "backspace" key in the "Exam Respiratory" field
		Then the value in the "Exam Respiratory" field should be "noteshortcut"
		When I click the "Close" button in the "Note Writer Quick Text Admin View" pane
		#Then the "Note Writer Quick Text Admin View" pane should close
		
	@NoteWriter
	Scenario: User Confirmation to Delete QT
		When I select the "User" subtab
		Given the user "user nw3" with username "nwuser3" and password "!password" is in the user list
		And I select the user "nwuser3"
		And I click the "Edit" button in the "Quick Details" pane
		And I edit the following user settings and I click save
			|Page       |Name                      |Type     |Value   |
			|NoteWriter |User Can Search for Notes |dropdown |All     |
		And the user "nwuser3" is associated with the "Autocreated-%Current Date%-" department
		Given I am logged into the portal with user "nwuser3" using the default password
		When I am on the "Patient List V2" tab
		And "MOLLY DARR" is on the patient list
		#may give warning about something
		And I click the "OK" button in the "Information" pane if it exists
		When I select patient "Molly Darr" from the patient list
		#removed few steps as per the updated note writer step definition
		And I load the "Progress Note" template note for the selected patient
		And I select the note "Data" section
		And I click the "Allergies" link in the "NoteWriter" pane
		And I wait "2" seconds
		Then the "Patient Data" pane should load
		When I click the "NoteWriter Preselection Icon" image in the "Allergy List" pane
		And I click the "Copy to Note" button
		And I wait "2" seconds
		And I click the "OK" button in the "Warning" pane if it exists
		And I click the "Annotation" element in the "Note Writer" pane
		And I click the "Annotation ABC" image in the "Note Writer" pane
		Then the "Click To Insert" pane should load
		When I click the "Add" button in the click to insert "Annotation" popup in the "Data" section
		And I wait "2" seconds
		Then the "Add Quick Text" pane should load
		And I wait "2" seconds
		And I enter "notetext1" in the "AddQuickTextLabel" note field
		And I enter "ntxt1" in the "AddQuickTextShortCut" note field
		And I click the "SaveNw" button in the "Add QuickText Content" pane
		And I click the "Annotation ABC" image in the "Note Writer" pane
		Then the "Click To Insert" pane should load
		When I click the "Add" button in the click to insert "Annotation" popup in the "Data" section
		And I enter "notetext2" in the "AddQuickTextLabel" note field
		And I enter "ntxt2" in the "AddQuickTextShortCut" note field
		And I click the "SaveNw" button in the "Add QuickText Content" pane
		And I click the "Annotation ABC" image in the "Note Writer" pane
		And I click the "Edit" button in the click to insert "Annotation" popup in the "Data" section
		And I wait "2" seconds
		Then the "Edit Quick Text" pane should load
		And I wait "2" seconds
		When I click the "Delete" button in the "Edit Quick Text Content" pane
		Then the text "Are you sure you want to delete this Quick Text item?" should appear in the "Question" pane
		And the following fields should display in the "Question" pane
			|Name |Type   |
			|Yes  |button |
			|No   |button |
		When I click the "Yes" button in the "Question" pane
		And I click the "SaveNw" button in the "Edit Quick Text Content" pane
		And I click the "Annotation ABC" image in the "Note Writer" pane
		And I click the "Edit" button in the click to insert "Annotation" popup in the "Data" section
		Then the "Edit Quick Text" pane should load
		And the "Edit Quick Text" table should have "1" rows not containing the text "notetext1"
		# deleting second note text 
		When I click the "Delete" button in the "Edit Quick Text Content" pane
		And the text "Are you sure you want to delete this Quick Text item?" should appear in the "Question" pane
		And I click the "Yes" button in the "Question" pane
		And I click the "SaveNw" button in the "Edit Quick Text Content" pane
		#Then the "Edit Quick Text" pane should close
		
	@NoteWriter
	Scenario: User DefaultText
		Given I am logged into the portal with user "nwuser3" using the default password
		And I am on the "Patient List V2" tab
		And "MOLLY DARR" is on the patient list
		When I select patient "Molly Darr" from the patient list
		#removed few steps as per the updated note writer step definition
		And I load the "Progress Note" template note for the selected patient
		And I select the note "Exam" section
		And I click the "Exam EENT Normal" element in the "Note Writer" pane
		And I click the "Exam EENT ABC" image in the "Note Writer" pane
		Then the "Click To Insert" pane should load
		When I click the "Edit" button in the click to insert "EENT" popup in the "Exam" section
		Then the "Edit Quick Text" pane should load
		Then the following field should not display in the "Edit Quick Text" pane
			|Name    |Type  |
			|Default |check |
		And I click the "Cancel" button in the "Edit Quick TextContent" pane
		
	@NoteWriter
	Scenario: Adv Temp User No Preference Edit QT Option
		Given I am logged into the portal with user "nwuser3" using the default password
		And I am on the "Preferences" tab
		Then the "Personal Preference" pane should load
		When I select "NoteWriter" from the "Edit Settings" dropdown in the "Personal Preference" pane
		Then the "Preference NoteWriter Settings" pane should load
		And the text "Quick Text" should not appear in the "NoteWriter Settings Table" section in the "Preference NoteWriter Settings" pane

	@NoteWriter
	Scenario: NW Icon Not Enabled Not able to Edit Draft
		# create a draft note
		Given I am logged into the portal with user "nwuser3" using the default password
		And I am on the "Patient List V2" tab
		And "Molly Darr" is on the patient list
		When I select patient "Molly Darr" from the patient list
		# may give warning about something
		And I click the "OK" button in the "Information" pane if it exists
		#removed few steps as per the updated note writer step definition
		And I load the "Progress Note" template note for the selected patient
		#Then the "Save as Draft" button should clickable
		And I click the "Save as Draft" button
		And I click the "Yes" button in the "Question" pane
		#Disable Note Writer Option
		Given I am logged into the portal with the default user
		And I am on the "Admin" tab
		And I select the "Institution" subtab
		And I select "Site Administration" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
		And I select "false" from the "NoteWriter" radio list in the "Site Administration" pane
		And I click the "Save" button
		And I click "OK" in the confirmation box
		When I am logged into the portal with user "nwuser3" using the default password
		And I am on the "Patient List V2" tab
		Then the following tab should not load
			|Note Search |
		When I select patient "Molly Darr" from the patient list
		#Then the "Patient Header Actions" menu should not have the following option
		#	|Write Note |
		And I select "Clinical Notes" from clinical navigation
		And the following field should not display in the "Clinical Notes" pane
			|Name           |Type  |
			|NoteWriterIcon |image |
		And I select "*DRAFT* Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
		Then the "Progress Note" pane should load
		And the following field should not display in the "Progress Note" pane
			|Name |Type   |
			|Edit |button |
		And the following field should display in the "Progress Note" pane
			|Name   |Type   |
			|Delete |button |
		And I click the "Delete" button in the "Progress Note" pane
		And I click the "Yes" button in the "Question" pane
		
	@NoteWriter
	Scenario: Enable NoteWriter in Institution settings
		#Revertback the NoteWriter Settings in the Site Administration Page
		When I am logged into the portal with user "nwadmin" using the default password
		And I am on the "Admin" tab
		And I select the "Institution" subtab
		And I select "Site Administration" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
		And I select "true" from the "NoteWriter" radio list in the "Site Administration" pane
		And I click the "Save" button	
		And I click "OK" in the confirmation box
	
	@NoteWriter
	Scenario: User Attempt to Edit Delete Department QT
		When I select the department "Autocreated-%Current Date%-"
		And I click the "Edit" button in the "Quick Details" pane
		And I navigate to the note writer quick text admin view page for selected "Progress Note (Dept)" quick text template
		And I select the note "Exam" section in the "NoteWriter Quick Text Admin View Content" pane
		And I wait "4" seconds
		Then the "Exam" pane should load within "5" seconds
		And I click the "Exam CONST Normal" element in the "Note Instance Edit" pane
		Then the text "CONSTITUTIONAL:" should appear in the "Note Instance Edit" pane
		When I click the "Exam Const ABC" image in the "Note Instance Edit" pane
		Then the "Click To Insert" pane should load
		When I click the "Edit" button in the click to insert "CONSTITUTIONAL" popup in the "Exam" section
		And I wait "2" seconds
		Then the "Quick Text" pane should load
		When I click the "New Quick Text" button
		And I wait "2" seconds
		And I enter "qtexam" in the "Label" field
		And I click the "Add" button in the "New QuickText Content" pane
		Then the "New Quick Text" table should have "1" rows containing the text "qtexam"
		When I click the "Save" button in the "New QuickText Content" pane
		#Then the "New Quick Text" pane should close
		And the "Quick Text" pane should load
		#And the "Quick Text" table should have "1" rows containing the text "qtexam"
		When I click the "Close" button in the "Quick Text Content" pane
		And I click the "Close" button in the "NoteWriter QuickText Admin View Content" pane
		When I am logged into the portal with user "nwuser3" using the default password
		And I am on the "Patient List V2" tab
		And "Molly Darr" is on the patient list
		And I select patient "Molly Darr" from the patient list
		#removed few steps as per the updated note writer step definition
		And I load the "Progress Note" template note for the selected patient
		And I select the note "Exam" section
		And I click the "Exam CONST Normal" element in the "NoteWriter" pane
		Then the text "CONSTITUTIONAL:" should appear in the "NoteWriter" pane
		When I click the "Exam Const ABC" image in the "NoteWriter" pane
		And I click the "Edit" button in the click to insert "CONSTITUTIONAL" popup in the "Exam" section
		Then The following field should be disabled in the "Edit Quick Text Content" pane
			|Name   |Type   |
			|Delete |button |			

	@NoteWriter
	Scenario: Quick Text Question Titles Test Results
		#Isolated the Lab Results scenario into five scenarios based on the functionality
		Given I am logged into the portal with user "nwuser3" using the default password
		And I am on the "Patient List V2" tab
		And "Molly Darr" is on the patient list
		And I select patient "Molly Darr" from the patient list
		#Verify the Question label for Subjective Note & ROS
		#removed few steps as per the updated note writer step definition
		And I load the "Progress Note" template note for the selected patient
		And I select the note "Data" section
		## Verify the Question label for Test Results
		When I click the "Test Results" link in the "NoteWriter" pane
		And I wait "2" seconds
		#Then the "TestResult List" pane should load
		#And I click the "Refresh" image in the "PatientDataHeader" pane
		Then the "Patient Data" pane should load
		And I click the "NoteWriter Preselection Icon" image in the "TestResultList" pane
		And I click the "Copy to Note" button
		And I click the "OK" button in the "Warning" pane if it exists
		And I click the "Annotation" image in the "NoteWriter" pane
		And I click the "Annotation ABC" element in the "NoteWriter" pane
		Then the "Click To Insert" pane should load
		When I click the "Add" button in the click to insert "Annotation" popup in the "Data" section
		Then the "Add Quick Text" pane should load
		When I click the "Cancel" button in the "AddQuickText Content" pane
		#Then the "Add Quick Text" pane should close
		When I click the "Annotation ABC" element in the "NoteWriter" pane
		And I click the "Edit" button in the click to insert "Annotation" popup in the "Data" section
		Then the "Edit Quick Text" pane should load
		When I click the "Cancel" button in the "Edit QuickText Content" pane
		#Then the "Edit Quick Text" pane should close
		And I click the "Remove Clinical Data" element in the "NoteWriter" pane
		And I click the "Cancel" button in the "NoteWriter Main" pane
		And I click the "Yes" button in the "Question" pane
	
	@NoteWriter  
	Scenario: Quick Text Question Titles Lab Results
		Given I am logged into the portal with user "nwuser3" using the default password
		And I am on the "Patient List V2" tab
		And "Molly Darr" is on the patient list
		And I select patient "Molly Darr" from the patient list
		And I load the "Progress Note" template note for the selected patient
		And I select the note "Data" section
		When I click the "Lab Results" link in the "NoteWriter" pane
		And I wait "3" seconds
		#And I click the "Refresh" image in the "PatientDataHeader" pane
		Then the "Patient Data" pane should load
		And I click the "NoteWriter Preselection Icon" image in the "LabList" pane
		And I click the "Copy to Note" button
		And I click the "OK" button in the "Warning" pane if it exists
		And I click the "Annotation" image in the "NoteWriter" pane
		And I click the "Annotation ABC" element in the "NoteWriter" pane
		Then the "Click To Insert" pane should load
		And I click the "Add" button in the click to insert "Annotation" popup in the "Data" section
		Then the "Add Quick Text" pane should load
		When I click the "Cancel" button in the "Add QuickText Content" pane
		#Then the "Add Quick Text" pane should close
		When I click the "Annotation ABC" image in the "NoteWriter" pane
		And I click the "Edit" button in the click to insert "Annotation" popup in the "Data" section
		Then the "Edit Quick Text" pane should load
		When I click the "Cancel" button in the "Edit QuickText Content" pane
		#Then the "Edit Quick Text" pane should close
		And I click the "Remove Clinical Data" image in the "NoteWriter" pane
		And I click the "Cancel" button in the "NoteWriter Main" pane
		And I click the "Yes" button in the "Question" pane
		
	@NoteWriter  
	Scenario: Quick Text Question Titles Meds
		Given I am logged into the portal with user "nwuser3" using the default password
		And I am on the "Patient List V2" tab
		And "Molly Darr" is on the patient list
		And I select patient "Molly Darr" from the patient list
		And I load the "Progress Note" template note for the selected patient
		And I select the note "Data" section
		When I click the "Medications" link in the "NoteWriter" pane
		And I wait "2" seconds
		#Then the "Medication List" pane should load
		#And I click the "Refresh" image in the "PatientDataHeader" pane
		Then the "Patient Data" pane should load
		And I click the "NoteWriter Preselection Icon" image in the "Medication List" pane
		And I click the "Copy to Note" button
		And I click the "OK" button in the "Warning" pane if it exists
		And I click the "Annotation" image in the "NoteWriter" pane
		And I click the "Annotation ABC" element in the "NoteWriter" pane
		Then the "Click To Insert" pane should load
		When I click the "Add" button in the click to insert "Annotation" popup in the "Data" section
		#Then the "Add Quick Text" pane should close
		When I click the "Cancel" button in the "Add QuickText Content" pane
		Then the "Add Quick Text" pane should load
		When I click the "Annotation ABC" image in the "NoteWriter" pane
		And I click the "Edit" button in the click to insert "Annotation" popup in the "Data" section
		Then the "Edit Quick Text" pane should load
		And I click the "Cancel" button in the "Edit QuickText Content" pane
		#Then the "Edit Quick Text" pane should close
		And I click the "Remove Clinical Data" image in the "NoteWriter" pane
		And I click the "Cancel" button in the "NoteWriter Main" pane
		And I click the "Yes" button in the "Question" pane
	
	@NoteWriter  
	Scenario: Quick Text Question Titles Clinical Notes
		Given I am logged into the portal with user "nwuser3" using the default password
		And I am on the "Patient List V2" tab
		And "Molly Darr" is on the patient list
		And I select patient "Molly Darr" from the patient list
		And I load the "Progress Note" template note for the selected patient
		And I select the note "Data" section
		When I click the "Clinical Notes" link in the "NoteWriter" pane
		And I wait "2" seconds
		#Then the "Clinical Note List" pane should load
		#And I click the "Refresh" image in the "PatientDataHeader" pane
		Then the "Patient Data" pane should load
		And I click the "NoteWriter Preselection Icon" image in the "Clinical Note List" pane
		And I click the "Copy to Note" button
		And I click the "OK" button in the "Warning" pane if it exists
		And I click the "Annotation" image in the "NoteWriter" pane
		And I click the "Annotation ABC" element in the "NoteWriter" pane
		Then the "Click To Insert" pane should load
		When I click the "Add" button in the click to insert "Annotation" popup in the "Data" section
		Then the "Add Quick Text" pane should load
		When I click the "Cancel" button in the "Add QuickText Content" pane
		#Then the "Add Quick Text" pane should close
		When I click the "Annotation ABC" image in the "NoteWriter" pane
		And I click the "Edit" button in the click to insert "Annotation" popup in the "Data" section
		Then the "Edit Quick Text" pane should load
		When I click the "Cancel" button in the "Edit QuickText Content" pane
		#Then the "Edit Quick Text" pane should close
		And I click the "Remove Clinical Data" image in the "NoteWriter" pane
		And I click the "Cancel" button in the "NoteWriter Main" pane
		And I click the "Yes" button in the "Question" pane
		
	@NoteWriter
	Scenario: Quick Text Question Titles Subjective CCHPIROS
		# Isolated the scenario into two scenarios based on the functionality
		When I am logged into the portal with user "nwuser3" using the default password
		And I am on the "Patient List V2" tab
		And "Molly Darr" is on the patient list
		And I select patient "Molly Darr" from the patient list
		#Verify the Question label for Subjective Note & ROS
		#removed few steps as per the updated note writer step definition
		And I load the "Progress Note" template note for the selected patient
		And I select the note "Subjective" section
		And I click the "Patient narrative ABC" image in the "NoteWriter" pane
		Then the "Click To Insert" pane should load
		When I click the "Add" button in the click to insert "Patientnarrative" popup in the "Subjective" section
		Then the "Add Quick Text" pane should load
		When I click the "Cancel" button in the "Add QuickText Content" pane
		#Then the "Add Quick Text" pane should close
		When I click the "Patient narrative ABC" image in the "NoteWriter" pane
		And I click the "Edit" button in the click to insert "Patientnarrative" popup in the "Subjective" section
		Then the "Edit Quick Text" pane should load
		When I click the "Cancel" button in the "Edit QuickText Content" pane
		#Then the "Edit Quick Text" pane should close
		When I click the "ROS CONST Normal" element in the "NoteWriter" pane
		And I click the "ROS CONSTITUTIONAL ABC" image in the "NoteWriter" pane
		Then the "Click To Insert" pane should load
		When I click the "Add" button in the click to insert "CONSTITUTIONAL" popup in the "Subjective" section
		Then the "Add Quick Text" pane should load
		When I click the "Cancel" button in the "Add QuickText Content" pane
		And I click the "ROS CONSTITUTION ALABC" image in the "NoteWriter" pane
		Then the "Click To Insert" pane should load
		When I click the "Edit" button in the click to insert "CONSTITUTIONAL" popup in the "Subjective" section
		Then the "Edit Quick Text" pane should load
		When I click the "Cancel" button in the "Edit QuickText Content" pane
		And I click the "Cancel" button in the "NoteWriter Main" pane
		And I click the "Yes" button in the "Question" pane
	
	@NoteWriter
	Scenario: Quick Text Question Titles History CCHPIROS
		#Verify the Question label for Chief Complaint & History of Present Illness
		When I am logged into the portal with user "nwuser3" using the default password
		And I am on the "Patient List V2" tab
		And "Molly Darr" is on the patient list
		And I select patient "Molly Darr" from the patient list
		#removed few steps as per the updated note writer step definition
		And I load the "History and Physical" template note for the selected patient
		And I select the note "History" section
		When I click the "History of Present Illness ABC" image in the "NoteWriter" pane
		Then the "Click To Insert" pane should load
		When I click the "Add" button in the click to insert "PresentIllness" popup in the "History" section
		Then the "Add Quick Text" pane should load
		When I click the "Cancel" button in the "Add QuickText Content" pane
		#Then the "Add Quick Text" pane should close
		When I click the "History of Present Illness ABC" image in the "NoteWriter" pane
		Then the "Click To Insert" pane should load
		When I click the "Edit" button in the click to insert "PresentIllness" popup in the "History" section
		#Then the "Edit Quick Text" pane should load
		When I click the "Cancel" button in the "Add QuickText Content" pane
		#Then the "Edit Quick Text" pane should close
		And I click the "Cancel" button in the "NoteWriter Main" pane
		And I click the "Yes" button in the "Question" pane
			
	@NoteWriter
	Scenario: No Quick Text Defined
		When I select the "User" subtab
		#Given the user with username "nwuser1" is in the user list
		Given the user "user1 nw" with username "nwuser1" and password "!password" is in the user list
		And I select the user "nwuser1"
		And I click the "Edit" button in the "Quick Details" pane
		And I edit the following user settings and I click save
			|Page       |Name                      |Type     |Value   |
			|General    |GeneralPATAccessLevel     |dropdown |Level 1 |
			|NoteWriter |User Can Search for Notes |dropdown |All     |
		And the user "nwuser1" is associated with the "Autocreated-%Current Date%-" department
		And I am logged into the portal with user "nwuser1" using the default password
		And I am on the "Admin" tab
		And I select the "Preferences" subtab
		And I select "NoteWriter" from the "Edit User Settings" dropdown in the "Personal Preferences" pane
		And I click the "Quick Text (Summary View)" edit link in the "Note Writer Settings" pane
		And I wait "2" seconds
		Then the "Quick Text Editor" pane should load
		And I click the "Close" button in the "Quick Text Editor Content" pane
		And I am logged into the portal with user "nwadmin" using the default password
		And I am on the "Admin" tab
		And I select the "Department" subtab
		And I select the department "Autocreated-%Current Date%-"
		And I click the "Edit" button in the "Quick Details" pane
		And I select "NoteWriter" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
		And I click the "Note Pickers" edit link in the "Note Writer Settings" pane
		When I click the "Delete All Pickers" button
		And I click the "Yes" button in the "Warning" pane
		When I click the "Department Pickers" edit category link in the "Department Note Pickers" pane
		And I wait "2" seconds
		Then the "Edit Department Pickers Header" pane should load
		When I enter "History and Physical" in the "Add Code" field
		And I click the "Lookup Values" element in the "Edit Department Note Pickers" pane
		And I enter "Progress Note" in the "Add Code" field
		And I click the "Lookup Values" element in the "Edit Department Note Pickers" pane
		When I click the "Save" button in the "Edit Department Note Pickers" pane
		And I click the "Close" button in the "Department Note Pickers" pane
		#And I am logged into the portal with user "nwuser1" and password "123"
		And I am logged into the portal with user "nwuser1" using the default password
		And I am on the "Patient List V2" tab
		And "Molly Darr" is on the patient list
		#may give warning about something
		And I click the "OK" button in the "Information" pane if it exists
		And I select patient "Molly Darr" from the patient list
		#removed few steps as per the updated note writer step definition
		And I load the "Progress Note" template note for the selected patient
		And I click the "ROS CONST Normal" element in the "NoteWriter" pane
		And I click the "ROS CONSTITUTIONAL ABC" image in the "NoteWriter" pane
		Then the "Click To Insert" pane should load
		And the text "(No Quick Text Defined)" should appear in the "Click To Insert" pane
		And I click the "Cancel" button in the "NoteWriter Main" pane
		And I click the "Yes" button in the "Question" pane

	@NoteWriter
    Scenario: User level Hide From Popup status on adding new QT
		And I load the edit my pickers page for selected "nwuser3" user
        When I click the "Add Category" button in the "Edit My Pickers" pane
        And I wait "2" seconds
        When I enter "UserTestQuestion" in the "Enter new category name" field
        And I click the "OK" button in the "Add Category Contents" pane
        Then the picker "UserTestQuestion" should appear in the children picker list	
        When I click the "Save" button in the "Edit My Pickers" pane
        Then the following links should display in the "Quick Text Editor Content" pane
			|UserTestQuestion |
        When I click the "UserTestQuestion" edit category link in the "Quick Text Editor Content" pane
        Then the "Edit My Pickers" pane should load
        When I click the "Add Text" button in the "Edit My Pickers" pane
        Then the "Add Quick Text" pane should load
		And I wait "2" seconds
        When I enter "UTestQ" in the "AddQuickTextLabel" field
        And I enter "UTQ" in the "AddQuickTextKeyboardShortcut" field
        And I click the "Save" button in the "Add Quick Text Content" pane
#        Then the following rows should appear in the "EditMyPickersChildren" table
#			|Type     |Label|Text To Insert|
#			|QuickText|UTestQ|UTestQ       |
		And I check the "HideFromPopup" checkbox in the row with "UTestQ" as the value under "Label" column in the "EditMyPickersChildren" table
		Then the "HideFromPopup" checkbox should be checked in the row with "UTestQ" as cell text under "Label" column in the "EditMyPickersChildren" table
        And I click the "Save" button in the "Edit My Pickers" pane
		When I click the "UserTestQuestion" edit category link in the "Quick Text Editor Content" pane
		And I wait "2" seconds
		When I click the "Add Text" button in the "Edit My Pickers" pane
        Then the "Add Quick Text" pane should load
		And I wait "2" seconds
        And I enter "UTestQ1" in the "AddQuickTextLabel" field
		And I enter "UTQ1" in the "AddQuickTextKeyboardShortcut" field
        And I click the "Save" button in the "Add Quick Text Content" pane
#        Then the following rows should appear in the "EditMyPickersChildren" table
#			|Type      |Label   |Text To Insert |
#			|QuickText |UTestQ1 |UTestQ1        |
        # make sure that the "Hide from POpup" status of the existing QT's does not change on adding a new QT
        Then the "HideFromPopup" checkbox should be checked in the row with "UTestQ" as cell text under "Label" column in the "EditMyPickersChildren" table
#        And the "HideFromPopup" checkbox should be unchecked in the row with "UTestQ1" as cell text under "Label" column in the "EditMyPickersChildren" table
		And I click the "Cancel" button in the "Edit My Pickers" pane
        #Then the "Edit My Pickers" pane should close
		And I click the "Close" button in the "Quick Text Editor Content" pane
	
	@NoteWriter
    Scenario: User Preference level Delete QT and Cancel
        And I load the edit my pickers page for selected "nwuser3" user
        When I click the "Add Category" button in the "Edit My Pickers" pane
        And I wait "2" seconds
        When I enter "UserTestQuestion1" in the "Enter new category name" field
        And I click the "OK" button in the "Add Category Contents" pane
        Then the picker "UserTestQuestion1" should appear in the children picker list	
        When I click the "Save" button in the "Edit My Pickers" pane
        Then the following links should display in the "Quick Text Editor Content" pane
			|UserTestQuestion1 |
        When I click the "UserTestQuestion1" edit category link in the "Quick Text Editor Content" pane
        Then the "Edit My Pickers" pane should load
        When I click the "Add Text" button in the "Edit My Pickers" pane
        Then the "Add Quick Text" pane should load
		And I wait "2" seconds
        When I enter "UTestQ2" in the "AddQuickTextLabel" field
		And I enter "UTQ2" in the "AddQuickTextKeyboardShortcut" field
		And I click the "Save" button in the "Add Quick Text Content" pane
#		Then the following rows should appear in the "EditMyPickersChildren" table
#			|Type      |Label   |Text To Insert |
#			|QuickText |UTestQ2 |UTestQ2        |
        And I click the "Save" button in the "Edit My Pickers" pane
		When I click the "UserTestQuestion1" edit category link in the "Quick Text Editor Content" pane
		And I wait "4" seconds
        And I delete the "UTestQ2" child picker in the "Edit My Pickers" pane
		#To validate there are no records in table
#		Then the following rows should appear in the "EditMyPickersChildren" table
#			|Type |Label |Text To Insert |
#			|     |      |               |
        When I click the "Cancel" button in the "Edit My Pickers" pane
       #Then the "Edit My Pickers" pane should close
		Then the following links should display in the "Quick Text Editor Content" pane
			|UTestQ2 |
        And I click the "Close" button in the "Quick Text Editor Content" pane
	
	@NoteWriter
    Scenario: User QT Summary - Delete QT entry from Category
        And I load the edit my pickers page for selected "nwuser3" user
        When I click the "Add Category" button in the "Edit My Pickers" pane
        And I wait "2" seconds
        When I enter "UserTestQuestion3" in the "Enter new category name" field
        And I click the "OK" button in the "Add Category Contents" pane
        Then the picker "UserTestQuestion3" should appear in the children picker list
        When I click the "Save" button in the "Edit My Pickers" pane
        Then the following links should display in the "Quick Text Editor Content" pane
			|UserTestQuestion3 |
		When I click the "UserTestQuestion3" edit category link in the "Quick Text Editor Content" pane
        Then the "Edit My Pickers" pane should load
        When I click the "Add Text" button in the "Edit My Pickers" pane
        Then the "Add Quick Text" pane should load
		And I wait "2" seconds
        When I enter "UTestQ3" in the "AddQuickTextLabel" field
		And I enter "UTQ3" in the "AddQuickTextKeyboardShortcut" field
		And I click the "Save" button in the "Add Quick Text Content" pane
#		Then the following rows should appear in the "EditMyPickersChildren" table
#			|Type      |Label   |Text To Insert |
#			|QuickText |UTestQ3 |UTestQ3        |
		And I click the "Save" button in the "Edit My Pickers" pane
		When I click the "UserTestQuestion3" edit category link in the "Quick Text Editor Content" pane
		And I wait "4" seconds
        And I delete the "UTestQ3" child picker in the "Edit My Pickers" pane
		And I click the "Save" button in the "Edit My Pickers" pane
	    Then the text "UTestQ3" should not appear in the "Quick Text Editor Content" pane
		And I click the "Close" button in the "Quick Text Editor Content" pane
        Given I am logged into the portal with user "nwuser3" using the default password
        And I am on the "Patient List V2" tab
        And "MOLLY DARR" is on the patient list
        And I click the "OK" button in the "Information" pane if it exists
        When I select patient "Molly Darr" from the patient list
        And I load the "Progress Note" template note for the selected patient
        And I select the note "Subjective" section
		And I click the "Patient narrative ABC" image in the "NoteWriter" pane
        Then the "Click To Insert" pane should load
		And I click the "GlobalText" element in the "Click To Insert" pane
		And the text "UserTestQuestion3" should appear in the "Click To Insert" pane
        And the text "UTQ3" should not appear in the "Click To Insert" pane
		And I click the "Cancel" button in the "NoteWriter Main" pane
		And I click the "Yes" button in the "Question" pane
	
	@NoteWriter
    Scenario: User Preference level Delete Category
        And I load the edit my pickers page for selected "nwuser3" user
        When I click the "Add Category" button in the "Edit My Pickers" pane
        And I wait "2" seconds
        When I enter "UserTestQuestion4" in the "Enter new category name" field
        And I click the "OK" button in the "Add Category Contents" pane
        Then the picker "UserTestQuestion4" should appear in the children picker list	
        When I click the "Save" button in the "Edit My Pickers" pane
        Then the following links should display in the "Quick Text Editor Content" pane
			|UserTestQuestion4 |
		When I click the "My Pickers" edit category link in the "Quick Text Editor Content" pane
		Then the "Edit My Pickers" pane should load
		When I delete the "UserTestQuestion4" picker in the "Edit My Pickers" pane
		And I click the "Save" button in the "Edit My Pickers" pane
		And I click the "My Pickers" edit category link in the "Quick Text Editor Content" pane
		Then the "Edit My Pickers" pane should load
		And the picker "UserTestQuestion4" should not appear in the children picker list
		When I click the "Save" button in the "Edit My Pickers" pane
		#Then the "Edit My Pickers" pane should close
		And I click the "Close" button in the "Quick Text Editor Content" pane
		Given I am logged into the portal with user "nwuser3" using the default password
        And I am on the "Patient List V2" tab
        And "MOLLY DARR" is on the patient list
        And I click the "OK" button in the "Information" pane if it exists
        When I select patient "Molly Darr" from the patient list
        And I load the "Progress Note" template note for the selected patient
        And I select the note "Subjective" section
		And I click the "Patient narrative ABC" image in the "NoteWriter" pane
        Then the "Click To Insert" pane should load
		And the text "(No Quick Text Defined)" should appear in the "Click To Insert" pane
		And the text "UserTestQuestion4" should not appear in the "Click To Insert" pane
		And I click the "Cancel" button in the "NoteWriter Main" pane
		And I click the "Yes" button in the "Question" pane
		
	@NoteWriter
    Scenario: User Level Create Summary View Category
        And I load the edit my pickers page for selected "nwuser3" user
        When I click the "Add Category" button in the "Edit My Pickers" pane
        And I wait "2" seconds
        When I enter "UserTestQuestion5" in the "Enter new category name" field
        And I click the "OK" button in the "Add Category Contents" pane
        Then the picker "UserTestQuestion5" should appear in the children picker list	
        When I click the "Save" button in the "Edit My Pickers" pane
        Then the following links should display in the "Quick Text Editor Content" pane
			|UserTestQuestion5 |
		When I click the "UserTestQuestion5" edit category link in the "Quick Text Editor Content" pane
        Then the "Edit My Pickers" pane should load
        When I click the "Add Text" button in the "Edit My Pickers" pane
        Then the "Add Quick Text" pane should load
		And I wait "2" seconds
        When I enter "UTestQ5" in the "AddQuickTextLabel" field
		And I enter "UTQ5" in the "AddQuickTextKeyboardShortcut" field
		And I click the "Save" button in the "Add Quick Text Content" pane
#		Then the following rows should appear in the "EditMyPickersChildren" table
#			|Type      |Label   |Text To Insert |
#			|QuickText |UTestQ5 |UTestQ5        |
		And I click the "Save" button in the "Edit My Pickers" pane
		#Then the "Edit My Pickers" pane should close
		And I click the "Close" button in the "Quick Text Editor Content" pane
		Given I am logged into the portal with user "nwuser3" using the default password
        And I am on the "Patient List V2" tab
        And "MOLLY DARR" is on the patient list
        And I click the "OK" button in the "Information" pane if it exists
        When I select patient "Molly Darr" from the patient list
        And I load the "Progress Note" template note for the selected patient
        And I select the note "Subjective" section
		And I click the "Patient narrative ABC" image in the "NoteWriter" pane
        Then the "Click To Insert" pane should load
		And I click the "GlobalText" element in the "Click To Insert" pane
		And the text "UserTestQuestion5" should appear in the "Click To Insert" pane
		And the text "UTestQ5" should appear in the "Click To Insert" pane
		And I click the "Cancel" button in the "NoteWriter Main" pane
		And I click the "Yes" button in the "Question" pane

	@NoteWriter
    Scenario: User Preference level Department Pickers Display
        When I select the department "Autocreated-%Current Date%-"
		And I click the "Edit" button in the "Quick Details" pane
		And I select "NoteWriter" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
		And I click the "Quick Text (Summary View)" edit link in the "Department General Settings" pane
		And I wait "2" seconds
		Then the "Department Quick Text Editor" pane should load
		And the "QuickText Department Pickers" table should have at least "1" row
		When I click the "Delete All Pickers" button in the "Department Quick Text Editor Content" pane
		And I click the "Yes" button in the "Question" pane
		When I click the "Department Pickers" edit category link in the "Department QuickText Editor Content" pane
		And I wait "2" seconds
		And I click the "Add Category" button in the "Edit Department Pickers" pane
		And I wait "2" seconds
        Then the "Add Category" pane should load
        When I enter "NewDeptPicker" in the "Enter new category name" field
        And I click the "OK" button in the "Add Category Contents" pane
        Then the picker "NewDeptPicker" should appear in the children picker list
		When I click the "Save" button in the "Edit Department Pickers" pane
		Then the following links should display in the "Department QuickText Editor Content" pane
			|NewDeptPicker |
		And I click the "Close" button in the "Department QuickText Editor Content" pane
		And I select the "User" subtab
		And I search for the user "nwuser3"
        And I select the user "nwuser3"
        And I click the "Edit" button in the "Quick Details" pane
        And I select "NoteWriter" from the "Edit User Settings" dropdown
		And I wait "2" seconds
		When I click the "Quick Text (Summary View)" edit link in the "User NoteWriter Settings" pane
		And I wait "2" seconds
		Then the following links should display in the "Quick Text Editor Content" pane
			|NewDeptPicker |
		And I click the "Close" button in the "Quick Text Editor Content" pane
	
	@NoteWriter
	Scenario: As Admin0 create new QT group for PatientNarrative Field
        When I select the department "Autocreated-%Current Date%-"
		And I click the "Edit" button in the "Quick Details" pane
		And I navigate to the note writer quick text admin view page for selected "Progress Note (Dept)" quick text template
		When I select the note "Subjective" section in the "NoteWriter Quick Text Admin View Content" pane
		And I wait "2" seconds
		Then the "Subjective" pane should load
		And I click the "Patient narrative ABC" element in the "Note Instance Edit" pane
		Then the "Click To Insert" pane should load
		When I click the "Add" button in the click to insert "Patientnarrative" popup in the "Subjective" section
		And I wait "2" seconds
		Then the "Quick Text" pane should load
		When I click the "Close" button in the "QuickText Content" pane
		#Then the "Quick Text" pane should close
		And I click the "Patient narrative ABC" element in the "Note Instance Edit" pane
		Then the "Click To Insert" pane should load
		When I click the "Edit" button in the click to insert "Patientnarrative" popup in the "Subjective" section
		And I wait "2" seconds
		Then the "QuickText" pane should load
        When I click the "Update Groupings" link in the "Quick Text Content" pane
		And I wait "2" seconds
        Then the "Update Quick Text Groupings" pane should load
		And the "UpdateQuickTextGroupings" pane title should be "Update Quick Text Groupings for Patient narrative"
		When I create a new group "Symptoms" in the update quick text grouping pane
		And I click the "Save" button in the "Update Quick Text Groupings Content" pane
        And I click the "Close" button in the "Quick Text Content" pane
        #Then the "QuickText" pane should close
        And I click the "Patient narrative ABC" element in the "Note Instance Edit" pane
		Then the "Click To Insert" pane should load
		And the text "Symptoms" should appear in the "Click To Insert" pane
		And I click the "Close" button in the "NoteWriter Quick Text Admin View Content" pane
		Then the "Note Writer Quick Text Admin View" pane should close

	@NoteWriter
    Scenario: As Admin0 add and Del QT Group for ROS Systems
        When I select the department "Autocreated-%Current Date%-"
		And I click the "Edit" button in the "Quick Details" pane
		And I navigate to the note writer quick text admin view page for selected "Progress Note (Dept)" quick text template
		When I select the note "Exam" section in the "NoteWriter Quick Text Admin View Content" pane
		And I wait "2" seconds
        And I select the note "Exam" section in the "NoteWriter Quick Text Admin View Content" pane
		And I click the "Exam RESP Normal" element in the "Note Instance Edit" pane
		And I click the "Exam Resp ABC" image in the "Note Instance Edit" pane
		And I click the "Add" button in the click to insert "RESPIRATORY" popup in the "Exam" section
		And I wait "2" seconds
		Then the "Quick Text" pane should load
        And the "Quick Text" pane title should be "Quick Text for RESPIRATORY"
		When I click the "Update Groupings" link in the "Quick Text Content" pane
		And I wait "2" seconds
        Then the "Update Quick Text Groupings" pane should load
		And the "Update Quick Text Groupings" pane title should be "Update Quick Text Groupings for RESPIRATORY"
		And I create a new group "InputGrp1" in the update quick text grouping pane
		And I click the "Save" button in the "Update Quick Text Groupings Content" pane
		And I create a new quick text with label "abc" and shortcut "abc" for selected group "InputGrp1" in the "Quick Text Content" pane
		Then the following rows should appear in the "Quick Text" table
			|Label |Text to Insert |Shortcut |Grouping  |
			|abcd  |abcd           |abcd     |InputGrp1 |
        When I click the "Close" button in the "Quick Text Content" pane
#        Then the "Quick Text" pane should close
        When I click the "Exam Resp ABC" image in the "Note Instance Edit" pane
		And I wait "2" seconds
		Then the following text should appear in the "Click To Insert" pane
			|InputGrp1 |
			|abc       |
        And I click the "Add" button in the click to insert "RESPIRATORY" popup in the "Exam" section
		And I wait "2" seconds
        Then the "Quick Text" pane should load
        When I click the "Update Groupings" link in the "Quick Text Content" pane
		And I wait "2" seconds
		Then the "Update Quick Text Groupings" pane should load
		When I delete the "InputGrp1" grouping in the "Update Quick Text Groupings Content" pane
		And I click the "Save" button in the "Update Quick Text Groupings Content" pane
		When I click the "Update Groupings" link in the "Quick Text Content" pane
		And I wait "2" seconds
        Then the grouping name "InputGrp1" should not appear in the grouping list
        When I click the "Save" button in the "Update Quick Text Groupings Content" pane
       #Then the "Update Quick Text Groupings" pane should close
        When I click the "Close" button in the "Quick Text Content" pane
       #Then the "Quick Text" pane should close
        And I click the "Close" button in the "NoteWriter Quick Text Admin View Content" pane
		#Then the "Note Writer Quick Text Admin View" pane should close
		
	@NoteWriter
	Scenario: As Admin0 Move QT from one group to another
		When I select the department "Autocreated-%Current Date%-"
		And I click the "Edit" button in the "Quick Details" pane
		And I navigate to the note writer quick text admin view page for selected "Progress Note (Dept)" quick text template
		When I select the note "Exam" section in the "NoteWriter Quick Text Admin View Content" pane
		And I wait "2" seconds
        And I select the note "Exam" section in the "NoteWriter Quick Text Admin View Content" pane
		And I click the "Exam RESP Normal" element in the "Note Instance Edit" pane
		And I click the "Exam Resp ABC" image in the "Note Instance Edit" pane
		And I click the "Add" button in the click to insert "RESPIRATORY" popup in the "Exam" section
		And I wait "2" seconds
		Then the "Quick Text" pane should load
        And the "Quick Text" pane title should be "Quick Text for RESPIRATORY"
		When I click the "Update Groupings" link in the "Quick Text Content" pane
		And I wait "2" seconds
        Then the "Update Quick Text Groupings" pane should load
		And I create a new group "TestGrp1" in the update quick text grouping pane
		And I create a new group "TestGrp2" in the update quick text grouping pane
		And I click the "Save" button in the "Update Quick Text Groupings Content" pane
        And I create a new quick text with label "Test" and shortcut "tst" for selected group "TestGrp1" in the "Quick Text Content" pane
        Then the following rows should appear in the "Quick Text" table
			|Label |Text to Insert |Shortcut |Grouping |
			|Test1 |Test1          |tst1     |TestGrp1 |
		#When I click the checkbox in the row with "Test1" as the value under "Label" in the "Quick Text" table
		And I select "TestGrp2" from the "MovetoQuickTextGrouping" dropdown
		And I click the "Move" button in the "Quick Text Content" pane
		And I wait "2" seconds
		Then the following rows should appear in the "Quick Text" table
			|Label |Text to Insert |Shortcut |Grouping |
			|Test1 |Test1          |tst1     |TestGrp2 |
		When I click the "Close" button in the "Quick Text Content" pane
		#Then the "Quick Text" pane should close
		And I click the "Close" button in the "NoteWriter Quick Text Admin View Content" pane
		#Then the "Note Writer Quick Text Admin View" pane should close

	@NoteWriter
	Scenario: As Admin0 Edit QT from Template View
		When I select the department "Autocreated-%Current Date%-"
		And I click the "Edit" button in the "Quick Details" pane
		And I navigate to the note writer quick text admin view page for selected "Progress Note (Dept)" quick text template
		When I select the note "Exam" section in the "NoteWriter Quick Text Admin View Content" pane
		And I wait "2" seconds
        And I select the note "Exam" section in the "NoteWriter Quick Text Admin View Content" pane
		And I click the "Exam RESP Normal" element in the "Note Instance Edit" pane
		And I click the "Exam Resp ABC" image in the "Note Instance Edit" pane
		And I click the "Edit" button in the click to insert "RESPIRATORY" popup in the "Exam" section
		And I wait "4" seconds
		Then the "Quick Text" pane should load
		#editing the existing quick text link that is submitted in previous scenario
        And I click the "Test" link
		And I wait "2" seconds
		Then the "Edit Quick Text" pane should load
		And I enter "QTest" in the "Label" field
		And I enter "QTest" in the "Text to Insert" field
		And I click the "Save" button in the "Edit Quick Text Content" pane
		Then the following rows should appear in the "Quick Text" table
			|Label |Text to Insert |Shortcut |Grouping |
			|QTest |QTest          |tst1     |TestGrp2 |
		When I click the "Close" button in the "Quick Text Content" pane
		#Then the "Quick Text" pane should close
		And I click the "Close" button in the "NoteWriter Quick Text Admin View Content" pane
		#Then the "Note Writer Quick Text Admin View" pane should close
	
	@NoteWriter
	Scenario: QT Summary Dept Quick Text Default checkbox
		When I select the department "Autocreated-%Current Date%-"
		And I click the "Edit" button in the "Quick Details" pane
		And I select "NoteWriter" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
		And I click the "Quick Text (Summary View)" edit link in the "Department General Settings" pane
		Then the "Department Quick Text Editor Content" pane should load within "5" seconds
		#Then the "Department Quick Text Editor" pane should load
		#And the "QuickText Department Pickers" table should have at least "1" row
		When I click the "Delete All Pickers" button in the "Department Quick Text Editor Content" pane
		And I click the "Yes" button in the "Question" pane
		When I click the "Department Pickers" edit category link in the "Department QuickText Editor Content" pane
		And I wait "2" seconds
		And I click the "Add Category" button in the "Edit Department Pickers" pane
		And I wait "2" seconds
        Then the "Add Category" pane should load
        When I enter "TestQuestion" in the "Enter new category name" field
        And I click the "OK" button in the "Add Category Contents" pane
        Then the picker "TestQuestion" should appear in the children picker list
		When I click the "Save" button in the "Edit Department Pickers" pane
		Then the following links should display in the "Department QuickText Editor Content" pane
			|TestQuestion |
		When I click the "TestQuestion" edit category link in the "Department QuickText Editor Content" pane
		And I wait "2" seconds
		And I enter "001" in the "RestricttoQuestion" field in the "Edit Department Pickers" pane
		When I click the "Add Text" button in the "Edit Department Pickers" pane
		And I wait "2" seconds
		Then the "Add Quick Text" pane should load
		When I enter "TestQ" in the "AddQuickTextLabel" field
		Then the value in the "Add Quick TextLabel" field should be "TestQ"
		And I check the "Default" checkbox in the "Add Quick Text Content" pane
		And the value in the "Add Quick TextKeyboard Shortcut" field should be "TestQ"
		And the value in the "TexttoInsert" field should be "TestQ"
		When I click the "Save" button in the "Add Quick Text Content" pane
		#Then the "Add Quick Text" pane should close
		And I click the "Save" button in the "Edit Department Pickers" pane
		And I wait "2" seconds
		When I click the "TestQuestion" edit category link in the "Department QuickText Editor Content" pane
		And I wait "3" seconds
		Then the "Defaults" checkbox should be checked in the row with "TestQ" as cell text under "Label" column in the "EditMyPickersChildren" table
		When I click the "TestQ" link in the "Edit Department Pickers" pane
		Then the "Add Quick Text" pane should load
		When I uncheck the "Default" checkbox in the "Add Quick Text Content" pane
		And I click the "Save" button in the "Add Quick Text Content" pane
		Then the "Defaults" checkbox should be unchecked in the row with "TestQ" as cell text under "Label" column in the "EditMyPickersChildren" table
		And I click the "Save" button in the "Edit Department Pickers" pane
		And I click the "Close" button in the "Department Quick Text Editor Content" pane
		
	@NoteWriter
	Scenario: As Admin0 Add generic QT for History Physical template
		When I select the department "Autocreated-%Current Date%-"
		And I click the "Edit" button in the "Quick Details" pane
		And I navigate to the note writer quick text admin view page for selected "History and Physical (Dept)" quick text template
		When I select the note "Exam" section in the "NoteWriter Quick Text Admin View Content" pane
		And I wait "4" seconds
        And I click the "Exam RESP Normal" element in the "Note Instance Edit" pane
		And I click the "Exam Resp ABC" image in the "Note Instance Edit" pane
		And I click the "Add" button in the click to insert "RESPIRATORY" popup in the "Exam" section
		And I wait "2" seconds
		Then the "Quick Text" pane should load
        And the "Quick Text" pane title should be "Quick Text for RESPIRATORY"
		When I click the "Update Groupings" link in the "Quick Text Content" pane
		And I wait "2" seconds
        Then the "Update Quick Text Groupings" pane should load
		And I create a new group "HPGroup" in the update quick text grouping pane
		And I click the "Save" button in the "Update Quick Text Groupings Content" pane
        And I create a new quick text with label "HPTest" and shortcut "HPTest" for selected group "HPGroup" in the "Quick Text Content" pane
        Then the following rows should appear in the "Quick Text" table
			|Label  |Text to Insert |Shortcut |Grouping |
			|HPTest |HPTest         |HPTest   |HPGroup  |
		When I click the "Close" button in the "Quick Text Content" pane
        #Then the "Quick Text" pane should close
		# to clear the existing value from the field
		When I enter "" in the "Exam Respiratory" field
		And I click the "Exam Resp ABC" image in the "Note Instance Edit" pane
		And I wait "2" seconds
		Then the following text should appear in the "Click To Insert" pane
			|HPGroup |
			|HPTest  |
		When I expand the "HPGroup" group and select the "HPTest" quick text in the "Click To Insert" pane
		Then the value in the "Exam Respiratory" field should be "HPTest"
		When I click the "Close" button in the "NoteWriter Quick Text Admin View Content" pane
		#Then the "Note Writer Quick Text Admin View" pane should close
	
	@NoteWriter
	Scenario: As Admin0 edit generic QT for History Physical template
		When I select the department "Autocreated-%Current Date%-"
		And I click the "Edit" button in the "Quick Details" pane
		And I navigate to the note writer quick text admin view page for selected "History and Physical (Dept)" quick text template
		When I select the note "Exam" section in the "NoteWriter Quick Text Admin View Content" pane
		And I wait "2" seconds
        And I click the "Exam RESP Normal" element in the "Note Instance Edit" pane
		And I click the "Exam Resp ABC" image in the "Note Instance Edit" pane
		And I click the "Edit" button in the click to insert "RESPIRATORY" popup in the "Exam" section
		And I wait "2" seconds
		Then the "Quick Text" pane should load
		#editing the existing quick text link that is submitted in previous scenario
        And I click the "HPTest" link in the "Quick Text Content" pane
		And I wait "2" seconds
		Then the "Edit Quick Text" pane should load
		And I enter "PGTest" in the "Label" field
		And I enter "PGTest" in the "Text to Insert" field
		And I enter "PGTest" in the "Shortcut" field
		And I click the "Save" button in the "Edit Quick Text Content" pane
		Then the following rows should appear in the "Quick Text" table
			|Label  |Text to Insert |Shortcut |Grouping |
			|PGTest |PGTest         |PGTest   |HPGroup  |
		When I click the "Close" button in the "Quick Text Content" pane
       #Then the "Quick Text" pane should close
		# to clear the existing value from the field
		When I enter "" in the "Exam Respiratory" field
		And I click the "Exam Resp ABC" image in the "Note Instance Edit" pane
		And I wait "2" seconds
		Then the following text should appear in the "Click To Insert" pane
			|HPGroup |
			|PGTest  |
        When I expand the "HPGroup" group and select the "PGTest" quick text in the "Click To Insert" pane
		Then the value in the "Exam Respiratory" field should be "PGTest"
		When I click the "Close" button in the "NoteWriter Quick Text Admin View Content" pane
		#Then the "Note Writer Quick Text Admin View" pane should close
	
	@NoteWriter
	Scenario: Delete All Pickers	
		# Deleting pickers from the list to eliminate conflicts of duplicate groups in nightly run
		When I select the department "Autocreated-%Current Date%-"
		And I click the "Edit" button in the "Quick Details" pane
		And I select "NoteWriter" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
		And I click the "Quick Text (Summary View)" edit link in the "Department General Settings" pane
		Then the "Department Quick Text Editor Content" pane should load within "5" seconds
		#Then the "Department Quick Text Editor" pane should load
		#And the "QuickText Department Pickers" table should have at least "1" row
		When I click the "Delete All Pickers" button in the "Department Quick Text Editor Content" pane
		And I click the "Yes" button in the "Question" pane
		And I click the "Close" button in the "Department Quick Text Editor Content" pane
		
	@NoteWriter
	Scenario: Clear the Web Session and Purge Mobilizer cache [AUTO-147]
		And I am on the "Admin" tab
		And I select the "System Management" subtab
		And I click the "Misc" link in the "System Management Navigation" pane
		When I click the "Clear Web Session Caches" button
		And I click the "OK" button in the "Information" pane
		When I click the "Purge Mobilizer Cache" button
		And I click the "OK" button in the "Information" pane
		And I click the logout button
	
	@NoteWriter
	Scenario: Access notes within discharge summary with same session[AUTO-147]
		#Given I am logged into the portal with user "nwadmin" using the default password
		And I am on the "Patient List V2" tab
		And "Molly Darr" is on the patient list
		And I select patient "Molly Darr" from the patient list
		And I load the "Discharge Summary" template note for the selected patient
		#Then the "NoteWriterSign/Submit" button should clickable in the "NoteWriter Main" pane
		And I click the "NoteWriterSign/Submit" button in the "NoteWriter Main" pane
		#And I click the "Yes" button in the "Sign/Submit" pane
		And I click the "OK" button in the "SubmitNote" pane
		And I wait "2" seconds
		And I load the "Discharge Summary" template note for the selected patient
		And I select the note "Hospital Course" section
		And I wait "3" seconds
		And I select "Clinical Notes" from the "ClinicalData" dropdown
		When I select the "Progress Note" in the clinical data
		Then the "clinical Data Note Content" pane should load within "2" seconds
		When I select the "Discharge Summary" in the clinical data
		Then the "clinical Data Note Content" pane should load within "2" seconds
		And I click the "Cancel" button in the "NoteWriter Main" pane
		And I click the "Yes" button in the "Question" pane
		# repeating the steps in the same session
		And I load the "Discharge Summary" template note for the selected patient
		And I select the note "Hospital Course" section
		And I wait "3" seconds
		And I select "Clinical Notes" from the "ClinicalData" dropdown
		When I select the "Progress Note" in the clinical data
		Then the "clinical Data Note Content" pane should load within "2" seconds
		When I select the "History and Physical" in the clinical data
		Then the "clinical Data Note Content" pane should load within "2" seconds
		And I click the "Cancel" button in the "NoteWriter Main" pane
		And I click the "Yes" button in the "Question" pane
		And I click the logout button
	
	@NoteWriter
	Scenario: Access notes within discharge summary with subsequent session[AUTO-147]
		Given I am logged into the portal with user "nwadmin" using the default password
		And I am on the "Patient List V2" tab
		And "Molly Darr" is on the patient list
		And I select patient "Molly Darr" from the patient list
		And I load the "Discharge Summary" template note for the selected patient
		And I select the note "Hospital Course" section
		And I wait "3" seconds
		And I select "Clinical Notes" from the "ClinicalData" dropdown
		When I select the "Progress Note" in the clinical data
		Then the "clinical Data Note Content" pane should load within "2" seconds
		When I select the "History and Physical" in the clinical data
		Then the "clinical Data Note Content" pane should load within "2" seconds
		And I click the "Cancel" button in the "NoteWriter Main" pane
		And I click the "Yes" button in the "Question" pane

	@NoteWriter
	Scenario: Character limit on the Plan section of the A/P tab within progress note[DEV-50414]
		And I am on the "Patient List V2" tab
		And I select patient "Molly Darr" from the patient list
		And I load the "Progress Note" template note for the selected patient
		And I select the note "A/P" section
		#submitting problem with description more than 240 characters
		#And I click the "ToggleDxSearch" button
		And I enter "Characters length is more than 240 Characters length is more than 240 Characters length is more than 240 Characters length is more than 240 Characters length is more than 240 Characters length is more than 240 Characters length is more than 240" in the "ProblemDxSearch" field
		And I click the "AddAsFreeText" element in the "NoteWriterHistoryDXSearch" pane
		#entered more than 250 characters in the assessment and plan fields
		And I enter "Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250" in the "Assessment" field
		And I enter "Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250" in the "Plan" field
		#When I click the "NoteWriter...Sign/Submit" button in the "NoteWriter Main" pane
		#And I click the "Yes" button in the "Sign/Submit" pane
		#Then the "Warning" pane should load
	    And I select "Moderate" from the "LevelOfDecision" dropdown if it exists
	    Then I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
		And the text "The note has not been signed. The free text Problem text length is too long. Please shorten." should appear in the "Warning" pane
		And I click the "OK" button in the "Warning" pane
		And I click the "Cancel" button in the "NoteWriter Main" pane
		And I click the "Yes" button in the "Question" pane
		#logout because it unable to click Problem field in the next scenario
		And I click the logout button

	@NoteWriter
	Scenario: Character limit on the Plan section of the A/P tab within progress note[DEV-51143]
		And I am on the "Patient List V2" tab
		And I select patient "Molly Darr" from the patient list	
		And I load the "Progress Note" template note for the selected patient
		And I select the note "A/P" section
		#And I click the "ToggleDxSearch" button
		#submitting problem with description equal to 238 characters
		And I enter "Characters length is equal to 238 Characters length is equal to 238 Characters length is equal to 238 Characters length is equal to 238 Characters length is equal to 238 Characters length is equal to 238 Characters length is equal to 238X" in the "ProblemDxSearch" field
		And I click the "AddAsFreeText" element in the "NoteWriterHistoryDXSearch" pane
		#entered more than 250 characters in the assessment and plan fields
		And I enter "Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250" in the "Assessment" field
		And I enter "Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250 Characters length is more than 250" in the "Plan" field
		And I select "Moderate" from the "LevelOfDecision" dropdown if it exists
		Then I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
		#When I click the "NoteWriter...Sign/Submit" button in the "NoteWriter Main" pane
		#And I click the "Yes" button in the "Sign/Submit" pane
		And I click the "OK" button in the "SubmitNote" pane
		And I wait "2" seconds
		Then the "Error" pane should not load
		And the "Warning" pane should not load
		#And the "Note Writer Main" pane should close
		