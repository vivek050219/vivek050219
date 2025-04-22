@NoteWriterHCA
Feature: Notewriter HCA non-clinical data
  #  ALM Path: Notewriter (PK)>> Suites >> Templates - All Fields workflow >> 01 HCA All

  Background:
    Given I am logged into the portal with user "nwhca3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I use the API to create a patient list named "NwHCA" owned by "nwhca3" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I click the "Refresh Patient List" button
    And I select "NwHCA" from the "Patient List" menu
    And "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list

  Scenario: Enable QuickText v2
    # Pre-requisite
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

  Scenario: Setup - Create draft note for future scenarios
    And I select "Clinical Notes" from clinical navigation
    And I load the "HCA non-clinical data" template note for the selected patient
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I wait "5" seconds
    And I select the note "Miscellaneous Fields" section in the "Popout Wizard" pane
    And I enter "draft note" in the "Chief Complaint" field in the "Popout Note Wizard" pane
    And I save the HCA note template as draft
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I click the "OK" button in the "Question" pane if it exists

  Scenario: 1.1 Verify the Miscellaneous Fields section - Text Field
    #Test case : 01 - Miscellaneous Fields
    And I click the "OK" button in the "Question" pane if it exists
    And I select "Clinical Notes" from clinical navigation
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I click the "Edit" button
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I wait "3" seconds
    And I select the note "Miscellaneous Fields" section in the "Popout Wizard" pane
    And I enter "HCA patient non clinical data" in the "Chief Complaint" field in the "Popout Note Wizard" pane
    And I save the HCA note template as draft
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I click the "OK" button in the "Question" pane if it exists
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      | HCA patient non clinical data |

  Scenario: 1.2 Verify the Miscellaneous Fields section - Quick Text
    #Test case : 01 - Miscellaneous Fields
    And I select "Clinical Notes" from clinical navigation
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I wait up to "10" seconds for the "Edit" field of type "BUTTON" in the "Note Details" pane to be clickable
    And I click the "Edit" button
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I wait "3" seconds
    And I select the note "Miscellaneous Fields" section in the "Popout Wizard" pane
    When I click the "Miscellaneous Patient Narrative ABC" element in the "Miscellaneous Fields" pane
    And I click on the text "pn qt" in the "Miscellaneous Fields" pane
    Then the following text should appear in the "Miscellaneous Fields" pane
      | quick text for patient narrative hca field |
    And I click the "Quick Text Close" button in the "Miscellaneous Fields" pane
    And I save the HCA note template as draft
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I click the "OK" button in the "Question" pane if it exists
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      | quick text for patient narrative hca field |

    #TODO : blocking due to https://jira/browse/DEV-70265 - Clinical Notes filter popup and warning message should appear on the Undock Note.
  Scenario: 1.3 Verify the Miscellaneous Fields section - Dates
    #Test case : 01 - Miscellaneous Fields
    And I select "Clinical Notes" from clinical navigation
    And I save the "Arrival Date" value of patient under name "arrivalDate" in persistent state
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I click the "Edit" button
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I wait "3" seconds
    And I select the note "Miscellaneous Fields" section in the "Popout Wizard" pane
    And the "AdmissionDate" div should match the value stored at "arrivalDate" in persistent state
    When I enter "16/22/17" in the "SurgeryDate" field in the "Miscellaneous Fields" pane
    And I click the "ENTER" key in the "SurgeryDate" rich text field in the "Popout Note Wizard" pane
    And I wait up to "5" seconds for the "OK" field of type "BUTTON" in the "Warning Message" pane to be clickable
    Then the "Warning Message" pane should appear with the text "Months must be entered between the range of 01 (January) and 12 (December)."
#    Then A warning message should appear with the text "Months must be entered between the range of 01 (January) and 12 (December)." in "Warning Message" pane
    And I click the "OK" button in the "Warning Message" pane
    When I enter "%2 days from now MMDDYY%" in the "Surgery Date" field in the "Popout Note Wizard" pane
    And I click the "ENTER" key in the "SurgeryDate" rich text field in the "Popout Note Wizard" pane
    And I click the "Surgery Date Calendar" image in the "Popout Note Wizard" pane
    And I click the "Current Month" element in the "Calendar" pane
    And I click the "Today's Date" element in the "Calendar" pane
    Then the text "%Current Date MMDDYY%" should appear in the "Popout Note Wizard" pane
    When I enter "2455" in the "Surgery Time" field in the "Popout Note Wizard" pane
    And I click the "TAB" key in the "Surgery Time" rich text field in the "Popout Note Wizard" pane
    And I wait up to "5" seconds for the "OK" field of type "BUTTON" in the "Warning Message" pane to be clickable
    Then the "Warning Message" pane should appear with the text "Entered time is invalid"
