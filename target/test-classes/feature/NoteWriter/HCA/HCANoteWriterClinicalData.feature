@HCANoteWriter
Feature: NoteWriter ClinicalData

  Background:
    Given I am logged into the portal with user "nwuser3" using the default password
	  # "Use Templated Addendum" setting should be set to "Yes" in Notewriter user level settings for the above user
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "NwPLv2" owned by "nwuser3" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I click the "Refresh Patient List" button
    And I select "NwPLv2" from the "Patient List" menu
    And "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list

  @NoteWriter
  Scenario: Pre-Condition-Enable CPOEMEdication Disable
	 # Added this precondition to disable CPOEMEdication as suggested in DEV-68517 to show medication header in note template
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    Then the "Institution Settings" pane should load
    And I select "Site Administration" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And the "Site Administration" pane should load
    Then I select "false" from the "CPOE Medications" radio list in the "Site Administration" pane
    Then I select "true" from the "Medication" radio list in the "Site Administration" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    Then the "Institution Settings" pane should load

  @NoteWriter
  Scenario: ProblemList
    And I select patient "MOLLY DARR" from the patient list
    Then the text "DARR, MOLLY" should appear in the "Header" pane
    When I select "Problems" from clinical navigation
    And I select "Last 30 Days" from the "Clinical Timeframe" menu
    Then the "Problems" pane should load
    And the following field should not display in the "Problems" pane
      | Name           | Type    |
      | NoteWriterIcon | element |

  @NoteWriter @Demo
  Scenario: Allergies
    When I select "Allergies" from clinical navigation
    And I click the "NoteWriter Icon" element in the "Allergy" pane
    Then the checkbox should be checked in all rows in the "Allergies" table
	 #removed few steps as per the updated note writer step definition
    And I load the "HCA Progress Note" template note for the selected patient
    Then I wait "4" seconds
    And I select the note "Data" section
    Then I wait "2" seconds
    Then the "Clinical Data" table should load
    And the "Clinical Data" table should have at least "2" rows
    And the "Annotation" image should be shown in the following rows in the "Clinical Data" table
      | Displayed |              |
      | true      | Bee sting    |
      | true      | Penicillin   |
      | true      | Sulfonamides |
    And the "Trash" image should be shown in the following rows in the "Clinical Data" table
      | Displayed |              |
      | true      | Bee sting    |
      | true      | Penicillin   |
      | true      | Sulfonamides |
    And the "Clinical Data" table should have at least "1" rows containing the text "Allergies"
	 #removed few steps as per the updated note writer step definition and added below step
    And I save the template as Draft
    When I select "Clinical Notes" from clinical navigation
    When I click the "HP" button in the "Clinical Notes" pane if it exists
    And I check the "SelectAll/SelectNone" checkbox in the "Clinical Filter" pane if it exists
    And I click the "OK Filter" button if it exists
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    Then rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type             | Author    |
      | %Current Date MMDDYY% | *DRAFT* Progress Note | NW3, USER |
    When I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the "HCA Progress Note" pane should load
    And the text "Draft" should appear in the "HCA Progress Note" pane
    And the text "Allergies" should appear in the "Data" section in the "HCA Progress Note" pane
    And I delete the draft note in the "HCA Progress Note" pane

  @NoteWriter
  Scenario: Adding Pre-required Progress note
    And I am on the "Patient List V2" tab
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "HCA Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I sign/submit the "HCA Progress Note" note

  @NoteWriter
  Scenario: ClinicalNotes
    When I select "Clinical Notes" from clinical navigation
    And I click the "NoteWriter Icon" element in the "Clinical Notes" pane
