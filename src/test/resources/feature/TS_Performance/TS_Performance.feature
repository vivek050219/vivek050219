Feature: Performance test

  @TS_Performance @TS_ClinicalsPerformance
  Scenario Outline: Open Labs
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Lab List" from the "Patient List" menu
    And I select patient at index "<Index>" from the patient list
    When I select "Lab Results" from clinical navigation
    And I select "Expanded Panels" from the "Lab Results View" menu
   # And I select "the first item" in the "Lab Panels" table
   # And I select "the first item" from the "the first" column in the "Panel Table Subject" table


    Examples:
      | Index |
      | 1     |
      | 2     |
      | 3     |
      | 4     |
      | 5     |
      | 6     |
      | 7     |
      | 8     |
      | 9     |
      | 10    |

  @TS_Performance @TS_ClinicalsPerformance
  Scenario Outline: Open Visits
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Visit List" from the "Patient List" menu
    And I select patient at index "<Index>" from the patient list
    When I select "Visits" from clinical navigation
#    And I select "the first item" in the "Visits" table
    Then I select "Last 5 Years" from the "ClinicalTimeframe" menu
    And I select "the first item" in the "Visits" table

    Examples:
      | Index |
      | 1     |
      | 2     |
      | 3     |
      | 4     |
      | 5     |
      | 6     |
      | 7     |
      | 8     |
      | 9     |
      | 10    |
      | 11    |
      | 12    |


  @TS_Performance @TS_ClinicalsPerformance
  Scenario Outline: Open Patient Details
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Clinical Viewing" from the "Patient List" menu
    And I select patient at index "<Index>" from the patient list
    And I select "Patient Detail" from clinical navigation
    Then the "Patient Detail" pane should load

    Examples:
      | Index |
      | 1     |
      | 2     |
      | 3     |
      | 4     |
      | 5     |
      | 6     |
      | 7     |
      | 8     |
      | 9     |
      | 10    |



  @TS_Performance @TS_ClinicalsPerformance
  Scenario Outline: Open Allergies
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Clinical Viewing" from the "Patient List" menu
    And I select patient at index "<Index>" from the patient list
    When I select "Allergies" from clinical navigation
#    And I select "the first item" in the "Allergies" table
    Then I select "Last 5 Years" from the "ClinicalTimeframe" menu
    And I select "the first item" in the "Allergies" table

    Examples:
      | Index |
      | 1     |
      | 2     |
      | 3     |
      | 4     |
      | 5     |


  @TS_Performance @TS_ClinicalsPerformance
  Scenario Outline: Open Clinical Notes
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Notes List" from the "Patient List" menu
    And I select patient at index "<Index>" from the patient list
    When I select "Clinical Notes" from clinical navigation
    And I select "the first item" in the "ClinicalNotes" table

    Examples:
      | Index |
      | 1     |
      | 2     |
      | 3     |
      | 4     |
      | 5     |
      | 6     |
      | 7     |
      | 8     |
      | 9     |
      | 10    |
      | 11    |
      | 12    |
      | 13    |
      | 14    |
      | 15    |
      | 16    |
      | 17    |
      | 18    |
      | 19    |
      | 20    |



  @TS_Performance @TS_ClinicalsPerformance
  Scenario Outline: Open Problems
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Clinical Viewing" from the "Patient List" menu
    And I select patient at index "<Index>" from the patient list
    When I select "Problems" from clinical navigation
#    And I select "the first item" in the "Problem List" table
    Then I select "Last 5 Years" from the "ClinicalTimeframe" menu
    And I select "the first item" in the "Problem List" table

    Examples:
      | Index |
      | 1     |
      | 2     |
      | 3     |
      | 4     |
      | 5     |


  @TS_Performance @TS_ClinicalsPerformance
  Scenario Outline: Open Test Results
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Clinical Viewing" from the "Patient List" menu
    And I select patient at index "<Index>" from the patient list
    When I select "Test Results" from clinical navigation
#    And I select "the first item" in the "Test Results" table
    Then I select "Last 5 Years" from the "ClinicalTimeframe" menu
    And I select "the first item" in the "Test Results" table

    Examples:
      | Index |
      | 1     |
      | 2     |
      | 3     |
      | 4     |
      | 5     |


  @TS_Performance @TS_ClinicalsPerformance
  Scenario Outline: Open Vital Signs
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Vital List" from the "Patient List" menu
    And I select patient at index "<Index>" from the patient list
    When I select "Vitals" from clinical navigation
