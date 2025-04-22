@PortalSmoke
Feature: Schedule tab
	#Required permissions for scheduletest user:
	#User Permissions - Provider set to Yes
	#User Should have department verve
	#Patient List - Can Add/Edit PK Visits - Yes
	#Patient List -  Allow Patient Assignment - Yes
	#Patient List - Can Cancel Appointments - Yes
 	#Patient List - Allow Patient Visit Search - Yes
	#Patient List - Scheduling Access - All?

  @Demo
  Scenario: Prerequisite-Schedule Tab user patient list settings
    Given I am logged into the portal with user "pkadmin" and password "123"
    And I am on the "Admin" tab
    And I select the "User" subtab
    When I search for the user "scheduletest"
    And I select the user "scheduletest"
    And I click the "Edit" button in the "Quick Details" pane
    Then I select "Patient List" from the "Edit User Settings" dropdown
    And I select "All" from the "Scheduling Access" dropdown
    And I select "true" from the "Allow Patient Assignment" radio list
    And I select "true" from the "Allow Patient Visit Search" radio list
    And I select "true" from the "Can Add Edit PK Visits" radio list
    And I select "true" from the "Can Cancel Appointments" radio list
    Then I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "2" seconds


  Scenario: Schedule Tab
    Given I am logged into the portal with user "scheduletest" using the default password
    And I am on the "Schedule" tab
    Then the "Schedule" pane should load
		#Clear out any fields that may already be populated from previous run:
    And I click the "Clear Criteria" button in the "Search Criteria" pane
    And I wait "2" seconds
    Then All cells in the "Provider Search" table should contain the text "SCHEDULE, TEST"
    And I select "Last 7 Days" from the "Date Filter" menu
    When I enter "GHDO Clinic" in the "Services" field
    And I click the "Service Search" button
    And I select "GHDOHospital" from the "Facility" dropdown
    Then All cells in the "Scheduled Visits" table should contain the text "GHDOHospital"
    And I click the "Select All" button
    Then All cells in the schedule visits table should be selected
    When I click the "Select None" button
    Then All cells in the schedule visits table should not be selected
    When I click the "Print" button
    Then the "Print Schedule" pane should load
    And I click the "Close" button in the "Print Schedule" pane
    When I check the "Group By Date" checkbox
    Then the "Schedule Visits Header Table" table should have at least "1" row not containing the text "GHDO Clinic"
    When I uncheck the "Group By Date" checkbox
    Then the "Schedule Visits Header Table" table should have at least "1" row containing the text "GHDO Clinic"
    And I check the "Show Group Service Appointments" checkbox
    When I click the "Clear Criteria" button
    And I wait "2" seconds
    Then All cells in the "Provider Search" table should contain the text "SCHEDULE, TEST"
    Then the "Services Search" "Table" should not be visible
    Then  "- All -" should be selected in the "Facility" dropdown
    Then the following should be unchecked
      | Group By Date                   |
      | Show Group Service Appointments |


  @Demo
  Scenario: Create Visit
    Given I am logged into the portal with user "scheduletest" using the default password
    And I am on the "Schedule" tab
    When I click the "Clear Criteria" button in the "Search Criteria" pane
    And I click the "Delete Entry" image in the "Provider Search" pane if it exists
    And I enter "SCHEDULE, TEST" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    And I wait "2" seconds
    And I click the "Create Visit" button
    Then the "Create Schedule Visit Search Criteria" pane should load within "5" seconds
    And I click the "Create Schedule Visit Clear Criteria" button
    And I enter "Verve" in the "Last Name" field
    And I enter "ScheduleTest" in the "First Name" field
    And I uncheck the "Include Cancelled Visits" checkbox
    And I uncheck the "Include Past Visits" checkbox
    And I click the "Search for Visits" button
    #If any results come up, this link that needs to be pressed isn't there, and a button must be pressed instead to
    # pull up the same menu. This works as long as both are not on the screen, might need a better work around in the
    # future
    And I click the "Outpatient" link if it exists in the "Create Schedule Visit Search Results" pane
    And I click the "Create Outpatient Visit" button in the "Create Schedule Visit Search Results" pane if it exists
    #
    Then the "Create Schedule Visit Patient Account" pane should load
    And I enter "123456789" in the "MRN" field
    And I select "PKHospital" from the "Patient Information Facility" dropdown
    And I select "OP_Manreg" from the "Visit Type" dropdown
    And I enter "%1 day from now MMDDYY%" in the "Appointment Date" field
    And I enter "0001" in the "Appointment Time" field
