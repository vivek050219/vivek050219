@PortalSmoke
Feature: Admin Institution Preferences
  Institution subtab under Admin

  Background:
		#Given I am logged into the portal with the default user
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab


  Scenario: Device
		#verify the Device settings page under Institution settings
    When I select "Device" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    Then the "Device Settings" pane should load
    And the following fields should display in the "Device Settings" pane
      | Name                                                               | Type     |
      | Require Login after HH Timeout                                     | radio    |
      | Require Login after N minutes of Inactivity                        | text     |
      | Lock User after nLogin Attempts                                    | dropdown |
      | Disable Access after N login attempts via the web                  | dropdown |
      | Disable Access after N login attempts to the server via the device | dropdown |
			#|Submission Timer Interval                                          |text     |
      | Clear HH Data After Maximum Login Attempts on HH                   | radio    |
      | Manage Handheld Modules [Edit]                                     | link     |
      | Change Supported Version                                           | link     |
			#Below step related radio button "Show Web Views" is removed due to DEV-45246
			#|Show Web Views                                                     |radio    |
      | Enter text for Push Notification                                   | text     |
    When I click the "Manage Handheld Modules" edit link in the "Device Settings" pane
    And I click the "Upload New Android Binaries" button
		#And I wait "1" second
    Then the "Browse for File" pane should load
    When I click the "Cancel" button in the "Browse for File" pane
    Then the "Browse for File" pane should close


  Scenario: Patient List
    When I select "Patient List" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    Then the "Patient List Settings" pane should load
    And the following fields should display in the "Patient List Settings" pane
      | Name                                     | Type     |
      | Account Number Patient List Field Labels | text     |
      | SSN_PatientList Field Label              | text     |
#			|Maximum Number of Patients on the Short List when Populating |text     |
      | Patient Info Fields Account Number       | check    |
      | SSN_Patient Info Field                   | check    |
      | Allow Auto Verification                  | radio    |
#			|Allow Patient List Manipulation                              |radio    |
#			|Allow Get Patients                                           |radio    |
      | Visit Merging                            | dropdown |


# verify the Charge Capture settings page under Institution settings
  Scenario: Charge Capture Enable Code Edits
    Given I select "Charge Capture" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    Then the "Charge Capture Settings" pane should load
    And the following fields should display in the "Charge Capture Settings" pane
      | Name                             | Type  |
      | Billing Area Requires ID         | radio |
      | Require MRN                      | radio |
      | Show Biller Comments             | radio |
      | Enable Batch Entry               | radio |
      | Configure Billing Routers [Edit] | link  |
      | Add/Edit Charge Headers [Edit]   | link  |
		#When I click the "Code Edits" edit link in the "Charge Capture Settings" pane
#		And I click the "Enable Code Edit Types" link in the "Charge Capture Settings" pane
#		Then the "Edit Validity Dictionaries" pane should load
#		When I check the "Age-Server" checkbox
#		And I click the "OK" button in the "Edit Validity Dictionaries" pane
#		Then the "Charge Capture Settings" pane should load