#    And I select "the first item" in the "Vital Signs" table
    Then I select "Last 5 Years" from the "ClinicalTimeframe" menu
    And I select "the first item" in the "Vital Signs" table

    Examples:
      | Index |
      | 1     |
      | 2     |
      | 3     |
      | 4     |
      | 5     |
      | 6     |
      | 7     |
      | 8     |
      | 9     |
      | 10    |


  @TS_Performance @TS_ClinicalsPerformance
  Scenario Outline: Open I/O
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Clinical Viewing" from the "Patient List" menu
    And I select patient at index "<Index>" from the patient list
    When I select "I/O" from clinical navigation
#    And the "I/O Table Data" table should load
    Then I select "Last 5 Years" from the "ClinicalTimeframe" menu
#    And the "I/O Table Data" table should load

    Examples:
      | Index |
      | 1     |
      | 2     |
      | 3     |
      | 4     |
      | 5     |


  @TS_Performance @TS_ClinicalsPerformance
  Scenario Outline: Open Charges
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Charge List" from the "Patient List" menu
    And I select patient at index "<Index>" from the patient list
    When I select "Charges" from clinical navigation
    And I "uncheck" the following
      |Show Visits|
    And I select "the first item" in the "Charges" table
    Then I select "Last 5 Years" from the "ClinicalTimeframe" menu
    And I select "the first item" in the "Charges" table

    Examples:
      | Index |
      | 1     |
      | 2     |
      | 3     |
      | 4     |
      | 5     |
      | 6     |
      | 7     |
      | 8     |
      | 9     |
      | 10    |


  @TS_Performance @TS_ClinicalsPerformance
  Scenario Outline: Open Orders
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Order List" from the "Patient List" menu
    And I select patient at index "<Index>" from the patient list
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I select "Last Month" from the "Past Order Date" dropdown
    And I select "the first item" in the "Orders" table
    And I select "All Future" from the "Future Order Date" dropdown
    And I select "the first item" in the "Orders" table

    Examples:
      | Index |
      | 1     |
      | 2     |
      | 3     |
      | 4     |
      | 5     |
      | 6     |
      | 7     |
      | 8     |
      | 9     |
      | 10    |


  @TS_Performance
  Scenario Outline: Provider Search
    Given I am logged into the portal with the default user
    And I am on the "Admin" tab
    And I select the "System Management" subtab
    And I click the "Providers" link in the "System Management Navigation" pane
    And I enter "<Provider>" in the "Provider Name ID Alias" field
    And I click the "Search" button in the "Provider Main Search" pane
    And I select "the first item" in the "Provider Search Results" table

    Examples:
      | Provider |
      | Gupta    |


  @TS_Performance @TS_PatientSearchPerformance
  Scenario Outline: Loading of the Patient Search Results pane
    Given I am logged into the portal with the default user
    And I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I "check" the following
      |Include Cancelled Visits|
    And I "check" the following
      |Include Past Visits|
    And I fill in the following fields
      | Name | Type | Value   |
      | Last | text | <Patient> |
    And I select "Display 100 Results" from the "Max Search Results" dropdown
    And I click the "Search for Visits" button
    And I select "the first item" in the "Visit Search Results" table

    Examples:
      | Patient  |
      | Smith    |
      | AZPIAZU  |
      | JENKINS  |
      | JUCKETT  |
      | LIEBLA   |
      | MORRIS   |
      | PARRIS   |
      | PERDOMO  |
      | SCHWARTZ |
      | TRESCOTT |

  @TS_Performance @TS_CPOEPerformance
  Scenario Outline: CPOE Add First Order Set
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Order Set Entry" from the "Patient List" menu
    And I select patient at index "<Index>" from the patient list
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I click the "Enter Orders" button
    And I click the "OK" button if it exists
    And I click the "No" button in the "Question" pane if it exists
    When I enter "AM LABS" in the "Add Order" field in the "Enter Orders" pane
    And I select "AM LABS" from the "CPOE All Orders" list in the search results
    And I click the "CBC WITH DIFF  in AM Checkbox" element in the "Order Set Content" pane
