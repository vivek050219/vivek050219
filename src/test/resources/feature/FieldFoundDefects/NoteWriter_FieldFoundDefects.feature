Feature: NoteWriter Field Found Defects
  This test suite validates the defects which are found in CI.

  @NoteWriter @HCANoteWriter
  Scenario:Pre-requisite Enable QuickText v2
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

  @NoteWriter
  Scenario: 8.4.0 - DEV-75103 - An error occurred while attempting to perform grammar check error displayed when user clicking on proofread icon
    Given I am logged into the portal with user "hplevel3" using the default password
    And I am on the "Patient List V2" tab
    And I select "NwPLv2" from the "Patient List" menu
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I enter "Manually entered text. " in the "Patient NarrativeQTV2" rich text field
    And I enter "Testing proofread icon" in the "Patient NarrativeQTV2" rich text field
    Then I mouse over and click the "Proof read Icon" element in the "Note Writer" pane
    And the "Proof read" pane should load
    And I click the "Proof reader Close" button if it exists
    And I sign/submit the "Progress Note" note

  @NoteWriter
  Scenario: 8.4.0 - DEV-75104 - PK Spellcheck does not trigger for incorrect words
    Given I am logged into the portal with user "hplevel3" using the default password
    And I am on the "Patient List V2" tab
    And I select "NwPLv2" from the "Patient List" menu
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I enter "This is to verify spell chck" in the "PatientNarrativeQTV2" rich text field
    And I wait "3" seconds
    And The "Mis spell word" element should appear with the text "chck" in the "Note Writer" pane
    And I sign/submit the "Progress Note" note

  @NoteWriter
  Scenario:8.2.1 - DEV-76939- Blank screen appears on add/editing Note template by Admin User
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I click the "Note Template" edit link in the "Note Writer Settings" pane
    Then the "Note Template Maintenance" pane should load
#    Validating Add/Edit Note template through link
    And I select the "Progress Note" link in the row with "Progress Note" as the value under "External ID" in the "Note Template" table
    Then the "Add/Edit Note Template" pane should load
    And I click the "Cancel Note Template" button
    Then the "Note Template Maintenance" pane should load
#    Validating Add/Edit Note template through Add New Template button
    And I click the "Add New Template" button
    Then the "Add/Edit Note Template" pane should load
    And I click the "Cancel Note Template" button

  @HCANoteWriter
  Scenario: 8.4.0 - DEV-75103 - Verify proofread icon for HCA Progress Note
    Given I am logged into the portal with user "hplevel3" using the default password
    And I am on the "Patient List V2" tab
    And I select "NwPLv2" from the "Patient List" menu
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I enter "Manually entered text. " in the "Patient NarrativeQTV2" rich text field
    And I enter "Testing proofread icon" in the "Patient NarrativeQTV2" rich text field
    Then I mouse over and click the "Proof read Icon" element in the "Note Writer" pane
    And the "Proof read" pane should load
    And I click the "Proof reader Close" button if it exists
    And I sign/submit the "HCA Progress Note" note

  @HCANoteWriter
  Scenario: 8.4.0 - DEV-75104 - Verify PK Spellcheck for HCA Progress Note
    Given I am logged into the portal with user "hplevel3" using the default password
    And I am on the "Patient List V2" tab
    And I select "NwPLv2" from the "Patient List" menu
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I enter "This is to verify spell chck" in the "PatientNarrativeQTV2" rich text field
    And I wait "3" seconds
    And The "Mis spell word" element should appear with the text "chck" in the "Note Writer" pane
    And I sign/submit the "HCA Progress Note" note

  @HCANoteWriter
  Scenario:8.2.1 - DEV-76939- Blank screen appears on add/editing HCA Note template by Admin User
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I click the "Note Template" edit link in the "Note Writer Settings" pane
    Then the "Note Template Maintenance" pane should load
#    Validating Add/Edit Note template through link
    And I select the "HCA Progress Note" link in the row with "Progress Note" as the value under "External ID" in the "Note Template" table
    Then the "Add/Edit Note Template" pane should load
    And I click the "Cancel Note Template" button
    Then the "Note Template Maintenance" pane should load