#    Then A warning message should appear with the text "Entered time is invalid." in "Warning Message" pane
    And I click the "OK" button in the "Warning Message" pane
    And I enter "02:30pm" in the "Surgery Time" field in the "Popout Note Wizard" pane
    And I save the HCA note template as draft
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I click the "OK" button in the "Question" pane if it exists

  Scenario: 1.4 Verify the Miscellaneous Fields section - Co-sign Provider
    #Test case : 01 - Miscellaneous Fields
    And I select "Clinical Notes" from clinical navigation
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I click the "Edit" button
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I wait "3" seconds
    And I select the note "Miscellaneous Fields" section in the "Popout Wizard" pane
    #logged in user should be displayed by default
    And the text "LEVEL3, HCA3" should appear in the "Popout Note Wizard" pane
    And I enter "pk" in the "Surgeon LOOKUP" field in the "Popout Note Wizard" pane
    And I click the "SurgeonIMG" element in the "Popout Note Wizard" pane
    Then All cells in the "CoSiglookupTable" table should contain the text "pk"
    And I enter "hca3" in the "Surgeon LOOKUP" field in the "Popout Note Wizard" pane
    And I click the "ENTER" key in the "Surgeon LOOKUP" rich text field in the "Popout Note Wizard" pane
    And the text "LEVEL3, HCA3" should appear in the "Popout Note Wizard" pane
    And I save the HCA note template as draft
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      | LEVEL3, HCA3 |

    #TODO : blocking due to https://jira/browse/DEV-70265 - Clinical Notes filter popup and warning message should appear on the Undock Note.
  Scenario: 1.5 Verify the Miscellaneous Fields section - Number
    #Test case : 01 - Miscellaneous Fields
    And I select "Clinical Notes" from clinical navigation
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I click the "Edit" button
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I wait "3" seconds
    And I select the note "Miscellaneous Fields" section in the "Popout Wizard" pane
    And I enter "abcd" in the "Estimated Blood Loss" field in the "Popout Note Wizard" pane
    And I click the "TAB" key in the "Estimated Blood Loss" rich text field in the "Popout Note Wizard" pane
    And I wait up to "5" seconds for the "OK" field of type "BUTTON" in the "Warning Message" pane to be clickable
    Then the "Warning Message" pane should appear with the text "Invalid number. Entered value must be a number."
#    Then A warning message should appear with the text "Invalid number. Entered value must be a number." in "Warning Message" pane
    And I click the "OK" button in the "Warning Message" pane
    And I enter "50.23" in the "Estimated Blood Loss" field in the "Popout Note Wizard" pane
    And I check the "Time Out Completed" checkbox in the "Popout Note Wizard" pane
    And I uncheck the "Time Out Completed" checkbox in the "Popout Note Wizard" pane
    And I save the HCA note template as draft
    And I switch the focus to the "LoginWindow" window
    And I click the "OK" button in the "Question" pane if it exists

  Scenario: 1.6 Verify the Miscellaneous Fields section - Tobacco
    #Test case : 01 - Miscellaneous Fields
    And I select "Clinical Notes" from clinical navigation
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I click the "Edit" button
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I wait "5" seconds
    And I select the note "Miscellaneous Fields" section in the "Popout Wizard" pane
#    When I check the "Tobacco Use" checkbox in the "Miscellaneous Fields" pane
    And I click the "TobaccoUseCheckbox" element in the "Miscellaneous Fields" pane
    Then the following fields should display in the "Miscellaneous Fields" pane
      | Name             | Type     |
      | TobaccoUseStatus | dropdown |
      | TobaccoUseType   | text     |
      | TobaccoUseAmount | text     |
      | TobaccoUseYears  | text     |
      | TobaccoComments  | text     |
    And I enter "Chain Smoker" in the "Tobacco Comments" field in the "Miscellaneous Fields" pane
    And I select "Never" from the "Tobacco Use Status" dropdown in the "Miscellaneous Fields" pane
    And I enter "none" in the "Tobacco Use Type" field in the "Miscellaneous Fields" pane
    And I enter "2" in the "Tobacco Use Amount" field in the "Miscellaneous Fields" pane
    And I enter "1" in the "Tobacco Use Years" field in the "Miscellaneous Fields" pane
    And I save the HCA note template as draft
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I click the "OK" button in the "Question" pane if it exists
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      | Chain Smoker |

  Scenario: 1.7 Verify the Miscellaneous Fields section - Alcohol
    #Test case : 01 - Miscellaneous Fields
    And I select "Clinical Notes" from clinical navigation
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I click the "Edit" button
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I wait "5" seconds
    And I select the note "Miscellaneous Fields" section in the "Popout Wizard" pane
