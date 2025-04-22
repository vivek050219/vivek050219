@HCAInsertPrevious
Feature: HCA NoteWriter Insert Previous Scenarios
# ALM Path: Notewriter (PK)>> 009 - Insert Previous >> InsertPrevious

  Background:
    Given I am logged into the portal with user "ipuser1" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I use the API to create a patient list named "InsPrevUser1" owned by "ipuser1" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I click the "Refresh Patient List" button
    And I select "InsPrevUser1" from the "Patient List" menu
    And "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
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

  Scenario: Pre-Requisite - Set the Insert Previous Maximum number Notes to 1
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "nwsection1"
    And I select the user "nwsection1"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "NoteWriter" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I wait "3" seconds
    And I select "1" from the "Insert Previous Max Notes" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button

  Scenario: Create the First note at the Section level by entering data of ROS, Exam and A/P section using H&P Template
    # Test Case: 14 NW_AdvTemp_InsPrevSectionLevel
    Given I am logged into the portal with user "nwsection1" using the default password
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "nwsection" owned by "nwsection1" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I click the "Refresh Patient List" button
    And I select "nwsection" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA History and Physical" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    And I select the note "Subjective" section
    And I click the "OK" button in the "Information" pane if it exists
    And I click the "ROS General Normal" button in the "Note Writer" pane
    Then the text "Negative for fever, malaise, fatigue." should appear in the "ROS History" pane
    And I click the "ROS EYES Normal" button in the "Note Writer" pane