#   		Then the checkbox should be unchecked in the rows with "*DRAFT* Progress Note" cell text in the "Clinical Notes" table
    And the checkbox should be checked in the rows with "Progress Note" cell text in the "Clinical Notes" table
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Data" section
    Then the "Clinical Data" table should load
    And the "Clinical Data" table should have at least "2" rows
    And the "Annotation" image should be shown in the following rows in the "Clinical Data" table
      | Displayed |                             |
      | true      | Discharge Summary           |
      | true      | Continuity of Care Document |
      | true      | Nursing Assessment          |
      | true      | Consult - Renal             |
      | true      | History and Physical        |
    And the "Trash" image should be shown in the following rows in the "Clinical Data" table
      | Displayed |                             |
      | true      | Discharge Summary           |
      | true      | Continuity of Care Document |
      | true      | Nursing Assessment          |
      | true      | Consult - Renal             |
      | true      | History and Physical        |
    And the "Clinical Data" table should have at least "1" rows containing the text "Clinical Notes"
    And I save the template as Draft
    And I wait "2" seconds
    Then rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type             | Author    |
      | %Current Date MMDDYY% | *DRAFT* Progress Note | NW3, USER |
    When I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the "HCA Progress Note" pane should load
    And I wait "2" seconds
    And the text "Draft" should appear in the "HCA Progress Note" pane
    And the text "Clinical Notes" should appear in the "Data" section in the "HCA Progress Note" pane
    And I delete the draft note in the "HCA Progress Note" pane

  @NoteWriter
  Scenario: LabResults
    When I select "Lab Results" from clinical navigation
    And I select "Panel Summary" from the "Lab Results View" menu
    Then the "Components" pane should load within "5" seconds
    And I click the "NoteWriter Icon" element in the "Components" pane
    Then the checkbox should be checked in all rows in the "Lab Panels" table
	 #removed few steps as per the updated note writer step definition
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Data" section
    Then the "LabResultsData" table should load
    And the "LabResultsData" table should have at least "2" rows
    And the "Annotation" image should be shown in the following rows in the "LabResultsData" table
      | Displayed |         |
      | true      | BMP     |
      | true      | CBC     |
      | true      | Thyroid |
      | true      | PT/INR  |
      | true      | MIPanel |
    And the "Trash" image should be shown in the following rows in the "LabResultsData" table
      | Displayed |         |
      | true      | BMP     |
      | true      | CBC     |
      | true      | Thyroid |
      | true      | PT/INR  |
      | true      | MIPanel |
    And the "LabResultsData" table should have at least "1" rows containing the text "Lab Results"
	 #removed few steps as per the updated note writer step definition and added below step
    And I save the template as Draft
    And I select "Clinical Notes" from clinical navigation
    And I wait "2" seconds
    Then rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type             | Author    |
      | %Current Date MMDDYY% | *DRAFT* Progress Note | NW3, USER |
    When I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the "HCA Progress Note" pane should load
    And I wait "2" seconds
    And the text "Draft" should appear in the "HCA Progress Note" pane
    And the text "Labs" should appear in the "HCA Progress Note" pane
    And I delete the draft note in the "HCA Progress Note" pane