#    When I check the "Alcohol Use" checkbox in the "Miscellaneous Fields" pane
    And I click the "AlcoholUseCheckbox" element in the "Miscellaneous Fields" pane
    Then the following fields should display in the "Miscellaneous Fields" pane
      | Name             | Type     |
      | AlcoholUseStatus | dropdown |
      | AlcoholUseType   | text     |
      | AlcoholUseAmount | text     |
      | AlcoholUseYears  | text     |
      | AlcoholComments  | text     |
    And I enter "occasional" in the "Alcohol Comments" field in the "Miscellaneous Fields" pane
    And I select "Never" from the "Alcohol Use Status" dropdown in the "Miscellaneous Fields" pane
    And I enter "none" in the "Alcohol Use Type" field in the "Miscellaneous Fields" pane
    And I click the "ProofreaderClose" button in the "Miscellaneous Fields" pane if it exists
    And I enter "2" in the "Alcohol Use Amount" field in the "Miscellaneous Fields" pane
    And I enter "1" in the "Alcohol Use Years" field in the "Miscellaneous Fields" pane
    And I save the HCA note template as draft
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I click the "OK" button in the "Question" pane if it exists
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      | occasional |

  Scenario: 1.8 Verify the Miscellaneous Fields section - Drug Use
    #Test case : 01 - Miscellaneous Fields
    And I select "Clinical Notes" from clinical navigation
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I click the "Edit" button
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I wait "5" seconds
    And I select the note "Miscellaneous Fields" section in the "Popout Wizard" pane
