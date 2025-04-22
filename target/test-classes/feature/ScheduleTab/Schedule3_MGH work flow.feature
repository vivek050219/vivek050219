@Schedule
Feature: MGH work flow

  Background:

  Scenario Outline: Validate charges by login as jones for scheduling access set to user
    Given I am logged into the portal with user "scadmin" and password "123"
    When I am on the "Admin" tab
    And I open "Patient List" settings page for the user "<UserName>"
    And I edit the following user settings and I click save
      |Page             |Name                       |Type     |Value            |
      |Patient List     |Scheduling Access          |dropdown |User             |
      |Charge Capture   |Charge Desktop View Access |dropdown |No Other Charges |
      |User Permissions |CanEditOtherUsersCharges   |radio    |<value1>         |
    Given I am logged into the portal with user "<UserName>" and password "123"
    And I am on the "Schedule" tab
    Then the "Schedule" pane should load
    And I wait "3" seconds
    When I click the "ClearCriteria" button in the "SearchCriteria" pane
    And I click the "Delete Entry" image in the "Provider Search" pane
    And I select "Today" from the "Date Filter" menu
    And I enter "JONES, DOCTOR" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-1, TEST |
      |SCHEDULE-2, TEST |
      |SCHEDULE-3, TEST |
      |SCHEDULE-6, TEST |
    And the charge should be editable for the "SCHEDULE-1, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-3, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-6, TEST" visit in the scheduled tab

    Examples:
      |UserName   |value1 |
      |drjones    |false  |
      |drjones    |yes    |

  Scenario Outline:  Validate charges by login as smith for scheduling access set to user
    Given I am logged into the portal with user "scadmin" and password "123"
    When I am on the "Admin" tab
    And I open "Patient List" settings page for the user "<UserName>"
    And I edit the following user settings and I click save
      |Page             |Name                       |Type     |Value            |
      |Patient List     |Scheduling Access          |dropdown |User             |
      |Charge Capture   |Charge Desktop View Access |dropdown |No Other Charges |
      |User Permissions |CanEditOtherUsersCharges   |radio    |<value1>         |
    Given I am logged into the portal with user "<UserName>" and password "123"
    And I am on the "Schedule" tab
    Then the "Schedule" pane should load
    And I wait "3" seconds
    When I click the "ClearCriteria" button in the "SearchCriteria" pane
    And I click the "Delete Entry" image in the "Provider Search" pane
    And I select "Today" from the "Date Filter" menu
    And I enter "SMITH, NURSE" in the "Providers" field
    And I click the "ProviderSearch" button in the "SearchCriteria" pane
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-4, TEST |
      |SCHEDULE-5, TEST |
    And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-5, TEST" visit in the scheduled tab

    Examples:
      |UserName   |value1 |
      |nursesmith |false  |
      |nursesmith |yes    |

  Scenario Outline: Pre-requisite to set scheduling access and user permissions
    Given I am logged into the portal with user "scadmin" and password "123"
    When I am on the "Admin" tab
    And I open "Patient List" settings page for the user "<UserName>"
    And I edit the following user settings and I click save
      |Page             |Name                       |Type     |Value       |
      |Patient List     |Scheduling Access          |dropdown |All         |
      |Charge Capture   |Charge Desktop View Access |dropdown |All Charges |
      |User Permissions |CanEditOtherUsersCharges   |radio    |false       |

    Examples:
      |UserName    |
      |drjones     |
      |nursesmith  |

  Scenario: Validate charges by login as jones for scheduling access set to all
    Given I am logged into the portal with user "drjones" and password "123"
    And I am on the "Schedule" tab
    Then the "Schedule" pane should load
    And I wait "3" seconds
    When I click the "ClearCriteria" button in the "SearchCriteria" pane
    And I select "Today" from the "Date Filter" menu
    And I select "Billing or Scheduled" from the "ProviderType" dropdown
    And I enter "JONES, DOCTOR" in the "Providers" field
    And I click the "ProviderSearch" button in the "SearchCriteria" pane
    And I enter "SMITH, NURSE" in the "Providers" field
    And I click the "ProviderSearch" button in the "SearchCriteria" pane
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-1, TEST |
      |SCHEDULE-2, TEST |
      |SCHEDULE-3, TEST |
      |SCHEDULE-4, TEST |
      |SCHEDULE-5, TEST |
      |SCHEDULE-6, TEST |
    And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-1, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-3, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be viewable for the "SCHEDULE-5, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-6, TEST" visit in the scheduled tab

  Scenario: Validate charges by login as smith for scheduling access set to all
    Given I am logged into the portal with user "nursesmith" and password "123"
    And I am on the "Schedule" tab
    Then the "Schedule" pane should load
    And I wait "3" seconds
    When I click the "ClearCriteria" button in the "SearchCriteria" pane
    And I select "Today" from the "Date Filter" menu
    And I select "Billing or Scheduled" from the "ProviderType" dropdown
    And I enter "JONES, DOCTOR" in the "Providers" field
    And I click the "ProviderSearch" button in the "SearchCriteria" pane
    And I enter "SMITH, NURSE" in the "Providers" field
    And I click the "ProviderSearch" button in the "SearchCriteria" pane
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-1, TEST |
      |SCHEDULE-2, TEST |
      |SCHEDULE-3, TEST |
      |SCHEDULE-4, TEST |
      |SCHEDULE-5, TEST |
      |SCHEDULE-6, TEST |
    And the charge should be viewable for the "SCHEDULE-1, TEST" visit in the scheduled tab
    And the charge should be viewable for the "SCHEDULE-3, TEST" visit in the scheduled tab
    And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-5, TEST" visit in the scheduled tab
    And the charge should be viewable for the "SCHEDULE-6, TEST" visit in the scheduled tab

  Scenario Outline: Validate charges by login as smith and jones for scheduling access set to department
    Given I am logged into the portal with user "scadmin" and password "123"
    When I am on the "Admin" tab
    And I open "Patient List" settings page for the user "<UserName>"
    And I edit the following user settings and I click save
      |Page             |Name                       |Type     |Value                        |
      |Patient List     |Scheduling Access          |dropdown |Department                   |
      |Charge Capture   |Charge Desktop View Access |dropdown |Within the User's Department |
      |User Permissions |CanEditOtherUsersCharges   |radio    |yes                          |
    Given I am logged into the portal with user "<UserName>" and password "123"
    And I am on the "Schedule" tab
    Then the "Schedule" pane should load
    And I wait "3" seconds
    When I click the "ClearCriteria" button in the "SearchCriteria" pane
    And I click the "Delete Entry" image in the "Provider Search" pane if it exists
    And I select "Today" from the "Date Filter" menu
    And I select "Billing or Scheduled" from the "ProviderType" dropdown
    And I enter "JONES, DOCTOR" in the "Providers" field
    And I click the "ProviderSearch" button in the "SearchCriteria" pane
    And I enter "SMITH, NURSE" in the "Providers" field
    And I click the "ProviderSearch" button in the "SearchCriteria" pane
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-1, TEST |
      |SCHEDULE-2, TEST |
      |SCHEDULE-3, TEST |
      |SCHEDULE-4, TEST |
      |SCHEDULE-5, TEST |
      |SCHEDULE-6, TEST |
    And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-1, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-3, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-5, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-6, TEST" visit in the scheduled tab

    Examples:
      |UserName   |
      |drjones    |
      |nursesmith |

  Scenario Outline: Pre-requisite to set scheduling access set to all
    Given I am logged into the portal with user "scadmin" and password "123"
    When I am on the "Admin" tab
    And I open "Patient List" settings page for the user "<UserName>"
    And I edit the following user settings and I click save
      |Page             |Name                       |Type     |Value                        |
      |Patient List     |Scheduling Access          |dropdown |All                          |
      |Charge Capture   |Charge Desktop View Access |dropdown |Within the User's Department |
      |User Permissions |CanEditOtherUsersCharges   |radio    |false                        |

    Examples:
      |UserName   |
      |drjones    |
      |nursesmith |

  Scenario: Validate charges by login as jones for scheduling access set to all
    Given I am logged into the portal with user "drjones" and password "123"
    And I am on the "Schedule" tab
    When I click the "Clear Criteria" button in the "Search Criteria" pane
    And I select "Today" from the "Date Filter" menu
    And I select "Billing or Scheduled" from the "ProviderType" dropdown in the "Search Criteria" pane
    And I enter "JONES, DOCTOR" in the "Providers" field
    And I click the "ProviderSearch" button in the "SearchCriteria" pane
    And I enter "SMITH, NURSE" in the "Providers" field
    And I click the "ProviderSearch" button in the "SearchCriteria" pane
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-1, TEST |
      |SCHEDULE-2, TEST |
      |SCHEDULE-3, TEST |
      |SCHEDULE-4, TEST |
      |SCHEDULE-5, TEST |
      |SCHEDULE-6, TEST |
    And the charge should be editable for the "SCHEDULE-1, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-3, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be viewable for the "SCHEDULE-5, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-6, TEST" visit in the scheduled tab

  Scenario: Validate charges by login as smith for scheduling access set to all
    Given I am logged into the portal with user "nursesmith" and password "123"
    And I am on the "Schedule" tab
    When I click the "Clear Criteria" button in the "Search Criteria" pane
    And I select "Today" from the "Date Filter" menu
    And I select "Billing or Scheduled" from the "ProviderType" dropdown in the "Search Criteria" pane
    And I enter "JONES, DOCTOR" in the "Providers" field
    And I click the "ProviderSearch" button in the "SearchCriteria" pane
    And I enter "SMITH, NURSE" in the "Providers" field
    And I click the "ProviderSearch" button in the "SearchCriteria" pane
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-1, TEST |
      |SCHEDULE-2, TEST |
      |SCHEDULE-3, TEST |
      |SCHEDULE-4, TEST |
      |SCHEDULE-5, TEST |
      |SCHEDULE-6, TEST |
    And the charge should be viewable for the "SCHEDULE-1, TEST" visit in the scheduled tab
    And the charge should be viewable for the "SCHEDULE-3, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-5, TEST" visit in the scheduled tab
    And the charge should be viewable for the "SCHEDULE-6, TEST" visit in the scheduled tab

  Scenario: Clear the charges
    Given I am logged into the portal with user "drjones" and password "123"
    And I am on the "Patient List V2" tab
    And "TEST SCHEDULE-1" is on the patient list
    And patient "TEST SCHEDULE-1" has no charges
    And I click the "Ok" button if it exists
