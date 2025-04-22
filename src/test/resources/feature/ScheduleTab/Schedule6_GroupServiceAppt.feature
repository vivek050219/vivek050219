@Schedule
Feature: Show Group Service Appointments

	Scenario: Pre-requisite Group Service Appt
		Given I am logged into the portal with user "scadmin" and password "123"
		When I am on the "Admin" tab
		And I open "Patient List" settings page for the user "drjones"
		And I edit the following user settings and I click save
			|Page           |Name                       |Type     |Value            |
			|Patient List   |Scheduling Access          |dropdown |Department       |
			|Charge Capture |Charge Desktop View Access |dropdown |No Other Charges |
		And I open "Patient List" settings page for the user "scl2user"
		And I edit the following user settings and I click save
			|Page           |Name                       |Type     |Value                        |
			|Patient List   |Scheduling Access          |dropdown |Department                   |
			|Charge Capture |Charge Desktop View Access |dropdown |Within the User's Department |

	Scenario Outline: pre-requisite set schedule provider and med service to visits
		Given I am logged into the portal with user "<UserName>" and password "123"
		And I am on the "Patient List V2" tab
		And I select "SCHEDULEPLV2" from the "Patient List" menu
		And I select "<ProviderName>" provider and "<ServiceName>" as med service for the "<PatientName>" patient

		Examples:
			|UserName   |ProviderName   |ServiceName  |PatientName     |
			|drjones    |JONES, DOCTOR  |Diab Service |TEST SCHEDULE-1 |
			|drjones    |JONES, DOCTOR  |             |TEST SCHEDULE-2 |
			|nursesmith |               |Diab Service |TEST SCHEDULE-3 |
			|drmiller   |MILLER, DOCTOR |CHF Service  |TEST SCHEDULE-4 |
			|nursesmith |MILLER, DOCTOR |             |TEST SCHEDULE-5 |

	Scenario Outline: pre-requisite Adding charges to visits
		Given I am logged into the portal with user "<UserName>" and password "123"
		And I am on the "Patient List V2" tab
		And I select "SCHEDULEPLV2" from the "Patient List" menu
		And "<Patient>" is on the patient list
		And I select patient "<Patient>" from the patient list
		And I select "Charges" from clinical navigation
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
		And I enter "%Current Date MMDDYYYY%" in the "Date" field
		And I enter the ICD-10 code "B65.0"
		And I enter the CPT code "31040"
		And I click the "Submit" button
		And I click the "Save As Is" button in the "Confirm" pane if it exists
		And the "ChargeEntry" pane should close

		Examples:
			|UserName    |Patient         |BillArea      |BillingProv    |
			|drjones     |TEST SCHEDULE-1 |Orthopedics   |JONES, DOCTOR  |
			|nursesmith  |TEST SCHEDULE-3 |Orthopedics   |JONES, DOCTOR  |
			|drmiller    |TEST SCHEDULE-4 |Pulmonary     |MILLER, DOCTOR |
			|nursesmith  |TEST SCHEDULE-5 |Pulmonary     |MILLER, DOCTOR |

	Scenario: Available visits and Charges with jones as scheduled provider by login as jones
		Given I am logged into the portal with user "drjones" and password "123"
		And I am on the "Schedule" tab
		And I click the "Clear Criteria" button in the "Search Criteria" pane
		#default provider is selected
		And I select "Today" from the "Date Filter" menu
		And I click the "Delete Entry" image in the "Provider Search" pane
		And I enter "JONES, DOCTOR" in the "Providers" field
		And I click the "Provider Search" button in the "Search Criteria" pane
		And I check the "Show GroupService Appointments" checkbox
		Then the following visits should appear in the scheduled tab
			| SCHEDULE-1, TEST |
			| SCHEDULE-2, TEST |
			| SCHEDULE-3, TEST |
			| SCHEDULE-4, TEST |
		And the charge should be editable for the "SCHEDULE-1, TEST" visit in the scheduled tab
		And the charge should be editable for the "SCHEDULE-3, TEST" visit in the scheduled tab

	Scenario: Available visits and Charges with jones and smith as scheduled providers by login as jones
		Given I am logged into the portal with user "drjones" and password "123"
		And I am on the "Schedule" tab
		And I click the "Clear Criteria" button in the "Search Criteria" pane
		#default provider is selected
		And I select "Today" from the "Date Filter" menu
		And I click the "Delete Entry" image in the "Provider Search" pane
		And I check the "Show GroupService Appointments" checkbox
		When I enter "SMITH, NURSE" in the "Providers" field
		And I click the "Provider Search" button
		And I enter "JONES, DOCTOR" in the "Providers" field
		And I click the "Provider Search" button in the "Search Criteria" pane
		Then the following visits should appear in the scheduled tab
			| SCHEDULE-1, TEST |
			| SCHEDULE-2, TEST |
			| SCHEDULE-3, TEST |
			| SCHEDULE-4, TEST |
			| SCHEDULE-5, TEST |
		And the charge should be editable for the "SCHEDULE-1, TEST" visit in the scheduled tab
		And the charge should be editable for the "SCHEDULE-3, TEST" visit in the scheduled tab

	Scenario: Available visits and Charges with No providers by login as jones
		Given I am logged into the portal with user "scadmin" and password "123"
		When I am on the "Admin" tab
		And I open "Patient List" settings page for the user "drjones"
		And I edit the following user settings and I click save
			|Page           |Name                       |Type     |Value                        |
			|Charge Capture |Charge Desktop View Access |dropdown |Within the User's Department |
		Given I am logged into the portal with user "drjones" and password "123"
		And I am on the "Schedule" tab
		And I click the "Clear Criteria" button in the "Search Criteria" pane
		And I enter "JONES, DOCTOR" in the "Providers" field
		And I click the "Provider Search" button in the "Search Criteria" pane
		And I select "Today" from the "Date Filter" menu
		#There should not be providers in the list[DEV-49451]
		And I click the "Delete Entry" image in the "Provider Search" pane
		And I check the "Show GroupService Appointments" checkbox
		And the following text should appear in the "VisitsTable" pane
			|You must select at least one provider or service. |

	Scenario: Available visits and Charges with jones as scheduled provider by login as level2 user and service group unchecked
		Given I am logged into the portal with user "scl2user" and password "123"
		And I am on the "Schedule" tab
		And I click the "Clear Criteria" button in the "Search Criteria" pane
		And I select "Today" from the "Date Filter" menu
		And I uncheck the "Show GroupService Appointments" checkbox
		When I enter "JONES, DOCTOR" in the "Providers" field
		And I click the "Provider Search" button
		Then the following visits should appear in the scheduled tab
			|SCHEDULE-1, TEST |
			|SCHEDULE-2, TEST |
			|SCHEDULE-3, TEST |
		And the charge should be viewable for the "SCHEDULE-1, TEST" visit in the scheduled tab
		And the charge should be viewable for the "SCHEDULE-3, TEST" visit in the scheduled tab

	Scenario: Available visits and Charges with jones as scheduled provider by login as level2 user and service group checked
		Given I am logged into the portal with user "scl2user" and password "123"
		And I am on the "Schedule" tab
		And I click the "Clear Criteria" button in the "Search Criteria" pane
		And I click the "Delete Entry" image in the "Provider Search" pane if it exists
		And I check the "Show GroupService Appointments" checkbox
		When I enter "JONES, DOCTOR" in the "Providers" field
		And I click the "Provider Search" button
		Then the following visits should appear in the scheduled tab
			|SCHEDULE-1, TEST |
			|SCHEDULE-2, TEST |
			|SCHEDULE-3, TEST |
			|SCHEDULE-4, TEST |

		And the charge should be viewable for the "SCHEDULE-1, TEST" visit in the scheduled tab
		And the charge should be viewable for the "SCHEDULE-3, TEST" visit in the scheduled tab

	Scenario: Available visits and Charges with smith as scheduled provider by login as level2 user and service group unchecked
		Given I am logged into the portal with user "scl2user" and password "123"
		And I am on the "Schedule" tab
		And I click the "Clear Criteria" button in the "Search Criteria" pane
		And I click the "Delete Entry" image in the "Provider Search" pane if it exists
		And I uncheck the "Show Group Service Appointments" checkbox
		When I enter "SMITH, NURSE" in the "Providers" field
		And I click the "Provider Search" button
		And the following text should appear in the "VisitsTable" pane
			|No visits found in the selected time period that match the specified criteria. |
  
	Scenario: Available visits and Charges with smith as scheduled provider by login as level2 user and service group checked
		Given I am logged into the portal with user "scl2user" and password "123"
		And I am on the "Schedule" tab
		And I click the "Clear Criteria" button in the "Search Criteria" pane
		And I click the "Delete Entry" image in the "Provider Search" pane if it exists
		And I check the "Show Group Service Appointments" checkbox
		When I enter "SMITH, NURSE" in the "Providers" field
		And I click the "Provider Search" button
		Then the following visits should appear in the scheduled tab
			|SCHEDULE-1, TEST |
			|SCHEDULE-3, TEST |
			|SCHEDULE-4, TEST |
			|SCHEDULE-5, TEST |
		And the charge should be viewable for the "SCHEDULE-1, TEST" visit in the scheduled tab
		And the charge should be viewable for the "SCHEDULE-3, TEST" visit in the scheduled tab
		And the charge should be viewable for the "SCHEDULE-4, TEST" visit in the scheduled tab
		And the charge should be viewable for the "SCHEDULE-5, TEST" visit in the scheduled tab

	Scenario: Available visits and Charges with miller as scheduled provider by login as level2 user and service group unchecked
		Given I am logged into the portal with user "scl2user" and password "123"
		And I am on the "Schedule" tab
		And I click the "Clear Criteria" button in the "Search Criteria" pane
		And I uncheck the "Show Group Service Appointments" checkbox
		When I enter "MILLER, DOCTOR" in the "Providers" field
		And I click the "Provider Search" button
		Then the following visits should appear in the scheduled tab
			|SCHEDULE-4, TEST |
			|SCHEDULE-5, TEST |
		And the charge should be viewable for the "SCHEDULE-4, TEST" visit in the scheduled tab
		And the charge should be viewable for the "SCHEDULE-5, TEST" visit in the scheduled tab
  
	Scenario: Available visits and Charges with miller as scheduled provider by login as level2 user and service group checked
		Given I am logged into the portal with user "scl2user" and password "123"
		And I am on the "Schedule" tab
		And I click the "Clear Criteria" button in the "Search Criteria" pane
		And I check the "Show Group Service Appointments" checkbox
		When I enter "MILLER, DOCTOR" in the "Providers" field
		And I click the "Provider Search" button
		Then the following visits should appear in the scheduled tab
			|SCHEDULE-1, TEST |
			|SCHEDULE-2, TEST |
			|SCHEDULE-3, TEST |
			|SCHEDULE-4, TEST |
			|SCHEDULE-5, TEST |
		And the charge should be viewable for the "SCHEDULE-4, TEST" visit in the scheduled tab
		And the charge should be viewable for the "SCHEDULE-5, TEST" visit in the scheduled tab

	Scenario: Available visits and Charges with miller as scheduled provider and Diab service with service group checked
		Given I am logged into the portal with user "scl2user" and password "123"
		And I am on the "Schedule" tab
		And I click the "Clear Criteria" button in the "Search Criteria" pane
#		And I click the "Delete Entry" image in the "Provider Search" pane if it exists
		And I check the "Show Group Service Appointments" checkbox
		When I enter "MILLER, DOCTOR" in the "Providers" field
		And I click the "Provider Search" button
		When I enter "Diab Service" in the "Services" field
		And I click the "Service Search" button
		Then the following visits should appear in the scheduled tab
			|SCHEDULE-1, TEST |
			|SCHEDULE-3, TEST |
			|SCHEDULE-4, TEST |
			|SCHEDULE-5, TEST |
		And the charge should be viewable for the "SCHEDULE-1, TEST" visit in the scheduled tab
		And the charge should be viewable for the "SCHEDULE-3, TEST" visit in the scheduled tab
		And the charge should be viewable for the "SCHEDULE-4, TEST" visit in the scheduled tab
		And the charge should be viewable for the "SCHEDULE-5, TEST" visit in the scheduled tab