#    When I check the "Drug Use" checkbox in the "Miscellaneous Fields" pane
    And I click the "DrugUseCheckbox" element in the "Miscellaneous Fields" pane
    Then the following fields should display in the "Miscellaneous Fields" pane
      | Name          | Type     |
      | DrugUseStatus | dropdown |
      | DrugUseType   | text     |
      | DrugUseAmount | text     |
      | DrugUseYears  | text     |
      | DrugComments  | text     |
    And I enter "rarely" in the "Drug Comments" field in the "Miscellaneous Fields" pane
    And I select "Never" from the "Drug Use Status" dropdown in the "Miscellaneous Fields" pane
    And I enter "none" in the "Drug Use Type" field in the "Miscellaneous Fields" pane
    And I click the "ProofreaderClose" button in the "Miscellaneous Fields" pane if it exists
    And I enter "2" in the "Drug Use Amount" field in the "Miscellaneous Fields" pane
    And I enter "1" in the "Drug Use Years" field in the "Miscellaneous Fields" pane
    And I save the HCA note template as draft
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I click the "OK" button in the "Question" pane if it exists
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      | rarely |

    #TODO : blocking due to https://jira/browse/DEV-70265 - Clinical Notes filter popup and warning message should appear on the Undock Note.
  Scenario: 1.9 Verify the Miscellaneous Fields section - Marital Status
    #Test case : 01 - Miscellaneous Fields
    And I select "Clinical Notes" from clinical navigation
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I click the "Edit" button
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I wait "5" seconds
    And I select the note "Miscellaneous Fields" section in the "Popout Wizard" pane
    #verifying all possibilities of marital status dropdown
    When I select "Single" from the "Marital Status" dropdown in the "Popout Note Wizard" pane
    Then the option "Single" should be available in the "Marital Status" dropdown list in the "Miscellaneous Fields" pane
    When I select "Other..." from the "Marital Status" dropdown in the "Popout Note Wizard" pane
    Then the "Enter Other Choice Text" pane should load within "3" seconds
    And I enter "Together" in the "Other Choice" field in the "Enter Other Choice Text" pane
    And I click the "Other Choice Cancel" button in the "Enter Other Choice Text" pane
    Then the option "Single" should be available in the "Marital Status" dropdown list
    When I select "Other..." from the "Marital Status" dropdown in the "Popout Note Wizard" pane
    Then the "Enter Other Choice Text" pane should load within "3" seconds
    And I enter "Together" in the "Other Choice" field in the "Enter Other Choice Text" pane
    And I click the "Other Choice OK" button in the "Enter Other Choice Text" pane
    When I click the "EditOtherMaritalStatus" element in the "Popout Note Wizard" pane
    Then the "Enter Other Choice Text" pane should load within "3" seconds
    And I enter "Living Together" in the "Other Choice" field in the "Enter Other Choice Text" pane
    And I click the "Other Choice OK" button in the "Enter Other Choice Text" pane
    Then the option "Living Together" should be available in the "Marital Status" dropdown list
    And I save the HCA note template as draft
    And I switch the focus to the "LoginWindow" window
    And I click the "OK" button in the "Question" pane if it exists
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      | Living Together |

  Scenario: 1.10 Verify the Miscellaneous Fields section - Code Status
    #Test case : 01 - Miscellaneous Fields
    And I select "Clinical Notes" from clinical navigation
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I click the "Edit" button
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I wait "5" seconds
    And I select the note "Miscellaneous Fields" section in the "Popout Wizard" pane
    And Nothing should be selected by default in the "Code Status" radio list in the "Miscellaneous Fields" pane
    And I select "true" from the "Full Code" radio list in the "Miscellaneous Fields" pane
    And I select "true" from the "Limited Interventions" radio list in the "Miscellaneous Fields" pane
    And I save the HCA note template as draft
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I click the "OK" button in the "Question" pane if it exists
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      | Limited Interventions |

  Scenario: 2. Verify the Subjective section
    #Test case : 02 - Subjective
    And I select "Clinical Notes" from clinical navigation
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I click the "Edit" button
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I wait "5" seconds
    And I select the note "Subjective" section in the "Popout Wizard" pane
    When I check the "Unable To Obtain ROS" checkbox in the "Popout Note Wizard" pane
    Then the following fields should display in the "Popout Note Wizard" pane
      | Name                          | Type |
      | Unable To Obtain ROS Comments | text |
    And I enter "patient review of systems comments" in the "Unable To Obtain ROS Comments" field in the "Popout Note Wizard" pane
    And I click the "ROS General Normal" button in the "Popout Note Wizard" pane
    Then the text "Negative for fever, malaise, fatigue." should appear in the "Popout Note Wizard" pane
    And I click the "ROS Eyes Findings" element in the "Popout Note Wizard" pane
    And the value in the "ROS Eyes Findings" field in the "Popout Note Wizard" pane should be blank
    And I enter "itching sensation and watery eyes" in the "ROS Eyes Findings" field in the "Popout Note Wizard" pane
    And I click on the link "AllNormal" in the "Popout Note Wizard" pane
    And I wait up to "10" seconds for the "All/ImmTrash" field of type "MISC_ELEMENT" in the "Popout Note Wizard" pane to be clickable
    And the following fields should have corresponding text in the Subjective section in the "Popout Note Wizard" pane
      | Field     | Text                                                                                                       |
      | General   | Negative for fever, malaise, fatigue.                                                                      |
      | Eyes      | itching sensation and watery eyes                                                                          |
      | ENT       | Negative for sore throat. No otalgia. No rhinorrhea.                                                       |
      | Breast    | Negative for change in shape, swelling, masses, nipple discharge, pain, skin changes.                      |
      | Resp      | Negative for dyspnea or wheeze. No cough.                                                                  |
      | CV        | Negative for chest pain or palpitations. No extremity swelling.                                            |
      | GI        | Negative for abdominal pain or nausea. No emesis. No diarrhea.                                             |
      | GU        | Negative for dysuria, frequency, or urgency. No gross hematuria.                                           |
      | MSK       | Negative for joint stiffness, pain, or arthralgias.                                                        |
      | Skin      | Negative for rashes. No pruritus.                                                                          |
      | Neuro     | Negative for headache. No vertigo. Denies paresthesias.                                                    |
      | Psych     | Negative for specific complaints.                                                                          |
      | Endo      | Negative for cold intolerance, heat intolerance, polyphagia, polydipsia, polyuria, weight change, fatigue. |
      | HemaLymph | Negative for excessive bleeding, unusual masses.                                                           |
      | AllImm    | Negative for heat/cold intolerance, polydipsia, or polyuria.                                               |
    And I click the "All/ImmTrash" element in the "Popout Note Wizard" pane
