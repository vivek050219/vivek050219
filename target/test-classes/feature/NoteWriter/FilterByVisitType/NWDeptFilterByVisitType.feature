@842Enhancements
Feature: NW Dept Filter By Visit Type

#  #Filter Note Types available for selection by the type of Visit.  For example, admins can set at the user and dept.
#  #levels, that if the visit is a Surgery visit, perhaps only Op Report and Chart Notation note types could be set as
#  #available note types to select (or any note type set to ALL visit types).  Then, when a new note is created for the
#  #surgery visit, only Op Report and Chart Notation note types would be available for selection.

  Background:
    Given I am logged into the portal with user "nwadmin" using the default password
    And I am on the "Admin" tab
    Given I select the "Department" subtab
    And I select the department "VerveNWfilterNoteTypes"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "NoteWriter" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
    And I click the "Note Pickers" edit link in the "Note Writer Settings" pane
    Then I wait "4" seconds


  Scenario: Pre-req Default All Note Types as Dept Pickers
    Given I click the "Delete All Pickers" button
    And I click the "Yes" button in the "Warning" pane
    When I click the "Department Pickers" edit category link in the "Department Note Pickers" pane
    And I wait "2" seconds
    Then the "Edit Department Pickers Header" pane should load
    When I enter "History and Physical" in the "Add Code" field
    And I click the "Lookup Values" element in the "Edit Department Note Pickers" pane
#    Wait for IE slowness
    And I wait "2" seconds
    Then I enter "Chart Notation AM" in the "Add Code" field
    And I click the "Lookup Values" element in the "Edit Department Note Pickers" pane
    And I wait "2" seconds
    Then I enter "OperativeReport" in the "Add Code" field
    And I click the "Lookup Values" element in the "Edit Department Note Pickers" pane
    And I wait "2" seconds
    Then I enter "Discharge Summary" in the "Add Code" field
    And I click the "Lookup Values" element in the "Edit Department Note Pickers" pane
    And I wait "2" seconds
    When I click the "Save" button in the "Edit Department Note Pickers" pane
    Then the following fields should be enabled in the "Department Note Pickers" pane
      | Name             | Type  |
      | FilterByVisitAll | radio |
    And I click the "Close" button in the "Department Note Pickers" pane
##    This user and user nwadmin have both been added to department "VerveNWfilterNoteTypes"
    Given I am logged into the portal with user "nwfilter" using the default password
    Then I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Write Note" from the "Patient Header Actions" menu
    And the following templates should be available to select
      | History and Physical |
      | Chart Notation AM    |
      | OperativeReport      |
      | Discharge Summary    |
    And I click the "CancelTemplateSelect" button


  Scenario: Dept Note Pickers Filter-By-Visit-Type[DEV-78583][DEV-79483]
#    #Set History and Physical to Outpatient
    Given I click the "History and Physical" link in the "Department Note Pickers" pane
    And I wait "4" seconds
    Then the "Edit Dept Pickers By Visit" pane should load
    And I select "PK" from the "Include Visit Types" radio list in the "Edit Dept Pickers By Visit" pane
    Then I uncheck all checkboxes in "Edit Dept Pickers By Visit" pane
    Then I check the following checkboxes in the "Edit Dept Pickers By Visit" pane
      |Outpatient    |
    And I click the "SavePickers" button in the "Edit Dept Pickers By Visit" pane
#    #Set Chart Notation AM to All
    When I click the "Chart Notation AM" link in the "Department Note Pickers" pane
    And I wait "4" seconds
    Then the "Edit Dept Pickers By Visit" pane should load
    And I select "PK" from the "Include Visit Types" radio list in the "Edit Dept Pickers By Visit" pane
    Then I uncheck all checkboxes in "Edit Dept Pickers By Visit" pane
    And I select "All" from the "Include Visit Types" radio list in the "Edit Dept Pickers By Visit" pane
    And I click the "SavePickers" button in the "Edit Dept Pickers By Visit" pane
#    #Set OperativeReport to ER
    When I click the "OperativeReport" link in the "Department Note Pickers" pane
    And I wait "4" seconds
    Then the "Edit Dept Pickers By Visit" pane should load
    And I select "PK" from the "Include Visit Types" radio list in the "Edit Dept Pickers By Visit" pane
    Then I uncheck all checkboxes in "Edit Dept Pickers By Visit" pane
    Then I check the following checkboxes in the "Edit Dept Pickers By Visit" pane
      |ER        |
    And I click the "SavePickers" button in the "Edit Dept Pickers By Visit" pane
