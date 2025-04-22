@Schedule
Feature: Med Services

  Background:

  Scenario Outline: Pre-requisite to set settings for users
    Given I am logged into the portal with user "scadmin" and password "123"
    When I am on the "Admin" tab
    And I open "Patient List" settings page for the user "<UserName>"
    And I edit the following user settings and I click save
      |Page           |Name                       |Type     |Value           |
      |Patient List   |Scheduling Access          |dropdown |User            |
      |Charge Capture |Charge Desktop View Access |dropdown |No Other Charges|

    Examples:
      |UserName   |
      |nursesmith |
      |drjones    |
      |drmiller   |

  Scenario: Pre-requisite to set settings for scl2user user
    Given I am logged into the portal with user "scadmin" and password "123"
    When I am on the "Admin" tab
    And I open "Patient List" settings page for the user "scl2user"
    And I edit the following user settings and I click save
      |Page           |Name                       |Type     |Value                        |
      |Patient List   |Scheduling Access          |dropdown |Department                   |
      |Charge Capture |Charge Desktop View Access |dropdown |Within the User's Department |

  Scenario Outline: pre-requisite set schedule provider and med service to visits
    Given I am logged into the portal with user "<UserName>" and password "123"
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "SCHEDULEPLV2" owned by "<UserName>" with the following parameters
      | Type   | Name              | Value      |
      | Filter | Medical Service   | Card Group |
    And I click the "Refresh Patient List" button
    And I select "SCHEDULEPLV2" from the "Patient List" menu
    And I select "<ProviderName>" provider and "<ServiceName>" as med service for the "<PatientName>" patient

    Examples:
      |UserName   |ProviderName   |ServiceName  |PatientName     |
      |nursesmith |SMITH, NURSE   |Diab Service |TEST SCHEDULE-1 |
      |nursesmith |               |Diab Service |TEST SCHEDULE-2 |
      |drjones    |JONES, DOCTOR  |Diab Service |TEST SCHEDULE-3 |
      |drmiller   |MILLER, DOCTOR |Diab Service |TEST SCHEDULE-4 |
      |nursesmith |MILLER, DOCTOR |CHF Service  |TEST SCHEDULE-5 |
      |drmiller   |MILLER, DOCTOR |CHF Service  |TEST SCHEDULE-6 |
      |drbrown    |STEARN, DOCTOR |CHF Service  |TEST SCHEDULE-7 |

  Scenario: Pre-requisite department association with user
    Given I am logged into the portal with user "scadmin" and password "123"
    And I am on the "Admin" tab
    And the user "nursesmith" is associated with the "Orthopedics" department
    And the user "nursesmith" is associated with the "Pulmonary" department
    And the user "drbrown" is associated with the "Hospitalist" department
    And the user "drmiller" is associated with the "Orthopedics" department

  Scenario: Pre-requisite to delete charge
    Given I am logged into the portal with user "drjones" and password "123"
    And I am on the "Patient List V2" tab
    And "TEST SCHEDULE-4" is on the patient list
    And I select "Charges" from clinical navigation
    And patient "TEST SCHEDULE-4" has no charges

  Scenario Outline: pre-requisite Adding charges to visits
    Given I am logged into the portal with user "<UserName>" and password "123"
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "SCHEDULEPLV2" from the "Patient List" menu
    And I select "Charges" from clinical navigation
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
      |nursesmith  |TEST SCHEDULE-1 |Orthopedics   |SMITH, NURSE   |
      |nursesmith  |TEST SCHEDULE-2 |Orthopedics   |JONES, DOCTOR  |
      |nursesmith  |TEST SCHEDULE-5 |Pulmonary     |MILLER, DOCTOR |
      |drmiller    |TEST SCHEDULE-4 |Orthopedics   |MILLER, DOCTOR |
      |drbrown     |TEST SCHEDULE-7 |Hospitalist   |BROWN, DOCTOR  |

  Scenario: Available visits for selected Diab Medical Service by login as smith
    Given I am logged into the portal with user "nursesmith" and password "123"
    And I am on the "Schedule" tab
    And I click the "Clear Criteria" button in the "Search Criteria" pane
   #There should not be providers in the list[DEV-49451]
    And I click the "Delete Entry" image in the "Provider Search" pane
    When I enter "Diab Service" in the "Services" field
    And I click the "Service Search" button
   #	And I select "Today" from the "Date Filter" menu
    And I wait "3" seconds
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-1, TEST |
      |SCHEDULE-2, TEST |
      |SCHEDULE-3, TEST |
      |SCHEDULE-4, TEST |
    And the charge should be editable for the "SCHEDULE-1, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-2, TEST" visit in the scheduled tab

  Scenario: Available visits for selected CHF Medical Service by login as smith
    Given I am logged into the portal with user "nursesmith" and password "123"
    And I am on the "Schedule" tab
    And I click the "Clear Criteria" button in the "Search Criteria" pane
   #There should not be providers in the list[DEV-49451]
    And I click the "Delete Entry" image in the "Provider Search" pane
    When I enter "CHF Service" in the "Services" field
    And I click the "Service Search" button
    And I wait "3" seconds
