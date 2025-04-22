@Performance
Feature: Performance NoteWriter test

    @PerformanceOld @NWPerformanceOld
  Scenario Outline: NoteWriter Co-sign panes
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    When I select patient "<Patient>" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I click the "Clinical Notes Add" button
#    And I click the "Create New" button in the "Notes in Draft Status" pane if it exists
#    Then the "Select Note Template" pane should load
    And I select "ProgressNoteHTML5DragAndDrop" from the select template list
    And I select "Internal Medicine" from the "Speciality" dropdown
    And I select the note "A/P" section in the "NoteWriterMain" pane
    #And I select "High" from the "Level Of Decision" dropdown
    And I enter "Manually entered hospital course info" in the "ProgressAPHospitalCourseQTV2" rich text field
    And I click the "NoteWriterSign/Submit" button in the "NoteWriter Main" pane
    #And I click the "OK" button
    And I click the "Search" button
    Then I select "Adelberg" in the "Look Up" table
    And I click the "Look Up OK" button
    Then I select "the first item" in the "ClinicalNotes" table


    Examples:
      | Patient             |
      | PATIENT1, CLINICAL  |
      | PATIENT4, CLINICAL  |
      | PATIENT5, CLINICAL  |
      | PATIENT6, CLINICAL  |
      | PATIENT7, CLINICAL  |
      | PATIENT8, CLINICAL  |
      | PATIENT10, CLINICAL |
      | PATIENT14, CLINICAL |
      | PATIENT16, CLINICAL |
      | PATIENT18, CLINICAL |

  @Performance @NWPerformance
  Scenario Outline: Enter Three NoteWriter Notes with separate templates
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    When I select patient "<Patient>" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I click the "Clinical Notes Add" button
    And I select "ProgressNoteHTML5DragAndDrop" from the select template list
    And I select "Family Medicine" from the "Speciality" dropdown
    And I select the note "A/P" section
    And I enter "Manually entered hospital course info" in the "ProgressAPHospitalCourseQTV2" rich text field
    #And I select "High" from the "Level Of Decision" dropdown
    And I click the "NoteWriterSign/Submit" button in the "NoteWriter Main" pane
    And I click the "Search" button
    Then I select "Adelberg" in the "Look Up" table
    And I click the "Look Up OK" button
    And I click the "Clinical Notes Add" button
    And I select "HistoryAndPhysicalHTML5DragAndDrop" from the select template list
    And I select "Family Medicine" from the "Speciality" dropdown
    And I select the note "A/P" section
    And I select "Moderate" from the "Level Of Decision Making" dropdown
    And I click the "NoteWriterSign/Submit" button in the "NoteWriter Main" pane
    And I click the "Search" button
    Then I select "Adelberg" in the "Look Up" table
    And I click the "Look Up OK" button
    And I click the "Clinical Notes Add" button
    And I select "DischargeSummaryHTML5" from the select template list
    And I select "Family Medicine" from the "Speciality" dropdown
    #And I select the note "Follow Up" section
    Then I select the note "Discharge Medications" section
    And I click the "NoteWriterSign/Submit" button in the "NoteWriter Main" pane
    #And I click the "OK" button
    And I click the "Search" button
    Then I select "Adelberg" in the "Look Up" table
    And I click the "Look Up OK" button
    And I refresh the clinical display
    And I wait for loading to complete
    Then I select "the first item" in the "ClinicalNotes" table


    Examples:
      | Patient             |
      | PATIENT1, CLINICAL  |
      | PATIENT4, CLINICAL  |
      | PATIENT5, CLINICAL  |
      | PATIENT6, CLINICAL  |
      | PATIENT7, CLINICAL  |
      | PATIENT8, CLINICAL  |
      | PATIENT10, CLINICAL |
      | PATIENT14, CLINICAL |
      | PATIENT16, CLINICAL |
      | PATIENT18, CLINICAL |

  @Performance @NWPerformance
  Scenario Outline: Enter Detailed Discharge Summary Note
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    When I select patient "<Patient>" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I click the "Clinical Notes Add" button
    And I select "DischargeSummaryHTML5" from the select template list
    And I select "Internal Medicine" from the "Speciality" dropdown
 #   #Then I select the note "Enter Orders" section
    Then I select the note "Problems/Procedures" section
    #Then I click the "TrashDX" element in the "Note Writer" pane
