@InsertPrevious
Feature: NoteWriter Insert Previous Edge Scenarios
#  ALM Path: Notewriter (PK)>> 009 - Insert Previous >> Edge Scenarios

    Background:
        Given I am logged into the portal with user "InsPrevEdge3" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        And I use the API to create a patient list named "InsPrevEdge" owned by "InsPrevEdge3" with the following parameters
              | Type   | Name            | Value      |
              | Filter | Medical Service | Card Group |
        And I click the "Refresh Patient List" button
        And I select "InsPrevEdge" from the "Patient List" menu
        And "DARR, MOLLY" is on the patient list
        And "BAMBERGER, HELEN" is on the patient list
        And "HEATH, NEIL" is on the patient list
        And I select "Clinical Notes" from clinical navigation

    Scenario: Enable QuickText v2
    # Pre-requisite
        Given I am logged into the portal with user "nwadmin" using the default password
        And I am on the "Admin" tab
        And I select the "Institution" subtab
        And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
        And I wait "2" seconds
        And I select "true" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
        And I select "true" from the "Enable Spell Check" radio list in the "Note Writer Settings" pane
        And I select "None" from the "Validation" dropdown
        And I click the "Save" button
        And I click "OK" in the confirmation box
        And I click the logout button

    Scenario: Check Insert Previous for the all fields in History Section using H&P Template
    # Test Case: 001_Check Insert Previous for the all field in H&P Template
        And I select patient "DARR, MOLLY" from the patient list
        And I load the "History and Physical" template note for the selected patient
        And I select the note "History" section
        And I click the "OK" button in the "Information" pane if it exists
        And I select the note "History" section
        And I enter "This scenario tests the insert previous link in HPI rich text field in the History tab" in the "HPI QTV2" rich text field
        And I click the "CTRL ALL" key in the "HPI QTV2" rich text field in the "Note Writer Main" pane
        And I click the "Bold" key in the "HPI QTV2" rich text field in the "Note Writer Main" pane
        And I enter "This scenario tests the insert previous link in AdditionalPMHComments rich text field in the History tab" in the "Additional PMH Comments QTV2" rich text field
        And I click the "CTRL ALL" key in the "Additional PMH Comments QTV2" rich text field in the "Note Writer Main" pane
        And I click the "Bold" key in the "Additional PMH Comments QTV2" rich text field in the "Note Writer Main" pane
        And I enter "This scenario tests the insert previous link in AdditionalSurgeriesAndProcedures rich text field in the History tab" in the "Additional Surgeries QTV2" rich text field
        And I click the "CTRL ALL" key in the "Additional Surgeries QTV2" rich text field in the "Note Writer Main" pane
        And I click the "Bold" key in the "Additional Surgeries QTV2" rich text field in the "Note Writer Main" pane
        And I enter "This scenario tests the insert previous link in AdditionalAllergies rich text field in the History tab" in the "Allergies QTV2" rich text field
        And I click the "CTRL ALL" key in the "Allergies QTV2" rich text field in the "Note Writer Main" pane
        And I click the "Bold" key in the "Allergies QTV2" rich text field in the "Note Writer Main" pane
        And I enter "This scenario tests the insert previous link in HomeMedications rich text field in the History tab" in the "Home Medications QTV2" rich text field
        And I click the "CTRL ALL" key in the "Home Medications QTV2" rich text field in the "Note Writer Main" pane
        And I click the "Bold" key in the "Home Medications QTV2" rich text field in the "Note Writer Main" pane
        And I click the "SaveasDraft" button in the "ClinicalNote" pane
        Then I click the "Yes" button in the "Note Writer Main" pane

    Scenario: Verify Insert Previous for the all fields in History section using H&P Template
    # Test Case: 001_Check Insert Previous for the all field in H&P Template
        And I select patient "DARR, MOLLY" from the patient list
        And I select "Clinical Notes" from clinical navigation
        And I load the "History and Physical" template note for the selected patient
        And I select the note "History" section
        And I click the "OK" button in the "Information" pane if it exists
        And I click the "HPI" insert previous link in the "Note Writer Main" pane
        And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
        And the text "This scenario tests the insert previous link in HPI rich text field in the History tab" should appear in the "Note Writer Main" pane
        Then I verify the text "This scenario tests the insert previous link in HPI rich text field in the History tab" is bold in other mode in the "Note Writer Main" pane
        And the html "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "Note Writer Main" pane