#    And Text exact "Negative for heat/cold intolerance, polydipsia, or polyuria." should not appear in the "Popout Note Wizard" pane
    And I click the "ROSCommentFreeText" element in the "Popout Note Wizard" pane
    And the value in the "ROSCommentFreeText" field in the "Popout Note Wizard" pane should be blank
    And I enter "other comments" in the "ROS Comment Free Text" field in the "Popout Note Wizard" pane
    And I save the HCA note template as draft
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I click the "OK" button in the "Question" pane if it exists
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      | Negative for fever, malaise, fatigue.                                                                      |
      | itching sensation and watery eyes                                                                          |
      | Negative for sore throat. No otalgia. No rhinorrhea.                                                       |
      | Negative for change in shape, swelling, masses, nipple discharge, pain, skin changes.                      |
      | Negative for dyspnea or wheeze. No cough.                                                                  |
      | Negative for chest pain or palpitations. No extremity swelling.                                            |
      | Negative for abdominal pain or nausea. No emesis. No diarrhea.                                             |
      | Negative for dysuria, frequency, or urgency. No gross hematuria.                                           |
      | Negative for joint stiffness, pain, or arthralgias.                                                        |
      | Negative for rashes. No pruritus.                                                                          |
      | Negative for headache. No vertigo. Denies paresthesias.                                                    |
      | Negative for specific complaints.                                                                          |
      | Negative for cold intolerance, heat intolerance, polyphagia, polydipsia, polyuria, weight change, fatigue. |
      | Negative for excessive bleeding, unusual masses.                                                           |
      | other comments                                                                                             |
    And Text exact "Negative for heat/cold intolerance, polydipsia, or polyuria." should not appear in the "Note Details" pane

  Scenario: 3. Verify the Objective section
    #Test case : 03 - Objective
    And I select "Clinical Notes" from clinical navigation
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I wait "5" seconds
    And I click the "Edit" button
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I wait "5" seconds
    And I select the note "Objective" section in the "Popout Wizard" pane
    And I click the "Exam General Normal" element in the "Popout Note Wizard" pane
    Then the text "Well developed, well nourished, in no apparent distress." should appear in the "Popout Note Wizard" pane
    And I click the "Exam Head Findings" element in the "Popout Note Wizard" pane
    And the value in the "Exam Head Findings" field in the "Popout Note Wizard" pane should be blank
    And I enter "minor trauma and swelling" in the "Exam Head Findings" field in the "Popout Note Wizard" pane
    And I click on the link "AllNormal" in the "Popout Note Wizard" pane
    And I wait up to "10" seconds for the "PsychTrash" field of type "MISC_ELEMENT" in the "Popout Note Wizard" pane to be clickable
    Then the following fields should have corresponding text in the Objective section in the "Popout Note Wizard" pane
      | Field         | Text                                                                                                                                                  |
      | General       | Well developed, well nourished, in no apparent distress.                                                                                              |
      | Head          | minor trauma and swelling                                                                                                                             |
      | Eyes          | PERRL, EOM intact, conjunctiva and sclera clear, without nystagmus, lids normal.                                                                      |
      | Ears          | TM's intact and clear, normal canals, grossly normal hearing.                                                                                         |
      | Nose          | No deformity, no discharge, no inflammation, no lesions.                                                                                              |
      | Mouth         | Oropharynx without deformities or lesions, normal mucosa..                                                                                            |
      | Neck          | No masses, no thyromegaly, no abnormal cervical nodes, trachea midline.                                                                               |
      | Chest         | Grossly normal appearance.                                                                                                                            |
      | Breast        | No masses, no gynecomastia noted.                                                                                                                     |
      | Lungs         | Clear bilaterally with normal respiratory effort.                                                                                                     |
      | Heart         | Regular rate and rhythm, normal S1, S2, no murmurs, no rubs, no gallops, no clicks.                                                                   |
      | Abdomen       | Soft, non-tender, no organomegaly, no masses noted.                                                                                                   |
      | MSK           | No deformity, no scoliosis noted of thoracic or lumbar spine, joint ROM grossly normal, normal gait and station.                                      |
      | Extremities   | No clubbing, no cyanosis, no edema.                                                                                                                   |
      | Neuro         | No focal deficits, cranial nerves II-XII grossly intact, normal sensation, normal reflexes, normal coordination, normal muscle strength, normal tone. |
      | Pulses        | Pulses normal in all extremities.                                                                                                                     |
      | Rectal        | Normal rectal tone, no masses.                                                                                                                        |
      | Genitourinary | Normal external genitalia.                                                                                                                            |
      | Skin          | Intact without significant lesions, or rashes.                                                                                                        |
      | Lymph         | No significant cervical node adenopathy. No significant axillary node adenopathy. No significant inguinal node adenopathy.                            |
      | Psych         | Alert and oriented to time, person, place. Normal mood and affect, intact judgment and insight.                                                       |
    And I click the "PsychTrash" element in the "Popout Note Wizard" pane