# #Failed due to [DEV-79159].  https://jira/browse/DEV-79159: Medications and medication orders are not showing
# #up in 842 due to HL7s being rejected.
  @NoteWriter
  Scenario: Meds[DEV-79159]
    When I select "Medications" from clinical navigation
    And I click the "NoteWriter Icon" element in the "Medication" pane
    Then the checkbox should be checked in all rows in the "Medication Orders" table
	 #removed few steps as per the updated note writer step definition
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Data" section
    Then the "MedicationsData" table should load
    And the "MedicationsData" table should have at least "2" rows
    And the "Annotation" image should be shown in the following rows in the "MedicationsData" table
      | Displayed |               |
      | true      | Albuterol     |
      | true      | Carvedilol    |
      | true      | Acetaminophen |
    And the "Trash" image should be shown in the following rows in the "MedicationsData" table
      | Displayed |               |
      | true      | Albuterol     |
      | true      | Carvedilol    |
      | true      | Acetaminophen |
    And the "MedicationsData" table should have at least "1" rows containing the text "Medication"
	 #removed few steps as per the updated note writer step definition and added below step
    And I save the template as Draft
    And I select "Clinical Notes" from clinical navigation
    Then rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type             | Author    |
      | %Current Date MMDDYY% | *DRAFT* Progress Note | NW3, USER |
    When I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the "HCA Progress Note" pane should load
    And I wait "1" second
    And the text "Draft" should appear in the "HCA Progress Note" pane
    And the text "Medication" should appear in the "HCA Progress Note" pane
    And I delete the draft note in the "HCA Progress Note" pane

  @NoteWriter @Demo
  Scenario: TestResults
    When I select "Test Results" from clinical navigation
    And I click the "Note Writer Icon" element in the "Test Results" pane
    Then the checkbox should be checked in all rows in the "Test ResultsV2" table
	 #removed few steps as per the updated note writer step definition
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Data" section
    Then the "Clinical Data" table should load
    And the "Clinical Data" table should have at least "2" rows
    And the "Annotation" image should be shown in the following rows in the "Clinical Data" table
      | Displayed |              |
      | true      | EKG          |
      | true      | MRI - brain  |
      | true      | Abdominal CT |
    And the "Trash" image should be shown in the following rows in the "Clinical Data" table
      | Displayed |              |
      | true      | EKG          |
      | true      | MRI - brain  |
      | true      | Abdominal CT |
    And the "Clinical Data" table should have at least "1" rows containing the text "Test Results"
	 #removed few steps as per the updated note writer step definition and added below step
    And I save the template as Draft
    And I select "Clinical Notes" from clinical navigation
    And I wait "2" seconds
    Then rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type             | Author    |
      | %Current Date MMDDYY% | *DRAFT* Progress Note | NW3, USER |
    When I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    And I wait "1" second
    Then the "HCA Progress Note" pane should load
    And the text "Draft" should appear in the "HCA Progress Note" pane
    And the text "Test Results" should appear in the "HCA Progress Note" pane
    And I delete the draft note in the "HCA Progress Note" pane

  @NoteWriter @Demo
  Scenario: TestResults TextSelection
    When I select "Test Results" from clinical navigation
    And I wait "3" seconds
    And I select "EKG" in the "Test ResultsV2" table
    Then the "Test Results Detail" pane should load
	 #When I click the "Select All Text" element in the "Test Results Detail" pane
    When I enter "Finding" in the "NoteSearchText" field
    And I click the "SearchText" image
    Then I doubleClick on the searchtext in the "SearchDetail" pane
    And I click the "Add Selected Text" element in the "Test Results Detail" pane
    Then the following fields should display in the "TestSelectionNw" pane
      | Name                 | Type    |
      | Remove Selected Text | element |
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Data" section
    Then the "Clinical Data" table should load
    And the "Clinical Data" table should have at least "2" rows
    And the "Annotation" image should be shown in the following rows in the "Clinical Data" table
      | Displayed |     |
      | true      | EKG |
    And the "Trash" image should be shown in the following rows in the "Clinical Data" table
      | Displayed |     |
      | true      | EKG |
    And the "Clinical Data" table should have at least "1" rows containing the text "Test Results"
	 #removed few steps as per the updated note writer step definition and added below step
    And I save the template as Draft
    And I select "Clinical Notes" from clinical navigation
    And I wait "2" seconds
    Then rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type             | Author    |
      | %Current Date MMDDYY% | *DRAFT* Progress Note | NW3, USER |
    When I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the "HCA Progress Note" pane should load
    And the text "Draft" should appear in the "HCA Progress Note" pane
    And the text "Test Results" should appear in the "HCA Progress Note" pane
    And I delete the draft note in the "HCA Progress Note" pane

  @NoteWriter
  Scenario: ClinicalNotes TextSelection
    When I select "Clinical Notes" from clinical navigation
	 #And I load the "Progress Note" template note for the selected patient
	 #And I click the "NoteWriter...Sign/Submit" button in the "NoteWriter Main" pane
	 #And I click the "Yes" button in the "Sign/Submit" pane
	 #And I click the "OK" button in the "SubmitNote" pane
    And I wait "2" seconds
    When I select the cell with text "Progress Note" from the "Note Type" column in the "Clinical Notes" table
   #		And I select "Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the "HCA Progress Note" pane should load
	 #When I click the "Select All Text" element in the "Progress Note" pane
    When I enter "DATA" in the "NoteSearchText" field
    And I click the "SearchText" image
    Then I doubleClick on the searchtext in the "SearchDetail" pane
    And I click the "Add Selected Text" element in the "HCA Progress Note" pane
    Then the following fields should display in the "TestSelectionNw" pane
      | Name                 | Type    |
      | Remove Selected Text | element |
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Data" section
    Then the "Clinical Data" table should load
    And the "Clinical Data" table should have at least "2" rows
    And the "Annotation" image should be shown in the following rows in the "Clinical Data" table
      | Displayed |               |
      | true      | Progress Note |
    And the "Trash" image should be shown in the following rows in the "Clinical Data" table
      | Displayed |               |
      | true      | Progress Note |
    And the "Clinical Data" table should have at least "1" rows containing the text "Clinical Notes"
	 #removed few steps as per the updated note writer step definition and added below step
    And I save the template as Draft
    And I select "Clinical Notes" from clinical navigation
    Then rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type             | Author    |
      | %Current Date MMDDYY% | *DRAFT* Progress Note | NW3, USER |
    When I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    And I wait "1" second
    Then the "HCA Progress Note" pane should load
    And the text "Draft" should appear in the "HCA Progress Note" pane
    And the text "Clinical Notes" should appear in the "Data" section in the "HCA Progress Note" pane
    And I delete the draft note in the "HCA Progress Note" pane

  @NoteWriter
  Scenario: NoteFilterCategories
    When I select "Clinical Notes" from clinical navigation
   #		And I select "Write Note" from the "Patient Header Actions" menu
   #		And I click the "Create New" button in the "Notes in Draft Status" pane if it exists
    And I load the "HCA Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I wait "2" seconds
   #		And I click the "Save as Draft " button
   #		And I click the "Yes" button in the "Question" pane
    And I save the template as Draft
    And I wait "2" seconds
    And I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the "HCA Progress Note" pane should load
    When I click the "ALL" button in the "Clinical Notes" pane
    And I wait "2" seconds
    And I uncheck the "SelectAll/SelectNone" checkbox in the "Clinical Filter" pane
	 #And I check the "HP" checkbox in the "Clinical Filter" pane
    And I check the "HP" checkbox in the "Clinical Filter" pane
    And I click the "OK Filter" button
    Then the "Clinical Notes" table should load
    And the "HCA Progress Note" pane should not load
	 #When I select "ProgressNote" from the "Note Type" menu
    And I wait "2" seconds
    When I click the "HP" button in the "Clinical Notes" pane
    And I wait "2" seconds
	 #And I uncheck the "HP" checkbox in the "Clinical Filter" pane
    And I uncheck the "HP" checkbox in the "Clinical Filter" pane
    And I check the "ProgressNote" checkbox in the "Clinical Filter" pane
	 #And I check the "ProgressNote" checkbox in the "Clinical Filter" pane
    And I click the "OK Filter" button
    Then the "Clinical Notes" table should load
    When I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    Then the "HCA Progress Note" pane should load
	 #Revert back the Notetype menu to All
    When I click the "ProgressNote" button in the "Clinical Notes" pane
    And I wait "2" seconds
    And I check the "SelectAll/SelectNone" checkbox in the "Clinical Filter" pane
    And I click the "OK Filter" button
    Then the "Clinical Notes" table should load
    When I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    And I wait "1" second
    And I delete the draft note in the "HCA Progress Note" pane

  @NoteWriter
  Scenario: OrderStatus
    When I select "Orders" from clinical navigation
    And I click the "NoteWriter Icon" element in the "Orders" pane
    Then the checkbox should be checked in all rows in the "Orders" table
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Data" section
    Then the "Clinical Data" table should load
    And the "Clinical Data" table should have at least "2" rows
    And the "Annotation" image should be shown in the following rows in the "Clinical Data" table
      | Displayed |                   |
      | true      | Cholesterol level |
      | true      | BMP QAM           |
      | true      | Urine Culture     |
    And the "Trash" image should be shown in the following rows in the "Clinical Data" table
      | Displayed |                   |
      | true      | Cholesterol level |
      | true      | BMP QAM           |
      | true      | Urine Culture     |
    And the "Clinical Data" table should have at least "1" rows containing the text "Orders"
	 #removed few steps as per the updated note writer step definition and added the below step
    And I save the template as Draft
    When I select "Clinical Notes" from clinical navigation
    And I wait "2" seconds
    Then rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type             | Author    |
      | %Current Date MMDDYY% | *DRAFT* Progress Note | NW3, USER |
    When I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    And I wait "1" second
    Then the "HCA Progress Note" pane should load
    And the text "Draft" should appear in the "HCA Progress Note" pane
    And the text "Orders" should appear in the "HCA Progress Note" pane
    And I delete the draft note in the "HCA Progress Note" pane