#		And I select "SCHEDULED" from the "Relationship" dropdown
    And I enter "SCHEDULE, TEST" in the "Scheduled MD" field
    And I click the "Schedule MD Search" button in the "Create Schedule Visit Patient Account" pane
    And I click the "Add and Save" button
    And I click the "Yes" button in the "Question" pane
    And the "Create Schedule Visit Search Results" table should load
    And I click the "Close" button in the "Create Schedule Visit" pane
    Then the "Create Schedule Visit Search Criteria" pane should close
    And I select "Tomorrow" from the "Date Filter" menu
    And I wait up to "5" seconds for the "Schedule Visits Loading Icon" field of type "MISC_ELEMENT" in the "Scheduled Visits" pane to be invisible
    And I click the "Refresh" button
    And I wait up to "5" seconds for the "Schedule Visits Loading Icon" field of type "MISC_ELEMENT" in the "Scheduled Visits" pane to be invisible
    Then the following visit should appear in the scheduled tab
      | VERVE, SCHEDULETEST* |


  @Demo
  Scenario: Schedule Facility Filter
    Given I am logged into the portal with user "scheduletest" using the default password
    And I am on the "Schedule" tab
    And the "Schedule" pane should load
    And I click the "Clear Criteria" button in the "Search Criteria" pane
    And I click the "Delete Entry" image in the "Provider Search" pane if it exists
    And I enter "JONES, DOCTOR" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    And I select "Last 7 Days" from the "Date Filter" menu
    When I select "PKHospital-Verve" from the "Facility" dropdown
