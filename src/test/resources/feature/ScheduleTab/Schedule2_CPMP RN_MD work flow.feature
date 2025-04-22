@Schedule
Feature: CPMP RN_MD work flow Tab
Scenarios for testing CPMP RN_MD work flow under Scheduled tab.

  Scenario Outline: pre-requisite CPMP RN_MD work flow
    Given I am logged into the portal with user "<Username>" and password "123"
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "SCHEDULEPLV2" owned by "<Username>" with the following parameters
      | Type   | Name              | Value      |
      | Filter | Medical Service   | Card Group |
    And I click the "Refresh Patient List" button
    And I select "SCHEDULEPLV2" from the "Patient List" menu
    And I select "<Provider>" provider for the "<Visits>" patient

    Examples:
      |Username    |Provider      |Visits          |
      |drjones     |JONES, DOCTOR |TEST SCHEDULE-1 |
      |drjones     |JONES, DOCTOR |TEST SCHEDULE-2 |
      |drjones     |JONES, DOCTOR |TEST SCHEDULE-3 |
      |nursesmith  |JONES, DOCTOR |TEST SCHEDULE-6 |
      |nursesmith  |SMITH, NURSE  |TEST SCHEDULE-4 |
      |nursesmith  |SMITH, NURSE  |TEST SCHEDULE-5 |
      |nursesmith  |BURNS, DOCTOR |TEST SCHEDULE-7 |

  Scenario Outline: Adding charges to patients as per pre-requisite
    Given I am logged into the portal with user "<UserName>" and password "123"
    And I am on the "Patient List V2" tab
    And "<Patient>" is on the patient list
    And patient "<Patient>" has no charges
    And I select "Visits" from clinical navigation
    Then the "Visits" table should load
    And I wait "3" seconds
    When I select "the first item" in the "Visits" table
    And I click the "Add Charge to this Visit" button in the "Visit Detail" pane
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value         |
      |Bill Area    |scheduledeptA |
      |Billing Prov |<BillingProv> |
      |Svc Site     |Outpatient    |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "31040"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And the "ChargeEntry" pane should close

    Examples:
      |UserName   |Patient         |BillingProv    |
      |drjones    |TEST SCHEDULE-1 |JONES, DOCTOR  |
      |drjones    |TEST SCHEDULE-3 |JONES, DOCTOR  |
      |nursesmith |TEST SCHEDULE-6 |JONES, DOCTOR  |
      |nursesmith |TEST SCHEDULE-4 |JONES, DOCTOR  |
      |nursesmith |TEST SCHEDULE-5 |SMITH, NURSE   |
      |nursesmith |TEST SCHEDULE-7 |BURNS, DOCTOR  |

  Scenario Outline: CPMP RN_MD wflow Charge validation when selected user is Jones,Edit User (Yes/No)
    Given I am logged into the portal with user "scadmin" and password "123"
    When I am on the "Admin" tab
    And I open "Patient List" settings page for the user "<Selected User>"
    ## As per DEV-82468 and DEV-79812 dropdown "Charge Desktop View Access" option changed from "No Charges" to "No Other Charges" from the 8.4.2 version
    And I edit the following user settings and I click save
      |Page             |Name                         |Type     |Value            |
      |Patient List     |Scheduling Access            |dropdown |User             |
      |Charge Capture   |Charge Desktop View Access   |dropdown |No Other Charges |
      |User Permissions |Can Edit Other Users Charges |radio    |<CheckBox Value> |
    Given I am logged into the portal with user "<Selected User>" and password "123"
    And I am on the "Schedule" tab
    When I click the "Clear Criteria" button in the "Search Criteria" pane
    And I click the "Delete Entry" image in the "Provider Search" pane if it exists
    And I select "Today" from the "Date Filter" menu
    And I select "Billing or Scheduled" from the "Provider Type" dropdown
    And I enter "JONES, DOCTOR" in the "Providers" field
    And I wait "3" seconds
    And I click the "Provider Search" button in the "Search Criteria" pane
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-1, TEST |
      |SCHEDULE-2, TEST |
      |SCHEDULE-3, TEST |
      |SCHEDULE-4, TEST |
      |SCHEDULE-6, TEST |
    And the charge should be editable for the "SCHEDULE-1, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-3, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-6, TEST" visit in the scheduled tab

    Examples:
      |Selected User|CheckBox Value  |
      |drjones      |Yes             |
      |drjones      |No              |

  Scenario Outline: CPMP RN_MD wflow Charge validation when selected user is Smith,Edit User (Yes/No)
    Given I am logged into the portal with user "scadmin" and password "123"
    When I am on the "Admin" tab
    And I open "Patient List" settings page for the user "<Selected User>"
    And I edit the following user settings and I click save
      |Page             |Name                         |Type     |Value            |
      |Patient List     |Scheduling Access            |dropdown |User             |
      |Charge Capture   |Charge Desktop View Access   |dropdown |No Other Charges |
      |User Permissions |Can Edit Other Users Charges |radio    |<CheckBox Value> |
    And I am logged into the portal with user "<Selected User>" and password "123"
    And I am on the "Schedule" tab
    When I click the "Clear Criteria" button in the "Search Criteria" pane
    And I click the "Delete Entry" image in the "Provider Search" pane
    And I select "Today" from the "Date Filter" menu
    And I select "Billing or Scheduled" from the "Provider Type" dropdown
    And I enter "SMITH, NURSE" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-4, TEST  |
      |SCHEDULE-5, TEST |
    And the charge should be editable for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-5, TEST" visit in the scheduled tab

    Examples:
      |Selected User |CheckBox Value  |
      |nursesmith    |Yes             |
      |nursesmith    |No              |

  Scenario Outline: CPMP RN_MD wflow Charge validation when selected user is Jones,Charge desktop Access and Edit User settings changed
    Given I am logged into the portal with user "scadmin" and password "123"
    When I am on the "Admin" tab
    And I open "Patient List" settings page for the user "<Selected User>"
    And I edit the following user settings and I click save
      |Page             |Name                          |Type     |Value                        |
      |Patient List     |Scheduling Access             |dropdown |<Scheduling Access Value>    |
      |Charge Capture   |Charge Desktop View Access    |dropdown |<Charge Access Value>        |
      |User Permissions |Can Edit Other Users Charges  |radio    |<Edit User Value>            |
    Given I am logged into the portal with user "<Selected User>" and password "123"
    And I am on the "Schedule" tab
    When I click the "Clear Criteria" button in the "Search Criteria" pane
    And I click the "Delete Entry" image in the "Provider Search" pane
    And I select "Today" from the "Date Filter" menu
    And I select "Billing or Scheduled" from the "Provider Type" dropdown
    And I enter "JONES, DOCTOR" in the "Providers" field
    And I click the "ProviderSearch" button in the "Search Criteria" pane
    And I enter "SMITH, NURSE" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-1, TEST  |
      |SCHEDULE-2, TEST  |
      |SCHEDULE-3, TEST  |
      |SCHEDULE-4, TEST  |
      |SCHEDULE-5, TEST  |
      |SCHEDULE-6, TEST  |
    And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be viewable for the "SCHEDULE-5, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-1, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-3, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-6, TEST" visit in the scheduled tab

    Examples:
      |Selected User          |Scheduling Access Value |Charge Access Value              |Edit User Value  |
      |drjones                |All                     |All Charges                      |No               |
      |drjones                |All                     |Within the User's Department     |No               |

  Scenario Outline: CPMP RN_MD wflow Charge validation when Scheduling Access setting is made "Dept"
    Given I am logged into the portal with user "scadmin" and password "123"
    When I am on the "Admin" tab
    And I open "Patient List" settings page for the user "<Selected User>"
    And I edit the following user settings and I click save
      |Page             |Name                          |Type     |Value                        |
      |Patient List     |Scheduling Access             |dropdown |<Scheduling Access Value>    |
      |Charge Capture   |Charge Desktop View Access    |dropdown |<Charge Access Value>        |
      |User Permissions |Can Edit Other Users Charges  |radio    |<Edit User Value>            |
    Given I am logged into the portal with user "<Selected User>" and password "123"
    And I am on the "Schedule" tab
    When I click the "Clear Criteria" button in the "Search Criteria" pane
    And I click the "Delete Entry" image in the "Provider Search" pane
    And I select "Today" from the "Date Filter" menu
    And I select "Billing or Scheduled" from the "Provider Type" dropdown
    And I enter "JONES, DOCTOR" in the "Providers" field
    And I click the "ProviderSearch" button in the "Search Criteria" pane
    And I enter "SMITH, NURSE" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-1, TEST  |
      |SCHEDULE-2, TEST  |
      |SCHEDULE-3, TEST  |
      |SCHEDULE-4, TEST  |
      |SCHEDULE-5, TEST  |
      |SCHEDULE-6, TEST  |
    And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-1, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-3, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-5, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-6, TEST" visit in the scheduled tab

    Examples:
      |Selected User          |Scheduling Access Value |Charge Access Value              |Edit User Value  |
      |drjones                |Department              |Within the User's Department     |Yes              |
      |nursesmith             |Department              |Within the User's Department     |Yes              |

  Scenario: CPMP RN_MD wflow Charge validation when Charge desktop Access setting is "All Charges"
    Given I am logged into the portal with user "scadmin" and password "123"
    When I am on the "Admin" tab
    And I open "Patient List" settings page for the user "nursesmith"
    And I edit the following user settings and I click save
      |Page             |Name                          |Type     |Value       |
      |Patient List     |Scheduling Access             |dropdown |All         |
      |Charge Capture   |Charge Desktop View Access    |dropdown |All Charges |
      |User Permissions |Can Edit Other Users Charges |radio     |No          |
    Given I am logged into the portal with user "nursesmith" and password "123"
    And I am on the "Schedule" tab
    When I click the "Clear Criteria" button in the "Search Criteria" pane
    And I select "Today" from the "Date Filter" menu
    And I select "Billing or Scheduled" from the "Provider Type" dropdown
    And I enter "SMITH, NURSE" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    And I enter "JONES, DOCTOR" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-1, TEST  |
      |SCHEDULE-2, TEST  |
      |SCHEDULE-3, TEST  |
      |SCHEDULE-4, TEST  |
      |SCHEDULE-5, TEST  |
      |SCHEDULE-6, TEST  |
    And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be viewable for the "SCHEDULE-1, TEST" visit in the scheduled tab
    And the charge should be viewable for the "SCHEDULE-3, TEST" visit in the scheduled tab
    And the charge should be viewable for the "SCHEDULE-6, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-5, TEST" visit in the scheduled tab

  Scenario: CPMP RN_MD wflow Charge validation when Charge desktop Access setting is "Within User's Dept"
    Given I am logged into the portal with user "scadmin" and password "123"
    When I am on the "Admin" tab
    And I open "Patient List" settings page for the user "nursesmith"
    And I edit the following user settings and I click save
      |Page             |Name                          |Type     |Value                        |
      |Patient List     |Scheduling Access             |dropdown |All                          |
      |Charge Capture   |Charge Desktop View Access    |dropdown |Within the User's Department |
      |User Permissions |Can Edit Other Users Charges  |radio    |No                           |
    Given I am logged into the portal with user "nursesmith" and password "123"
    And I am on the "Schedule" tab
    When I click the "Clear Criteria" button in the "Search Criteria" pane
    And I select "Today" from the "Date Filter" menu
    And I select "Billing or Scheduled" from the "Provider Type" dropdown
    And I enter "SMITH, NURSE" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    And I enter "JONES, DOCTOR" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-1, TEST  |
      |SCHEDULE-2, TEST  |
      |SCHEDULE-3, TEST  |
      |SCHEDULE-4, TEST  |
      |SCHEDULE-5, TEST  |
      |SCHEDULE-6, TEST  |
    And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be viewable for the "SCHEDULE-1, TEST" visit in the scheduled tab
    And the charge should be viewable for the "SCHEDULE-3, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-5, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-6, TEST" visit in the scheduled tab
