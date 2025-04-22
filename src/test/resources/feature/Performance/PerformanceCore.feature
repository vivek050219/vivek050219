@Performance @OneWindow_Performance
Feature: Performance Core test

  @Performance @CorePerformance @OneWindow_Performance @OneWindow_CorePerformance
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
      | Smith    |

  #TODO: for more search criteria
  @Performance @CorePerformance @OneWindow_Performance @OneWindow_CorePerformance
  Scenario: Loading of the Patient Search Results pane
    Given I am logged into the portal with the default user
    And I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I "check" the following
      | Include Cancelled Visits |
    And I "check" the following
      | Include Past Visits |
    And I fill in the following fields
      | Name  | Type | Value |
      | Last  | text | Smith |
      | First | text | JULIA |
    And I select "Display 100 Results" from the "Max Search Results" dropdown
    And I click the "Search for Visits" button
    And I select "the first item" in the "Visit Search Results" table
#    And I select patient "Molly Darr" from the "Name (\d+)" column in the "Visit Search Results" table


  @Performance @CorePerformance @OneWindow_Performance @OneWindow_CorePerformance
  Scenario: Patient List Search by list
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    When I select "Find a Patient List" from the "Actions" menu
    And I enter "Follow" in the "Patient List Search" field
    And I wait "5" seconds
    And I select "the first item" from the "the first" column in the "Patient List Search Results" table
    And I click the "Close Search For PatientList" button


  @Performance @CorePerformance @OneWindow_Performance @OneWindow_CorePerformance
  Scenario: Patient List Search by provider
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    When I select "Find a Patient List" from the "Actions" menu
    And I enter "Perry" in the "Patient List Search" field
    And I wait "5" seconds
    And I select "the first item" from the "the first" column in the "Patient List Search Results" table
    And I click the "Close Search For PatientList" button


  @Performance @CorePerformance @OneWindow_Performance @OneWindow_CorePerformance
  Scenario: Patient List Search by department
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    When I select "Find a Patient List" from the "Actions" menu
    And I select "CPC Hospitalists" from the "Patient List Search Department" dropdown
    And I click the "Search Patient List" button
    And I select "the first item" from the "the first" column in the "Patient List Search Results" table
    And I click the "Close Search For PatientList" button