# Verify the code Edits Alert for the Patients less than 64 year old
  Scenario: Charge Capture Code Edits Alert
		# I am logged into the portal with user "addchargeuser1" using the default password
    Given I am on the "Patient Search" tab
    Then I click the "Clear Criteria" button
    And I enter "Angeline" in the "Last" field in the "Patient Search Criteria" pane
    And I enter "Mona" in the "First" field in the "Patient Search Criteria" pane
    And I select "ACTIVE" from the "Visit Status" dropdown
    And I uncheck the "Include Cancelled Visits" checkbox
    And I uncheck the "Include Past Visits" checkbox
    And I click the "Search for Visits" button
    Then the "Visit Search Results" table should load
    When I click the "View Detail" button
    And I wait "2" seconds
    Then the "Patient Details" pane should load
    And I wait "4" seconds
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I wait "2" seconds
		#And I select "Verve" from the "Bill Area" tabledropdown
		#And I select "Inpatient" from the "Svc Site" tabledropdown
    And I set the following charge headers
      | Name         | Value           |
      | Bill Area    | Verve           |
      | Billing Prov | KADMINV2, PERRY |
      | Svc Site     | Inpatient       |
    And I enter the CPT code "99252"
    And I enter the ICD-10 code "B36.0"
		#And I click the "Check for edits" link in the "Charge Entry" pane
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "No Errors Found" should appear in the "Charge Entry" pane
		#And I click the "Cancel" button in the "Charge Entry" pane
    And I click the "CloseX" image
    And I click the "Close" button in the "Patient Details" pane


  @donotrun
  Scenario: Charge Capture Disable CodeEdits
		# verify the Charge Capture settings page under Institution settings
    When I select "Charge Capture" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    Then the "Charge Capture Settings" pane should load
		#When I click the "Code Edits" edit link in the "Charge Capture Settings" pane
    When I click the "Enable Code Edit Types" link in the "Charge Capture Settings" pane
    Then the "Edit Validity Dictionaries" pane should load
    When I uncheck the "Age-Server" checkbox
    And I click the "OK" button in the "Edit Validity Dictionaries" pane
    Then the "Charge Capture Settings" pane should load


  Scenario: Charge Capture Code Edits NoAlert
		# Verify the No code Edits Alert for the Patients less than 64 year old
		#Given I am logged into the portal with user "addchargeuser1" using the default password
    When I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I enter "Angeline" in the "Last" field in the "Patient Search Criteria" pane
    And I enter "Mona" in the "First" field in the "Patient Search Criteria" pane
    And I select "ACTIVE" from the "Visit Status" dropdown
    And I uncheck the "Include Cancelled Visits" checkbox
    And I uncheck the "Include Past Visits" checkbox
    And I click the "Search for Visits" button
    Then the "Visit Search Results" table should load
    And I click the "View Detail" button
    And I wait "2" seconds
    Then the "Patient Details" pane should load
    And I wait "2" seconds
    And I select "Add Charge" from the "Patient Header Actions" menu
		#And I select "Verve" from the "Bill Area" tabledropdown
		#And I select "Inpatient" from the "Svc Site" tabledropdown
    And I set the following charge headers
      | Name         | Value           |
      | Bill Area    | Verve           |
      | Billing Prov | KADMINV2, PERRY |
      | Svc Site     | Inpatient       |
    And I enter the CPT code "01920"
    And I enter the ICD-10 code "B36.0"
		#And I click the "Check for edits" link in the "Charge Entry" pane
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "No Errors Found" should appear in the "Charge Entry" pane
		#Then the text "There are no errors / warnings / code edits" should appear in the "Code Edits" section in the "Charge Entry" pane
		#And I click the "Cancel" button in the "Charge Entry" pane
    And I click the "CloseX" image
    And I click the "Close" button in the "Patient Details" pane


  Scenario: Lab Results
    When I select "Lab Results" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    Then the "Lab Results Settings" pane should load


  Scenario: Meds
    When I select "Medications" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    Then the "Medications Settings" pane should load
    And the following fields should display in the "Medications Settings" pane
      | Name                                         | Type     |
      | Default of days for medication order history | dropdown |
      | Days for MAR History                         | dropdown |


  Scenario: Clinical Notes
    When I select "Clinical Notes" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    Then the "Clinical Notes Settings" pane should load
    And the following fields should display in the "Clinical Notes Settings" pane
      | Name                                                           | Type |
#			|Default of instances for all clinical note types               |dropdown |
      | Max Of Days Worth Of Notes To Keep Per Patient On The Handheld | text |


  Scenario: Orders
    When I select "Orders" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    Then the "Orders Settings" pane should load
    And the following fields should display in the "Orders Settings" pane
      | Name                                   | Type     |
      | DefaultDays Back For AllOrder Types    | dropdown |
      | DefaultDays Forward For AllOrder Types | dropdown |


  Scenario: Problem List
    When I select "Problem List" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    Then the "Problem List Settings" pane should load
    And the following fields should display in the "Problem List Settings" pane
      | Name                             | Type |
      | Nomenclature Vocabularies [Edit] | link |
			# Commented below  steps, below options are removed from build 8.1.5 as per JIRA DEV-46917
   			#|Allow Users To Toggle Between Public and Private |radio |
			#|Create New Problems As Public                    |radio |


  Scenario: Test Results
    When I select "Test Results" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    Then the "Test Results Settings" pane should load
    And the following fields should display in the "Test Results Settings" pane
      | Name                                                             | Type     |
      | Default Instances For Test Types                                 | dropdown |
      | Maximum of Days Worth of Test Data to Keep Per Patient on the HH | text     |


  Scenario: Sign Out
    When I select "Sign-Out" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    Then the "SignOut Settings" pane should load
    And the following fields should display in the "SignOut Settings" pane
      | Name                    | Type |
      | Task Definitions [Edit] | link |
      | Macros [Edit]           | link |


  Scenario: Vitals IO
    When I select "Vitals and I/Os" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    Then the "Vitals And IOs Settings" pane should load
    And the following fields should display in the "Vitals And IOs Settings" pane
      | Name                             | Type     |
      | Default No Days For Vital Types  | dropdown |
      | Default No Days For All IO Types | dropdown |
      | First Shift Start Time           | dropdown |
      | Shift Date To Display            | radio    |


  Scenario: NoteWriter
    When I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    Then the "NoteWriter Settings" pane should load
    And the following fields should display in the "NoteWriter Settings" pane
      | Name                               | Type     |
      | Note Templates [Edit]              | link     |
      | Note Auto Save Frequency           | dropdown |
      | eSignature Validation Method       | dropdown |
      | Clinical Notes Test Results Layout | dropdown |


  Scenario: Charge Capture
    When I select "Charge Capture" from the "Edit InstitutionSettings" dropdown in the "Institution Settings" pane
    Then the "Charge Capture Settings" pane should load
    And the following fields should display in the "Charge Capture Settings" pane
      | Name                                                                      | Type     |
      | Update Charges/Modifiers [Edit]                                           | link     |
      | Billing Area Requires ID                                                  | radio    |
      | Configure Billing Routers  [Edit]                                         | link     |
      | Configure Service Sites  [Edit]                                           | link     |
      | Add/Edit Charge Headers  [Edit]                                           | link     |
      | Check Validity Service Date                                               | radio    |
      | Require MRN                                                               | radio    |
      | Require Account Number                                                    | radio    |
      | Are Visits with a Status of Cancelled Considered Billable                 | radio    |
      | Are Visits with a Status of Inactive Considered Billable                  | radio    |