#    And Text exact "Alert and oriented to time, person, place. Normal mood and affect, intact judgment and insight." should not appear in the "Popout Note Wizard" pane
    And I click the "ExamCommentFreeText" element in the "Popout Note Wizard" pane
    And the value in the "Exam Comment Free Text" field in the "Popout Note Wizard" pane should be blank
    And I enter "other comments" in the "Exam Comment Free Text" field in the "Popout Note Wizard" pane
    And I save the HCA note template as draft
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I click the "OK" button in the "Question" pane if it exists
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      | Well developed, well nourished, in no apparent distress.                                                                                              |
      | minor trauma and swelling                                                                                                                             |
      | PERRL, EOM intact, conjunctiva and sclera clear, without nystagmus, lids normal.                                                                      |
      | TM's intact and clear, normal canals, grossly normal hearing.                                                                                         |
      | No deformity, no discharge, no inflammation, no lesions.                                                                                              |
      | Oropharynx without deformities or lesions, normal mucosa..                                                                                            |
      | No masses, no thyromegaly, no abnormal cervical nodes, trachea midline.                                                                               |
      | Grossly normal appearance.                                                                                                                            |
      | No masses, no gynecomastia noted.                                                                                                                     |
      | Clear bilaterally with normal respiratory effort.                                                                                                     |
      | Regular rate and rhythm, normal S1, S2, no murmurs, no rubs, no gallops, no clicks.                                                                   |
      | Soft, non-tender, no organomegaly, no masses noted.                                                                                                   |
      | No deformity, no scoliosis noted of thoracic or lumbar spine, joint ROM grossly normal, normal gait and station.                                      |
      | No clubbing, no cyanosis, no edema.                                                                                                                   |
      | No focal deficits, cranial nerves II-XII grossly intact, normal sensation, normal reflexes, normal coordination, normal muscle strength, normal tone. |
      | Pulses normal in all extremities.                                                                                                                     |
      | Normal rectal tone, no masses.                                                                                                                        |
      | Normal external genitalia.                                                                                                                            |
      |Intact without significant lesions, or rashes.                                                                                                       |
      |No significant cervical node adenopathy. No significant axillary node adenopathy. No significant inguinal node adenopathy.                           |
    And Text exact "Alert and oriented to time, person, place. Normal mood and affect, intact judgment and insight." should not appear in the "Note Details" pane

  Scenario: 4. Verify the Diagnosis Picker - History section
    #Test case : 04 - Diagnosis Picker - History
    And I select "Clinical Notes" from clinical navigation
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I wait "5" seconds
    And I click the "Edit" button
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I wait "5" seconds
    And I select the note "Diagnosis Picker - History" section in the "Popout Wizard" pane
    And I check the "Unable To Obtain History" checkbox in the "Popout Note Wizard" pane
    Then the following fields should display in the "Popout Note Wizard" pane
      |Name                              | Type         |
      |UnableToObtainHistoryComments     | text         |
    And I enter "These are diagnosis history comments" in the "Unable To Obtain History Comments" field in the "Popout Note Wizard" pane
    And I select "true" from the "Past Medical History" radio list in the "Popout Note Wizard" pane
    And I enter "Headache disorder" in the "Diagnosis Search" field in the "PopOut History Dx Search" pane
    And I select the "Headache disorder" codedescription in the Diagnoses search list in the "PopOut History Dx Search" pane
    Then the following text should appear in the "Popout Note Wizard" pane
      |Headache disorder |
    And I enter "%2 days from now MMDDYY%" in the "Headache Onset Date" field in the "Popout Note Wizard" pane
    And I click the "Headache Calendar" image in the "Popout Note Wizard" pane
    And I click the "Current Month" element in the "Calendar" pane
    And I click the "Today's Date" element in the "Calendar" pane
    And I select "true" from the "Past Surgical History" radio list in the "Popout Note Wizard" pane
    And I enter "Shoulder clicking" in the "Diagnosis Search" field in the "PopOut History Dx Search" pane
    And I select the "Shoulder clicking" codedescription in the Diagnoses search list in the "PopOut History Dx Search" pane
    Then the following text should appear in the "Popout Note Wizard" pane
      |Shoulder clicking |
    And I enter "%2 days from now MMDDYY%" in the "ShoulderOnsetDate" field in the "Popout Note Wizard" pane
    And I click the "Shoulder Calendar" image in the "Popout Note Wizard" pane
    And I click the "Current Month" element in the "Calendar" pane
    And I click the "Today's Date" element in the "Calendar" pane
    And I save the HCA note template as draft
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I click the "OK" button in the "Question" pane if it exists
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |These are diagnosis history comments         |
      |Headache                                     |
      |Shoulder clicking                            |

  Scenario: 5. Verify the Diagnosis Picker - A/P section
    #Test case : 05 - Diagnosis Picker - AP
    And I select "Clinical Notes" from clinical navigation
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I wait "5" seconds
    And I click the "Edit" button
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I wait "5" seconds
    And I select the note "Diagnosis Picker - A/P" section in the "Popout Wizard" pane
    And I click the "Add Problem" button in the "Popout Note Wizard" pane if it exists
    And I enter "Knee" in the "Diagnosis Search" field in the "PopOut AP Dx Search" pane
    And I select the "Knee clicking" codedescription in the Diagnoses search list in the "PopOut AP Dx Search" pane
    Then the following text should appear in the "Popout Note Wizard" pane
      |Knee clicking |
    Then the following fields should display in the "Popout Note Wizard" pane
      |Name                              | Type         |
      |KneeProblemPlan                   | text         |
    And I enter "knee pain and swelling" in the "Knee Problem Plan" field in the "Popout Note Wizard" pane
    And I enter "Toe anomaly" in the "Diagnosis Search" field in the "PopOut AP Dx Search" pane
    And I select the "Toe anomaly" codedescription in the Diagnoses search list in the "PopOut AP Dx Search" pane
    Then the following text should appear in the "Popout Note Wizard" pane
      |Toe anomaly |
    Then the following fields should display in the "Popout Note Wizard" pane
      |Name                              | Type         |
      |ToeProblemPlan                    | text         |
    And I enter "toe infection" in the "Toe Problem Plan" field in the "Popout Note Wizard" pane
    And I enter "knee and toe abrasion" in the "AP Additional Comments" field in the "Popout Note Wizard" pane
    And I save the HCA note template as draft
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I click the "OK" button in the "Question" pane if it exists
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |knee pain and swelling   |
      |toe infection            |
      |knee and toe abrasion    |

  Scenario: 6. Verify the Hospital course section
    #Test case : 06 - Hospital Course
    And I select "Clinical Notes" from clinical navigation
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I wait "5" seconds
    And I click the "Edit" button
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I wait "5" seconds
    And I select the note "Hospital Course" section in the "Popout Wizard" pane
    When I click the "HospitalCourseABC" element in the "Popout Note Wizard" pane