# #Failed due to [DEV-79159].  https://jira/browse/DEV-79159: Medications and medication orders are not showing
# #up in 842 due to HL7s being rejected.
  @NoteWriter
  Scenario: MultipleClinicalData [DEV-47691][DEV-79159]
    And "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    When I select "Clinical Notes" from clinical navigation
    And I load the "HCA Progress Note" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I wait "2" seconds
    And I click the "Save as Draft " button
    And I click the "Yes" button in the "Question" pane
    When I select "Allergies" from clinical navigation
    And I click the "NoteWriter Icon" element in the "Allergy" pane
    Then the checkbox should be checked in all rows in the "Allergies" table
    When I select "Clinical Notes" from clinical navigation
    Then I wait "2" seconds
    And I click the "NoteWriter Icon" element in the "ClinicalNotes" pane
    Then the checkbox should be unchecked in the rows with "*DRAFT* Progress Note" cell text in the "Clinical Notes" table
    And the checkbox should be checked in the rows with "Progress Note" cell text in the "Clinical Notes" table
    When I select "Lab Results" from clinical navigation
    And I select "Panel Summary" from the "Lab Results View" menu
    And I click the "NoteWriter Icon" element in the "Components" pane
    Then the checkbox should be checked in all rows in the "Lab Panels" table
    When I select "Medications" from clinical navigation
    And I click the "NoteWriter Icon" element in the "Medication" pane
    Then the checkbox should be checked in all rows in the "Medication Orders" table
    When I select "Test Results" from clinical navigation
    And I click the "NoteWriter Icon" element in the "Test Results" pane
    Then the checkbox should be checked in all rows in the "Test ResultsV2" table
    When I select "Orders" from clinical navigation
    And I click the "NoteWriter Icon" element in the "Orders" pane
    Then the checkbox should be checked in all rows in the "Orders" table
	 #Then the checkbox should be checked in the rows with "Final" cell text in the "Orders" table
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Data" section
    Then the "Clinical Data" table should load
    And the "Clinical Data" table should have at least "2" rows
    And the "Annotation" image should be shown in the following rows in the "Clinical Data" table
      | Displayed |                    |
      | true      | Soy                |
      | true      | Discharge Summary  |
      | true      | BMP                |
