Feature: Performance NoteWriter test

  @TS_Performance_AUTO321
  Scenario: Document Progress Note NOT using pop-out mode - AUTO-321
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I click the "Refresh Patient List" button
    And I select "NW entry" from the "Patient List" menu
    When I select patient "CROSS, CYNTHIA" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I click the "Clinical Notes Add" button
    And I select "Progress Note" from the select template list
    And I select "Hospitalist" from the "Speciality" dropdown
    And I enter "Ms. Cross is a 71 year-old female admitted for the evaluation of increasing groin pain. " in the "Chief Complaint" field
    And I click the "Chief Complaint ABC QTV2" button
    And I click the "Global Text" element
    And I click the "Resident" element
    And I click on the text "Critical care w/resident - Patient critically ill" in the "Click To Insert V2" pane
    And I append text "Patient has an enlarged prostate causing discomfort and pain that requires monitoring." to the "Chief Complaint" field
    And I click the "ROS CONST Abnormal" button
    And I enter "General weakness, Pain in the groin area and fever." in the "ROS CONST Comment" field
    And I click the "ROS EYES Normal" button
    And I click the "ROS ENT/MOUTH Normal" button
    And I click the "ROS GASTROINTESTINAL Abnormal" button
    And I enter "General weakness, Pain in the groin area and fever." in the "ROS GASTROINTESTINAL Comment" field
    And I click the "ROS SKIN Abnormal" button
    And I select the note "A/P" section
    And I enter "Prostate Cancer" in the "Diagnosis Search Input" field
    And I select the "Z80.42" code in the Diagnoses search list in the "Note Writer History DX Search" pane
    #Open Favorites list:
    And I click the "Favorites List" element in the "Note Writer History DX Search" pane
    And I click on the text "R19.5" in the "Note Writer History DX Search" pane
    #Close Favorites list:
    And I click the "Favorites List" element in the "Note Writer History DX Search" pane
    #Open Existing list:
    And I click the "Existing List" element in the "Note Writer History DX Search" pane
    And I click on the text "G89.4" in the "Note Writer History DX Search" pane
    #Close Existing list:
    And I click the "Existing List" element in the "Note Writer History DX Search" pane
    And I enter "Patient has a family history of prostate cancer. Patient will be required to go through yearly exams to ensure cancer is caught quickly." in the "Prostate Cancer" field
    And I enter "The patient’s history of GERD is the cause for the hospitalization we will continue to monitor the patient through exams and treatments." in the "Chronic Pain Syndrome" field
    Then I click the "NoteWriter Sign/Submit" button in the "Note Writer Main" pane
    And I click the "Search" button
    Then I select "Anderson" in the "Look Up" table
    And I click the "Look Up OK" button

  @TS_Performance_AUTO322
  Scenario: Document Progress Note in Pop-Out - AUTO-322
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I click the "Refresh Patient List" button
    And I select "NW entry" from the "Patient List" menu
    When I select patient "CASTILLO, PABLO I" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I click the "Clinical Notes Add" button
    And I select "Progress Note" from the select template list
    And I select "Hospitalist" from the "Speciality" dropdown
    And I wait up to "3" seconds for the "PopOut" field of type "BUTTONS" in the "Note Writer" pane to be clickable
    And I pop out note writer
    And I wait "5" seconds
    And I enter "Mr. Castillo is a 74 year-old male admitted for the evaluation of increasing Kidney pain." in the "Chief Complaint" field in the "Popout Note Wizard" pane
    And I click the "Progress Subjective Narrative IABC" element in the "Popout Note Wizard" pane
    And I click the "Reported by" element in the "Popout Note Wizard" pane
    And I click the "Patient QT" element in the "Popout Note Wizard" pane
    And I click the "ROS CONST Normal" button in the "Popout Note Wizard" pane
    And I click the "ROS EYES Normal" button in the "Popout Note Wizard" pane
    And I click the "ROS ENT/MOUTH Normal" button in the "Popout Note Wizard" pane
    And I click the "ROS RESPIRATORY Normal" button in the "Popout Note Wizard" pane
    And I click the "ROS CARDIOVASCULAR Normal" button in the "Popout Note Wizard" pane
    And I click the "ROS GASTROINTESTINAL Normal" button in the "Popout Note Wizard" pane
    And I click the "ROS GENITOURINARY Normal" button in the "Popout Note Wizard" pane
    And I click the "ROS MUSCULOSKELETAL Normal" button in the "Popout Note Wizard" pane
    And I click the "ROS SKIN Normal" button in the "Popout Note Wizard" pane
    And I click the "ROS NEUROLOGICAL Normal" button in the "Popout Note Wizard" pane
    And I click the "ROS PSYCHIATRIC Normal" button in the "Popout Note Wizard" pane
    And I click the "ROS HEMATALOGIC/LYMPHORETICULAR Normal" button in the "Popout Note Wizard" pane
    And I click the "ROS ALLERGIC/IMMUNOLOGIC Normal" button in the "Popout Note Wizard" pane
    And I select the note "Objective" section in the "Popout Wizard" pane
    And I click the "Exam SKIN Abnormal" button in the "Popout Note Wizard" pane
    And I enter "Skin appears grey." in the "Exam SKIN Comment" field in the "Popout Note Wizard" pane
    And I click the "Exam MUSCULOSKELETAL Abnormal" button in the "Popout Note Wizard" pane
    When I click the "MUSCULOSKELETAL ABC QTV2" element in the "Popout Note Wizard" pane
    And I click the "Manage Quick Text" button in the "Popout Note Wizard" pane
    And I wait "4" seconds
    And I switch the focus to the "portal Window" window
    And I enter "Pain and Weakness" in the "QTV2 Name" field
    And I clear the "QTV2 Description" rich text field
    And I enter "Patient exhibits general muscle weakness and is unsteady walking." in the "QTV2 Description" rich text field
    And I click the "Save" button in the "Add Quick Text Content" pane
    And I click the "Close" button in the "AddQuickText" pane
    And I switch the focus to the "popout Window" window
    When I click the "MUSCULOSKELETAL ABC QTV2" element in the "Popout Note Wizard" pane
    And I click on the text "Pain and Weakness" in the "Popout Note Wizard" pane
    And I click the "Exam NEUROLOGICAL Normal" button in the "Popout Note Wizard" pane
    And I click the "Exam PSYCHIATRIC Normal" button in the "Popout Note Wizard" pane
    And I switch the focus to the "popout Window" window
    When I pop in note writer
    And I wait up to "3" seconds for the "PopOut" field of type "BUTTONS" in the "Note Writer" pane to be visible
    And I select the note "Data" section
    When I click the "Lab Results" link in the "Clinical Data Link Column" section in the "Note Writer" pane
    Then the "Patient Data" pane should load
    And I select "Expanded Panels" from the "Patient Data Lab Results View" menu
    And I click the Add To Note checkbox for the row with text "GLUC MONITORING" in the "Panel" column in the "Lab Panels" table in the "Lab List" pane
    And I click the Add To Note checkbox for the row with text "BASIC METABOLIC PANEL" in the "Panel" column in the "Lab Panels" table in the "Lab List" pane
    And I click the "Copy to Note" button in the "Patient Data" pane
    And I click the "OK" button in the "Warning" pane if it exists
    And I wait up to "3" seconds for the "PopOut" field of type "BUTTONS" in the "Note Writer" pane to be clickable
    And I pop out note writer
    And I wait "5" seconds
    And I select the note "A/P" section in the "Popout Wizard" pane
    And I enter "Kidney Abscess" in the "Diagnosis Search Input" field in the "Pop Out History Dx Search" pane
    And I select the "N15.1" code in the Diagnoses search list in the "Pop Out History Dx Search" pane
    #Open Favorites list:
    And I click the "Favorites List" element in the "Pop Out History Dx Search" pane
    And I click on the text "R19.5" in the "Pop Out History Dx Search" pane
    #Close Favorites list:
    And I click the "Favorites List" element in the "Pop Out History Dx Search" pane
    #Open Existing list:
    And I click the "Existing List" element in the "Pop Out History Dx Search" pane
    And I click on the text "N18.9" in the "Pop Out History Dx Search" pane
    #Close Existing list:
    And I click the "Existing List" element in the "Pop Out History Dx Search" pane
    And I enter "Patient has a family history of Kidney disease. Patient will be required to go through Dialysis." in the "Kidney Abscess" field in the "Popout Note Wizard" pane
    And I enter "The patient’s history of CKD is the cause for the hospitalization we will continue to monitor the patient through exams and treatments." in the "Chronic Kidney Disease" field in the "Popout Note Wizard" pane
    Then I click the "NoteWriter Sign/Submit" button in the "Popout Wizard" pane
    And I click the "Search" button
    Then I select "Anderson" in the "Look Up" table
    And I click the "Look Up OK" button
    And I switch the focus to the "portal Window" window

  @TS_Performance_AUTO325 @WIP
  Scenario: Document Discharge Summary - AUTO-325
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I click the "Refresh Patient List" button
    And I select "NW entry" from the "Patient List" menu
    When I select patient "FERLISI, JANET C" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I click the "Clinical Notes Add" button
    And I select auto-popout template "Discharge Summary" from the select template list
    And I wait "5" seconds
    And I select "Hospitalist" from the "Speciality" dropdown in the "Popout Wizard" pane
    And I select the note "Hospital course" section in the "Popout Wizard" pane
    And I enter "She appeared to have pneumonia at the time of admission so we empirically covered her for community-acquired pneumonia with ceftriaxone and azithromycin until day 2 when her blood cultures grew out strep pneumoniae that was pan sensitive so we stopped the ceftriaxone and completed a 5 day course of azithromycin. But on day 4 she developed diarrhea so we added flagyl to cover for c.diff, which did come back positive on day 6 so he needs 3 more days of that…” this can be summarized more concisely as follows: “Completed 5 day course of azithromycin for pan sensitive strep pneumoniae pneumonia complicated by c.diff colitis. Currently on day 7/10 of flagyl" in the "Hospital Course" field in the "Popout Note Wizard" pane
    Then I click the "NoteWriter Sign/Submit" button in the "Popout Wizard" pane
    And I click the "OK" button in the "Note Writer Wizard" pane
    And I switch the focus to the "portal Window" window

    #A failure during NW popout may leave the patient list minimized.
  @TS_Performance_Teardown
  Scenario: Maximize Patient List
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And the patient list is maximized