#    Then the "" visits should appear in the scheduled tab
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-5, TEST |
      |SCHEDULE-6, TEST |
      |SCHEDULE-7, TEST |
    And the charge should be editable for the "SCHEDULE-5, TEST" visit in the scheduled tab

  Scenario: Available visits for selected Diab Medical Service and provider by login as smith
    Given I am logged into the portal with user "nursesmith" and password "123"
    And I am on the "Schedule" tab
    And I click the "Clear Criteria" button in the "Search Criteria" pane
   #Default service provider is in list
    When I enter "Diab Service" in the "Services" field
    And I click the "Service Search" button
    And I wait "3" seconds
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-1, TEST |
      |SCHEDULE-2, TEST |
      |SCHEDULE-3, TEST |
      |SCHEDULE-4, TEST |
    And the charge should be editable for the "SCHEDULE-1, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-2, TEST" visit in the scheduled tab

  Scenario: Available visits for selected Diab Medical Service by login as jones
    Given I am logged into the portal with user "drjones" and password "123"
    And I am on the "Schedule" tab
    And I click the "Clear Criteria" button in the "Search Criteria" pane
   #There should not be providers in the list[DEV-49451]
    And I click the "Delete Entry" image in the "Provider Search" pane
    And I enter "JONES, DOCTOR" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    And I click the "Delete Entry" image in the "Provider Search" pane
    When I enter "Diab Service" in the "Services" field
    And I click the "Service Search" button
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-1, TEST |
      |SCHEDULE-2, TEST |
      |SCHEDULE-3, TEST |
      |SCHEDULE-4, TEST |
    And the charge should be editable for the "SCHEDULE-2, TEST" visit in the scheduled tab

  Scenario: Available visits for selected CHF Medical Service by login as jones
    Given I am logged into the portal with user "drjones" and password "123"
    And I am on the "Schedule" tab
    And I click the "Clear Criteria" button in the "Search Criteria" pane
   #There should not be providers in the list[DEV-49451]
    And I click the "Delete Entry" image in the "Provider Search" pane
    And I enter "JONES, DOCTOR" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    And I click the "Delete Entry" image in the "Provider Search" pane
    When I enter "CHF Service" in the "Services" field
    And I click the "Service Search" button
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-5, TEST |
      |SCHEDULE-6, TEST |
      |SCHEDULE-7, TEST |

  Scenario: Available visits for selected CHF Medical Service and provider by login as jones
    Given I am logged into the portal with user "drjones" and password "123"
    And I am on the "Schedule" tab
    And I click the "Clear Criteria" button in the "Search Criteria" pane
   #Default provider is in the list
    And I enter "JONES, DOCTOR" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    When I enter "CHF Service" in the "Services" field
    And I click the "Service Search" button
    And I select "Today" from the "Date Filter" menu
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-2, TEST |
      |SCHEDULE-3, TEST |
      |SCHEDULE-5, TEST |
      |SCHEDULE-6, TEST |
      |SCHEDULE-7, TEST |
    And the charge should be editable for the "SCHEDULE-2, TEST" visit in the scheduled tab

  Scenario: Available visits for selected Diab Medical Service by login as miller
    Given I am logged into the portal with user "drmiller" and password "123"
    And I am on the "Schedule" tab
    And I click the "Clear Criteria" button in the "Search Criteria" pane
    And I click the "Delete Entry" image in the "Provider Search" pane
    And I enter "MILLER, DOCTOR" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
   #There should not be providers in the list[DEV-49451]
    And I click the "Delete Entry" image in the "Provider Search" pane
    When I enter "Diab Service" in the "Services" field
    And I click the "Service Search" button
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-1, TEST |
      |SCHEDULE-2, TEST |
      |SCHEDULE-3, TEST |
      |SCHEDULE-4, TEST |
    And the charge should be editable for the "SCHEDULE-4, TEST" visit in the scheduled tab

  Scenario: Available visits for selected CHF Medical Service by login as miller
    Given I am logged into the portal with user "drmiller" and password "123"
    And I am on the "Schedule" tab
    And I click the "Clear Criteria" button in the "Search Criteria" pane
    And I click the "Delete Entry" image in the "Provider Search" pane
    And I enter "MILLER, DOCTOR" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
   #There should not be providers in the list[DEV-49451]
    And I click the "Delete Entry" image in the "Provider Search" pane
    When I enter "CHF Service" in the "Services" field
    And I click the "Service Search" button
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-5, TEST |
      |SCHEDULE-6, TEST |
      |SCHEDULE-7, TEST |
    And the charge should be editable for the "SCHEDULE-5, TEST" visit in the scheduled tab

  Scenario: Available visits for selected Diab Medical Service and provider by login as miller
    Given I am logged into the portal with user "drmiller" and password "123"
    And I am on the "Schedule" tab
    And I click the "Clear Criteria" button in the "Search Criteria" pane
    And I enter "MILLER, DOCTOR" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
   #Default Service Provider is in the list
    When I enter "Diab Service" in the "Services" field
    And I click the "Service Search" button
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-1, TEST |
      |SCHEDULE-2, TEST |
      |SCHEDULE-3, TEST |
      |SCHEDULE-4, TEST |
      |SCHEDULE-5, TEST |
      |SCHEDULE-6, TEST |
    And the charge should be editable for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be editable for the "SCHEDULE-5, TEST" visit in the scheduled tab

  Scenario: Available visits for selected Diab Medical Service by login as scl2user
    Given I am logged into the portal with user "scl2user" and password "123"
    And I am on the "Schedule" tab
    And I click the "Clear Criteria" button in the "Search Criteria" pane
   #There should not be providers in the list
    When I enter "Diab Service" in the "Services" field
    And I click the "Service Search" button
    And I select "Today" from the "Date Filter" menu
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-1, TEST |
      |SCHEDULE-2, TEST |
      |SCHEDULE-3, TEST |
      |SCHEDULE-4, TEST |
    And the charge should be viewable for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be viewable for the "SCHEDULE-2, TEST" visit in the scheduled tab
    And the charge should be viewable for the "SCHEDULE-1, TEST" visit in the scheduled tab

  Scenario: Available visits for selected CHF Medical Service by login as scl2user
    Given I am logged into the portal with user "scl2user" and password "123"
    And I am on the "Schedule" tab
    And I click the "Clear Criteria" button in the "Search Criteria" pane
   #There should not be providers in the list
    When I enter "CHF Service" in the "Services" field
    And I click the "Service Search" button
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-5, TEST |
      |SCHEDULE-6, TEST |
      |SCHEDULE-7, TEST |
    And the charge should be viewable for the "SCHEDULE-5, TEST" visit in the scheduled tab
    And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-7, TEST" visit in the scheduled tab

  Scenario: Available visits for selected CHF Medical Service and provider by login as scl2user
    Given I am logged into the portal with user "scl2user" and password "123"
    And I am on the "Schedule" tab
    And I click the "Clear Criteria" button in the "Search Criteria" pane
    When I enter "CHF Service" in the "Services" field
    And I click the "Service Search" button
    When I enter "MILLER, DOCTOR" in the "Providers" field
    And I click the "Provider Search" button
    Then the following visits should appear in the scheduled tab
      |SCHEDULE-4, TEST |
      |SCHEDULE-5, TEST |
      |SCHEDULE-6, TEST |
      |SCHEDULE-7, TEST |
    And the charge should be viewable for the "SCHEDULE-4, TEST" visit in the scheduled tab
    And the charge should be viewable for the "SCHEDULE-5, TEST" visit in the scheduled tab
    And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-7, TEST" visit in the scheduled tab

  Scenario Outline: Clear the charges
    Given I am logged into the portal with user "<UserName>" and password "123"
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "SCHEDULEPLV2" from the "Patient List" menu
    And "<Patient>" is on the patient list
    And patient "<Patient>" has no charges
    And I click the "Ok" button if it exists

    Examples:
      |UserName   |Patient         |
      |drjones    |TEST SCHEDULE-3 |
      |nursesmith |TEST SCHEDULE-1 |

