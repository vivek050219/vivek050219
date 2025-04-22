@Schedule
Feature: Single User Scheduled Billing

    @donotrun
    Scenario: pre-requisite to turn off all codeedits on user server
		Given I am logged into the portal with user "pkadminv2" using the default password
        And I turn "on" all codeedits on "server"

    Scenario Outline: pre-requisite Single User Scheduled Provider setting
        Given I am logged into the portal with user "<Username>" and password "123"
        And I am on the "Patient List V2" tab
        And I use the API to create a patient list named "SCHEDULEPLV2" owned by "<Username>" with the following parameters
            | Type   | Name              | Value      |
            | Filter | Medical Service   | Card Group |
        And I click the "Refresh Patient List" button
        And I select "SCHEDULEPLV2" from the "Patient List" menu
        And I select "<Provider>" provider for the "<Visits>" patient
        Examples:
            |Username    |Provider       |Visits          |
            |drjones     |JONES, DOCTOR  |TEST SCHEDULE-1 |
            |drjones     |JONES, DOCTOR  |TEST SCHEDULE-3 |
            |billerbrown |               |TEST SCHEDULE-2 |
            |drjones     |JONES, DOCTOR  |TEST SCHEDULE-2 |
            |nursesmith  |SMITH, NURSE   |TEST SCHEDULE-4 |
            |nursesmith  |SMITH, NURSE   |TEST SCHEDULE-5 |
            |drmiller    |MILLER, DOCTOR |TEST SCHEDULE-6 |
            |drmiller    |SMITH, NURSE   |TEST SCHEDULE-7 |

    Scenario Outline: pre-requisite Adding charges to patients Single User Scheduled Billing
        Given I am logged into the portal with user "<UserName>" and password "123"
        And I am on the "Patient List V2" tab
		And "<Patient>" is on the patient list
        And patient "<Patient>" has no charges
        And I click the "Ok" button if it exists
        And I select "Visits" from clinical navigation
        Then the "Visits" table should load
        And I wait "3" seconds
        When I select "the first item" in the "Visits" table
        And I click the "Add Charge to this Visit" button in the "Visit Detail" pane
        And I wait "3" seconds
        And I set the following charge headers
            |Name         |Value         |
            |Bill Area    |<BillArea>    |
            |Billing Prov |<BillingProv> |
            |Svc Site     |Outpatient    |
        And I enter the ICD-10 code "B65.0"
        And I enter the CPT code "31040"
        And I click the "Submit" button
        And I click the "Save As Is" button in the "Confirm" pane if it exists
        And the "ChargeEntry" pane should close

    Examples:
		|UserName    |Patient         |BillArea      |BillingProv    |
		|drjones     |TEST SCHEDULE-1 |scheduledeptA |JONES, DOCTOR  |
		|drjones     |TEST SCHEDULE-3 |scheduledeptA |JONES, DOCTOR  |
		|nursesmith  |TEST SCHEDULE-4 |scheduledeptA |SMITH, NURSE   |
		|billerbrown |TEST SCHEDULE-2 |scheduledeptA |SMITH, NURSE   |
		|drmiller    |TEST SCHEDULE-6 |scheduledeptB |MILLER, DOCTOR |

    Scenario Outline: Single User Scheduled and login as jones
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
        And I click the "Delete Entry" image in the "Provider Search" pane if it exists
        And I select "Today" from the "Date Filter" menu
        And I select "Billing or Scheduled" from the "ProviderType" dropdown
        And I enter "JONES, DOCTOR" in the "Providers" field
        And I click the "ProviderSearch" button in the "SearchCriteria" pane
        Then the following visits should appear in the scheduled tab
            |SCHEDULE-1, TEST |
            |SCHEDULE-2, TEST |
            |SCHEDULE-3, TEST |
        And the charge should be editable for the "SCHEDULE-1, TEST" visit in the scheduled tab
        And the charge should be editable for the "SCHEDULE-3, TEST" visit in the scheduled tab
        Examples:
            |UserName |value1 |
            |drjones  |false  |
            |drjones  |yes    |

    Scenario Outline: Single User Scheduled and login as nursesmith
        Given I am logged into the portal with user "scadmin" and password "123"
        When I am on the "Admin" tab
        And I open "Patient List" settings page for the user "<UserName>"
        And I edit the following user settings and I click save
            | Page             | Name                       | Type     | Value            |
            | Patient List     | Scheduling Access          | dropdown | User             |
            | Charge Capture   | Charge Desktop View Access | dropdown | No Other Charges |
            | User Permissions | CanEditOtherUsersCharges   | radio    | <value1>         |
        Given I am logged into the portal with user "<UserName>" and password "123"
        And I am on the "Schedule" tab
        Then the "Schedule" pane should load
        And I wait "3" seconds
        When I click the "ClearCriteria" button in the "SearchCriteria" pane
        And I click the "Delete Entry" image in the "Provider Search" pane
        And I select "Today" from the "Date Filter" menu
        And I select "Billing or Scheduled" from the "ProviderType" dropdown
        And I enter "SMITH, NURSE" in the "Providers" field
        And I click the "ProviderSearch" button in the "SearchCriteria" pane
        Then the following visits should appear in the scheduled tab
            | SCHEDULE-2, TEST |
            | SCHEDULE-5, TEST |
            | SCHEDULE-4, TEST |
        And the charge should be editable for the "SCHEDULE-2, TEST" visit in the scheduled tab
        And the charge should be editable for the "SCHEDULE-4, TEST" visit in the scheduled tab
        Examples:
            |UserName   |value1 |
            |nursesmith |false  |
            |nursesmith |yes    |

    Scenario Outline: Single User Scheduled and login as billerbrown
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
        When I click the "ClearCriteria" button in the "Search Criteria" pane
        And I click the "Delete Entry" image in the "Provider Search" pane if it exists
        And I select "Today" from the "Date Filter" menu
        And I select "Billing or Scheduled" from the "Provider Type" dropdown
        And I enter "BROWN, BILLER" in the "Providers" field
        And I click the "Provider Search" button in the "Search Criteria" pane
        And the following text should appear in the "Search Result" pane
            |No visits found in the selected time period that match the specified criteria. |

        Examples:
            |UserName    |value1 |
            |billerbrown |false  |
            |billerbrown |yes    |

    Scenario Outline: Pre-Requisite Available visits for selected Single User Scheduled by setting preferences Scheduling Access All
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
            |billerbrown |

    Scenario: Single User Scheduled and Billing Login as jones
        Given I am logged into the portal with user "drjones" and password "123"
        And I am on the "Schedule" tab
        Then the "Schedule" pane should load
        And I wait "3" seconds
        When I click the "ClearCriteria" button in the "SearchCriteria" pane
        And I click the "Delete Entry" image in the "Provider Search" pane
        And I select "Today" from the "Date Filter" menu
        And I select "Billing or Scheduled" from the "ProviderType" dropdown
        And I enter "JONES, DOCTOR" in the "Providers" field
        And I click the "ProviderSearch" button in the "SearchCriteria" pane
        And I enter "SMITH, NURSE" in the "Providers" field
        And I click the "ProviderSearch" button in the "SearchCriteria" pane
        And I enter "MILLER, DOCTOR" in the "Providers" field
        And I click the "ProviderSearch" button in the "SearchCriteria" pane
        Then the following visits should appear in the scheduled tab
            | SCHEDULE-1, TEST |
            | SCHEDULE-2, TEST |
            |SCHEDULE-3, TEST |
            |SCHEDULE-4, TEST |
            |SCHEDULE-5, TEST |
            |SCHEDULE-6, TEST |
            |SCHEDULE-7, TEST |
        And the charge should be editable for the "SCHEDULE-1, TEST" visit in the scheduled tab
        And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-2, TEST" visit in the scheduled tab
        And the charge should be editable for the "SCHEDULE-3, TEST" visit in the scheduled tab
        And the charge should be viewable for the "SCHEDULE-4, TEST" visit in the scheduled tab
        And the charge should be viewable for the "SCHEDULE-6, TEST" visit in the scheduled tab

    Scenario: Single User Scheduled and Billing Login as biller brown
        Given I am logged into the portal with user "billerbrown" and password "123"
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
        And I enter "MILLER, DOCTOR" in the "Providers" field
        And I click the "ProviderSearch" button in the "SearchCriteria" pane
        Then the following visits should appear in the scheduled tab
            |SCHEDULE-1, TEST |
            |SCHEDULE-2, TEST |
            |SCHEDULE-3, TEST |
            |SCHEDULE-4, TEST |
            |SCHEDULE-5, TEST |
            |SCHEDULE-6, TEST |
            |SCHEDULE-7, TEST |
        And the charge should be viewable for the "SCHEDULE-1, TEST" visit in the scheduled tab
        And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-2, TEST" visit in the scheduled tab
        And the charge should be viewable for the "SCHEDULE-3, TEST" visit in the scheduled tab
        And the charge should be viewable for the "SCHEDULE-4, TEST" visit in the scheduled tab
        And the charge should be viewable for the "SCHEDULE-6, TEST" visit in the scheduled tab

    Scenario Outline: Single User Scheduled and Billing preferences Scheduling Access set to Department
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
        And the charge should be editable for the "SCHEDULE-1, TEST" visit in the scheduled tab
        And the charge should be editable for the "SCHEDULE-2, TEST" visit in the scheduled tab
        And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-2, TEST" visit in the scheduled tab
        And the charge should be editable for the "SCHEDULE-3, TEST" visit in the scheduled tab
        And the charge should be editable for the "SCHEDULE-4, TEST" visit in the scheduled tab

		Examples:
			|UserName    |
			|drjones     |
			|nursesmith  |
			|billerbrown |

    Scenario: Single User Scheduled and Billing Login as nurse smith
        Given I am logged into the portal with user "scadmin" and password "123"
        When I am on the "Admin" tab
        And I open "Patient List" settings page for the user "nursesmith"
        And I edit the following user settings and I click save
            |Page             |Name                       |Type     |Value       |
            |Patient List     |Scheduling Access          |dropdown |All         |
            |Charge Capture   |Charge Desktop View Access |dropdown |All Charges |
            |User Permissions |CanEditOtherUsersCharges   |radio    |yes         |
        Given I am logged into the portal with user "nursesmith" and password "123"
        And I am on the "Schedule" tab
        Then the "Schedule" pane should load
        When I click the "Clear Criteria" button in the "Search Criteria" pane
        And I click the "Delete Entry" image in the "Provider Search" pane if it exists
        And I select "Today" from the "Date Filter" menu
        And I select "Billing or Scheduled" from the "ProviderType" dropdown in the "Search Criteria" pane
        And I enter "JONES, DOCTOR" in the "Providers" field
        And I click the "ProviderSearch" button in the "SearchCriteria" pane
        And I enter "SMITH, NURSE" in the "Providers" field
        And I click the "ProviderSearch" button in the "SearchCriteria" pane
        And I enter "MILLER, DOCTOR" in the "Providers" field
        And I click the "ProviderSearch" button in the "SearchCriteria" pane
        Then the following visits should appear in the scheduled tab
            |SCHEDULE-1, TEST |
            |SCHEDULE-2, TEST |
            |SCHEDULE-3, TEST |
            |SCHEDULE-4, TEST |
            |SCHEDULE-5, TEST |
            |SCHEDULE-6, TEST |
            |SCHEDULE-7, TEST |
        And the charge should be editable for the "SCHEDULE-1, TEST" visit in the scheduled tab
        And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-2, TEST" visit in the scheduled tab
        And the charge should be editable for the "SCHEDULE-2, TEST" visit in the scheduled tab
        And the charge should be editable for the "SCHEDULE-3, TEST" visit in the scheduled tab
        And the charge should be editable for the "SCHEDULE-4, TEST" visit in the scheduled tab
        And the charge should be editable for the "SCHEDULE-6, TEST" visit in the scheduled tab

    Scenario: Single User Scheduled and Billing Login as drjones preferences scheduling access set to department
        Given I am logged into the portal with user "scadmin" and password "123"
        When I am on the "Admin" tab
        And I open "Patient List" settings page for the user "drjones"
        And I edit the following user settings and I click save
            |Page             |Name                       |Type     |Value            |
            |Patient List     |Scheduling Access          |dropdown |Department       |
            |Charge Capture   |Charge Desktop View Access |dropdown |No Other Charges |
            |User Permissions |CanEditOtherUsersCharges   |radio    |false            |
        Given I am logged into the portal with user "drjones" and password "123"
        And I am on the "Schedule" tab
        Then the "Schedule" pane should load
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
        And the charge should be editable for the "SCHEDULE-1, TEST" visit in the scheduled tab
        And the charge should be editable for the "SCHEDULE-3, TEST" visit in the scheduled tab

    Scenario: Single User Scheduled and Billing Login as biller brown scheduling access set to dept
        Given I am logged into the portal with user "scadmin" and password "123"
        When I am on the "Admin" tab
        And I open "Patient List" settings page for the user "billerbrown"
        And I edit the following user settings and I click save
            |Page             |Name                       |Type     |Value            |
            |Patient List     |Scheduling Access          |dropdown |Department       |
            |Charge Capture   |Charge Desktop View Access |dropdown |No Other Charges |
            |User Permissions |CanEditOtherUsersCharges   |radio    |false            |
        Given I am logged into the portal with user "billerbrown" and password "123"
        And I am on the "Schedule" tab
        Then the "Schedule" pane should load
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
        And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-1, TEST" visit in the scheduled tab
        And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-2, TEST" visit in the scheduled tab
        And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-3, TEST" visit in the scheduled tab
        And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-4, TEST" visit in the scheduled tab
        And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-5, TEST" visit in the scheduled tab

    Scenario: Single User Scheduled and Billing Login nurse smith with preference Scheduling Access as All
        Given I am logged into the portal with user "scadmin" and password "123"
        When I am on the "Admin" tab
        And I open "Patient List" settings page for the user "nursesmith"
        And I edit the following user settings and I click save
            |Page             |Name                       |Type     |Value                        |
            |Patient List     |Scheduling Access          |dropdown |All                          |
            |Charge Capture   |Charge Desktop View Access |dropdown |Within the User's Department |
            |User Permissions |CanEditOtherUsersCharges   |radio    |false                        |
        Given I am logged into the portal with user "nursesmith" and password "123"
        And I am on the "Schedule" tab
        When I click the "Clear Criteria" button in the "Search Criteria" pane
        And I click the "Delete Entry" image in the "Provider Search" pane if it exists
        And I select "Today" from the "Date Filter" menu
        And I select "Billing or Scheduled" from the "ProviderType" dropdown in the "Search Criteria" pane
        And I enter "JONES, DOCTOR" in the "Providers" field
        And I click the "ProviderSearch" button in the "SearchCriteria" pane
        And I enter "SMITH, NURSE" in the "Providers" field
        And I click the "ProviderSearch" button in the "SearchCriteria" pane
        And I enter "MILLER, DOCTOR" in the "Providers" field
        And I click the "ProviderSearch" button in the "SearchCriteria" pane
        Then the following visits should appear in the scheduled tab
            |SCHEDULE-1, TEST |
            |SCHEDULE-2, TEST |
            |SCHEDULE-3, TEST |
            |SCHEDULE-4, TEST |
            |SCHEDULE-5, TEST |
            |SCHEDULE-6, TEST |
            |SCHEDULE-7, TEST |
        And the charge should be viewable for the "SCHEDULE-1, TEST" visit in the scheduled tab
        And the charge should be viewable for the "SCHEDULE-3, TEST" visit in the scheduled tab
        And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-2, TEST" visit in the scheduled tab
        And the charge should be editable for the "SCHEDULE-2, TEST" visit in the scheduled tab
        And the charge should be editable for the "SCHEDULE-4, TEST" visit in the scheduled tab

    Scenario Outline: Single User Scheduled and Billing Login as jones and biller brown with preferences Scheduling Access as All
        Given I am logged into the portal with user "scadmin" and password "123"
        When I am on the "Admin" tab
        And I open "Patient List" settings page for the user "<UserName>"
        And I edit the following user settings and I click save
            |Page             |Name                       |Type     |Value                        |
            |Patient List     |Scheduling Access          |dropdown |All                          |
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
        And I enter "MILLER, DOCTOR" in the "Providers" field
        And I click the "ProviderSearch" button in the "SearchCriteria" pane
        Then the following visits should appear in the scheduled tab
            |SCHEDULE-1, TEST |
            |SCHEDULE-2, TEST |
            |SCHEDULE-3, TEST |
            |SCHEDULE-4, TEST |
            |SCHEDULE-5, TEST |
            |SCHEDULE-6, TEST |
            |SCHEDULE-7, TEST |
        And the charge should be editable for the "SCHEDULE-1, TEST" visit in the scheduled tab
        And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-2, TEST" visit in the scheduled tab
        And the charge should be editable for the "SCHEDULE-2, TEST" visit in the scheduled tab
        And the charge should be editable for the "SCHEDULE-3, TEST" visit in the scheduled tab
        And the charge should be editable for the "SCHEDULE-4, TEST" visit in the scheduled tab

        Examples:
            |UserName    |
            |drjones     |
            |billerbrown |

    Scenario: Clear the charges
        Given I am logged into the portal with user "drmiller" and password "123"
        And I am on the "Patient List V2" tab
        And patient "TEST SCHEDULE-6" has no charges
        And I click the "Ok" button if it exists