#    And I click on the text "hosp qt" in the "ClickToInsertV2" pane
    And I mouse over and click the "hosp qt" linktext in the "Popout Note Wizard" pane
    Then the following text should appear in the "Popout Note Wizard" pane
      |quick text for hospital course   |
    And I click the "Quick Text Close" button in the "Popout Note Wizard" pane if it exists
    And I enter "manually entered text for hospital course field" in the "Hospital Course QTV2" rich text field in the "Popout Note Wizard" pane
    And I save the HCA note template as draft
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I click the "OK" button in the "Question" pane if it exists
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |manually entered text for hospital course field |
      |quick text for hospital course                  |

    #TODO : blocking due to https://jira/browse/DEV-70265 - Clinical Notes filter popup and warning message should appear on the Undock Note.
  Scenario: 7. Verify the Attestation section
    #Test case : 07 - Attestation
    And I select "Clinical Notes" from clinical navigation
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I wait "5" seconds
    And I click the "Edit" button
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I wait "5" seconds
    And I select the note "Attestation" section in the "Popout Wizard" pane
    And I check the "Counseling" checkbox in the "Popout Note Wizard" pane
    Then the following fields should display in the "Popout Note Wizard" pane
      |Name                  | Type     |
      |TimeSpentCounseling   | text     |
    And I enter "abcd" in the "TimeSpentCounseling" field in the "Popout Note Wizard" pane
    And I click the "TAB" key in the "TimeSpentCounseling" rich text field in the "Popout Note Wizard" pane
    And I wait up to "5" seconds for the "OK" field of type "BUTTON" in the "WarningMessage" pane to be clickable
    Then the "Warning Message" pane should appear with the text "Invalid number. Entered value must be a number."