#    Then I select "True" from the "PastMedicalHistory" radio list
    And I enter "Appendectomy" in the "Diagnosis Search Input" field
    And I wait "2" seconds
    And I select the "S/P appendectomy" codedescription in the Diagnoses search list in the "Note Writer History DX Search" pane
    And I enter "CABG" in the "Diagnosis Search Input" field in the "NoteWriter History DX Search" pane
    And I select the "Hx of CABG" codedescription in the Diagnoses search list in the "NoteWriter History DX Search" pane
    And I wait "2" seconds
    And I click the "DischargeProceduresPerformedABC" element
    And I click on the text "QT1" in the "ClickToInsert" pane
    Then I select the note "Hospital course" section
    And I click the "HospitalCourseABC" element
    And I click on the text "QT1" in the "ClickToInsert" pane


##    //Commented the steps due to DEV-83595
#    When I select "Allergies" from the "Clinical Data" dropdown
#    And I wait for loading to complete
#    And I drag the text "Penicillins" from the "Allergies" clinical order to hospital course text field
##    When I select "Clinical Notes" from the "Clinical Data" dropdown
##    And I wait for loading to complete
##    And I drag the text "OR Nursing Note" from the "ClinicalNotes" clinical order to hospital course text field
#    When I select "I/O" from the "Clinical Data" dropdown
#    And I wait for loading to complete
#    #And I drag the text "%1 day ago M/d/yy% 3:00 PM - %1 day ago M/d/yy% 11:00 PM" from the "IOs" clinical order to hospital course text field
#    When I select "Lab Results" from the "Clinical Data" dropdown
#    And I wait for loading to complete
#    And I drag the text "MAGNESIUM" from the "Labs" clinical order to hospital course text field
#    When I select "Medications" from the "Clinical Data" dropdown
#    And I wait for loading to complete
#    #And I drag the text "POSACONAZOLE" from the "Medications" clinical order to hospital course text field
#    When I select "Test Results" from the "Clinical Data" dropdown
#    And I wait for loading to complete
#    And I drag the text "SURGICAL PATHOLOGY" from the "Tests" clinical order to hospital course text field
#    When I select "Vitals" from the "Clinical Data" dropdown
#    And I wait for loading to complete
#    And I drag the text "Body Mass Index (BMI):" from the "Vitals" clinical order to hospital course text field
#    When I select "Clinical Notes" from the "Clinical Data" dropdown
#    And I wait for loading to complete
#    And I drag the text "OR Nursing Note" from the "ClinicalNotes" clinical order to hospital course text field

    Then I select the note "Objective" section
    And I click the "Exam Eyes Normal" element in the "Note Writer" pane
    And I click the "Exam Skin Abnormal" element in the "Note Writer" pane
    And I enter "Manually entered text for objective skin" in the "ExamSkinAbnormalQTV2" rich text field in the "Note Writer" pane
    And I click the "Exam Psych Normal" element in the "Note Writer" pane

    Then I select the note "Data" section
    When I click the "Lab Results" link in the "NoteWriter" pane
    Then the "Patient Data" pane should load
    And I click the "Logo" element
    And I click the "NoteWriter Preselection Icon" image in the "LabList" pane
    And I wait "2" seconds
    And I click the "Copy to Note" button
    And the "ClinicalData" table should load