#			|true       |Aspirin			|
      | true      | EKG                |
      | true      | Cardiology Consult |
    And the "Trash" image should be shown in the following rows in the "Clinical Data" table
      | Displayed |                    |
      | true      | Soy                |
      | true      | Discharge Summary  |
      | true      | BMP                |
#			|true       |Aspirin			|
      | true      | EKG                |
      | true      | Cardiology Consult |
    And the "Clinical Data" table should have at least "1" rows containing the text "Allergies"
    And the "Clinical Data" table should have at least "1" rows containing the text "Clinical Notes"
    And the "LabResultsData" table should have at least "1" rows containing the text "Lab Results"
    And the "Medications Data" table should have at least "1" rows containing the text "Medications"
    And the "Clinical Data" table should have at least "1" rows containing the text "Test Results"
    And the "Clinical Data" table should have at least "1" rows containing the text "Orders"
    And I save the template as Draft
    When I select "Clinical Notes" from clinical navigation
    Then rows starting with the following should appear in the "Clinical Notes" table
      | Date/Time             | Note Type             | Author    |
      | %Current Date MMDDYY% | *DRAFT* Progress Note | NW3, USER |
    When I select "*DRAFT* Progress Note" from the "Note Type" column in the "Clinical Notes" table
    And I wait "2" seconds
    Then the "HCA Progress Note" pane should load
    And the text "Draft" should appear in the "HCA Progress Note" pane
    And the text "Allergies" should appear in the "Data" section in the "HCA Progress Note" pane
    And the text "Clinical Notes" should appear in the "HCA Progress Note" pane
    And the text "Labs" should appear in the "HCA Progress Note" pane
#		And the text "Medication" should appear in the "Data" section in the "HCA Progress Note" pane
    And the text "Test Results" should appear in the "HCA Progress Note" pane
    And the text "Orders" should appear in the "HCA Progress Note" pane
    And I delete the draft note in the "HCA Progress Note" pane

  @NoteWriter
  Scenario: Baylor addendum problem [AUTO-186][DEV-57760]
    And I select "Clinical Notes" from clinical navigation
    Then the "Clinical Notes" table should load
    And I select "Progress Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I wait "2" seconds
    Then the following field should be enabled in the "Note Detail" pane
      | Name         | Type   |
      | Add Addendum | button |
    And the "Note Detail" pane should load

  @NoteWriter
  Scenario: Post-Condition-Enable CPOEMEdication Enable
	 # Added this postcondition to enable CPOEMEdication as suggested in DEV-68517
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    Then the "Institution Settings" pane should load
    And I select "Site Administration" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And the "Site Administration" pane should load
    Then I select "false" from the "Medication" radio list in the "Site Administration" pane
    Then I select "true" from the "CPOE Medications" radio list in the "Site Administration" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    Then the "Institution Settings" pane should load