#        And I click the "Additional PMH Comments" insert previous link in the "Note Writer Main" pane
#        And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
#        And the text "This scenario tests the insert previous link in AdditionalPMHComments rich text field in the History tab" should appear in the "Note Writer Main" pane
#        Then I verify the text "This scenario tests the insert previous link in AdditionalPMHComments rich text field in the History tab" is bold in other mode in the "Note Writer Main" pane
#        And the html "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "Note Writer Main" pane
#        And I click the "Additional Surgeries And Procedures" insert previous link in the "Note Writer Main" pane
#        And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
#        And the text "This scenario tests the insert previous link in AdditionalSurgeriesAndProcedures rich text field in the History tab" should appear in the "Note Writer Main" pane
#        Then I verify the text "This scenario tests the insert previous link in AdditionalSurgeriesAndProcedures rich text field in the History tab" is bold in other mode in the "Note Writer Main" pane
#        And the html "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "Note Writer Main" pane
        And I click the "Additional Allergies" insert previous link in the "Note Writer Main" pane
        And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
        And the text "This scenario tests the insert previous link in AdditionalAllergies rich text field in the History tab" should appear in the "Note Writer Main" pane
        Then I verify the text "This scenario tests the insert previous link in AdditionalAllergies rich text field in the History tab" is bold in other mode in the "Note Writer Main" pane
        And the html "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "Note Writer Main" pane
        And I click the "Home Medications" insert previous link in the "Note Writer Main" pane
        And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
        And the text "This scenario tests the insert previous link in HomeMedications rich text field in the History tab" should appear in the "Note Writer Main" pane
        Then I verify the text "This scenario tests the insert previous link in HomeMedications rich text field in the History tab" is bold in other mode in the "Note Writer Main" pane
        And the html "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "Note Writer Main" pane
        And I sign/submit the "History and Physical" note
        And I am on the "Patient List V2" tab
        And "DARR, MOLLY" is on the patient list
        And I select patient "DARR, MOLLY" from the patient list
        And I select "Clinical Notes" from clinical navigation
        When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
        And I select "*DRAFT* History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
		And the following text should appear in the "History Physical Contents" pane
            |HPI:                              |
            |Additional PMH Comments:          |
            |Additional Surgeries/Procedures:  |
        And I click the "Delete Note" button
        And I click the "Yes" button in the "Question" pane

    Scenario: Check Insert Previous for the all the fields in Family/Social History Section using H&P Template
    # Test Case: 001_Check Insert Previous for the all field in H&P Template
        And I select patient "HEATH, NEIL" from the patient list
        And I select "Clinical Notes" from clinical navigation
        And I wait "2" seconds
        And I load the "History and Physical" template note for the selected patient
        And I select the note "Family/Social History" section
        When I check the "Tobacco Use" checkbox in the dashboard mode
        And I select "Current" from the "Tobacco Use Status" dropdown
        And I enter "10" in the "Packs Per Day" field
        And I enter "1" in the "No of Years" field
        And I enter "Chain Smoker" in the "Tobacco Use Comments" field
        When I check the "Alcohol Use" checkbox in the dashboard mode
        And I select "Few times a month" from the "Frequency" dropdown
        And I enter "Occasionaly" in the "Alcohol Use Comment" field
        Then the value in the "Alcohol Use Comment" field should be "Occasionaly"
        And I check the "Drug Use" checkbox in the dashboard mode
        And I enter "Never" in the "Drug Use Comment" field
        When I select "Married" from the "Marital Status" dropdown
        Then the option "Married" should be available in the "Marital Status" dropdown list
        When I enter "Lives at home independently" in the "Living Situation" field
        Then the value in the "Living Situation" field should be "Lives at home independently"
        When I enter "This scenario tests the insert previous link in Additional Social History Info text field in the the Family/Social History Section" in the "Additional Social History Info" field
        When I select "Full Code" from the "Code Status" dropdown
        Then the option "Full Code" should be available in the "Code Status" dropdown list
        When I enter "This scenario tests the insert previous link in Healthcare Proxy text field in the the Family/Social History Section" in the "Health Care Proxy" field
        Then the value in the "Health Care Proxy" field should be "This scenario tests the insert previous link in Healthcare Proxy text field in the the Family/Social History Section"
        And I wait "2" seconds
        And I enter "B56.0" in the "Diagnosis Search" field
        And I wait "2" seconds
        When I enter "This scenario tests the insert previous link in FamilyProblemList text field in the the Family/Social History Section" in the "Diagnoses FSH QTV2" rich text field
        And I enter "This scenario tests the insert previous link in AdditionalFamilyHistoryInfo text field in the the AdditionalFamilyHistoryInfo Section" in the "Additional Family History Info" rich text field
        And I click the "CTRL ALL" key in the "Additional Family History Info" rich text field in the "Note Writer Main" pane
        And I click the "Bold" key in the "Additional Family History Info" rich text field in the "Note Writer Main" pane
        And I click the "SaveasDraft" button in the "Clinical Note" pane
        Then I click the "Yes" button in the "Note Writer Main" pane
        And I wait "2" seconds

    Scenario: Verify Insert Previous for the all fields in Family/Social History section using H&P Template
    # Test Case: 001_Check Insert Previous for the all field in H&P Template
        And I select patient "HEATH, NEIL" from the patient list
        And I select "Clinical Notes" from clinical navigation
        And I load the "History and Physical" template note for the selected patient
        And I select the note "Family/Social History" section
        And I click the "OK" button in the "Information" pane if it exists
        And I click the "Social History" insert previous link in the "Note Writer Main" pane
        And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
        And the text "This scenario tests the insert previous link in Additional Social History Info text field in the the Family/Social History Section" should appear in the "Note Writer Main" pane
        And the html "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "Note Writer Main" pane
        And I select "Full Code" from the "Code Status" dropdown