#    And I click the "POTASSIUM  starting in AM Daily 0500 X 3" element in the "Order Set Content" pane
    And I click the "Done with Order Set" button
    And I click the "Sign/Submit" button in the "Order Submission" pane
    And I click the "Search" button
    Then I select "Alford" in the "Look Up" table
    And I click the "Look Up OK" button
    And I select "the first item" in the "Orders" table

    Examples:
      | Index |
      | 1     |
      | 2     |
      | 3     |
      | 4     |
      | 5     |
      | 6     |
      | 7     |
      | 8     |
      | 9     |
      | 10    |

  @TS_Performance @TS_CPOEPerformance
  Scenario Outline: CPOE Add Second Order Set
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Order Set Entry" from the "Patient List" menu
    And I select patient at index "<Index>" from the patient list
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I click the "Enter Orders" button
    And I click the "OK" button if it exists
    And I click the "No" button in the "Question" pane if it exists
    When I enter "GENERAL ADM MED/SURG" in the "Add Order" field in the "Enter Orders" pane
    And I select "GENERAL ADM MED/SURG" from the "CPOE All Orders" list in the search results
    And I click the "Done with Order Set" button
    And I click the "Sign/Submit" button in the "Order Submission" pane
    And I click the "Search" button
    Then I select "Alford" in the "Look Up" table
    And I click the "Look Up OK" button
    And I select "the first item" in the "Orders" table

    Examples:
      | Index |
      | 1     |
      | 2     |
      | 3     |
      | 4     |
      | 5     |
      | 6     |
      | 7     |
      | 8     |
      | 9     |
      | 10    |

  @TS_Performance @TS_CPOEPerformance
  Scenario Outline: CPOE Add Third Order Set
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Order Set Entry" from the "Patient List" menu
    And I select patient at index "<Index>" from the patient list
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I click the "Enter Orders" button
    And I click the "OK" button if it exists
    And I click the "No" button in the "Question" pane if it exists
    When I enter "PACU ADULT" in the "Add Order" field in the "Enter Orders" pane
    And I select "PACU ADULT" from the "CPOE All Orders" list in the search results
    And I click the "Done with Order Set" button
    And I click the "Sign/Submit" button in the "Order Submission" pane
    And I click the "Search" button
    Then I select "Alford" in the "Look Up" table
    And I click the "Look Up OK" button
    And I select "the first item" in the "Orders" table

    Examples:
      | Index |
      | 1     |
      | 2     |
      | 3     |
      | 4     |
      | 5     |
      | 6     |
      | 7     |
      | 8     |
      | 9     |
      | 10    |


  @TS_Performance_dontrun @TS_CPOEPerformance_dontrun
  Scenario Outline: CPOE Four Order Defs with pop-up detail
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Order Entry" from the "Patient List" menu
    And I select patient at index "<Index>" from the patient list
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I click the "Enter Orders" button
    And I click the "OK" button if it exists
    And I click the "No" button in the "Question" pane if it exists
    When I enter "ELECTROCARDIOGRAM 12 LEAD" in the "Add Order" field in the "Enter Orders" pane
    And I select "ELECTROCARDIOGRAM 12 LEAD" from the "CPOE All Orders" list in the search results
    And I select "Murmur" from the "Reason for Exam" dropdown
    And I click the "Enter Order OK" button in the "EnterOrders" pane
    Then I enter "CHANGE MD/TEAM" in the "Add Order" field in the "Enter Orders" pane
    And I select "CHANGE MD/TEAM" from the "CPOE All Orders" list in the search results
    And I click the "Search2" button
    Then I select "the first item" in the "Look Up" table
    And I select "B" from the "AssignToTeam" dropdown
    And I click the "Enter Order OK" button in the "EnterOrders" pane
    Then I enter "Diabetic Diet" in the "Add Order" field in the "Enter Orders" pane
    And I select "the first item" from the "CPOE All Orders" list in the search results
    And I select "1500 kCal" from the "Carb Consistent" dropdown
    And I click the "Enter Order OK" button in the "EnterOrders" pane
    Then I enter "Swallow Eval and Treat" in the "Add Order" field in the "Enter Orders" pane
    And I select "the first item" from the "CPOE All Orders" list in the search results
    And I enter "Automation Testing" in the "Precautions Special Instruct" field
    And I click the "Enter Order OK" button in the "EnterOrders" pane
    And I click the "Sign/Submit" button in the "Order Submission" pane
    And I click the "Search" button
    Then I select "Alford" in the "Look Up" table
    And I click the "Look Up OK" button
    And I select "the first item" in the "Orders" table

    Examples:
      | Index |
      | 1     |
      | 2     |
      | 3     |
      | 4     |
      | 5     |
      | 6     |
      | 7     |
      | 8     |
      | 9     |
      | 10    |




  @TS_Performance @TS_CPOEPerformance
  Scenario Outline: CPOE Add Order Entry without pop-up detail
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Order Entry" from the "Patient List" menu
    And I select patient at index "<Index>" from the patient list
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I click the "Enter Orders" button
    And I click the "OK" button if it exists
    And I click the "No" button in the "Question" pane if it exists
    When I enter "<Order Def>" in the "Add Order" field in the "Enter Orders" pane
    And I select CPOE "All" tab
    And I select "the first item" from the "CPOE All Orders" list in the search results