#			|Enable Code Edit Types                                                    |link     |
      | Extension period before draft expires                                     | dropdown |
      | Allow Sending Transactions For Manually Registered Patients To The Outbox | dropdown |
      | Allow Free Text Errors To Go To Outbox                                    | radio    |
      | Add GC Modifier Prompt                                                    | text     |
      | Show Biller Comments                                                      | radio    |
      | LabelMissing Charges Filter                                               | text     |
      | Auto-Added Code Entry [Edit]                                              | link     |
      | Enable Batch Entry                                                        | radio    |
      | PQRS Reporting Period                                                     | dropdown |
      | Billing File Purge Threshold                                              | text     |
      | Require NDC Collection                                                    | radio    |
      | Allow Free Text NDC Values                                                | radio    |
      | Manage Field Dictionary                                                   | link     |
      | Manage Sections                                                           | link     |
      | CDM Preferences                                                           | link     |
      | Manage Infusion                                                           | link     |
      | Manage NDC                                                                | link     |


  Scenario: eSignature
    When I select "eSignature" from the "EditInstitutionSettings" dropdown in the "Institution Settings" pane
    Then the "eSignature Settings" pane should load
    And the following fields should display in the "eSignature Settings" pane
      | Name                                                               | Type     |
      | Enable Sign All                                                    | radio    |
      | Enable Saved PIN                                                   | radio    |
      | Minutes before saved PIN is timed out                              | text     |
#			|Must Scroll to Bottom to Sign                                      |radio    |
      | Must Scroll Through All Signature Blocks to Sign Scanned Documents | radio    |
      | Days Before Unsigned Report is Marked Critically Overdue           | text     |
      | Validation Method                                                  | dropdown |
#			|Send Signed Reports To SourceSystem                                |dropdown |
      | Allow Decline                                                      | radio    |
      | Number of Days Documents Remain in Declined State                  | text     |


  Scenario: View Session Report
    When I click the "View Reports" button
    Then the "System Reports" pane should load
    And I select "Session Report" from the "Report Type" dropdown in the "System Reports" pane
    And I select "Today" from the "Date Range" dropdown in the "Select Report Criteria" pane
	 	#Commented below step as all departments are selected by default
	 	#And I select All departments under select report criteria pane
    And I click the "OK" button in the "Select Report Criteria" pane
    Then the "Session Report" table should load
    When I click the "Return to System Reports" link in the "Session Report" pane
    Then the "System Reports" pane should load


  Scenario: View Reports Usage Report
		# During execution, page gets refresh and navigates back to Institution main while returning to "System Reports" form Report result pane
    When I click the "View Reports" button
    Then the "System Reports" pane should load
    And I select "Usage Report" from the "Report Type" dropdown in the "System Reports" pane
    And I select "Today" from the "Date Range" dropdown in the "Select Report Criteria" pane
		#Commented below step as all departments are selected by default
	 	#And I select All departments under select report criteria pane
    And I click the "OK" button in the "Select Report Criteria" pane
    Then the "Usage Report" table should load
    When I click the "Return to System Reports" link in the "Usage Report" pane
    Then the "System Reports" pane should load

	#Performance issue: DEV-39747

  Scenario: View Reports Session Logs
    When I click the "View Reports" button
    And I select "Session Logs" from the "Report Type" dropdown
		#7 days of data causes a script issue in IE8.  "Yesterday" should be good enough.
    And I select "Last 3 days" from the "Date Range" dropdown in the "Select Report Criteria" pane
    And I select "All" from the "Session Type" dropdown in the "Select Report Criteria" pane
		#Commented below step as all departments are selected by default
	 	#And I select All departments under select report criteria pane
    And I click the "OK" button in the "Select Report Criteria" pane
		#Header holds a row under table body, Hence checking for minimum of 2 rows
    Then the "Sessions Logs" table should have at least "2" rows
    When I click the "Return to System Reports" link in the "Session Logs" pane
    Then the "System Reports" pane should load


  Scenario: View Reports Event Logs
    When I click the "View Reports" button
    And I select "Event Logs" from the "Report Type" dropdown
		#And I wait "2" seconds
    And I select "Last 7 days" from the "Date Range" dropdown in the "Select Report Criteria" pane
		#Commented below step as all departments are selected by default
	 	#And I select All departments under select report criteria pane
    And I click the "OK" button in the "Select Report Criteria" pane
    Then the "Event Logs" table should load
		#Header holds a row under table body, Hence checking for minimum of 2 rows
		#There is no data related to EventLog for HH
    Then the "Event Logs" table should load with the following columns
      | Event Id   |
      | Log Id     |
      | Event Time |
      | Type       |
      | Label      |
      | Message    |
    When I click the "Return to System Reports" link in the "Event Logs" pane
    Then the "System Reports" pane should load