#		And I wait for loading to complete
    And I wait up to "5" seconds for the "Schedule Visits Loading Icon" field of type "MISC_ELEMENT" in the "Scheduled Visits" pane to be invisible
    Then the following visits should appear in the scheduled tab
      | SCHEDULE-1, TEST |
      | SCHEDULE-2, TEST |
      | SCHEDULE-3, TEST |
    When I select "- All -" from the "Facility" dropdown
    And I wait up to "5" seconds for the "Schedule Visits Loading Icon" field of type "MISC_ELEMENT" in the "Scheduled Visits" pane to be invisible
    Then the following visits should appear in the scheduled tab
      | SCHEDULE-1, TEST |
      | SCHEDULE-2, TEST |
      | SCHEDULE-3, TEST |


  @Demo
  Scenario: Schedule Group by Date
    Given I am logged into the portal with user "scheduletest" using the default password
    And I am on the "Schedule" tab
    And the "Schedule" pane should load
    And I click the "Clear Criteria" button in the "Search Criteria" pane
    And I click the "Delete Entry" image in the "Provider Search" pane if it exists
    And I enter "JONES, DOCTOR" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    And I enter "SMITH, NURSE" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    And I select "Last 7 Days" from the "Date Filter" menu
    And I wait up to "5" seconds for the "Schedule Visits Loading Icon" field of type "MISC_ELEMENT" in the "Scheduled Visits" pane to be invisible
    Then the "Schedule Visits Header Table" table should have at least "1" row containing the text "SMITH, NURSE"
    And the "Schedule Visits Header Table" table should have at least "1" row containing the text "JONES, DOCTOR"
    And the following visits should appear in the scheduled tab
      | SCHEDULE-1, TEST |
      | SCHEDULE-2, TEST |
      | SCHEDULE-3, TEST |
      | SCHEDULE-4, TEST |
      | SCHEDULE-5, TEST |
    When I check the "Group By Date" checkbox
    Then the "Schedule Visits Header Table" table should have at least "1" row not containing the text "SMITH, NURSE"
    And the "Schedule Visits Header Table" table should have at least "1" row not containing the text "JONES, DOCTOR"


  @Demo
  Scenario: Schedule Date Criteria
    Given I am logged into the portal with user "scheduletest" using the default password
    And I am on the "Schedule" tab
    Then the "Schedule" pane should load
    And I click the "Clear Criteria" button in the "Search Criteria" pane
    And I click the "Delete Entry" image in the "Provider Search" pane if it exists
    And I enter "SCHEDULE, TEST" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    And I enter "JONES, DOCTOR" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    And I wait up to "5" seconds for the "Schedule Visits Loading Icon" field of type "MISC_ELEMENT" in the "Scheduled Visits" pane to be invisible
    When I select "This Calendar Week" from the "Date Filter" menu
    And I wait up to "5" seconds for the "Schedule Visits Loading Icon" field of type "MISC_ELEMENT" in the "Scheduled Visits" pane to be invisible
    Then the text "%Current Date MMDDYY%" should appear in the "Visits Table" pane
    And the text "%1 day ago MMDDYY%" should appear in the "Visits Table" pane
    And the text "%1 day from now MMDDYY%" should appear in the "Visits Table" pane
    When I select "Last 7 Days" from the "Date Filter" menu
    And I wait up to "5" seconds for the "Schedule Visits Loading Icon" field of type "MISC_ELEMENT" in the "Scheduled Visits" pane to be invisible
    Then the text "%Current Date MMDDYY%" should appear in the "Visits Table" pane
    And the text "%1 day ago MMDDYY%" should appear in the "Visits Table" pane
    And the text "%1 day from now MMDDYY%" should not appear in the "Visits Table" pane
		#modifying the admit date of manually registered patient to clean up
    When I am on the "Patient Search" tab
    And I enter "Verve" in the "Last" field
    And I enter "ScheduleTest" in the "First" field
    And I select "Outpatient" from the "Visit Type" dropdown
    And I enter "SCHEDULE, TEST" in the "Scheduled MD" field
    And I click the "Scheduled MD Search" button
    And I uncheck the "Include Cancelled Visits" checkbox
    And I click the "Search for Visits" button
    And I select patient "SCHEDULETEST* VERVE" from the "Name (\d)" column in the "Visit Search Results" table
    And I click the "Edit" button
    Then the "Add Patient Content" pane should load within "5" seconds
    And I enter "%1 day ago MMDDYY%" in the "Appointment DateTime-Date" field
    And I enter "0001" in the "Appointment DateTime-Time" field
    And I click the "Save" button


  Scenario: Reassign Visit
    Given I am logged into the portal with user "scheduletest" using the default password
    And I am on the "Schedule" tab
    Then the "Schedule" pane should load
    And I click the "Clear Criteria" button in the "Search Criteria" pane
    And I click the "Delete Entry" image in the "Provider Search" pane if it exists
    And I enter "SCHEDULE, TEST" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    And the "Provider Search" table should load
    And I select "Last 7 Days" from the "Date Filter" menu
    When I check the "Group By Date" checkbox