#    And I select "<Order Def>" from the "CPOE All Orders" list in the search results
    When I enter "<Order Def 2>" in the "Add Order" field in the "Enter Orders" pane
    And I select CPOE "All" tab
    And I select "the first item" from the "CPOE All Orders" list in the search results
#    And I select "<Order Def 2>" from the "CPOE All Orders" list in the search results
#    And I click the "Enter Order OK" button in the "EnterOrders" pane
    And I click the "Sign/Submit" button in the "Order Submission" pane
    And I click the "Search" button
    Then I select "Alford" in the "Look Up" table
    And I click the "Look Up OK" button
    And I select "the first item" in the "Orders" table

    Examples:
      | Index | Order Def                                           | Order Def 2                  |
      | 1     | BASIC METABOLIC PANEL                               | NS 500 ML 25 MLS/HR IV ASDIR |
      | 2     | CBC                                                 | BASIC METABOLIC PANEL        |
      | 3     | morphine Inj 2 MG IM ONCE                           | MAGNESIUM                    |
      | 4     | Acetaminophen Tab (Tylenol Tab) 325 MG PO ONCE      | PREALBUMIN                   |
      | 5     | Spironolactone Tab (Aldactone Tab) 12.5 MG PO DAILY | Regular Diet                 |
      | 6     | BASIC METABOLIC PANEL                               | NS 500 ML 25 MLS/HR IV ASDIR |
      | 7     | CBC                                                 | BASIC METABOLIC PANEL        |
      | 8     | morphine Inj 2 MG IM ONCE                           | MAGNESIUM                    |
      | 9     | Acetaminophen Tab (Tylenol Tab) 325 MG PO ONCE      | PREALBUMIN                   |
      | 10    | Spironolactone Tab (Aldactone Tab) 12.5 MG PO DAILY | Regular Diet                 |

  @TS_Performance @TS_CCPerformance
  Scenario Outline: Diagnosis Search through Add Charge
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Charge List" from the "Patient List" menu
    When I select patient at index "<Index>" from the patient list
    And I select "Charges" from clinical navigation
		    And I "uncheck" the following
      |Show Visits|
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the ICD-10 codes "R51"
    Then the text "R51" should appear in the "Charge Entry" pane
    And I click the "Close" image

    Examples:
      | Index |
      | 1     |
      | 2     |
      | 3     |
      | 4     |
      | 5     |
      | 6     |
      | 7     |
      | 8     |
      | 9     |
      | 10    |

  @TS_Performance @TS_NWPerformance
  Scenario Outline: Enter Four NoteWriter Notes with separate templates
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "NW entry" from the "Patient List" menu
    When I select patient at index "<Index>" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I click the "Clinical Notes Add" button
    And I wait "10" seconds
#    And I click the "Write A Note Expand" button if it exists
    And the "Write A Note" toggle is open
    And I enter "Cardiothoracic" in the "Template Search" field
    And I select "Cardiothoracic/Thoracic Surgery Progress Note" from the select template list
    And I select "Hospitalist" from the "Speciality" dropdown in the "NoteWriter Main" pane
    And I click the "NoteWriterSign/Submit" button in the "NoteWriter Main" pane
    And I click the "Look Up OK" button
    Then I select "the first item" in the "ClinicalNotes" table
    And I click the "Clinical Notes Add" button
    And I wait "2" seconds
    #And I select "Discharge Summary" from the select template list
    #And I select "Hospitalist" from the "Speciality" dropdown in the "NoteWriter Main" pane
    #And I click the "NoteWriterSign/Submit" button in the "NoteWriter Main" pane
    #And I click the "Look Up OK" button
    #Then I select "the first item" in the "ClinicalNotes" table
    #And I click the "Clinical Notes Add" button
#    And I click the "Write A Note Expand" button if it exists
    And the "Write A Note" toggle is open
    And I enter "Clinical" in the "Template Search" field
    And I wait "2" seconds
    And I select "Clinical Note" from the select template list
    And I wait "2" seconds
    And I select "Hospitalist" from the "Speciality" dropdown in the "NoteWriter Main" pane
    And I click the "NoteWriterSign/Submit" button in the "NoteWriter Main" pane
    And I click the "Look Up OK" button
    Then I select "the first item" in the "ClinicalNotes" table
    And I click the "Clinical Notes Add" button
    And I wait "2" seconds