#    Validating Add/Edit Note template through Add New Template button
    And I click the "Add New Template" button
    Then the "Add/Edit Note Template" pane should load
    And I click the "Cancel Note Template" button

  @NoteWriter
  Scenario: 8.4.0.6:DEV-77041-Parsing Error popup shouldn't appear when user edit esig document in Inbox
    Given I am logged into the portal with user "hplevel3" using the default password
    And I am on the "Patient List V2" tab
    And I select "NwPLv2" from the "Patient List" menu
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Chart Notation AM" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    Then I select the note "Notation" section
    When I enter "This is the Title field of DEV-77041" in the "TitleField" rich text field
    And I enter "77041" in the "NotationQTV2" rich text field
    And I wait "3" seconds
    Then the following text should appear in the "NoteWriter" pane
      |Date: 10/17/18 Dear Dr. Iwanczyk |
    And I click the "Save as Draft" button in the "Clinical Note" pane
    And I click the "Yes" button in the "Question" pane
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Notes" element
    And I click the "Refresh" button
    And I wait "5" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table
    And I wait "5" seconds
    And I click the "EDIT/SIGN" button
    And I wait for loading to complete
    And I enter "Test1" at last in the "Notation" field
    And I click the "Sign/Submit" button in the "NoteWriter Wizard" pane
    And I click the "OK" button in the "Sign/SubmitNote" pane
    Then the "Warning" pane should not appear with the text "The entity name must immediately follow the '&' in the entity reference. "
    And I wait "5" seconds
    And I click the "Xclose" button if it exists
    And I am on the "Patient List V2" tab
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "Chart Notation " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the "Chart Notation AM" pane should load
    And the text "Final" should appear in the "Chart Notation AM" pane

  @NoteWriter
  Scenario: 8.4.0:DEV-74709- NW - System error appears when user try to add a note picker
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Preferences" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I click the "Note Pickers" edit link in the "Note Writer Settings" pane
    And I click the "My Pickers" edit category link in the "Department Charge Pickers" pane
    And I wait "5" seconds
    And I enter "OperativeReport" in the "Add Code" field in the "Edit MyPickers" pane
    And I click the "Lookup Values" element in the "Edit MyPickers" pane
    And I select "OperativeReport" from the "Code" column in the "AddCode Result List" table
    Then the picker "OperativeReport" should appear in the children picker list
    And I click the "Save" button in the "Edit My Pickers" pane
    And I wait "5" seconds
    Then the text "OperativeReport" should appear in the "Department Charge Pickers" pane
    And I click the "My Pickers" edit category link in the "Department Charge Pickers" pane
    And I wait "5" seconds
    And I delete the "OperativeReport" picker in the "Edit MyPickers" pane
    And I click the "Save" button in the "Edit My Pickers" pane
