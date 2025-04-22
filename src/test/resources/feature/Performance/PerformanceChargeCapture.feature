@Performance @OneWindow_Performance
Feature: Performance Charge Capture test

  @Performance @CCPerformance @OneWindow_Performance @OneWindow_CCPerformance
  Scenario Outline: Diagnosis Search through Add Charge
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    ##Given "<Patient>", admitted in the past "201" days, is on the patient list
    When I select patient "<Patient>" from the patient list
    And I select "Charges" from clinical navigation
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I enter the ICD-10 codes "R51"
    Then the text "R51" should appear in the "Charge Entry" pane
    And I click the "Close" image

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


  @Performance @CCPerformance @OneWindow_Performance @OneWindow_CCPerformance
  Scenario: Patient Charge Status
    Given I am logged into the portal with the default user
    Given I am on the "Charges" tab
    And I select the "Patient Charge Status" subtab
    And the following subtabs should load
    |Patient Charge Status|
    And I select "My Patients" from the "Patient Charge Status" menu
    And I select "Automation Perf Test" from the "Patient List" menu
    Then the "Patient Charge Status" table should have at least "1" rows


  @Performance @CCPerformance @OneWindow_Performance @OneWindow_CCPerformance
  Scenario: Diagnosis Search through Patient Charge Status
    Given I am logged into the portal with the default user
    Given I am on the "Charges" tab
    And I select the "Patient Charge Status" subtab
    And the following subtabs should load
      |Patient Charge Status|
    And I select "My Patients" from the "Patient Charge Status" menu
    And I select "Automation Perf Test" from the "Patient List" menu
    Then the "Patient Charge Status" table should have at least "1" rows
    Then I click the "Add" link if it exists in the "Patient Charge Status" pane
    And I enter the ICD-10 codes "R51"
    Then the text "R51" should appear in the "Charge Entry" pane
    And I click the "Close" image

  @Performance @CCPerformance @OneWindow_Performance @OneWindow_CCPerformance
  Scenario Outline: Save charges
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    ##Given "<Patient>", admitted in the past "201" days, is on the patient list
    When I select patient "<Patient>" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value     |
      |Bill Area    |Adult Unit|
      |Svc Site     |Inpatient |
    And I enter the ICD-10 code "I25.10"
    And I enter the CPT code "99241"
    And I click the "Submit" button

    Examples:
      | Patient             |
      | PATIENT1, MEDREC    |
      | PATIENT2, MEDREC    |
      | PATIENT3, MEDREC    |
      | PATIENT4, MEDREC    |
      | PATIENT5, MEDREC    |
      | PATIENT7, MEDREC    |
      | PATIENT8, MEDREC    |
      | PATIENT9, MEDREC    |

  @Performance @CCPerformance @OneWindow_Performance @OneWindow_CCPerformance
  Scenario: Submit batch charges for charge routing
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    Given I am on the "Charges" tab
    When I select the "Outbox" subtab
    And I click the "Outbox Refresh" image
    #And I select "All Departments" from the "Outbox Department" dropdown
    And I check the "Adult Unit" checkbox
    And I click the "Commit" button