#    #When I select "AG CRYPTOSPORIDIA STOOL EIA" from the "Test (\d of \d)" column in the "Patient List TestResults" table
#    #And I enter "Fin" in the "NoteSearchTextQTV2" field
#    #And I click the "SearchTextQTV2" image
#    #Then I doubleClick on the searchtext in the "SearchDetails" pane
#    #And I click the "AddSelectedTextV3" element  ****THIS ISNT WORKING RIGHT NOW****
#    #And I click the "Copy to Note" button
    And I click the "DischargeDataAddCommentsABC" element
    And I click on the text "QT1" in the "ClickToInsert" pane

    Then I select the note "Discharge Medications" section
    And I click the "Annotation Allergy" image
    When I enter "This is annotation text for allergy field" in the "AllergyDischargeSummary" rich text field in the "Note Writer" pane
    And I enter "Manually entered discharge medications additional detail text" in the "DischargeMedsDetailsQTV2" rich text field in the "Note Writer" pane
    And I click the "DischargeMedicationsAddCommentsABC" element
    And I click on the text "QT1" in the "ClickToInsert" pane

    Then I select the note "Discharge Instructions" section
    And I click the "DischargeInstructionsABC" element
    And I click on the text "QT1" in the "ClickToInsert" pane
    And I click the "DischageInstructionsEmergencyInstrucitonsABC" element
    And I click on the text "QT1" in the "ClickToInsert" pane
    And I click the "DischageInstructionsAdditionalDetailABC" element
    And I click on the text "QT1" in the "ClickToInsert" pane

    Then I select the note "Attestation" section
    And I check the "Counseling" checkbox
    And I enter "10" in the "TimeSpentCounseling" field
    And I check the "Examined This Patient" checkbox
    And I enter "Manually entered discharge instructions detail text" in the "DischargeInsAttestationDetailsQTV2" rich text field
    And I click the "DischageAttestationDetailABC" element
    And I click on the text "QT1" in the "ClickToInsert" pane

    Then I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I click the "Search" button
    Then I select "Adelberg" in the "Look Up" table
    And I click the "Look Up OK" button
    #And I click the "OK" button in the "Submit Note" pane

    Examples:
      | Patient              |
      | PATIENT1, MEDREC     |
      | PATIENT2, MEDREC     |
      | PATIENT3, MEDREC     |
      | PATIENT4, MEDREC     |
      | PATIENT5, MEDREC     |
      | PATIENT7, MEDREC     |
      | PATIENT8, MEDREC     |
      | PATIENT9, MEDREC     |


  @Performance @NWPerformance
  Scenario Outline: Enter Detailed Progress Note
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    When I select patient "<Patient>" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I click the "Clinical Notes Add" button
    And I select "ProgressNoteHTML5DragAndDrop" from the select template list
    And I select "Internal Medicine" from the "Speciality" dropdown
    And I click the "ProgressHPIABC" element
    And I click on the text "HPI_1" in the "ClickToInsert" pane
    And I click the "ProgressSubjectiveNarrativeIABC" element
    And I click on the text "PN_QT2" in the "ClickToInsert" pane
    And I enter "Manually entered text" in the "ProgressSubjectiveNarrativeQTV2" rich text field
    And I click the "ROS EYES Normal" button in the "Note Writer" pane
    And I click the "ROS RESP Normal" button in the "Note Writer" pane
    And I click the "ROS NEURO Normal" button in the "Note Writer" pane
    When I click the "ROSCV Abnormal" element in the "Note Writer" pane
    And I click the "ROSCVAbnormalABCQTV2" element
    And I click on the text "chest pain" in the "ClickToInsert" pane
    And I click on the text "palpitation" in the "ClickToInsert" pane
    And I enter "PND and orthopnea" in the "ROSCardiovascularAbnormalQTV2" rich text field in the "Note Writer" pane
    And I click the "ROS MSK Normal" element in the "Note Writer" pane
    #objective tab
    Then I select the note "Objective" section
    And I click the "Exam Eyes Normal" element in the "Note Writer" pane
    #When I click the "ProblemTrash" element in the "Note Writer" pane
    And I click the "Exam Skin Abnormal" element in the "Note Writer" pane
    And I enter "Manually entered text for objective skin" in the "ExamSkinAbnormalQTV2" rich text field in the "Note Writer" pane
    And I click the "Exam Psych Normal" element in the "Note Writer" pane
    #data tab
    Then I select the note "Data" section
    When I click the "Allergies" link in the "NoteWriter" pane
    And I wait "2" seconds
    And I click the "Logo" element
    And I click the "NoteWriterPreselectionIcon" element
    And I click the "CopytoNote" button

    Then I select the note "A/P" section
    And I click the "ProgressAPHospitalCourseIABC" element
    And I click on the text "PN_HC2" in the "ClickToInsert" pane
    And I click the "ProgressAPGeneralAssessmentABC" element
    And I click on the text "PN_GA1" in the "ClickToInsert" pane
    And I click the "ProgressAPAdditionalCommentsABC" element
    And I click on the text "PN_AC_AP1" in the "ClickToInsert" pane
    And I enter "Toe" in the "Diagnosis Search Input" field
    And I wait "2" seconds
    And I select the "Toe anomaly" codedescription in the Diagnoses search list in the "Note Writer History DX Search" pane

    Then I select the note "Attestation" section
    And I check the "Counseling" checkbox
    And I enter "10" in the "TimeSpentCounseling" field
    And I check the "Examined This Patient" checkbox
    And I enter "Manually entered discharge instructions detail text" in the "DischargeInsAttestationDetailsQTV2" rich text field in the "NoteWriter" pane
    And I click the "DischageAttestationDetailABC" element
    And I click on the text "QT1" in the "ClickToInsert" pane

    Then I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I click the "Search" button
    Then I select "Adelberg" in the "Look Up" table
    And I click the "Look Up OK" button

    Examples:
      | Patient              |
      | PATIENT1, MEDREC     |
      | PATIENT2, MEDREC     |
      | PATIENT3, MEDREC     |
      | PATIENT4, MEDREC     |
      | PATIENT5, MEDREC     |
      | PATIENT7, MEDREC     |
      | PATIENT8, MEDREC     |
      | PATIENT9, MEDREC     |