#    And I clear the "Ros Eyes Normal QTV2" rich text field
    And I enter "This is for search field ROS Eyes normal" in the "Ros Eyes Normal QTV2" field
    Then the text "This is for search field ROS Eyes normal" should appear in the "ROS History" pane
    Then I select the note "Objective" section
    When I click the "Exam Neck Normal" element
    Then the text "No masses, no thyromegaly, no abnormal cervical nodes, trachea midline." should appear in the "Exam History" pane
    And I select the note "A/P" section
    And I enter "Chest pain radiating to arm" in the "Diagnosis Search" field in the "NoteWriterAPDXSearch" pane
    And I select the "R07.89" code in the Diagnoses search list in the "NoteWriterAPDXSearch" pane
    And I enter "This scenario test the insert previous Field in the A/P section" in the "Plan QTV2" rich text field
    And I sign/submit the "HCA History and Physical" note

  Scenario: Create the Second note using Insert previous link and by entering data at Section level of ROS, Exam and A/P section using H&P Template
    #  Test Case: 14 NW_AdvTemp_InsPrevSectionLevel
    Given I am logged into the portal with user "nwsection1" using the default password
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "nwsection" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "OK" button in the "Information" pane if it exists
    And I click the "ROS GI Normal" button in the "ROS History" pane
    Then the text "Negative for abdominal pain or nausea. No emesis. No diarrhea." should appear in the "ROS History" pane
    When I click the "ROS Skin Normal" button
    Then the text "Negative for rashes. No pruritus." should appear in the "ROS History" pane
    And I select the note "Objective" section
    When I click the "Exam Neck Normal" element
    Then the text "No masses, no thyromegaly, no abnormal cervical nodes, trachea midline." should appear in the "Exam History" pane
    When I click the "Exam Psych Normal" element
    Then the text "Alert and oriented to time, person, place. Normal mood and affect, intact judgment and insight." should appear in the "Exam History" pane
    And I select the note "A/P" section
    And I click the "OK" button in the "Information" pane if it exists
    And I enter "Leg pain" in the "Diagnosis Search" field in the "NoteWriterAPDXSearch" pane
    And I select the "M79.606" code in the Diagnoses search list in the "NoteWriterAPDXSearch" pane
    And I enter "This scenario test the second note of Insert previous" in the "Plan QTV2" rich text field
    And I sign/submit the "HCA History and Physical" note

  Scenario: Create the third note by using second note Insert previous link at section level of ROS, Exam and A/P section using H&P Template
  # Test Case: 14 NW_AdvTemp_InsPrevSectionLevel
    Given I am logged into the portal with user "nwsection1" using the default password
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "nwsection" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "OK" button in the "Information" pane if it exists
    And I click the "ROS" insert previous link in the "Note Writer" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      | Negative for abdominal pain or nausea. No emesis. No diarrhea. |
      | Negative for rashes. No pruritus.                              |
   # Validating the third note using second note insert previous link, data is not pulled from first note
    And the text "This is for search field ROS Eyes normal" should not appear in the "Data To Insert From Previous Notes" pane
    And the text "Negative for fever, malaise, fatigue." should not appear in the "Data To Insert From Previous Notes" pane
    And I select the note "Objective" section
    And I click the "Exam Target" insert previous link in the "Note Writer" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      | No masses, no thyromegaly, no abnormal cervical nodes, trachea midline.                         |
      | Alert and oriented to time, person, place. Normal mood and affect, intact judgment and insight. |
    And the text "Soft, no tenderness. No masses. No guarding. Bowel sounds present." should not appear in the "Data To Insert From Previous Notes" pane
    And I select the note "A/P" section
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    Then the text "This scenario test the second note of Insert previous" should appear in the "Data To Insert From Previous Notes" pane
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And the text "This scenario test the insert previous Field in the A/P section" should not appear in the "Note Writer" pane
    And I sign/submit the "HCA History and Physical" note

  Scenario: Check Insert Previous for the all field of ROS, Exam and A/P section using H&P Template for nwdept1 user
   # Test Case:  06 NW_AdvTemp_InsPrevDepartment
    Given I am logged into the portal with user "nwdept1" using the default password
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "NwDept" owned by "nwdept1" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I click the "Refresh Patient List" button
    And I select "NwDept" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "ROS Resp Normal" button
    Then the text "Negative for dyspnea or wheeze. No cough." should appear in the "ROS History" pane
    Then I select the note "Objective" section
    And I click the "Exam Eyes Normal" element in the "Note Writer" pane
    Then the text "PERRL, EOM intact, conjunctiva and sclera clear, without nystagmus, lids normal." should appear in the "Note Writer" pane
    And I select the note "A/P" section
    And I enter "Chest pain radiating to arm" in the "Diagnosis Search" field in the "NoteWriterAPDXSearch" pane
    And I select the "R07.89" code in the Diagnoses search list in the "NoteWriterAPDXSearch" pane
    And I enter "This scenario test the insert previous link in Assessment Plan rich text field in the A/P section" in the "Plan QTV2" rich text field
    And I sign/submit the "HCA History and Physical" note

  Scenario: Verify Insert Previous for ROS, Exam & A/P section using H&P Template for nwdept1 user
   # Test Case:  06 NW_AdvTemp_InsPrevDepartment
    Given I am logged into the portal with user "nwdept1" using the default password
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "OK" button in the "Information" pane if it exists
    And I wait up to "10" seconds for loading to complete
    And I click the "ROS" insert previous link in the "Note Writer" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      | Negative for dyspnea or wheeze. No cough. |
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And the html "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "ROS History" pane
    And I select the note "Objective" section
    And I click the "OK" button in the "Information" pane if it exists
    And I click the "Exam Target" insert previous link in the "Note Writer" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      | PERRL, EOM intact, conjunctiva and sclera clear, without nystagmus, lids normal. |
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And the text "PERRL, EOM intact, conjunctiva and sclera clear, without nystagmus, lids normal." should appear in the "Note Writer" pane
    And I select the note "A/P" section
    And I click the "OK" button in the "Information" pane if it exists
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And the text "This scenario test the insert previous link in Assessment Plan rich text field in the A/P section" should appear in the "Note Writer" pane
    And I sign/submit the "HCA History and Physical" note

  Scenario: Verify Insert Previous for ROS, Exam & A/P section using H&P Template for nwdept2 user
    # Test Case: 06 NW_AdvTemp_InsPrevDepartment
    Given I am logged into the portal with user "nwdept2" using the default password
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "NwDept" owned by "nwdept2" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I click the "Refresh Patient List" button
    And I select "NwDept" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "OK" button in the "Information" pane if it exists
    And I click the "ROS" insert previous link in the "Note Writer" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      | Negative for dyspnea or wheeze. No cough. |
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And the html "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "ROS History" pane
    And I select the note "Objective" section
    And I click the "OK" button in the "Information" pane if it exists
    And I click the "Exam Target" insert previous link in the "Note Writer" pane
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And the text "PERRL, EOM intact, conjunctiva and sclera clear, without nystagmus, lids normal." should appear in the "Note Writer" pane
    And I select the note "A/P" section
    And I click the "OK" button in the "Information" pane if it exists
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And the text "This scenario test the insert previous link in Assessment Plan rich text field in the A/P section" should appear in the "Note Writer" pane
    And I sign/submit the "HCA History and Physical" note

  Scenario: Check Insert Previous for the all field of ROS, Exam and A/P section using H&P Template for nwdept3 user
    # Test Case: 06 NW_AdvTemp_InsPrevDepartment
    Given I am logged into the portal with user "nwdept3" using the default password
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "NwDept" owned by "nwdept3" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I click the "Refresh Patient List" button
    And I select "NwDept" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "ROS GI Normal" button
    Then the text "Negative for abdominal pain or nausea. No emesis. No diarrhea." should appear in the "ROS History" pane
    Then I select the note "Objective" section
    When I click the "Exam Neck Normal" element
    Then the text "No masses, no thyromegaly, no abnormal cervical nodes, trachea midline." should appear in the "Exam History" pane
    And I select the note "A/P" section
    And I enter "Fever" in the "Diagnosis Search" field in the "NoteWriterAPDXSearch" pane
    And I select the "R50.9" code in the Diagnoses search list in the "NoteWriterAPDXSearch" pane
    And I enter "This scenario test the insert previous link for user3" in the "PlanQTV2" rich text field
    And I sign/submit the "HCA History and Physical" note

  Scenario: Verify Data for ROS, Exam & A/P section using H&P Template for nwdept3 user irrespective of other 2 users
   # Test Case: 06 NW_AdvTemp_InsPrevDepartment
    Given I am logged into the portal with user "nwsection1" using the default password
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "nwsection" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "OK" button in the "Information" pane if it exists
    And I click the "ROS" insert previous link in the "Note Writer" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      | Negative for abdominal pain or nausea. No emesis. No diarrhea. |
     # Below text should appear for user1 and user2 as they have same department. This text should not appear for user3 as it is associated to different deaprtment
    And the text "Negative for dyspnea or wheeze. No cough." should not appear in the "Data To Insert From Previous Notes" pane
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And the html "Type="hidden" onblur="return HE(event,this)" FormData="true" onchange="return HE(event,this)" />" should not appear in the "ROS History" pane
    And I select the note "Objective" section
    And I click the "OK" button in the "Information" pane if it exists
    And I click the "Exam Target" insert previous link in the "Note Writer" pane
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And the following text should appear in the "ExamHistory" pane
      | No masses, no thyromegaly, no abnormal cervical nodes, trachea midline. |
     # Below text should appear for user1 and user2 as they have same department. This text should not appear for user3 as it is associated to different deaprtment
    And the text "PERRL, EOM intact, conjunctiva and sclera clear, without nystagmus, lids normal." should not appear in the "Exam Target Table" section in the "Note Writer" pane
    And I select the note "A/P" section
    And I click the "OK" button in the "Information" pane if it exists
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And the text "This scenario test the insert previous link for user3" should appear in the "Note Writer" pane
    # Below text should appear for user1 and user2 as they have same department. This text shopuld not appear for user3 as it is associated to different deaprtmen
    And the text "This scenario test the insert previous link in Assessment Plan rich text field in the A/P section" should not appear in the "Note Writer" pane
    And I sign/submit the "HCA History and Physical" note

  Scenario: Verify InsertPrevious Max Number Notes setting
    Given I am logged into the portal with user "nwadmin" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "ipuser1"
    And I select the user "ipuser1"
    And I wait "2" seconds
    And I click the "Edit" button in the "Quick Details" pane
    And I select "NoteWriter" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I wait "5" seconds
    Then "7" should be selected in the "Insert Previous Max Notes" dropdown in the "User Note Writer Settings" pane

  Scenario: Create initial note 1 to verify InsertPrevious
   # Test Case: 02 NW_AdvTemp_InsPrevInitialCreateInitialMaxNum
    And I load the "HCA History and Physical" template note for the selected patient
    And I wait "3" seconds
    And I select the note "Subjective" section
    And I click the "ROS EYES Normal" button
    And I click the "ROS ENT Abnormal" button
    And I verify if "ROS" insert previous link is disabled in the "Note Writer" pane
    And I select the note "Objective" section
    And I verify if "Exam Target" insert previous link is disabled in the "Note Writer" pane
    And I select the note "A/P" section
    And I enter "toe" in the "Diagnosis Search" field in the "NoteWriterAPDXSearch" pane
    And I select the "S90.416A" code in the Diagnoses search list in the "NoteWriterAPDXSearch" pane
    And I verify if "Problem List" insert previous link is disabled in the "Note Writer" pane
    And I sign/submit the "HCA History and Physical" note
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Final" should appear in the "HCA Progress Note" pane
    Given "1" notes should present in the database for the patient "Roy Blazer" and the user "ipuser1"

  Scenario: Create note 2 to verify InsertPrevious Max number
   # Test Case: 03 NW_AdvTemp_InsPrevUserCreateMaxNum-1
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "ROS GI Normal" button
    And I click the "ROS NEURO Abnormal" button
    And I select the note "A/P" section
    And I enter "head" in the "Diagnosis Search" field in the "NoteWriterAPDXSearch" pane
    And I select the "Head ache" codedescription in the Diagnoses search list in the "NoteWriterAPDXSearch" pane
    And I sign/submit the "HCA History and Physical" note
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Final" should appear in the "HCA Progress Note" pane
    Given "2" notes should present in the database for the patient "Roy Blazer" and the user "ipuser1"

  Scenario: Create note 3 to verify InsertPrevious Max number
   # Test case: 03 NW_AdvTemp_InsPrevUserCreateMaxNum-2
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "ROS GU Normal" button
    And I click the "ROS Skin Abnormal" button
    And I select the note "A/P" section
    And I enter "finger" in the "Diagnosis Search" field in the "NoteWriterAPDXSearch" pane
    And I select the "S60.419A" code in the Diagnoses search list in the "NoteWriterAPDXSearch" pane
    And I click the "Save as Draft" button in the "Clinical Note" pane
    Then I click the "Yes" button in the "Information" pane
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Draft" should appear in the "HCA Progress Note" pane
    Given "3" notes should present in the database for the patient "Roy Blazer" and the user "ipuser1"

  Scenario: Create note 4 to verify InsertPrevious Max number
   # Test Case: 03 NW_AdvTemp_InsPrevUserCreateMaxNum-3
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "ROS General Normal" button
    And I click the "ROS PSYCH Abnormal" button
    And I select the note "A/P" section
    And I enter "renal" in the "Diagnosis Search" field in the "NoteWriterAPDXSearch" pane
    And I select the "N15.1" code in the Diagnoses search list in the "NoteWriterAPDXSearch" pane
    And I sign/submit the "HCA History and Physical" note
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Final" should appear in the "HCA Progress Note" pane
    Given "4" notes should present in the database for the patient "Roy Blazer" and the user "ipuser1"

  Scenario: Create note 5 to verify InsertPrevious Max number
  # Test Case: 03 NW_AdvTemp_InsPrevUserCreateMaxNum-4
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "ROS CV Normal" button
    And I click the "ROS Resp Abnormal" button
    And I select the note "A/P" section
    And I enter "back" in the "Diagnosis Search" field in the "NoteWriterAPDXSearch" pane
    And I select the "S20.419A" code in the Diagnoses search list in the "NoteWriterAPDXSearch" pane
    And I sign/submit the "HCA History and Physical" note
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Final" should appear in the "HCA Progress Note" pane
    Given "5" notes should present in the database for the patient "Roy Blazer" and the user "ipuser1"

  Scenario: Create note 6 to verify InsertPrevious Max number
  # Test Case: 03 NW_AdvTemp_InsPrevUserCreateMaxNum-5
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "ROS MSK Normal" button
    And I click the "ROS HEMA Abnormal" button
    And I select the note "A/P" section
    And I enter "elbow" in the "Diagnosis Search" field in the "NoteWriterAPDXSearch" pane
    And I select the "S50.319A" code in the Diagnoses search list in the "NoteWriterAPDXSearch" pane
    And I click the "Save as Draft" button in the "Clinical Note" pane
    Then I click the "Yes" button in the "Information" pane
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Draft" should appear in the "HCA Progress Note" pane
    Given "6" notes should present in the database for the patient "Roy Blazer" and the user "ipuser1"

  Scenario: Create note 7 to verify InsertPrevious Max number
   # Test Case: 03 NW_AdvTemp_InsPrevUserCreateMaxNum-6
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "ROS ALL/IMM Normal" button
    And I click the "ROS CV Abnormal" button
    And I select the note "A/P" section
    And I enter "muscle" in the "Diagnosis Search" field in the "NoteWriterAPDXSearch" pane
    And I select the "Muscle abscess" codedescription in the Diagnoses search list in the "NoteWriterAPDXSearch" pane
    And I sign/submit the "HCA History and Physical" note
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Final" should appear in the "HCA Progress Note" pane
    Given "7" notes should present in the database for the patient "Roy Blazer" and the user "ipuser1"

  Scenario: Create final note 8 to verify InsertPrevious Max number
  # Test Case: 03 NW_AdvTemp_InsPrevUserCreateMaxPlus
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "ROS CV Normal" button
    And I click the "ROS Resp Abnormal" button
    And I click the "ROS GU Abnormal" button
    And I select the note "A/P" section
    And I enter "burn" in the "Diagnosis Search" field in the "NoteWriterAPDXSearch" pane
    And I select the "T30.0" code in the Diagnoses search list in the "NoteWriterAPDXSearch" pane
    And I select the note "Subjective" section
    And I verify if "ROS" insert previous link is enabled in the "Note Writer" pane
    And I select the note "A/P" section
    And I verify if "Problem List" insert previous link is enabled in the "Note Writer" pane
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    And I wait "3" seconds
    And I click the "My Notes" element in the "Data To Insert From Previous Notes" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      | Muscle abscess |
    And I click the "Page Previous Image" element in the "Data To Insert From Previous Notes" pane for "6" times
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      | Toe abrasion |
    And I click the "Insert Selection QTV2" button in the "Data To Insert From PreviousNotes" pane
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    And I wait "5" seconds
    And I click the "Page Previous Image" element in the "Data To Insert From Previous Notes" pane for "5" times
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    Then the following text should appear in the "Problem Target" pane
      | Burn         |
      | Toe abrasion |
      | Head ache    |
    And I sign/submit the "HCA History and Physical" note
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Final" should appear in the "HCA Progress Note" pane
    Given "8" notes should present in the database for the patient "Roy Blazer" and the user "ipuser1"

  Scenario: Verify new text gets appended to InsertPrevious text for Exam section
   # Test Case: 04 NW_AdvTemp_InsPrevAppend
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Objective" section
    And I click the "Exam Other FreeText" button
    And I enter "This is a test." in the "Exam Other QTV2" rich text field
    And I select the note "A/P" section
    And I enter "skin" in the "Diagnosis Search" field in the "NoteWriterAPDXSearch" pane
    And I select the "L98.9" code in the Diagnoses search list in the "NoteWriterAPDXSearch" pane
    And I enter "Skin rashes" in the "PlanQTV2" rich text field
    And I sign/submit the "HCA History and Physical" note
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA History and Physical" template note for the selected patient
    And I wait "3" seconds
    And I select the note "Objective" section
    And I wait "5" seconds
    And I click the "Exam Target" insert previous link in the "Note Writer" pane
    Then the text "Other" should appear in the "Data To Insert From Previous Notes" pane
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And the text "This is a test." should appear in the "Note Writer" pane
    And I enter "This is new line added to other field" in the "Exam Other QTV2" rich text field
    And the text "This is new line added to other field" should appear in the "Note Writer" pane
    And I sign/submit the "HCA History and Physical" note
    And I click the logout button
    Given I am logged into the portal with user "ipuser1" using the default password
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Objective" section
    And I wait "2" seconds
    And I click the "Exam Target" insert previous link in the "Note Writer" pane
    Then the text "Other" should appear in the "Data To Insert From Previous Notes" pane
    Then the text "This is a test." should appear in the "Data To Insert From Previous Notes" pane
    Then the text "This is new line added to other field" should appear in the "Data To Insert From Previous Notes" pane
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And I select the note "Subjective" section
    And I click the "ROS ALL/IMM Normal" button
    And I select the note "A/P" section
    And I enter "elbow" in the "Diagnosis Search" field in the "NoteWriterAPDXSearch" pane
    And I select the "S50.319A" code in the Diagnoses search list in the "NoteWriterAPDXSearch" pane
    And I sign/submit the "HCA History and Physical" note

  Scenario: Verify new text gets appended to InsertPrevious text for A/P section
  # Test Case: 04 NW_AdvTemp_InsPrevAppend
    And I load the "HCA History and Physical" template note for the selected patient
    And I wait "2" seconds
    And I select the note "Subjective" section
    And I click the "ROS CV Normal" button
    And I select the note "A/P" section
    And I wait "2" seconds
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    Then the text "Elbow" should appear in the "Data To Insert From Previous Notes" pane
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And I click the "Plan Field ABCQTV2" element in the "Note Writer" pane
    When I click on the text "Quick Text AP" in the "Click To Insert V2" pane
    Then the text "This is QuickText for AP field" should appear in the "Note Writer" pane
    And I sign/submit the "HCA History and Physical" note
    And "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA History and Physical" template note for the selected patient
    And I wait "2" seconds
    And I select the note "A/P" section
    And I wait "5" seconds
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    Then the text "Elbow" should appear in the "Data To Insert From Previous Notes" pane
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And I enter "This is freeform text" in the "PlanQTV2" rich text field
    And I sign/submit the "HCA History and Physical" note
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the text "This is QuickText for AP field" should appear in the "HCA Progress Note" pane
    And the text "This is freeform text" should appear in the "HCA Progress Note" pane

  Scenario: Verify no duplicate entry using InsertPrevious
   # Test Case: 05 NW_AdvTemp_InsPrevClinicDataNoDupe
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I wait "3" seconds
    And I enter "This is a test quick text" in the "Patient Narrative QTV2" rich text field
    And I click the "ROS EYES Normal" button in the "Note Writer" pane
    And I select the note "Objective" section
    And I click the "Exam Eyes Normal" element in the "Note Writer" pane
    And I select the note "A/P" section
    And I click the "Add Problem" button in the "Note Writer" pane if it exists
    And I enter "R07.89" in the "Problem DxSearch" field
    And I enter "Burn" in the "PlanQTV2" rich text field
    And I sign/submit the "HCA Progress Note" note
    And I am on the "Patient List V2" tab
    And "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "OK" button in the "Information" pane if it exists
    And I wait "3" seconds
    And I click the "Patient Narrative" insert previous link in the "Note Writer" pane
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And the text "This is a test quick text" should appear in the "Note Writer" pane
    And I click the "ROS" insert previous link in the "Note Writer" pane
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    Then the text "Negative for blurry vision. No diplopia." should appear in the "Note Writer" pane
    And I click the "ROS" insert previous link in the "Note Writer" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text | Status   |
      | Eyes | Disabled |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I select the note "Objective" section
    And I click the "OK" button in the "Information" pane if it exists
    And I wait "3" seconds
    And I click the "Exam Target" insert previous link in the "Note Writer" pane
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    Then the text "PERRL, EOM intact, conjunctiva and sclera clear, without nystagmus, lids normal." should appear in the "Note Writer" pane
    And I click the "Exam Target" insert previous link in the "Note Writer" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text | Status   |
      | Eyes | Disabled |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I select the note "A/P" section
    And I click the "OK" button in the "Information" pane if it exists
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And the text "Burn" should appear in the "Note Writer" pane
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text | Status   |
      | Burn | Disabled |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I click the "Add Problem" button in the "Note Writer" pane if it exists
    And I wait "2" seconds
    And I click the "Add All Existing Diagnosis" element in the "NoteWriter History DXSearch" pane
    And the text "All of the selected data has not been inserted because it is already included" should appear in the "Warning Message" pane
    And I click the "Warning OK" button in the "Warning Message" pane
    And I sign/submit the "HCA Progress Note" note

  Scenario: Prerequisite step Enable include department notes setting
    #Prerequisite
    Given I am logged into the portal with user "nwadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Department" subtab
    And I select the department "ipdept1"
    And I wait "2" seconds
    And I click the "Edit" button in the "Quick Details" pane
    And I select "NoteWriter" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
    And I select "true" from the "Include Department Notes In Insert Previous" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box

  Scenario: Verify InsertPrevious within same facility group
   # Test Case: 09 NW_AdvTemp_InsPrevFacility
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I wait "3" seconds
    And I enter "This is a test" in the "Patient Narrative QTV2" rich text field
    And I click the "ROS Resp Normal" button in the "Note Writer" pane
    And I select the note "Objective" section
    And I click the "Exam Eyes Normal" element in the "Note Writer" pane
    And I select the note "A/P" section
    And I click the "Add Problem" button in the "Note Writer" pane if it exists
    And I wait "2" seconds
    And I enter "R07.89" in the "Problem Dx Search" field
    And I enter "Burn" in the "Plan QTV2" rich text field
    And I sign/submit the "HCA Progress Note" note
    And I click the logout button
    Given I am logged into the portal with user "ipuser2" using the default password
    And I am on the "Patient List V2" tab
    And "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I wait "3" seconds
    And I click the "Patient Narrative" insert previous link in the "Note Writer" pane
    And I click the "My Department Notes" element in the "Data To Insert From Previous Notes" pane
    And I wait "2" seconds
    And the text "This is a test" should appear in the "Data To Insert From Previous Notes" pane
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And I click the "ROS" insert previous link in the "Note Writer" pane
    Then the text "Respiratory" should appear in the "Data To Insert From Previous Notes" pane
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And I select the note "Objective" section
    And I click the "OK" button in the "Information" pane if it exists
    And I wait "3" seconds
    And I click the "Exam Target" insert previous link in the "Note Writer" pane
    Then the text "Eyes" should appear in the "Data To Insert From Previous Notes" pane
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And I select the note "A/P" section
    And I click the "OK" button in the "Information" pane if it exists
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    Then the text "Burn" should appear in the "Data To Insert From Previous Notes" pane
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And I sign/submit the "HCA Progress Note" note

  Scenario: Verify InsertPrevious within different facility group
   # Test Case: 09 NW_AdvTemp_InsPrevFacility
    Given I am logged into the portal with user "ipuser3" using the default password
    And I am on the "Patient List V2" tab
    And "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "History" section
    And I click the "OK" button in the "Information" pane if it exists
    And I enter "This is note for user3" in the "HPI QTV2" rich text field
    And I sign/submit the "HCA History and Physical" note
    And "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I wait up to "10" seconds for loading to complete
    And I click the "Patient Narrative" insert previous link in the "Note Writer" pane
    And I click the "My Department Notes" element in the "Data To Insert From Previous Notes" pane
    And I wait "2" seconds
    And the text "This is a test" should not appear in the "Data To Insert From Previous Notes" pane
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I click the "ROS" insert previous link in the "Note Writer" pane
    Then the text "RESP" should not appear in the "Data To Insert From Previous Notes" pane
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I select the note "Objective" section
    And I click the "OK" button in the "Information" pane if it exists
    And I wait "3" seconds
    And I click the "Exam Target" insert previous link in the "Note Writer" pane
    Then the text "Eyes" should not appear in the "Data To Insert From Previous Notes" pane
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I select the note "A/P" section
    And I click the "OK" button in the "Information" pane if it exists
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    Then the text "Burn" should not appear in the "Data To Insert From Previous Notes" pane
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I sign/submit the "HCA Progress Note" note

  Scenario: Create a History and physical of Ros, Exam and A/P section for Insert Previous link
    # Test Case: 13 NW_AdvTemp_InsPrevPreview
    Given I am logged into the portal with user "nwpreview1" using the default password
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "NwPreview" owned by "nwpreview1" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I click the "Refresh Patient List" button
    And I select "NwPreview" from the "Patient List" menu
    And "DARR, MOLLY" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "ROS EYES Normal" button in the "Note Writer" pane