#    #Set Discharge Summary to Inpatient
    When I click the "Discharge Summary" link in the "Department Note Pickers" pane
    And I wait "4" seconds
    Then the "Edit Dept Pickers By Visit" pane should load
    And I select "PK" from the "Include Visit Types" radio list in the "Edit Dept Pickers By Visit" pane
    Then I uncheck all checkboxes in "Edit Dept Pickers By Visit" pane
    Then I check the following checkboxes in the "Edit Dept Pickers By Visit" pane
      |Inpatient     |
    And I click the "Save Pickers" button in the "Edit Dept Pickers By Visit" pane
    And I select "PK" from the "Visit Type Radio" radio list in the "Department Note Pickers" pane
    Then I select "Outpatient" from the "PK Visit Types" dropdown in the "Department Note Pickers" pane
    And I wait "2" seconds
    And only the following note pickers should be available
      | History and Physical |
      | Chart Notation AM    |
    Then I select "Inpatient" from the "PK Visit Types" dropdown in the "Department Note Pickers" pane
    And I wait "2" seconds
    And only the following note pickers should be available
      | Chart Notation AM    |
      | Discharge Summary    |
    Then I select "ER" from the "PK Visit Types" dropdown in the "Department Note Pickers" pane
    And I wait "2" seconds
    And only the following note pickers should be available
      | Chart Notation AM    |
      | OperativeReport      |
    And I click the "Close" button in the "Department Note Pickers" pane
#Below: This isn't working in 842?  Is this implemented yet in 842? -- HIC 3/22/19
#This isn't working in 841 either and supposedly is meant to be working in 841.  See [DEV-79483]. -- HIC 3/27/19
    Given I am logged into the portal with user "nwfilter" using the default password
    Then I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
#    #Molly Darr has Inpatient visits
    And I select "Write Note" from the "Patient Header Actions" menu
    And only the following note templates should be available to select
      | Chart Notation AM    |
      | Discharge Summary    |
    Then I click the "Cancel Template Select" button

#  #spaceholder: This UI not implemented yet. See [DEV-78583].
#  @NoteWriter
#  Scenario: Verify Filtered Dept Note Pickers Listed Next to Templates


  Scenario: Ensure Only All, PK, or ADT Radio Buttons can be Selected for Dept Note Pickers
    When I click the "History and Physical" link in the "Department Note Pickers" pane
    And I wait "4" seconds
    Then the "Edit Dept Pickers By Visit" pane should load
    Then I select "All" from the "Include Visit Types" radio list in the "Edit Dept Pickers By Visit" pane
    And the following fields should be enabled in the "Edit Dept Pickers By Visit" pane
      | Name            | Type  |
      | AllVisitTypes   | radio |
    And the following fields should be disabled in the "Edit Dept Pickers By Visit" pane
      | Name   | Type  |
      | PK     | radio |
      | ADT    | radio |
    Then I select "ADT" from the "Include Visit Types" radio list in the "Edit Dept Pickers By Visit" pane
    And the following fields should be enabled in the "Edit Dept Pickers By Visit" pane
      | Name  | Type  |
      | ADT   | radio |
    Then the following fields should be disabled in the "Edit Dept Pickers By Visit" pane
      | Name            | Type  |
      | AllVisitTypes   | radio |
      | PK              | radio |
    And I select "PK" from the "Include Visit Types" radio list in the "Edit Dept Pickers By Visit" pane
    Then the following fields should be enabled in the "Edit Dept Pickers By Visit" pane
      | Name | Type  |
      | PK   | radio |
    And the following fields should be disabled in the "Edit Dept Pickers By Visit" pane
      | Name            | Type  |
      | AllVisitTypes   | radio |
      | ADT             | radio |
    And I click the "Cancel Pickers" button in the "Edit Dept Pickers By Visit" pane
    And I click the "Close" button in the "Department Note Pickers" pane

  Scenario: Dept Pickers - Ensure Only PK or ADT can be Selected for the Same Visit Type
    When I click the "History and Physical" link in the "Department Note Pickers" pane
    And I wait "4" seconds
    Then the "Edit Dept Pickers By Visit" pane should load
    Then I select "PK" from the "Include Visit Types" radio list in the "Edit Dept Pickers By Visit" pane
    And the "Outpatient" checkbox should be checked in the "Edit Dept Pickers By Visit" pane
    Then I select "ADT" from the "Include Visit Types" radio list in the "Edit Dept Pickers By Visit" pane
    Then I check the following checkboxes in the "Edit Dept Pickers By Visit" pane
      |O:SIMHOSPITAL    |
    And I click the "SavePickers" button in the "Edit Dept Pickers By Visit" pane
    When I click the "History and Physical" link in the "Department Note Pickers" pane
    And I wait "4" seconds
    Then the "Edit Dept Pickers By Visit" pane should load
    Then I select "ADT" from the "Include Visit Types" radio list in the "Edit Dept Pickers By Visit" pane
    And the "O:SIMHOSPITAL" checkbox should be checked in the "Edit Dept Pickers By Visit" pane
    Then I select "PK" from the "Include Visit Types" radio list in the "Edit Dept Pickers By Visit" pane
    And the "Outpatient" checkbox should be unchecked in the "Edit Dept Pickers By Visit" pane
    Then I check the following checkboxes in the "Edit Dept Pickers By Visit" pane
      |Outpatient    |
    And I click the "SavePickers" button in the "Edit Dept Pickers By Visit" pane
    When I click the "History and Physical" link in the "Department Note Pickers" pane
    And I wait "4" seconds
    Then the "Edit Dept Pickers By Visit" pane should load
    Then I select "ADT" from the "Include Visit Types" radio list in the "Edit Dept Pickers By Visit" pane
    And the "O:SIMHOSPITAL" checkbox should be unchecked in the "Edit Dept Pickers By Visit" pane
    Then I select "PK" from the "Include Visit Types" radio list in the "Edit Dept Pickers By Visit" pane
    And the "Outpatient" checkbox should be checked in the "Edit Dept Pickers By Visit" pane
    And I click the "SavePickers" button in the "Edit Dept Pickers By Visit" pane
    And I click the "Close" button in the "Department Note Pickers" pane


  Scenario: Export Dept Note Pickers
    Given I wait up to "20" seconds for the "Export Pickers" field of type "BUTTON" to be clickable