#        And I click the "Health care Proxy" insert previous link in the "Note Writer Main" pane
#        And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
#        And the html "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "Note Writer Main" pane
        And I click the "Family Problem List" insert previous link in the "Note Writer Main" pane
        And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
        And the text "This scenario tests the insert previous link in FamilyProblemList text field in the the Family/Social History Section" should appear in the "Note Writer Main" pane
        And the html "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "Note Writer Main" pane
#        And I click the "Additional Family History" insert previous link in the "Note Writer Main" pane
#        And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
#        And the text "This scenario tests the insert previous link in AdditionalFamilyHistoryInfo text field in the the AdditionalFamilyHistoryInfo Section" should appear in the "Note Writer Main" pane
#        Then I verify the text "This scenario tests the insert previous link in AdditionalFamilyHistoryInfo text field in the the AdditionalFamilyHistoryInfo Section" is bold in other mode in the "Note Writer Main" pane
#        And the html "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "Note Writer Main" pane
        And I sign/submit the "History and Physical" note


    Scenario: Check Insert Previous for the all fields in ROS, Exam and A/P section using H&P Template
    # Test Case: 001_Check Insert Previous for the all field in H&P Template
        And I select patient "HEATH, NEIL" from the patient list
        And I select "Clinical Notes" from clinical navigation
        And I load the "History and Physical" template note for the selected patient
        And I select the note "ROS" section
        And I click the "ROS RESP Normal" button
        Then the text "Negative for dyspnea or wheeze. No cough." should appear in the "ROS History" pane
        Then I select the note "Exam" section
        And I click the "Exam Eyes Normal" element in the "Note Writer Main" pane
        And I click the "Exam Resp Normal" element in the "Note Writer Main" pane
        And the following text should appear in the "Note Writer Main" pane
          |PERL. Sclerae nonicteric. Conjunctivae pink. |
          |Lungs clear to auscultation, no distress.    |
#         |Kung Fu Panda an animated movie              |
        And I select the note "A/P" section
        And I enter "Chest pain radiating to arm" in the "AP Diagnosis Search" field in the "NoteWriter APDX Search QTV2" pane
        And I select the "R07.89" code in the Diagnoses search list in the "NoteWriter APDX Search QTV2" pane
        And I enter "This scenario test the insert previous link in Assessment Plan rich text field in the A/P section" in the "Plan QTV2" rich text field
        And I click the "CTRL ALL" key in the "Plan QTV2" rich text field
        And I click the "Bold" key in the "Plan QTV2" rich text field
        And I sign/submit the "History and Physical" note

    Scenario: Verify Insert Previous for the all fields in ROS, Exam & A/P section using H&P Template
    # Test Case: 001_Check Insert Previous for the all field in H&P Template
        And I select patient "HEATH, NEIL" from the patient list
        And I select "Clinical Notes" from clinical navigation
        And I load the "History and Physical" template note for the selected patient
        And I select the note "ROS" section
        And I click the "OK" button in the "Information" pane if it exists
        And I click the "ROS" insert previous link in the "Note Writer Main" pane
        And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
        And the html "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "ROS History" pane
        And I select the note "Exam" section
        And I click the "OK" button in the "Information" pane if it exists
        And I wait "3" seconds
        And I click the "Exam Target" insert previous link in the "Note Writer Main" pane
        And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
        And the text "PERL. Sclerae nonicteric. Conjunctivae pink." should appear in the "Note Writer Main" pane
        And the text "Lungs clear to auscultation, no distress." should appear in the "Note Writer Main" pane
        And the html "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "Note Writer Main" pane
        And I select the note "A/P" section
        And I click the "ESC" key in the "AP Diagnosis Search" field in the "Note Writer Main" pane
        And I click the "Problem List" insert previous link in the "Note Writer Main" pane
        And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
        And the text "This scenario test the insert previous link in Assessment Plan rich text field in the A/P section" should appear in the "Note Writer Main" pane
        And the html "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "Note Writer Main" pane
        And I sign/submit the "History and Physical" note

    Scenario: Check Insert Previous for the all fields in the Subjective, ROS, Exam, A/P section using Progress Note Template
    # Test Case: 002_Check Insert Previous for the all field in PN Template
        Given I am logged into the portal with user "InsPrevEdge3" using the default password
        And I am on the "Patient List V2" tab
        And "HEATH, NEIL" is on the patient list
        And I select patient "HEATH, NEIL" from the patient list
        And I select "Clinical Notes" from clinical navigation
        And I load the "Progress Note" template note for the selected patient
        And I select the note "Subjective" section
        And I enter "This is a test quick text" in the "Patient Narrative QTV2" rich text field
        And I click the "CTRL ALL" key in the "Patient Narrative QTV2" rich text field in the "Note Writer Main" pane
        And I click the "Bold" key in the "Patient Narrative QTV2" rich text field in the "Note Writer Main" pane
        And I click the "ROS EYES Normal" button in the "Note Writer Main" pane
        And I click the "ROS RESP Normal" button in the "Note Writer Main" pane
        Then the following text should appear in the "Note Writer Main" pane
         |Negative for blurry vision. No diplopia.                |
         |Negative for dyspnea or wheeze. No cough.               |
        And I select the note "Exam" section
        And I click the "Exam Eyes Normal" element in the "Note Writer Main" pane
        And I click the "Exam Resp Normal" element in the "Note Writer Main" pane
        And the following text should appear in the "Note Writer Main" pane
         |PERL. Sclerae nonicteric. Conjunctivae pink. |
         |Lungs clear to auscultation, no distress.    |