#    And I clear the "Ros Eyes Normal QTV2" rich text field
    And I enter "This is for search field ROS Eyes normal" in the "Ros Eyes Normal QTV2" field
    Then the text "This is for search field ROS Eyes normal" should appear in the "ROS History" pane
    And I click the "ROS Resp Normal" button
    Then the text "Negative for dyspnea or wheeze. No cough." should appear in the "ROS History" pane
    Then I select the note "Objective" section
    When I click the "Exam Psych Normal" element
    Then the text "Alert and oriented to time, person, place. Normal mood and affect, intact judgment and insight." should appear in the "Exam History" pane
    When I click the "Exam Neck Normal" element
    Then the text "No masses, no thyromegaly, no abnormal cervical nodes, trachea midline." should appear in the "Exam History" pane
    And I select the note "A/P" section
    And I enter "Chest pain radiating to arm" in the "Diagnosis Search" field in the "Note Writer APDX Search" pane
    And I select the "R07.89" code in the Diagnoses search list in the "Note Writer APDX Search" pane
    And I enter "This scenario test the insert previous Field in the A/P section" in the "Plan QTV2" rich text field
    And I enter "Leg pain" in the "Diagnosis Search" field in the "Note Writer APDX Search" pane
    And I select the "M79.606" code in the Diagnoses search list in the "Note Writer APDX Search" pane
    And I sign/submit the "HCA History and Physical" note

  Scenario: Verifying the data copied with Insert Previous link of Ros, Exam and A/P section
    # Test Case: 13 NW_AdvTemp_InsPrevPreview
    Given I am logged into the portal with user "nwpreview1" using the default password
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "NwPreview" from the "Patient List" menu
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "OK" button in the "Information" pane if it exists
    And I click the "ROS GI Normal" button in the "Note Writer" pane
    Then the text "Negative for abdominal pain or nausea. No emesis. No diarrhea." should appear in the "ROS History" pane
    And I click the "ROS" insert previous link in the "Note Writer" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      | This is for search field ROS Eyes normal  |
      | Negative for dyspnea or wheeze. No cough. |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I click the "ROS" insert previous link in the "Note Writer" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      | This is for search field ROS Eyes normal  |
      | Negative for dyspnea or wheeze. No cough. |
    And I uncheck the "Resp Qtv2" checkbox
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    Then the following text should appear in the "ROS History" pane
      | This is for search field ROS Eyes normal                       |
      | Negative for abdominal pain or nausea. No emesis. No diarrhea. |
    And I select the note "Objective" section
    And I click the "Exam Target" insert previous link in the "Note Writer" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      | Alert and oriented to time, person, place. Normal mood and affect, intact judgment and insight. |
      | No masses, no thyromegaly, no abnormal cervical nodes, trachea midline.                         |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I click the "Exam Target" insert previous link in the "Note Writer" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      | Alert and oriented to time, person, place. Normal mood and affect, intact judgment and insight. |
      | No masses, no thyromegaly, no abnormal cervical nodes, trachea midline.                         |
    And I uncheck the "Neck Qtv2" checkbox
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    Then the text "Alert and oriented to time, person, place. Normal mood and affect, intact judgment and insight." should appear in the "Exam History" pane
    And I select the note "A/P" section
    And I click the "OK" button in the "Information" pane if it exists
    And I enter "brain abscess" in the "Diagnosis Search" field in the "Note Writer APDX Search" pane
    And I select the "G06.0" code in the Diagnoses search list in the "Note Writer APDX Search" pane
    And I enter "This scenario test the diagnosis using insert previous Field in the A/P section" in the "Plan QTV2" rich text field
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      | This scenario test the insert previous Field in the A/P section |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      | This scenario test the insert previous Field in the A/P section |
    And I uncheck the "Chest Pain Qtv2" checkbox
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    Then the following text should appear in the "Note Writer" pane
      | This scenario test the diagnosis using insert previous Field in the A/P section |
      |                                                                                 |
    And I sign/submit the "HCA History and Physical" note


  Scenario: Check Insert Previous link for the all field of ROS, and A/P section using H&P Template
     # Test Case:  10 NW_AdvTemp_InsPrevFieldOrSection
    Given I am logged into the portal with user "nwfield1" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "ROS EYES Normal" button in the "NoteWriter" pane