#    Wait an extra 2 seconds for IE
    Then the following note pickers should be available for the "VerveNWfilterNoteTypes" department
      | History and Physical |
      | Chart Notation AM    |
      | OperativeReport      |
      | Discharge Summary    |
    When I click the "Export Pickers" button
    #    #Delete any prior dl'd zip file if it exists before dl'ing the new zip file
    Then I delete the "VerveNWfilterNoteTypesPickerExport" ".zip" file
#    #Delete any prior unzipped file if it exists before unzipping the new file
    And I delete the "VerveNWfilterNoteTypesPickerExport" ".csv" file
    Then I click the "Export All" button
    When I use Robot to click the IE Save button in downloads bar if it exists
    And I unzip the "VerveNWfilterNoteTypesPickerExport" file
    And I click the "InformationOK" button
    Then I use Robot to click the IE Close button in downloads bar if it exists
    And I click the "Close" button in the "Department Note Pickers" pane

#This isn't working in 841 either and supposedly is meant to be working in 841.  See [DEV-79485]. -- HIC 3/2/7/19
#   #I can Export the CSV fine and it comes out correct, but when import back in, the note pickers are no longer filtered
#    #by visit type.
#  DEV-79787: Still not working in 841.  Made new dev issue for fix to be backported to 841.  -- HIC 4/15/19
# DEV-79485 Fixed: This is now working in 842.  -- HIC 4/15/19
  Scenario: Import Dept Note Pickers[DEV-78583][DEV-79485][DEV-79787]
    Given I wait "2" seconds
#    Wait an extra 2 seconds for IE
    When I click the "Delete All Pickers" button
    And I click the "Yes" button in the "Warning" pane
    When I click the "Import Pickers" button
    Then I import the "VerveNWfilterNoteTypesPickerExport.csv" file using the "Choose File" Input element
    And I click the "ImportFile" button
    Then the following note pickers should be available for the "VerveNWfilterNoteTypes" department
      | History and Physical |
      | Chart Notation AM    |
      | OperativeReport      |
      | Discharge Summary    |
    And I select "PK" from the "Visit Type Radio" radio list in the "Department Note Pickers" pane
    Then I select "Outpatient" from the "PK Visit Types" dropdown in the "Department Note Pickers" pane
    And I wait "2" seconds
    And only the following note pickers should be available
      | History and Physical |
      | Chart Notation AM    |
    Then I select "Inpatient" from the "PK Visit Types" dropdown in the "Department Note Pickers" pane
    And I wait "2" seconds
    And only the following note pickers should be available
      | Chart Notation AM    |
      | Discharge Summary    |
    Then I select "ER" from the "PK Visit Types" dropdown in the "Department Note Pickers" pane
    And I wait "2" seconds
    And only the following note pickers should be available
      | Chart Notation AM    |
      | OperativeReport      |
    And I click the "Close" button in the "Department Note Pickers" pane

  Scenario: Dept - Change Visit Type Mid-Note Creation and Check for Warning[DEV-78583][DEV-79483]
    Then I click the "Close" button in the "Department Note Pickers" pane
    Given I am logged into the portal with user "nwfilter" using the default password
    Then I am on the "Patient Search" tab
    And I click the "Clear Criteria" button in the "Patient Search Criteria" pane
    And I enter "darr" in the "Last" field in the "Patient Search Criteria" pane
    And I enter "molly" in the "First" field in the "Patient Search Criteria" pane
    Then I click the "Search for Visits" button in the "Patient Search Criteria" pane
    When I sort the "Visit Search Results" table chronologically by the "Admit/Appt" column in "Descending" order
    And I select "the first item" in the "Visit Search Results" table
    And I select "Outpatient" from the "Create Visit" menu
    And the "Patient Search Charge Entry" pane should load
    When I fill in the following fields
      | Name                         | Type     | Value                   |
      | Add Facility                 | dropdown | SIMHOSPITAL             |
      | Add Visit Type               | dropdown | OP_Manreg               |
      | AppointmentDateTime-Date     | text     | %Current Date MMDDYY%   |
      | AppointmentDateTime-Time     | text     | %Current Time HHMM%     |
    And I click the "Add and Save" button
    Then I am on the "Patient List V2" tab
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Write Note" from the "Patient Header Actions" menu
    Then the "Select Note Template" pane should load