#    Then the picker "OperativeReport" should not appear in the children picker list
    And I click the "Close" button in the "Department Charge Pickers" pane

   @NoteWriter
   Scenario: 8.4.1.7: Mandatory fields in collapsed section are not required to submit note [DEV-79888]
     Given I am logged into the portal with user "hplevel3" using the default password
     And I am on the "Patient List V2" tab
     And I select "NwPLv2" from the "Patient List" menu
     When "Molly Darr" is on the patient list
     And I select patient "Molly Darr" from the patient list
     And I load the "History and Physical" template note for the selected patient
     And I select the note "Family/Social History" section
     Then the "FamilySocialHistory" pane should load
     When I check the "TobaccoUse" checkbox
     And I select "Current" from the "TobaccoUseStatus" dropdown
     #packs per day and # of years are mandatory fields, hence not entering any values and verifying for warning message
     When I check the "AlcoholUse" checkbox
     And I select "Few times a month" from the "Frequency" dropdown
     And I enter "Occuasionaly" in the "AlcoholUseComment" field
     When I click the "NoteWriter Sign/Submit" button in the "Note Writer Main" pane
     Then the "Warning Message" pane should appear with the text "Please complete the required fields."
     And I click the "Warning OK" button in the "Warning Message" pane
     Then I uncheck the "TobaccoUse" checkbox
     And I sign/submit the "History and Physical" note

  @NoteWriter @HCANoteWriter
  Scenario:Post-requisite Disable QuickText v2
    Given I am logged into the portal with user "nwadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "false" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
    And I select "false" from the "Enable Spell Check" radio list in the "Note Writer Settings" pane
    And I select "None" from the "Validation" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box

  @NoteWriterCosig
  Scenario:DEV-77599 - DEV-78015 - Prerequisite : Enable NoteWriter Co-signature
    Given I am logged into the portal with user "nwadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "true" from the "Enable Spell Check" radio list in the "Note Writer Settings" pane
    And I select "true" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
    And I select "true" from the "CoSignature" radio list in the "Note Writer Settings" pane
    And I select "Password" from the "Validation" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box if it exists
    And I open "NoteWriter" settings page for the user "CSlvl3u3"
    And I edit the following user settings and I click save
      |Page       |Name                      |Type     |Value   |
      |NoteWriter |Use Addendum Template     |radio    |true    |

  @NoteWriterCosig
   Scenario: 8.2.1.14 - DEV-77599 - DEV-78015 -Unable to load the Co-Sign Addendum template
     Given I am logged into the portal with user "CSlvl3u3" using the default password
     And I am on the "Patient List V2" tab
     And the patient list is maximized
     When "Molly Darr" is on the patient list
     And I select patient "Molly Darr" from the patient list
     And I load the "Chart Notation AM" template note for the selected patient
     Then I select the note "Notation" section
     And I wait "3" seconds
     When I enter "This is the Title field." in the "TitleField" rich text field
     And I enter "scenario to test co-sign addendum" in the "NotationQTV2" rich text field
     And I sign/submit the Co-sig note as cosignature "CSLVL1U1"
     Given I am logged into the portal with user "CSlvl1u1" using the default password
     And I am on the "Inbox" tab
     When I select the "eSig and PK Mail" subtab
     And I click the "Co-Sign" element
     And I click the "Refresh" button
     Then the "Messages" table should load
     And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
     When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table
     Then the "eSig Note Content" pane should load
     And I verify the note count of the "Messages" table and click the "Sign" button with "123" password
     And I click the logout button
     #after clicking add addendum button, configured note wizard template should load
     Given I am logged into the portal with user "CSlvl3u3" using the default password
     And I am on the "Patient List V2" tab
     When "Molly Darr" is on the patient list
     And I select patient "Molly Darr" from the patient list
     And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
     When I select "Chart Notation" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
     And I click the "Add Addendum" button in the "Note Details" pane
     And I wait "5" seconds
     Then the "Note Edit Instance" pane should load
     And I select the note "Subjective" section
     And I enter "This is addendum note" in the "PatientNarrativeQTV2" rich text field
     And I select the note "A/P" section
     And I enter "R52" in the "PN Diagnosis Search" field
     And I select "Moderate" from the "LevelOfDecision" dropdown
     And I sign/submit the Co-sig note as cosignature "CSLVL1U1"
     And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
     And the child note "Progress Note" should be sticky to its parent note "Chart Notation - with Addendum" in the "Clinical Notes" table

  @NoteWriterCosig
  Scenario: 8.4.0 - DEV-78016-Back_to_Inbox and Skip button should display
        #TODO : blocked by DEV-83074
    Given I am logged into the portal with user "CSlvl3u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I wait "5" seconds
    Then the "Messages" table should load
    And I click the "Co-SignAll" element
    And I click the "Attest" button
    And I wait "3" seconds
    Then the following fields should display in the "CoSigNote" pane
      |Name                  |Type   |
      |Back To Inbox         |button |
      |NW ProgressNote Skip  |button |
    And I click the "Back To Inbox" button in the "CoSigNote" pane
    And I click the "Yes" button in the "Question" pane
    
  @NoteWriterCosig
  Scenario:DEV-77599 - DEV-78015 - Postrequisite : Disable NoteWriter Co-signature
    Given I am logged into the portal with user "nwadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "false" from the "Enable Spell Check" radio list in the "Note Writer Settings" pane
    And I select "false" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
    And I select "false" from the "CoSignature" radio list in the "Note Writer Settings" pane
    And I select "None" from the "Validation" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box if it exists
    And I open "NoteWriter" settings page for the user "CSlvl3u3"
    And I edit the following user settings and I click save
      |Page       |Name                      |Type     |Value   |
      |NoteWriter |Use Addendum Template     |radio    |false   |

  @NoteWriterPopOut
  Scenario: 8.4.0 : DEV-74837 - NW-PopIn/PopOut of Note throws System error upon adding Labs with Abnormal and Critical status
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And I wait up to "3" seconds for the "PopOut" field of type "BUTTONS" in the "Note Writer" pane to be visible
    And I pop out note writer
    Then I select the note "Data" section
    And I switch the focus to the "portal Window" window
    And I select "Lab Results" from clinical navigation
    And I select "Expanded Panels" from the "Lab Results View" menu
    And I select table row with cell values "BMP;Critical" from "Lab Panels" table
    And I check the "Selected Lab Results" checkbox in the "Components" pane
    And I select table row with cell values "CBC;Abnormal" from "Lab Panels" table
    And I check the "Selected Lab Results" checkbox in the "Components" pane
    And I switch the focus to the "popout Window" window
    When I pop in note writer
    And I wait up to "3" seconds for the "PopOut" field of type "BUTTONS" in the "Note Writer" pane to be visible
    Then the text "A System Error Has Occured" should not appear in the "Note Writer" pane
    And rows containing the following should appear in the "Clinical Data" table
        |BMP   |
        |CBC   |
    And I sign/submit the "Progress Note" note

