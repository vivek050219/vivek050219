@HCANoteWriterQTV2
Feature: HCA NoteWriter Quick Text V2 Discharge Summary


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

  Scenario: Verify Hospital Course in Discharge Summary template
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "HCA Discharge Summary" template note for the selected patient
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I select the note "Hospital Course" section in the "Popout Wizard" pane
    And I wait "2" seconds
    And I enter "hc1" in the "HospitalCourseQTV2" rich text field in the "Popout Note Wizard" pane
    And I click the "enter" key in the "HospitalCourseQTV2" rich text field in the "Popout Note Wizard" pane
    Then the text "Patient is a" should appear in the "Popout Note Wizard" pane
    When I click the "Free Text" textbox in the rich text field
    And I enter "50" in the "Free Text" free text field in the "Popout Note Wizard" pane
    Then the text "50" should appear in the "Popout Note Wizard" pane
    When I click the "List" list in the rich text field
    Then the following text should appear in the "Popout Note Wizard" pane
      | Male   |
      | Female |
    When I select "Male" option from the "HospitalCourse ListSelect" list
    Then the text "Male" should appear in the "Popout Note Wizard" pane
    When I enter "hc2" in the "HospitalCourseQTV2" rich text field in the "Popout Note Wizard" pane
    And I click the "space" key in the "HospitalCourseQTV2" rich text field in the "Popout Note Wizard" pane
    Then the text "For details refer to the clinic and op notes" should appear in the "Popout Note Wizard" pane
    When I enter "he was then transferred to PACU for recovery and postop orthopedic floor for convalescence, physical therapy, and discharge planning." in the "HospitalCourseQTV2" rich text field
    Then the text "he was then transferred to PACU for recovery and postop orthopedic floor for convalescence, physical therapy, and discharge planning." should appear in the "Popout Note Wizard" pane
    When I enter "hc3" in the "HospitalCourseQTV2" rich text field
    And I click the "space" key in the "HospitalCourseQTV2" rich text field
    Then the text "DVT prophylaxis was initiated with Lovenox." should appear in the "Popout Note Wizard" pane
    Then I click the "NoteWriterSign/Submit" button in the "PopoutWizard" pane
    And I wait "2" seconds
    And I click the "OK" button in the "NoteWriterWizard" pane
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I click the "OK" button in the "Question" pane if it exists

  Scenario: Verify Discharge Medications in Discharge Summary template [DEV-57044]
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "HCA Discharge Summary" template note for the selected patient
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I select the note "Discharge Medications" section in the "Popout Wizard" pane
    And I wait "5" seconds
      #TODO : blicked by https://jira/browse/DEV-85093
    And the checkbox should be checked in the rows with "hives" cell text in the "AllergyDischargeSummary" table
    And I uncheck the "BeeSting" checkbox in the "Popout Note Wizard" pane
    Then the following should be unchecked
      | BeeSting |
    And I click the "Annotation" element in the "Popout Note Wizard" pane
    When I enter "This is annotation text for allergy field" in the "AllergyDischargeSummary" rich text field in the "Popout Note Wizard" pane
    And I wait "2" seconds
    Then the text "This is annotation text for allergy field" should appear in the "Popout Note Wizard" pane
    Then I click the "NoteWriterSign/Submit" button in the "PopoutWizard" pane
    And I wait "2" seconds
    And I click the "OK" button in the "NoteWriterWizard" pane
    And I wait "2" seconds
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
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