#    #Molly Darr should have Inpatient visits, which is set to Discharge Summary notes.
#    # At least 1 Outpatient visit,  which is set to History & Physical.
#    # And, Chart Notation which is set to All.
#    # This filtering below should be working in 841, but it's not.  -- HIC 4/17/19
    And only the following note templates should be available to select
#      | History and Physical |
      | Chart Notation AM    |
      | Discharge Summary    |
    Then I select "Discharge Summary" from the select template list
    And I click the "OK" button in the "Information" pane if it exists
    Then the selection in the "Select a Visit" dropdown should contain "Inpatient"
    And I select an "Outpatient" visit from the "Select a Visit" dropdown
    And I wait "5" seconds
    And the "Error Dialog" pane should appear with the text "This note type cannot be written on selected visit type. Please change to the correct visit"
    Then I click the "OK" button in the "Warning" pane
    And I click the "NoteWriterCancelNote" button in the "ClinicalNote" pane
    Then I click the "Yes" button in the "Warning" pane

  Scenario: Dept - Create Draft Note and then Change Note Picker Config[DEV-78583][DEV-79483]
    Then I click the "Close" button in the "Department Note Pickers" pane
    Given I am logged into the portal with user "nwfilter" using the default password
    Then I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    Then I load the "Discharge Summary" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    Then the selection in the "Select a Visit" dropdown should contain "Inpatient"
    And I click the "Save as Draft" button
    And I click the "Yes" button in the "Question" pane
    Then I am on the "Admin" tab
    Given I select the "Department" subtab
    And I select the department "VerveNWfilterNoteTypes"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "NoteWriter" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
    And I click the "Note Pickers" edit link in the "Note Writer Settings" pane
    Then I wait "4" seconds
    When I click the "Discharge Summary" link in the "Department Note Pickers" pane
    And I wait "4" seconds
    Then the "Edit Dept Pickers By Visit" pane should load
    And I select "PK" from the "Include Visit Types" radio list in the "Edit Dept Pickers By Visit" pane
    Then I uncheck all checkboxes in "Edit Dept Pickers By Visit" pane
    Then I check the following checkboxes in the "Edit Dept Pickers By Visit" pane
      |ER     |
    And I click the "SavePickers" button in the "Edit Dept Pickers By Visit" pane
    And I click the "Close" button in the "Department Note Pickers" pane
    Then I am on the "Patient List V2" tab
    And I select patient "Molly Darr" from the patient list
    And I select "Write Note" from the "Patient Header Actions" menu
    Then the "Select Note Template" pane should load
#    #Molly Darr should have Inpatient visits, which is set to only those notes available to ALL note types now (Chart Notation AM).
#    # At least 1 Outpatient visit,  which is set to History & Physical.
#    # This filtering below should be working in 841, but it's not.  -- HIC 4/17/19
    And only the following note templates should be available to select
#      | History and Physical |
      | Chart Notation AM    |
    And I click the "Cancel" button in the "Select Note Template" pane
    When I select "Clinical Notes" from clinical navigation
    Then I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "*DRAFT* Discharge Summary" from the "Note Type" column in the "Clinical Notes" table
    Then I click the "Edit Note" button
    #below warning should not appear, user should be allowed to contiue editing the note
#    And the "Error Dialog" pane should appear with the text "This note type cannot be written on selected visit type. Please change to the correct visit"
#    Then I click the "OK" button in the "Warning" pane
    And I select the note "Follow Up" section
    Then I select "Fair" from the "Discharge Condition" dropdown
    And I enter "adding manual text" in the "DischargeConditionQTV2" field
    And I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I wait "2" seconds
    And I click the "OK" button in the "Submit Note" pane

  Scenario: Post-req Delete Any Dept Notepickers
    When I click the "Delete All Pickers" button
    And I click the "Yes" button in the "Warning" pane
    And I click the "Close" button in the "Department Note Pickers" pane
