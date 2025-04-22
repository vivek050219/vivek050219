@Performance @OneWindow_Performance
Feature: Performance Clincals test
  @Performance @ClinicalsPerformance @OneWindow_Performance @OneWindow_ClinicalsPerformance
  Scenario Outline: Open Labs
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    When I select "Lab Results" from clinical navigation
    And I select "Expanded Panels" from the "LabResultsView" menu
    And I select "the first item" in the "Lab Panels" table
  #Then I select "Last 5 Years" from the "ClinicalTimeframe" menu
  #Removed this filter in 8.1.14.21
    And I select "the first item" in the "Lab Panels" table
    And I select "the first item" from the "the first" column in the "Panel Table Subject" table

    Examples:
      | Patient             |
      | PATIENT1, CLINICAL  |
      | PATIENT2, CLINICAL  |
      | PATIENT4, CLINICAL  |
      | PATIENT6, CLINICAL  |
      | PATIENT8, CLINICAL  |
      | PATIENT9, CLINICAL  |
      | PATIENT13, CLINICAL |
      | PATIENT18, CLINICAL |
      | PATIENT19, CLINICAL |
      | PATIENT21, CLINICAL |



  @Performance @ClinicalsPerformance @OneWindow_Performance @OneWindow_ClinicalsPerformance
  Scenario Outline: Open Visits
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    And I click the "Logo" element
    When I select "Visits" from clinical navigation
    And I select "the first item" in the "Visits" table
    Then I select "Last 5 Years" from the "ClinicalTimeframe" menu
    And I select "the first item" in the "Visits" table

    Examples:
      | Patient             |
      | PATIENT5, CLINICAL  |
      | PATIENT7, CLINICAL  |
      | PATIENT18, CLINICAL |
      | PATIENT13, CLINICAL |
      | PATIENT10, CLINICAL |
      | PATIENT17, CLINICAL |
      | PATIENT11, CLINICAL |
      | PATIENT20, CLINICAL |
      | PATIENT23, CLINICAL |
      | PATIENT14, CLINICAL |


  @Performance @ClinicalsPerformance @OneWindow_Performance @OneWindow_ClinicalsPerformance
  Scenario Outline: Open Patient Details
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    And I select "Patient Detail" from clinical navigation
    Then the "Patient Detail" pane should load

    Examples:
      | Patient             |
      | PATIENT3, CLINICAL  |
      | PATIENT7, CLINICAL  |
      | PATIENT10, CLINICAL |
      | PATIENT11, CLINICAL |
      | PATIENT12, CLINICAL |
      | PATIENT14, CLINICAL |
      | PATIENT15, CLINICAL |
      | PATIENT16, CLINICAL |
      | PATIENT17, CLINICAL |
      | PATIENT20, CLINICAL |


  @Performance @ClinicalsPerformance @OneWindow_Performance @OneWindow_ClinicalsPerformance
  Scenario Outline: Open New Results
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    And I select "New Results" from clinical navigation
    And I select "the first item" in the "Patient Summary" table
    Then I select "Last 5 Years" from the "ClinicalTimeframe" menu
    And I select "the first item" in the "Patient Summary" table

    Examples:
      | Patient             |
      | PATIENT3, CLINICAL  |
      | PATIENT7, CLINICAL  |
      | PATIENT10, CLINICAL |
      | PATIENT11, CLINICAL |
      | PATIENT12, CLINICAL |
      | PATIENT14, CLINICAL |
      | PATIENT15, CLINICAL |
      | PATIENT16, CLINICAL |
      | PATIENT17, CLINICAL |
      | PATIENT20, CLINICAL |


  @Performance @ClinicalsPerformance @OneWindow_Performance @OneWindow_ClinicalsPerformance
  Scenario Outline: Open Allergies
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    And I click the "Logo" element
    When I select "Allergies" from clinical navigation
    And I select "the first item" in the "Allergies" table
    Then I select "Last 5 Years" from the "ClinicalTimeframe" menu
    And I select "the first item" in the "Allergies" table

    Examples:
      | Patient             |
      | PATIENT26, CLINICAL |
      | PATIENT27, CLINICAL |
      | PATIENT28, CLINICAL |
      | PATIENT23, CLINICAL |
      | PATIENT13, CLINICAL |
      | PATIENT23, CLINICAL |
      | PATIENT8, CLINICAL  |
      | PATIENT6, CLINICAL  |
      | PATIENT4, CLINICAL  |
      | PATIENT26, CLINICAL |


  @Performance @ClinicalsPerformance @OneWindow_Performance @OneWindow_ClinicalsPerformance
  Scenario Outline: Open Clinical Notes
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    And I click the "Logo" element
    When I select "Clinical Notes" from clinical navigation
    And I select "the first item" in the "ClinicalNotes" table
    #Then I select "Last 5 Years" from the "ClinicalTimeframe" menu
    #Filter removed in 8.1.14.21
    And I select "the first item" in the "ClinicalNotes" table

    Examples:
      | Patient             |
      | PATIENT1, CLINICAL  |
      | PATIENT4, CLINICAL  |
      | PATIENT5, CLINICAL  |
      | PATIENT7, CLINICAL  |
      | PATIENT12, CLINICAL |
      | PATIENT14, CLINICAL |
      | PATIENT16, CLINICAL |
      | PATIENT19, CLINICAL |
      | PATIENT20, CLINICAL |
      | PATIENT24, CLINICAL |


  @Performance @ClinicalsPerformance @OneWindow_Performance @OneWindow_ClinicalsPerformance
  Scenario Outline: Open Medications
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    And I click the "Logo" element
    When I select "Medications" from clinical navigation
    And I select "the first item" in the "Medication Orders QOL" table
    And I select "Tomorrow" from the "Future Order Date" dropdown in the "Medications" pane
    And I select "the first item" in the "Medication Orders QOL" table
    And I select "Last Year" from the "Past Order Date" dropdown in the "Medications" pane
    And I select "the first item" in the "Medication Orders QOL" table

    Examples:
      | Patient             |
      | PATIENT1, CLINICAL  |
      | PATIENT6, CLINICAL  |
      | PATIENT8, CLINICAL  |
      | PATIENT9, CLINICAL  |
      | PATIENT12, CLINICAL |
      | PATIENT16, CLINICAL |
      | PATIENT22, CLINICAL |
      | PATIENT14, CLINICAL |
      | PATIENT23, CLINICAL |
      | PATIENT18, CLINICAL |


  @Performance @ClinicalsPerformance @OneWindow_Performance @OneWindow_ClinicalsPerformance
  Scenario Outline: Open Orders
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    And I select "Orders" from clinical navigation
    And the "Orders" table should load
    #And I select "the first item" in the "Orders" table
    And I select "Last Month" from the "Past Order Date" dropdown
    And I select "the first item" in the "Orders" table
    And I select "All Future" from the "Future Order Date" dropdown
    And I select "the first item" in the "Orders" table

    Examples:
      | Patient             |
      | PATIENT1, CLINICAL  |
      | PATIENT8, CLINICAL  |
      | PATIENT9, CLINICAL  |
      | PATIENT13, CLINICAL |
      | PATIENT15, CLINICAL |
      | PATIENT5, CLINICAL  |
      | PATIENT4, CLINICAL  |
      | PATIENT21, CLINICAL |
      | PATIENT17, CLINICAL |
      | PATIENT25, CLINICAL |

  @Performance @ClinicalsPerformance @OneWindow_Performance @OneWindow_ClinicalsPerformance
  Scenario Outline: Open Problems
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    And I click the "Logo" element
    When I select "Problems" from clinical navigation
    And I select "the first item" in the "Problem List" table
    Then I select "Last 5 Years" from the "ClinicalTimeframe" menu
    And I select "the first item" in the "Problem List" table

    Examples:
      | Patient             |
      | PATIENT3, CLINICAL  |
      | PATIENT11, CLINICAL |
      | PATIENT9, CLINICAL  |
      | PATIENT13, CLINICAL |
      | PATIENT15, CLINICAL |
      | PATIENT16, CLINICAL |
      | PATIENT19, CLINICAL |
      | PATIENT21, CLINICAL |
      | PATIENT24, CLINICAL |
      | PATIENT25, CLINICAL |


  @Performance @ClinicalsPerformance @OneWindow_Performance @OneWindow_ClinicalsPerformance
  Scenario Outline: Open Test Results
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    And I click the "Logo" element
    When I select "Test Results" from clinical navigation
    And I select "the first item" in the "Test Results" table
    Then I select "Last 5 Years" from the "ClinicalTimeframe" menu
    And I select "the first item" in the "Test Results" table

    Examples:
      | Patient             |
      | PATIENT1, CLINICAL  |
      | PATIENT3, CLINICAL  |
      | PATIENT5, CLINICAL  |
      | PATIENT7, CLINICAL  |
      | PATIENT8, CLINICAL  |
      | PATIENT10, CLINICAL |
      | PATIENT12, CLINICAL |
      | PATIENT13, CLINICAL |
      | PATIENT18, CLINICAL |
      | PATIENT22, CLINICAL |


  @Performance @ClinicalsPerformance @OneWindow_Performance @OneWindow_ClinicalsPerformance
  Scenario Outline: Open Vital Signs
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    When I select "Vitals" from clinical navigation
    #"Display at most" auto-populates a value of 7 when cleared.  Step below sets field to "97".
    And I enter "9" in the "Display at most" field
    When I refresh the clinical display
    And I select "the first item" in the "Vital Signs" table
    Then I select "Last 5 Years" from the "ClinicalTimeframe" menu
    And I select "the first item" in the "Vital Signs" table

    Examples:
      | Patient             |
      | PATIENT1, CLINICAL  |
      | PATIENT3, CLINICAL  |
      | PATIENT4, CLINICAL  |
      | PATIENT8, CLINICAL  |
      | PATIENT9, CLINICAL  |
      | PATIENT12, CLINICAL |
      | PATIENT16, CLINICAL |
      | PATIENT17, CLINICAL |
      | PATIENT18, CLINICAL |
      | PATIENT19, CLINICAL |


  @Performance @ClinicalsPerformance @OneWindow_Performance @OneWindow_ClinicalsPerformance
  Scenario Outline: Open I/O
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    When I select "I/O" from clinical navigation
    And the "I/O Table Data" table should load
    Then I select "Last 5 Years" from the "ClinicalTimeframe" menu
    And the "I/O Table Data" table should load

    Examples:
      | Patient             |
      | PATIENT14, CLINICAL |
      | PATIENT4, CLINICAL  |
      | PATIENT7, CLINICAL  |
      | PATIENT17, CLINICAL |
      | PATIENT13, CLINICAL |
      | PATIENT16, CLINICAL |
      | PATIENT18, CLINICAL |
      | PATIENT20, CLINICAL |
      | PATIENT19, CLINICAL |
      | PATIENT23, CLINICAL |


  @Performance @ClinicalsPerformance @OneWindow_Performance @OneWindow_ClinicalsPerformance
  Scenario Outline: Open Charges
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    When I select "Charges" from clinical navigation
    And I select "the first item" from the "the first" column in the "Charges" table
    And I "uncheck" the following
      | Show Visits |
    And I select "the first item" in the "Charges" table
    Then I select "Last 5 Years" from the "ClinicalTimeframe" menu
    And I select "the first item" in the "Charges" table

    Examples:
      | Patient             |
      | PATIENT3, CLINICAL  |
      | PATIENT11, CLINICAL |
      | PATIENT9, CLINICAL  |
      | PATIENT13, CLINICAL |
      | PATIENT15, CLINICAL |
      | PATIENT16, CLINICAL |
      | PATIENT19, CLINICAL |
      | PATIENT21, CLINICAL |
      | PATIENT24, CLINICAL |
      | PATIENT25, CLINICAL |

  @Performance @ClinicalsPerformance
  Scenario Outline: DEV-34848 Lab results that changes from expanded panels to Component table
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    And I select patient "<Patient>" from the patient list
    When I select "Lab Results" from clinical navigation
    And I select "Component Table" from the "LabResultsView" menu
    Then I select "Last 5 Years" from the "ClinicalTimeframe" menu
    Then the "LabComponentTable" table should load
    When I click the "ComponentUnfiled" element in the row with text "CORRECTED PCO2" in the "LabComponentTable" table
    And I select "Expanded Panels" from the "LabResultsView" menu
    And I select "the first item" in the "Lab panels" table


    Examples:
      | Patient             |
      | PATIENT1, CLINICAL  |
      | PATIENT10, CLINICAL |
      | PATIENT11, CLINICAL |