#    Then A warning message should appear with the text "Invalid number. Entered value must be a number." in "WarningMessage" pane
    And I click the "OK" button in the "Warning Message" pane
    And I enter "20" in the "Time Spent Counseling" field in the "Popout Note Wizard" pane
    And I check the "Examined Patient" checkbox in the "Popout Note Wizard" pane
    And I enter "Additional attestation details for the patient." in the "Attestation Detail" field in the "Popout Note Wizard" pane
    When I click the "Additional Attestation ABC" element in the "Popout Note Wizard" pane
    And I click on the text "attest" in the "Popout Note Wizard" pane
    Then the following text should appear in the "Popout Note Wizard" pane
      |attesting the patient based on counselling   |
    And I click the "Quick Text Close" button in the "Popout Note Wizard" pane
    And I save the HCA note template as draft
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I click the "OK" button in the "Question" pane if it exists
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      |Counseling                                                                                |
      |20 minutes                                                                                |
      |I have seen and examined this patient                                                     |
      |Additional attestation details for the patient.attesting the patient based on counselling |

  Scenario: 8. Verify note details after sign and submitting the note
    #Test case : 08 - Sign and Submit note - Note Detail Data verification
    And I select "Clinical Notes" from clinical navigation
    When I select "*DRAFT* HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I wait "5" seconds
    And I click the "Edit" button
    And I wait "5" seconds
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I select the note "Miscellaneous Fields" section in the "Popout Wizard" pane
    And I enter "submitting draft note" in the "Chief Complaint" field in the "Popout Note Wizard" pane
    And I click the "NoteWriter Sign/Submit" button in the "PopoutWizard" pane
    And I wait "5" seconds
    And I click the "OK" button
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I click the "OK" button in the "Question" pane if it exists
    When I select "HCA Note " from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the following text should appear in the "Note Details" pane
      | submitting draft note                                                                                                                                 |
      | quick text for patient narrative hca field                                                                                                            |
      | LEVEL3, HCA3                                                                                                                                          |
      | Chain Smoker                                                                                                                                          |
      | occasional                                                                                                                                            |
      | rarely                                                                                                                                                |
      | Living Together                                                                                                                                       |
      | Limited Interventions                                                                                                                                 |
      | Negative for fever, malaise, fatigue.                                                                                                                 |
      | itching sensation and watery eyes                                                                                                                     |
      | Negative for sore throat. No otalgia. No rhinorrhea.                                                                                                  |
      | Negative for change in shape, swelling, masses, nipple discharge, pain, skin changes.                                                                 |
      | Negative for dyspnea or wheeze. No cough.                                                                                                             |
      | Negative for chest pain or palpitations. No extremity swelling.                                                                                       |
      | Negative for abdominal pain or nausea. No emesis. No diarrhea.                                                                                        |
      | Negative for dysuria, frequency, or urgency. No gross hematuria.                                                                                      |
      | Negative for joint stiffness, pain, or arthralgias.                                                                                                   |
      | Negative for rashes. No pruritus.                                                                                                                     |
      | Negative for headache. No vertigo. Denies paresthesias.                                                                                               |
      | Negative for specific complaints.                                                                                                                     |
      | Negative for cold intolerance, heat intolerance, polyphagia, polydipsia, polyuria, weight change, fatigue.                                            |
      | Negative for excessive bleeding, unusual masses.                                                                                                      |
      | other comments                                                                                                                                        |
      | Well developed, well nourished, in no apparent distress.                                                                                              |
      | minor trauma and swelling                                                                                                                             |
      | PERRL, EOM intact, conjunctiva and sclera clear, without nystagmus, lids normal.                                                                      |
      | TM's intact and clear, normal canals, grossly normal hearing.                                                                                         |
      | No deformity, no discharge, no inflammation, no lesions.                                                                                              |
      | Oropharynx without deformities or lesions, normal mucosa..                                                                                            |
      | No masses, no thyromegaly, no abnormal cervical nodes, trachea midline.                                                                               |
      | Grossly normal appearance.                                                                                                                            |
      | No masses, no gynecomastia noted.                                                                                                                     |
      | Clear bilaterally with normal respiratory effort.                                                                                                     |
      | Regular rate and rhythm, normal S1, S2, no murmurs, no rubs, no gallops, no clicks.                                                                   |
      | Soft, non-tender, no organomegaly, no masses noted.                                                                                                   |
      | No deformity, no scoliosis noted of thoracic or lumbar spine, joint ROM grossly normal, normal gait and station.                                      |
      | No clubbing, no cyanosis, no edema.                                                                                                                   |
      | No focal deficits, cranial nerves II-XII grossly intact, normal sensation, normal reflexes, normal coordination, normal muscle strength, normal tone. |
      | Pulses normal in all extremities.                                                                                                                     |
      | Normal rectal tone, no masses.                                                                                                                        |
      | Normal external genitalia.                                                                                                                            |
      | Intact without significant lesions, or rashes.                                                                                                        |
      | No significant cervical node adenopathy. No significant axillary node adenopathy. No significant inguinal node adenopathy.                            |
      | These are diagnosis history comments                                                                                                                  |
      | Headache                                                                                                                                              |
      | Shoulder clicking                                                                                                                                     |
      | knee pain and swelling                                                                                                                                |
      | toe infection                                                                                                                                         |
      | knee and toe abrasion                                                                                                                                 |
      | manually entered text for hospital course field                                                                                                       |
      | quick text for hospital course                                                                                                                        |
      | Counseling                                                                                                                                            |
      | 20 minutes                                                                                                                                            |
      | I have seen and examined this patient                                                                                                                 |
      | Additional attestation details for the patient.attesting the patient based on counselling                                                             |

  Scenario: Disable Quick text V2
    Given I am logged into the portal with user "nwadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "false" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
    And I select "false" from the "Enable Spell Check" radio list in the "Note Writer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box