#    And I click the "Write A Note Expand" button if it exists
    And the "Write A Note" toggle is open
    And I enter "Infectious" in the "Template Search" field
    And I wait "2" seconds
    And I select "Infectious Disease Progress Note" from the select template list
    And I wait "2" seconds
    And I select "Hospitalist" from the "Speciality" dropdown in the "NoteWriter Main" pane
    And I click the "NoteWriterSign/Submit" button in the "NoteWriter Main" pane
    And I click the "Look Up OK" button
    Then I select "the first item" in the "ClinicalNotes" table
    And I click the "Clinical Notes Add" button
    And I wait "2" seconds
#    And I click the "Write A Note Expand" button if it exists
    And the "Write A Note" toggle is open
    And I enter "Cardiology" in the "Template Search" field
    And I wait "2" seconds
    And I select "Cardiology Progress Note" from the select template list
    And I wait "2" seconds
    And I select "Hospitalist" from the "Speciality" dropdown in the "NoteWriter Main" pane
    And I click the "NoteWriterSign/Submit" button in the "NoteWriter Main" pane
    And I click the "Look Up OK" button
    Then I select "the first item" in the "ClinicalNotes" table
    And I click the "Clinical Notes Add" button
    And I wait "2" seconds
#    And I click the "Write A Note Expand" button if it exists
    And the "Write A Note" toggle is open
    And I enter "Pulmonary" in the "Template Search" field
    And I wait "2" seconds
    And I select "Pulmonary Progress Note" from the select template list
    And I wait "2" seconds
    And I select "Hospitalist" from the "Speciality" dropdown in the "NoteWriter Main" pane
    And I click the "NoteWriterSign/Submit" button in the "NoteWriter Main" pane
    And I click the "Look Up OK" button
    Then I select "the first item" in the "ClinicalNotes" table
    And I click the "Clinical Notes Add" button
    And I wait "2" seconds
#    And I click the "Write A Note Expand" button if it exists
    And the "Write A Note" toggle is open
    And I enter "ICU" in the "Template Search" field
    And I wait "2" seconds
    And I select "ICU Progress Note" from the select template list
    And I wait "2" seconds
    And I select "Hospitalist" from the "Speciality" dropdown in the "NoteWriter Main" pane
    And I click the "NoteWriterSign/Submit" button in the "NoteWriter Main" pane
    And I click the "Look Up OK" button
    Then I select "the first item" in the "ClinicalNotes" table
    And I click the "Clinical Notes Add" button
    And I wait "2" seconds
#    And I click the "Write A Note Expand" button if it exists
    And the "Write A Note" toggle is open
    And I enter "Consult" in the "Template Search" field
    And I wait "2" seconds
    And I select "Consult Note" from the select template list
    And I wait "2" seconds
    And I select "Hospitalist" from the "Speciality" dropdown in the "NoteWriter Main" pane
    And I click the "NoteWriterSign/Submit" button in the "NoteWriter Main" pane
    And I click the "Look Up OK" button
    And I click the "Clinical Notes Add" button
    And I wait "2" seconds
#    And I click the "Write A Note Expand" button if it exists
    And the "Write A Note" toggle is open
    And I enter "Progress" in the "Template Search" field
    And I wait "2" seconds
    And I select "Progress Note" from the select template list
    And I wait "2" seconds
    And I select "Hospitalist" from the "Speciality" dropdown in the "NoteWriter Main" pane
    And I wait "2" seconds
    And I click the "NoteWriterSign/Submit" button in the "NoteWriter Main" pane
    And I click the "Search" button
    Then I select "Anderson" in the "Look Up" table
    And I click the "Look Up OK" button

    Examples:
      | Index |
      | 1     |
      | 2     |
      | 3     |
      | 4     |
      | 5     |
      | 6     |
      | 7     |
      | 8     |
      | 9     |
      | 10    |
      | 11    |
      | 12    |
      | 13    |
      | 14    |
      | 15    |
      | 16    |
      | 17    |
      | 18    |
      | 19    |
      | 20    |
      | 21    |
      | 22    |
      | 23    |
      | 24    |
      | 25    |


	  
  @TS_Performance @TS_CCPerformance
  Scenario: Patient Charge Status
    Given I am logged into the portal with the default user
    Given I am on the "Charges" tab
    And I select the "Patient Charge Status" subtab
    And I select "Clinical Viewing" from the "Patient List" menu
    Then the "Patient Charge Status" table should have at least "1" rows


  @TS_Performance
  Scenario: Patient List Search by list
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    When I select "Find a Patient List" from the "Actions" menu
    And I enter "Follow" in the "Patient List Search" field