#    And I clear the "Ros Eyes Normal QTV2" rich text field
    And I enter "This is for search field ROS Eyes normal" in the "Ros Eyes Normal QTV2" field
    And I click the "ROS Resp Normal" button
    Then the text "Negative for dyspnea or wheeze. No cough." should appear in the "ROS History" pane
    And I select the note "A/P" section
    And I enter "Chest pain radiating to arm" in the "Diagnosis Search" field in the "Note Writer APDX Search" pane
    And I select the "R07.89" code in the Diagnoses search list in the "Note Writer APDX Search" pane
    And I enter "This scenario test the insert previous Field in the A/P section" in the "PlanQTV2" rich text field
    And I enter "fever" in the "Diagnosis Search" field in the "Note Writer APDX Search" pane
    And I select the "R50.9" code in the Diagnoses search list in the "Note Writer APDX Search" pane
    And I sign/submit the "HCA History and Physical" note

  Scenario: Verification of  Insert Previous link for the selected data in the fields of ROS, and A/P section using H&P Template
     # Test Case:  10 NW_AdvTemp_InsPrevFieldOrSection
    Given I am logged into the portal with user "nwfield1" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "OK" button in the "Information" pane if it exists
    And I wait "3" seconds
    And I click the "ROS" insert previous link in the "Note Writer" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      | This is for search field ROS Eyes normal  |
      | Negative for dyspnea or wheeze. No cough. |
    And I uncheck the "Resp Qtv2" checkbox
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And the text "This is for search field ROS Eyes normal" should appear in the "ROS History" pane
    And I select the note "A/P" section
    And I click the "OK" button in the "Information" pane if it exists
    And I wait "3" seconds
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    Then the following text should appear in the "Data To Insert From Previous Notes" pane
      | This scenario test the insert previous Field in the A/P section |
    And I uncheck the "Chest Pain Qtv2" checkbox
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    Then the text "" should appear in the "NoteWriter" pane


  Scenario: Create notes for different users within same department
   #Test Case : 12 NW_AdvTemp_InsPrevOptions
    Given I am logged into the portal with user "ipuser1" using the default password
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "InsPrevUser1" from the "Patient List" menu
    And "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA History and Physical" template note for the selected patient
    And I wait "3" seconds
    And I select the note "Subjective" section
    And I click the "ROS EYES Normal" button
    And I click the "ROS ENT Abnormal" button
    And I select the note "Objective" section
    And I click the "Exam Eyes Normal" element in the "Note Writer" pane
    And I select the note "A/P" section
    And I enter "toe" in the "Diagnosis Search" field in the "Note Writer APDX Search" pane
    And I select the "S90.416A" code in the Diagnoses search list in the "Note Writer APDX Search" pane
    And I sign/submit the "HCA History and Physical" note
    Given I am logged into the portal with user "ipuser2" using the default password
    And I am on the "Patient List V2" tab
    And "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA History and Physical" template note for the selected patient
    And I wait "3" seconds
    And I select the note "Subjective" section
    And I click the "ROS MSK Normal" button
    And I click the "ROS HEMA Abnormal" button
    And I select the note "Objective" section
    And I click the "Exam Neck Normal" element in the "Note Writer" pane
    And I select the note "A/P" section
    And I enter "elbow" in the "Diagnosis Search" field in the "Note Writer APDX Search" pane
    And I select the "S50.319A" code in the Diagnoses search list in the "Note Writer APDX Search" pane
    And I sign/submit the "HCA History and Physical" note

  Scenario: Verify InsertPrevious data available within same department users
    #Test Case : 12 NW_AdvTemp_InsPrevOptions
    # create another note by logging as first user and verify that user has access to both MyNotes and MyDepartmentNotes
    And I load the "HCA History and Physical" template note for the selected patient
    And I wait "3" seconds
    And I select the note "Subjective" section
    And I click the "ROS" insert previous link in the "Note Writer" pane
    And I click the "My Notes" element in the "Data To Insert From Previous Notes" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text | Status  |
      | Eyes | Enabled |
    And I click the "My Department Notes" element in the "Data To Insert From Previous Notes" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text            | Status  |
      | Musculoskeletal | Enabled |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I select the note "Objective" section
    And I click the "Exam Target" insert previous link in the "Note Writer" pane
    And I click the "My Notes" element in the "Data To Insert From Previous Notes" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text | Status  |
      | Eyes | Enabled |
    And I click the "My Department Notes" element in the "Data To Insert From Previous Notes" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text | Status  |
      | Neck | Enabled |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I select the note "A/P" section
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    And I click the "My Notes" element in the "Data To Insert From Previous Notes" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text         | Status  |
      | Toe abrasion | Enabled |
    And I click the "My Department Notes" element in the "Data To Insert From Previous Notes" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text           | Status  |
      | Elbow abrasion | Enabled |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I save the template as Draft


  Scenario: Enable Charges favorite setting
    #Test Case : 21 NW_AdvTemp_InsPrevFavorite
    #Prerequisite
    Given I am logged into the portal with user "nwadmin" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "ipuser1"
    And I select the user "ipuser1"
    And I wait "2" seconds
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I wait "5" seconds
    And I select "true" from the "Enable Charge Favorites" radio list in the "Charge Capture Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I click the logout button

  Scenario: Add problem to favorite list
    #Test Case : 21 NW_AdvTemp_InsPrevFavorite
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "A/P" section
    And I enter "toe" in the "Diagnosis Search" field in the "NoteWriter AP DX Search" pane
    And I select the "S90.416A" code in the Diagnoses search list in the "NoteWriter AP DX Search" pane
    And I click the "Favorite Dx" image in the "Note Writer" pane if it exists
    And I click "OK" in the confirmation box if it exists
    And I sign/submit the "HCA History and Physical" note

  Scenario: Create note with favorite problem in A/P section
    #Test Case : 21 NW_AdvTemp_InsPrevFavorite
    And I load the "HCA History and Physical" template note for the selected patient
    And I wait "3" seconds
    And I select the note "Subjective" section
    And I click the "ROS EYES Normal" button
    And I select the note "Objective" section
    And I click the "Exam Eyes Normal" element in the "Note Writer" pane
    And I select the note "A/P" section
    And I choose the "S90.416A" code in the "Favorites" list in the "Favorite Diagnoses" search section in the "Note Writer APDX Search" pane
    And I sign/submit the "HCA History and Physical" note

  Scenario: Verify InsertPrevious for favorite problem in A/P section
    #Test Case : 21 NW_AdvTemp_InsPrevFavorite
    And I load the "HCA History and Physical" template note for the selected patient
    And I wait "3" seconds
    And I select the note "A/P" section
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    When I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    Then the following fields should display in the "Note Writer" pane
      | Name             | Type    |
      | Favorite Problem | element |
    And I sign/submit the "HCA History and Physical" note

  Scenario: Create notes to verify InsertPrevious for users within same group
    #Test Case : NW_Adv_Temp_InsPrev_Users_Same Group
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I wait "3" seconds
    And I enter "This is a test note by user1" in the "Patient Narrative QTV2" rich text field
    And I click the "ROS Resp Normal" button in the "Note Writer" pane
    And I select the note "Objective" section
    And I click the "Exam Eyes Normal" element in the "Note Writer" pane
    And I select the note "A/P" section
    And I click the "Add Problem" button in the "Note Writer" pane if it exists
    And I wait "2" seconds
    And I enter "R07.89" in the "Problem Dx Search" field
    And I enter "Burn" in the "PlanQTV2" rich text field
    And I sign/submit the "HCA Progress Note" note
    And I click the logout button
    Given I am logged into the portal with user "ipuser2" using the default password
    And I am on the "Patient List V2" tab
    And "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I wait "3" seconds
    And I enter "This is a test note by user2" in the "Patient Narrative QTV2" rich text field
    And I click the "ROS MSK Normal" button in the "Note Writer" pane
    And I select the note "Objective" section
    And I click the "Exam Neck Normal" element in the "Note Writer" pane
    And I select the note "A/P" section
    And I click the "Add Problem" button in the "Note Writer" pane if it exists
    And I wait "2" seconds
    And I enter "S50.319A" in the "Problem Dx Search" field
    And I enter "elbow" in the "Plan QTV2" rich text field
    And I sign/submit the "HCA Progress Note" note
    And I click the logout button

  Scenario: Verify InsertPrevious for users within same group for all the sections
    #Test Case : NW_Adv_Temp_InsPrev_Users_Same Group
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I wait up to "5" seconds for loading to complete
    And I click the "Patient Narrative" insert previous link in the "Note Writer" pane
    And I click the "My Department Notes" element in the "Data To Insert From Previous Notes" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text                         | Status  |
      | This is a test note by user2 | Enabled |
    And I click the "Page Previous Image" element in the "Data To Insert From Previous Notes" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text                         | Status  |
      | This is a test note by user1 | Enabled |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I click the "ROS" insert previous link in the "Note Writer" pane
    And I click the "My Department Notes" element in the "Data To Insert From Previous Notes" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text            | Status  |
      | Musculoskeletal | Enabled |
    And I click the "Page Previous Image" element in the "Data To Insert From Previous Notes" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text        | Status  |
      | Respiratory | Enabled |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I select the note "Objective" section
    And I click the "Exam Target" insert previous link in the "Note Writer" pane
    And I click the "My Department Notes" element in the "Data To Insert From Previous Notes" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text | Status  |
      | Neck | Enabled |
    And I click the "Page Previous Image" element in the "Data To Insert From Previous Notes" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text | Status  |
      | Eyes | Enabled |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I select the note "A/P" section
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    And I click the "My Department Notes" element in the "Data To Insert From Previous Notes" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text              | Status  |
      | Abrasion of elbow | Enabled |
    And I click the "Page Previous Image" element in the "Data To Insert From Previous Notes" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text             | Status  |
      | Other chest pain | Enabled |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I save the template as Draft


  Scenario: Verify InsertPrevious across Departments
      #Test Case  : NW_AdvTemp_InsPrevCrossDept
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I wait "3" seconds
    And I click the "ROS GU Normal" button in the "Note Writer" pane
    And I select the note "Objective" section
    And I click the "Exam Eyes Normal" element in the "Note Writer" pane
    And I select the note "A/P" section
    And I click the "Add Problem" button in the "Note Writer" pane if it exists
    And I wait "2" seconds
    And I enter "F99" in the "Problem Dx Search" field
    And I sign/submit the "HCA Progress Note" note
    And I click the logout button
    Given I am logged into the portal with user "ipuser3" using the default password
    And I am on the "Patient List V2" tab
    And "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I wait "3" seconds
    And I click the "ROS" insert previous link in the "Note Writer" pane
    Then the checkbox for the following text should not present in the insert previous notes pane
      | Text          |
      | Genitourinary |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I select the note "Objective" section
    And I click the "Exam Target" insert previous link in the "Note Writer" pane
    Then the checkbox for the following text should not present in the insert previous notes pane
      | Text |
      | Eyes |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I select the note "A/P" section
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    Then the checkbox for the following text should not present in the insert previous notes pane
      | Text            |
      | Mental disorder |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I save the template as Draft


  Scenario: Create Draft notes to verify InsertPrevious
    #Test Case : NW_AdvTemp_InsPrevDrafts
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I wait "3" seconds
    And I click the "ROS ALL/IMM Normal" button in the "Note Writer" pane
    And I select the note "Objective" section
    And I click the "Exam Skin Abnormal Findings" element in the "Note Writer" pane
    And I select the note "A/P" section
    And I click the "Add Problem" button in the "Note Writer" pane if it exists
    And I wait "2" seconds
    And I enter "L60.9" in the "Problem Dx Search" field
    And I enter "Nail" in the "Plan QTV2" rich text field
    And I save the template as Draft
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*DRAFT*  Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the text "Draft" should appear in the "HCA Progress Note" pane
    And I click the "Edit" button in the "HCA Progress Note" pane
    And I select the note "Subjective" section
    And I wait "3" seconds
    And I enter "Editing draft note" in the "Patient Narrative QTV2" rich text field
    And I save the template as Draft
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*DRAFT*  Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the text "Draft" should appear in the "HCA Progress Note" pane

  Scenario: Verify InsertPrevious for Draft notes at user level
    #Test Case : NW_AdvTemp_InsPrevDrafts
    Given I am logged into the portal with user "ipuser2" using the default password
    And I am on the "Patient List V2" tab
    And "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I wait "3" seconds
    And I click the "Patient Narrative" insert previous link in the "Note Writer" pane
    And I click the "My Notes" element in the "Data To Insert From Previous Notes" pane
    Then the checkbox for the following text should not present in the insert previous notes pane
      | Text               |
      | Editing draft note |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I select the note "Objective" section
    And I click the "Exam Target" insert previous link in the "Note Writer" pane
    Then the checkbox for the following text should not present in the insert previous notes pane
      | Text           |
      | Cardiovascular |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I select the note "A/P" section
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    Then the checkbox for the following text should not present in the insert previous notes pane
      | Text          |
      | Nail disorder |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I click the "NoteWriter Cancel Note" button in the "ClinicalNote" pane
    Then I click the "Yes" button in the "Information" pane

  Scenario: Verify InsertPrevious for Draft notes at department level
    #Test Case : NW_AdvTemp_InsPrevDrafts
    Given I am logged into the portal with user "ipuser2" using the default password
    And I am on the "Patient List V2" tab
    And "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I wait "3" seconds
    And I click the "Patient Narrative" insert previous link in the "Note Writer" pane
    And I click the "My Department Notes" element in the "Data To Insert From Previous Notes" pane
    Then the checkbox for the following text should not present in the insert previous notes pane
      | Text               |
      | Editing draft note |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I select the note "Objective" section
    And I click the "Exam Target" insert previous link in the "Note Writer" pane
    Then the checkbox for the following text should not present in the insert previous notes pane
      | Text           |
      | Cardiovascular |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I select the note "A/P" section
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    Then the checkbox for the following text should not present in the insert previous notes pane
      | Text          |
      | Nail disorder |
    And I click the "Cancel Insert Previous" button in the "Data To Insert From Previous Notes" pane
    And I click the "NoteWriter Cancel Note" button in the "Clinical Note" pane
    Then I click the "Yes" button in the "Information" pane

  Scenario: Create notes by different users of different department
    #Test Case : NW_AdvTemp_InsPrevUsersShareGroup
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "ROS GI Normal" button
    And I click the "ROS NEURO Abnormal" button
    And I enter "Neuro Abnormal" in the "ROS NEURO Abnormal QTV2" rich text field
    And I select the note "Objective" section
    And I click the "Exam Neck Normal" element in the "Note Writer" pane
    And I select the note "A/P" section
    And I enter "head" in the "Diagnosis Search" field in the "NoteWriterAPDXSearch" pane
    And I select the "Head ache" codedescription in the Diagnoses search list in the "NoteWriterAPDXSearch" pane
    And I sign/submit the "HCA History and Physical" note
    Given I am logged into the portal with user "ipuser3" using the default password
    And I am on the "Patient List V2" tab
    And "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "ROS GU Normal" button
    And I click the "ROS Skin Abnormal" button
    And I select the note "Objective" section
    And I click the "Exam Eyes Normal" element in the "Note Writer" pane
    And I select the note "A/P" section
    And I enter "finger" in the "Diagnosis Search" field in the "NoteWriterAPDXSearch" pane
    And I select the "S60.419A" code in the Diagnoses search list in the "NoteWriterAPDXSearch" pane
    And I sign/submit the "HCA History and Physical" note

  Scenario: Verify InsertPrevious for another user within same department
    #Test Case : NW_AdvTemp_InsPrevUsersShareGroup
    And I load the "HCA History and Physical" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "ROS" insert previous link in the "Note Writer" pane
    And I click the "My Department Notes" element in the "Data To Insert From Previous Notes" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text             | Status  |
      | Gastrointestinal | Enabled |
      | Neurological     | Enabled |
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    Then the text "Gastrointestinal" should appear in the "Note Writer" pane
    Then the text "Neurological" should appear in the "Note Writer" pane
    And I select the note "Objective" section
    And I click the "Exam Target" insert previous link in the "Note Writer" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text | Status  |
      | Neck | Enabled |
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    Then the text "Neck" should appear in the "Note Writer" pane
    And I select the note "A/P" section
    And I click the "Proble mList" insert previous link in the "Note Writer" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text      | Status  |
      | Head ache | Enabled |
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    Then the text "Head ache" should appear in the "Note Writer" pane
    And I save the template as Draft

  #TODO: blocked by DEV-85402
  Scenario: Verify no duplicate for normal and abnormal entries using InsertPrevious
    #Test Case : 05 NW_AdvTemp_InsPrev_ClinicData_NormAbnorm_NoDupe
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "ROS EYES Normal" button
    And I click the "ROS GU Normal" button
    And I click the "ROS Skin Abnormal" button
    And I click the "ROS GI Normal" button
    And I select the note "Objective" section
    And I click the "Exam Eyes Normal" element in the "Note Writer" pane
    And I select the note "A/P" section
    And I click the "Add Problem" button in the "Note Writer" pane if it exists
    And I wait up to "3" seconds for loading to complete
    And I enter "R07.89" in the "Problem Dx Search" field
    And I enter "Burn" in the "Plan QTV2" rich text field
    And I sign/submit the "HCA Progress Note" note
    #new note to check series of ROS in InsPrev
    And "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA Progress Note" template note for the selected patient
    And I select the note "Subjective" section
    And I click the "ROSEyesFindings" element
    And I enter "It is free text for ROS" in the "RosEyesNormalQTV2" field
    And I click the "ROS" insert previous link in the "Note Writer" pane
    Then the checkbox for the following text should present with the given status in the insert previous notes pane
      | Text | Status   |
      | Eyes | Disabled |
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    Then the "ROS Target Table" table should have "1" rows containing the text "Eyes"
    And I sign/submit the "HCA Progress Note" note

  Scenario: Create notes to verify problem sorting in A/P section
   #Test Case : NW_AdvTemp_InsPrev_Problem_Sorting
    And I load the "HCA History and Physical" template note for the selected patient
    And I wait "3" seconds
    And I select the note "A/P" section
    And I click the "Add Problem" button in the "Note Writer" pane if it exists
    And I wait up to "3" seconds for loading to complete
    And I enter "Leg" in the "Diagnosis Search" field in the "Note Writer APDX Search" pane
    And I select the "Leg abrasion" codedescription in the Diagnoses search list in the "Note Writer APDX Search" pane
    And I wait up to "3" seconds for loading to complete
    Then the text "Leg abrasion" should appear in the "Note Writer" pane
    And I enter "Hand" in the "Diagnosis Search" field in the "Note Writer APDX Search" pane
    And I select the "Hand abrasion" codedescription in the Diagnoses search list in the "Note Writer APDX Search" pane
    And I wait up to "3" seconds for loading to complete
    Then the text "Hand abrasion" should appear in the "Note Writer" pane
    And I enter "Toe" in the "Diagnosis Search" field in the "Note Writer APDX Search" pane
    And I select the "Toe abrasion" codedescription in the Diagnoses search list in the "Note Writer APDX Search" pane
    And I wait up to "3" seconds for loading to complete
    Then the text "Toe abrasion" should appear in the "Note Writer" pane
    And I enter "Head" in the "Diagnosis Search" field in the "Note Writer APDX Search" pane
    And I select the "Head ache" codedescription in the Diagnoses search list in the "Note Writer APDX Search" pane
    And I wait up to "3" seconds for loading to complete
    Then the text "Head ache" should appear in the "Note Writer" pane
    And I enter "Tongue" in the "Diagnosis Search" field in the "Note Writer APDX Search" pane
    And I select the "Tongue abnormality" codedescription in the Diagnoses search list in the "Note Writer APDX Search" pane
    And I wait up to "3" seconds for loading to complete
    Then the text "Tongue abnormality" should appear in the "Note Writer" pane
    And I move the following problems to the mentioned position in the "Note Writer" pane
      | Problem            | Position |
      | Leg abrasion       | 3        |
      | Toe abrasion       | 5        |
      | Tongue abnormality | 4        |
      | Head ache          | 1        |
    And I sign/submit the "HCA History and Physical" note
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Final" should appear in the "History Physical Contents" pane

  Scenario: Verify problems order in InsertPrevious page
    #Test Case : NW_AdvTemp_InsPrev_Problem_Sorting
    And I load the "HCA History and Physical" template note for the selected patient
    And I wait "3" seconds
    And I select the note "A/P" section
    And I click the "ProblemList" insert previous link in the "Note Writer" pane
    Then the following problems should appear in the mentioned position in the "Data To Insert From Previous Notes" pane
      | Problem            | Position |
      | Head ache          | 1        |
      | Hand abrasion      | 2        |
      | Leg abrasion       | 3        |
      | Tongue abnormality | 4        |
      | Toe abrasion       | 5        |
    And I click the "InsertSelectionQTV2" button in the "Data To Insert From Previous Notes" pane
    And I wait "3" seconds
    Then the following problems should appear in the mentioned position in the "Problem Target" pane
      | Problem            | Position |
      | Head ache          | 1        |
      | Hand abrasion      | 2        |
      | Leg abrasion       | 3        |
      | Tongue abnormality | 4        |
      | Toe abrasion       | 5        |
    And I enter "Eyes" in the "Diagnosis Search" field in the "Note Writer APDX Search" pane
    And I select the "Eyes swollen" codedescription in the Diagnoses search list in the "Note Writer APDX Search" pane
    And I wait up to "3" seconds for loading to complete
    Then the text "Eyes swollen" should appear in the "Note Writer" pane
    And I enter "Hear" in the "Diagnosis Search" field in the "Note Writer APDX Search" pane
    And I select the "Hearing difficulty" codedescription in the Diagnoses search list in the "Note Writer APDX Search" pane
    And I wait up to "3" seconds for loading to complete
    Then the text "Hearing difficulty" should appear in the "Note Writer" pane
    And I move the following problems to the mentioned position in the "Note Writer" pane
      | Problem            | Position |
      | Hearing difficulty | 6        |
    Then the following problems should appear in the mentioned position in the "Problem Target" pane
      | Problem            | Position |
      | Head ache          | 1        |
      | Hand abrasion      | 2        |
      | Leg abrasion       | 3        |
      | Tongue abnormality | 4        |
      | Toe abrasion       | 5        |
      | Hearing difficulty | 6        |
      | Eyes swollen       | 7        |
    And I sign/submit the "HCA History and Physical" note
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Final" should appear in the "HCA Progress Note" pane

  Scenario: Verify problems order in InsertPrevious page after adding and reordering new problems
    #Test Case : NW_AdvTemp_InsPrev_Problem_Sorting
    And I load the "HCA History and Physical" template note for the selected patient
    And I wait "3" seconds
    And I select the note "A/P" section
    And I click the "Problem List" insert previous link in the "Note Writer" pane
    Then the following problems should appear in the mentioned position in the "Data To Insert From Previous Notes" pane
      | Problem            | Position |
      | Head ache          | 1        |
      | Hand abrasion      | 2        |
      | Leg abrasion       | 3        |
      | Tongue abnormality | 4        |
      | Toe abrasion       | 5        |
      | Hearing difficulty | 6        |
      | Eyes swollen       | 7        |
    And I click the "Page Previous Image" element in the "Data To Insert From Previous Notes" pane
    And I wait "2" seconds
    Then the following problems should appear in the mentioned position in the "Data To Insert From Previous Notes" pane
      | Problem            | Position |
      | Head ache          | 1        |
      | Hand abrasion      | 2        |
      | Leg abrasion       | 3        |
      | Tongue abnormality | 4        |
      | Toe abrasion       | 5        |
    And I click the "Insert Selection QTV2" button in the "Data To Insert From Previous Notes" pane
    And I wait "3" seconds
    And I sign/submit the "HCA History and Physical" note
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select patient "Roy Blazer" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Final" should appear in the "History Physical Contents" pane
    Then the contents of the "Clinical Notes" clinical table should contain the results of the "Patient Notes" query