#		When I select "VERVE, SCHEDULETEST*" from the "%1 day ago MMDDYY%" column in the "Scheduled Visits" table
    And I wait up to "5" seconds for the "Schedule Visits Loading Icon" field of type "MISC_ELEMENT" in the "Scheduled Visits" pane to be invisible
    When I select the cell containing with text "VERVE, SCHEDULETEST*" from the "%1 day ago MMDDYY%" column in the "Scheduled Visits" table
    And I click the "Reassign Visit" button
    And I enter "KADMIN, PERRY" in the "Provider Name" field in the "Reassign Visits" pane
    And I click the "Provider Lookup" button in the "Reassign Visits" pane
    And I click the "OK" button in the "Reassign Visits" pane
    And I wait "2" seconds
    Then the cell with text "VERVE, SCHEDULETEST*" from the "%1 day ago MMDDYY%" column in the "Scheduled Visits" table should not exist
	  #Check provider/service that it was reassigned to?
    And I click the "Delete Entry" image in the "Provider Search" pane if it exists
    And I enter "KADMIN, PERRY" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    And I select "Last 7 Days" from the "Date Filter" menu
    When I check the "Group By Date" checkbox
    And I wait up to "5" seconds for the "Schedule Visits Loading Icon" field of type "MISC_ELEMENT" in the "Scheduled Visits" pane to be invisible
    Then the cell with text "VERVE, SCHEDULETEST*" from the "%1 day ago MMDDYY%" column in the "Scheduled Visits" table should exist
	 # Reverting Visit Reassignment
    When I select the cell containing with text "VERVE, SCHEDULETEST*" from the "%1 day ago MMDDYY%" column in the "Scheduled Visits" table
    And I click the "Reassign Visit" button
    And I enter "SCHEDULE, TEST" in the "Provider Name" field in the "Reassign Visits" pane
    And I click the "Provider Lookup" button in the "Reassign Visits" pane
    And I click the "OK" button in the "Reassign Visits" pane
    And I wait "2" seconds


  @Demo
  Scenario: Add Charge
    Given I am logged into the portal with user "scheduletest" using the default password
    And I am on the "Schedule" tab
    Then the "Schedule" pane should load
    And I click the "Clear Criteria" button in the "Search Criteria" pane
    And I click the "Delete Entry" image in the "Provider Search" pane if it exists
    And I enter "SCHEDULE, TEST" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    And the "Provider Search" table should load
    And I select "Last 7 Days" from the "Date Filter" menu
    When I check the "Group By Date" checkbox
    And I wait up to "5" seconds for the "Schedule Visits Loading Icon" field of type "MISC_ELEMENT" in the "Scheduled Visits" pane to be invisible
    When I click the "Not Coded Outpatient" link in the cell with text "VERVE, SCHEDULETEST*" in the "%1 day ago MMDDYY%" column of the "Scheduled Visits" table
    And the "ChargeEntry" pane should load
    And I set the following charge headers
      | Name         | Value          |
      | Billing Prov | SCHEDULE, TEST |
      | Svc Site     | Outpatient     |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "31040"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    And the "ChargeEntry" pane should close
    Then the cell with text "VERVE, SCHEDULETEST*" from the "%1 day ago MMDDYY%" column in the "Scheduled Visits" table should contain text "Holding Bin"
    When I click the "Holding Bin" link in the cell with text "VERVE, SCHEDULETEST*" in the "%1 day ago MMDDYY%" column of the "Scheduled Visits" table
    Then the "ChargeEntry" pane should load
    And I click the "Close" image


  Scenario: Patient Detail
    Given I am logged into the portal with user "scheduletest" using the default password
    And I am on the "Schedule" tab
    Then the "Schedule" pane should load
    And I click the "Clear Criteria" button in the "Search Criteria" pane
    And I click the "Delete Entry" image in the "Provider Search" pane if it exists
    And I enter "SCHEDULE, TEST" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    And the "Provider Search" table should load
    And I select "Last 7 Days" from the "Date Filter" menu
    When I check the "Group By Date" checkbox
    And I wait up to "5" seconds for the "Schedule Visits Loading Icon" field of type "MISC_ELEMENT" in the "Scheduled Visits" pane to be invisible
    When I click the "Patient Detail Icon" "button" in the cell with text "VERVE, SCHEDULETEST*" in the "%1 day ago MMDDYY%" column of the "Scheduled Visits" table
    Then the "Patient Detail" pane should load
    Then the text "VERVE, SCHEDULETEST*" should appear in the "Name" field in the "Demographics" section of the "Schedule Patient Details" table
    When I click the "Close" button


  Scenario: Cancel Visit
    Given I am logged into the portal with user "scheduletest" using the default password
    And I am on the "Schedule" tab
    Then the "Schedule" pane should load
    And I click the "Clear Criteria" button in the "Search Criteria" pane
    And I click the "Delete Entry" image in the "Provider Search" pane if it exists
    And I enter "SCHEDULE, TEST" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    And the "Provider Search" table should load
    And I select "Last 7 Days" from the "Date Filter" menu
    When I check the "Group By Date" checkbox
    And I wait up to "5" seconds for the "Schedule Visits Loading Icon" field of type "MISC_ELEMENT" in the "Scheduled Visits" pane to be invisible
    When I select the cell containing with text "VERVE, SCHEDULETEST*" from the "%1 day ago MMDDYY%" column in the "Scheduled Visits" table
    When I click the "Cancel Visit" button
    And I click the "No" button in the "Question" pane
    Then the cell with text "VERVE, SCHEDULETEST*" from the "%1 day ago MMDDYY%" column in the "Scheduled Visits" table should exist
    When I select the cell containing with text "VERVE, SCHEDULETEST*" from the "%1 day ago MMDDYY%" column in the "Scheduled Visits" table
    And I click the "Cancel Visit" button
    And I click the "Yes" button in the "Question" pane
    And I wait "2" seconds
    Then the cell with text "VERVE, SCHEDULETEST*" from the "%1 day ago MMDDYY%" column in the "Scheduled Visits" table should contain text "(Cancelled)"


  @Demo
  Scenario: print schedule
    Given I am logged into the portal with user "scheduletest" using the default password
    And I am on the "Schedule" tab
    And the "Provider Search" table should load
    And I click the "Refresh" button
    And I wait up to "5" seconds for the "Schedule Visits Loading Icon" field of type "MISC_ELEMENT" in the "Scheduled Visits" pane to be invisible
    When I click the "Print" button
    Then the "Print Schedule" pane should load within "5" seconds
    And I click the "Close" button in the "Print Schedule" pane


  Scenario: Admin Scheduling Access
    When I am logged into the portal with user "pkadmin" and password "123"
    And I am on the "Admin" tab
    And I select the "User" subtab
    When I search for the user "scheduletest"
    And I select the user "scheduletest"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Patient List" from the "Edit User Settings" dropdown
    And I select "None" from the "Scheduling Access" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait up to "5" seconds for the "User Username" field of type "Text_Field" to be visible
    And I click the logout button
    And I am logged into the portal with user "scheduletest" and password "123"
    Then the following tab should not load
      | Schedule |
    When I am logged into the portal with user "pkadmin" and password "123"
    And I am on the "Admin" tab
    And I select the "User" subtab
    When I search for the user "scheduletest"
    And I select the user "scheduletest"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Patient List" from the "Edit User Settings" dropdown
    And I select "User" from the "Scheduling Access" dropdown
    And I wait "2" seconds
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "2" seconds
    And I wait up to "5" seconds for the "User Username" field of type "Text_Field" to be visible
    And I click the logout button
    And I am logged into the portal with user "scheduletest" and password "123"
    And I am on the "Schedule" tab
    Then the "Schedule" pane should load
    And I click the "Clear Criteria" button in the "Search Criteria" pane
    And I wait "2" seconds
    Then the "Provider Search" table should have "1" row containing the text "SCHEDULE, TEST"
    And I enter "KADMIN, PERRY" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    Then the "Provider Search" table should have "0" row containing the text "KADMIN, PERRY"
    When I am logged into the portal with user "pkadmin" and password "123"
    And I am on the "Admin" tab
    And I select the "User" subtab
    When I search for the user "scheduletest"
    And I select the user "scheduletest"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Patient List" from the "Edit User Settings" dropdown
    And I select "Department" from the "Scheduling Access" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait up to "5" seconds for the "User Username" field of type "Text_Field" to be visible
    And I click the logout button
    And I am logged into the portal with user "scheduletest" and password "123"
    And I am on the "Schedule" tab
    Then the "Schedule" pane should load
    And I click the "Clear Criteria" button in the "Search Criteria" pane
    And I wait "2" seconds
    Then the "Provider Search" table should have "1" row containing the text "SCHEDULE, TEST"
    And I enter "KADMIN, PERRY" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    Then the "Provider Search" table should have "1" row containing the text "KADMIN, PERRY"
    And I enter "JONES, DOCTOR" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    Then the "Provider Search" table should have "0" row containing the text "JONES, DOCTOR"
    When I am logged into the portal with user "pkadmin" and password "123"
    And I am on the "Admin" tab
    And I select the "User" subtab
    When I search for the user "scheduletest"
    And I select the user "scheduletest"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Patient List" from the "Edit User Settings" dropdown
    And I select "All" from the "Scheduling Access" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait up to "5" seconds for the "User Username" field of type "Text_Field" to be visible
    And I click the logout button
    And I am logged into the portal with user "scheduletest" and password "123"
    And I am on the "Schedule" tab
    Then the "Schedule" pane should load
    And I enter "KADMIN, PERRY" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    Then the "Provider Search" table should have "1" row containing the text "KADMIN, PERRY"
    And I enter "JONES, DOCTOR" in the "Providers" field
    And I click the "Provider Search" button in the "Search Criteria" pane
    Then the "Provider Search" table should have "1" row containing the text "JONES, DOCTOR"