#        |Kung Fu Panda an animated movie              |
        And I select the note "A/P" section
        And I click the "Add Problem" button in the "Note Writer Main" pane if it exists
        And I enter "R07.89" in the "PN Diagnosis Search" field
        And I enter "Burn" in the "Plan QTV2" rich text field
        And I click the "CTRL ALL" key in the "Plan QTV2" rich text field in the "Note Writer Main" pane
        And I click the "Bold" key in the "Plan QTV2" rich text field in the "Note Writer Main" pane
        And I select "Moderate" from the "Level Of Decision" dropdown
        And I click the "SaveasDraft" button in the "Clinical Note" pane
        Then I click the "Yes" button in the "Note Writer Main" pane
        And I wait "2" seconds


    Scenario: Verify Insert Previous for Subjective, ROS, Exam & A/P section using Progress Note Template
    # Test Case: 002_Check Insert Previous for the all field in PN Template
        And I select patient "HEATH, NEIL" from the patient list
        And I load the "Progress Note" template note for the selected patient
        And I select the note "Subjective" section
        And I click the "OK" button in the "Information" pane if it exists
        And I click the "Patient Narrative" insert previous link in the "Note Writer Main" pane
        And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
        And the text "This is a test quick text" should appear in the "Note Writer Main" pane
        Then I verify the text "This is a test quick text" is bold in other mode in the "Note Writer Main" pane
        And the html "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "Note Writer Main" pane
        And I click the "ROS" insert previous link in the "Note Writer Main" pane
        Then the following text should appear in the "Data To Insert From Previous Notes" pane
         |Negative for blurry vision. No diplopia.                |
         |Negative for dyspnea or wheeze. No cough.               |
        And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
        And I select the note "Exam" section
        And I click the "OK" button in the "Information" pane if it exists
        And I click the "Exam Target" insert previous link in the "Note Writer Main" pane
        And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
        And the following text should appear in the "Note Writer Main" pane
         |PERL. Sclerae nonicteric. Conjunctivae pink. |
         |Lungs clear to auscultation, no distress.    |
#        |Kung Fu Panda an animated movie              |
        And the html "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "Note Writer Main" pane
        And I select the note "A/P" section
        And I click the "ESC" key in the "PN Diagnosis Search" field in the "Note Writer Main" pane
        And I click the "Problem List" insert previous link in the "Note Writer Main" pane
        And I click the "Insert Selected" button in the "Data To Insert From Previous Notes" pane
        And the text "Burn" should appear in the "Note Writer Main" pane
        Then I verify the text "Burn" is bold in other mode in the "Note Writer Main" pane
        And the html "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "Note Writer Main" pane
        And I sign/submit the "Progress Note" note
        And I am on the "Patient List V2" tab
        And "HEATH, NEIL" is on the patient list
        And I select patient "HEATH, NEIL" from the patient list
        And I select "Clinical Notes" from clinical navigation
        When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
        And I select "*DRAFT* Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
        And the following text should appear in the "Progress Note Contents" pane
          |Patient Narrative                 |
#         |REVIEW OF SYSTEMS EYES:           |
          |RESPIRATORY:                      |
        And I click the "Delete Note" button
        And I click the "Yes" button in the "Question" pane






