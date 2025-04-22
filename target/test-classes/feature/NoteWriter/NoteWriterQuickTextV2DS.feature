@NoteWriterQTV2
Feature: NoteWriter Quick Text V2 Discharge Summary


	Background:
		Given I am logged into the portal with user "hplevel3" using the default password
		And I am on the "Patient List V2" tab
		And the patient list is maximized

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

	Scenario: Verify Follow Up section in Discharge Summary template
		When "LOLA BONNET" is on the patient list
		And I select patient "LOLA BONNET" from the patient list
		And I load the "Discharge Summary" template note for the selected patient
		And I find out all active windows
		And I switch the focus to the "popoutWindow" window
		And I select the note "Follow Up" section
		Then I select "Fair" from the "Discharge Condition" dropdown
		And I enter "Patient will continue recovery at home." in the "DischargeConditionQTV2" rich text field
		And the text "Patient will continue recovery at home." should appear in the "Note Writer Main" pane
		And I click the "DischargeConditionABC" element
		When I click on the text "imprv" in the "ClickToInsertV2" pane
		And I click the "CloseQuickText" button
		And the text "Patient condition has improved" should appear in the "Note Writer Main" pane
		Then The "PendingLabTests" element should contain with the text "Pending" in the "Note Writer Main" pane
		And I enter "Patient should try to exercise daily." in the "RecommendationsDischargeInstructionsQTV2" rich text field
		And the text "Patient should try to exercise daily." should appear in the "Note Writer Main" pane
		And I click the "RecommendationsDischargeInstructionsABC" element
		And I click on the text "lfat" in the "ClickToInsertV2" pane
		And I click the "RecommendationsDischargeInstructionsABC" element
		Then the following text should appear in the "Note Writer Main" pane
			| Recommend patient to have low fat diet |
	 #Discharge Orders are not appearing under Follow up appointment section, need clarification regarding this
	 #Steps 8 and 9 need to be added which are related to this
		And I enter "adams" in the "Physicians Lookup" field in the "Note Writer Main" pane
		Then I select "AMY" option from the "Physican LookUp Search List" list
   #		And I click the "Physician Lookup" element in the "Note Writer Main" pane
   #		And I enter "111-111-1111" in the "Physician Fax" field
		And I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
		And I wait "2" seconds
		And I click the "OK" button in the "Note Writer Main" pane
		And I wait "2" seconds
		And I switch the focus to the "LoginWindow" window
		And I click the "OK" button in the "Question" pane if it exists

	Scenario: Verify Hospital Course in Discharge Summary template
		When "Molly Darr" is on the patient list
		And I select patient "Molly Darr" from the patient list
		And I load the "Discharge Summary" template note for the selected patient
		And I find out all active windows
		And I switch the focus to the "popoutWindow" window
		And I select the note "Hospital Course" section
		And I wait "2" seconds
		And I enter "hc1" in the "HospitalCourseQTV2" rich text field
		And I click the "enter" key in the "HospitalCourseQTV2" rich text field
		Then the text "Patient is a" should appear in the "Hospital Course" pane
		When I click the "Free Text" textbox in the rich text field
		And I enter "50" in the "Free Text" free text field in the "Hospital Course" pane
		Then the text "50" should appear in the "Hospital Course" pane
		When I click the "List" list in the rich text field
		Then the following text should appear in the "Hospital Course" pane
			| Male   |
			| Female |
		When I select "Male" option from the "ListSelect" list
		Then the text "Male" should appear in the "Hospital Course" pane
		When I enter "hc2" in the "HospitalCourseQTV2" rich text field
		And I click the "space" key in the "HospitalCourseQTV2" rich text field
		Then the text "For details refer to the clinic and op notes" should appear in the "Hospital Course" pane
		When I enter "he was then transferred to PACU for recovery and postop orthopedic floor for convalescence, physical therapy, and discharge planning." in the "HospitalCourseQTV2" rich text field
		Then the text "he was then transferred to PACU for recovery and postop orthopedic floor for convalescence, physical therapy, and discharge planning." should appear in the "Hospital Course" pane
		When I enter "hc3" in the "HospitalCourseQTV2" rich text field
		And I click the "space" key in the "HospitalCourseQTV2" rich text field
		Then the text "DVT prophylaxis was initiated with Lovenox." should appear in the "Hospital Course" pane
		Then I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
		And I wait "2" seconds
		And I click the "OK" button in the "Note Writer Main" pane
		And I switch the focus to the "LoginWindow" window
		And I click the "OK" button in the "Question" pane if it exists

	Scenario: Verify Discharge Medications in Discharge Summary template [DEV-57044]
		When "Molly Darr" is on the patient list
		And I select patient "Molly Darr" from the patient list
		And I load the "Discharge Summary" template note for the selected patient
		And I find out all active windows
		And I switch the focus to the "popoutWindow" window
		And I select the note "Discharge Medications" section
		And I wait "5" seconds
		Then the "Discharge Medications" pane should load
		And the "CurrentAllergy" pane should load
	 #with new Responsive design for NW, checkboxes will not be displayed
   #		And the checkbox should be checked in the rows with "hives" cell text in the "AllergyDischargeSummary" table
   #		And I uncheck the "BeeSting" checkbox
   #		Then the following should be unchecked
   #			|BeeSting |
		And I click the "Annotation" element
		When I enter "This is annotation text for allergy field" in the "AllergyDischargeSummary" rich text field
		And I wait "2" seconds
		Then the text "This is annotation text for allergy field" should appear in the "Discharge Medications" pane
		And I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
		And I click the "OK" button in the "Note Writer Main" pane
		And I wait "2" seconds
		And I switch the focus to the "LoginWindow" window
		And I click the "OK" button in the "Question" pane if it exists

	Scenario: Disable Quick text V2
		Given I am logged into the portal with user "nwadminv2" using the default password
		And I am on the "Admin" tab
		And I select the "Institution" subtab
		And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
		And I wait "2" seconds
		And I select "false" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
		And I click the "Save" button
		And I click "OK" in the confirmation box