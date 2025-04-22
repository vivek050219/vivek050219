Feature: Patient Search
  In order to find patients or visits users should be able to search for patients or visits by entering specific criteria

  Background:
		#Given I am logged into the portal with the default user
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I check the "Include Cancelled Visits" checkbox
    And I check the "Include Past Visits" checkbox

  @BuildVerificationTest
  Scenario: Searching Visits by Last Name
    When I enter "darr" in the "Last" field in the "Patient Search Criteria" pane
    And I select "Display 25 Results" from the "Max Search Results" dropdown
    And I click the "Search for Visits" button in the "Patient Search Criteria" pane
    Then only patients with last name "Darr" should appear in the "Visit Search Results" table

  @BuildVerificationTest @PortalSmoke
  Scenario: Search Patient by LastName
    When I enter "darr" in the "Last" field in the "Patient Search Criteria" pane
    And I select "Display 25 Results" from the "Max Search Results" dropdown
    And I click the "Search for Patients" button in the "Patient Search Criteria" pane
    Then only patients with last name "Darr" should appear in the "Patient Search Results" table

  @PortalSmoke
  Scenario: Patient/Visit search functionality
    Given I select "Inpatient" from the "Visit Type" dropdown
    And I select "INACTIVE" from the "Visit Status" dropdown
    And I click the "Search for Visits" button
    Then all values under the "Type" column in the "Visit Search Results" table should be "Inpatient (Inactive)"
    When I select "Outpatient" from the "Visit Type" dropdown
    And I select "PKHospital" from the "Facility" dropdown
    And I select "OP-G" from the "Unit" dropdown
    And I select "" from the "Visit Status" dropdown
    And I click the "Search for Visits" button
    Then all values under the "Type" column in the "Visit Search Results" table should be "Outpatient"
    And all values under the "Location" column in the "Visit Search Results" table should contain "PKHospital"
    When I click the "Clear Criteria" button
    And I enter "darr" in the "Last" field
    And I select "Inpatient" from the "Visit Type" dropdown
    And I uncheck the "Include Past Visits" checkbox
    And I click the "Search for Patients" button
    Then only patients with last name "Darr" should appear in the "Patient Search Results" table
    When I click the "Search for Visits" button
    Then only patients with last name "Darr" should appear in the "Visit Search Results" table
    Then all values under the "Type" column in the "Visit Search Results" table should be "Inpatient"
    And all values under the "Discharge" column in the "Visit Search Results" table should be blank
    And the "Actions" menu should have the following options
      | Add Charge |
			#|Add Form  |
      | Add Task   |
    When I click the "Clear Criteria" button
    Then Nothing should be selected in the "Visit Type" dropdown
    And Nothing should be selected in the "Facility" dropdown
    And Nothing should be selected in the "Unit" dropdown
    Then the value in the "Last" field should be blank


  @PortalSmoke
  Scenario: Add visit from search
    Given I fill in the following fields
      | Name  | Type | Value       |
      | Last  | text | ManRegVisit |
      | First | text | Greg        |
    Then I click the "Search for Visits" button
#		#Neither of these two methods are working in 9x Classic in IE -- Finds the dropdown or the menu, but can't seem to click on anything
#		#And I select "ER" from the "Create Visit" menu if it exists
#		#Then I select "ER" from the "Create Visit" dropdown if it exists
    When I click the "Create Visit" button if it exists and select "ER" from the dropdown that displays
#    And I click the "ER" link if it exists in the "Search Results" pane
    Then the "Patient Search Charge Entry" pane should load
    And the value in the "First Name" field should be "Greg"
    And the value in the "Last Name" field should be "ManRegVisit"
    When I select "ER_Manreg" from the "Add Visit Type" dropdown
    Then I fill in the following fields
      | Name                    | Type     | Value                   |
      | Middle Name             | text     | E                       |
      | Add MRN                 | text     | 234567891               |
      | Add Facility            | dropdown | PKHospital              |
      | Admit DateTime-Date     | text     | %Current Date MMDDYY%   |
      | Admit DateTime-Time     | text     | %Current Time HHMM%     |
      | Discharge DateTime-Date | text     | %1 day from now MMDDYY% |
      | Discharge DateTime-Time | text     | %Current Time HHMM%     |
    And I click the "Add and Save" button
    And I click the "Yes" button if it exists
    And I fill in the following fields
      | Name  | Type | Value       |
      | Last  | text | ManRegVisit |
      | First | text | Greg        |
      | MRN   | text | 234567891   |
    And I uncheck the "Include Cancelled Visits" checkbox
    And I uncheck the "Include Past Visits" checkbox
    When I click the "Search for Visits" button
    Then the following rows should appear in the "Visit Search Results" table
      | Name                 | MRN       | Type | Location   | Discharge               |
      | MANREGVISIT, GREG E* | 234567891 | ER   | PKHospital | %1 day from now MMDDYY% |
    When I select "Outpatient" from the "Create Visit" menu
    Then the value in the "First Name" field should be "Greg"
    And the value in the "Last Name" field should be "ManRegVisit"
    And I select "OP_Manreg" from the "Add Visit Type" dropdown
    When I fill in the following fields
      | Name                      | Type     | Value                 |
      | Middle Name               | text     | E                     |
      | Add MRN                   | text     | 234567891             |
      | Add Facility              | dropdown | PKHospital            |
      | Appointment DateTime-Date | text     | %Current Date MMDDYY% |
      | Appointment DateTime-Time | text     | %Current Time HHMM%   |
      | Account Number            | text     | 444444                |
      | Reason For Visit          | text     | Back pain             |
	  #		And I select "CAREMANAGER" from the "Relationship" dropdown
    And I click the "Add and Save" button
    And I click the "Yes" button if it exists
    And I click the "Clear Criteria" button
    And I fill in the following fields
      | Name       | Type     | Value       |
      | Last       | text     | ManRegVisit |
      | First      | text     | Greg        |
      | Visit Type | dropdown | Outpatient  |
    And I click the "Search for Visits" button
    Then the following rows should appear in the "Visit Search Results" table
      | Name                 | Visit # | Type       | Reason For Visit | Location   |
      | MANREGVISIT, GREG E* | 444444  | Outpatient | Back pain        | PKHospital |


  @PortalSmoke
  Scenario: Add patient from search
    Given I enter "Smith" in the "Last" field
    Then I enter "John" in the "First" field
    And I enter "%365 days ago MMDDYYYY%" in the "DOB" field
    And I click the "Search for Patients" button
    # Only one of these should actually run, but both are necessary since which one appears depends on if a patient with
    # the same criteria already exists
    When I click the "Create a new Patient from the search criteria" link if it exists in the "Search Results" pane
    And I click the "Add Patient" button in the "Search Results" pane if it exists
    #
    Then the "Add Patient Content" pane should load
    And the value in the "First Name" field should be "John"
    And the value in the "Last Name" field should be "Smith"
    And the value in the "DOB" field in the "Add Patient Content" pane should be "%365 days ago MMDDYYYY%"
    When I fill in the following fields
      | Name    | Type     | Value  |
      | Add MRN | text     | 123456 |
      | Gender  | dropdown | Male   |
    And I click the "Save" button
    And I click the "Yes" button if it exists
    And I click the "Search for Patients" button
    Then the following rows should appear in the "Patient Search Results" table
      | Name         | DOB                     | Gender | MRN    |
      | SMITH, JOHN* | %365 days ago MMDDYYYY% | Male   | 123456 |


  @PortalSmoke
  Scenario: Edit visit from search
    Given I enter "ManRegVisit" in the "Last" field
    Then I enter "Greg" in the "First" field
    And I enter "1" in the "Admit in last N days" field
    And I select "ER" from the "Visit Type" dropdown
    And I uncheck the "Include Cancelled Visits" checkbox
    And I click the "Search for Visits" button
#    And I add an "ER" visit from the Patient Search tab -- IE just doesn't seem to be able to click on menu options in PKmenus anymore
    And I sort the "Visit Search Results" table chronologically by the "Admit/Appt" column in "Descending" order
    And I select patient "MANREGVISIT, GREG E*" from the "Name" column in the "Visit Search Results" table
    And I click the "Edit" button
    And the "Patient Search Charge Entry" pane should load
	 #And I wait "2" seconds
    And I fill in the following fields
      | Name         | Type     | Value      |
      | Add Facility | dropdown | PKHospital |
      | Add Unit     | dropdown | 5R         |
      | Room         | dropdown | 502        |
    When I click the "Save" button
    Then rows containing the following should appear in the "Visit Search Results" table
      | Name                 | Location          |
      | MANREGVISIT, GREG E* | 5R.502.PKHospital |


  @PortalSmoke
  Scenario: Reassign visit from search
    Given I enter "ManRegVisit" in the "Last" field
    Then I enter "Greg" in the "First" field
    And I enter "1" in the "Admit in last N days" field
    And I select "ER" from the "Visit Type" dropdown
    And I uncheck the "Include Cancelled Visits" checkbox
    And I click the "Search for Visits" button
#    And I add an "ER" visit from the Patient Search tab -- IE just doesn't seem to be able to click on menu options in PKmenus anymore
    And I sort the "Visit Search Results" table chronologically by the "Admit/Appt" column in "Descending" order
    And I select patient "MANREGVISIT, GREG E*" from the "Name" column in the "Visit Search Results" table
    And I click the "Reassign Visit(s)" button
    And I wait "2" seconds
    And I enter "KADMINV2, PERRY" in the "Reassign Scheduled MD" field
    And I select "Card Group" from the "Reassign Med Service" dropdown
    And I click the "OK" button
    And I select "Card Group" from the "Med Service" dropdown
    And I enter "KADMINV2, PERRY" in the "Scheduled MD" field
    And I click the "Search for Visits" button
    Then the following rows should appear in the "Visit Search Results" table
      | Name                 | Type |
      | MANREGVISIT, GREG E* | ER   |


  @PortalSmoke
  Scenario: Cancel visit from search
    Given I uncheck the "Include Cancelled Visits" checkbox
    Then I fill in the following fields
      | Name                 | Type     | Value       |
      | Last                 | text     | ManRegVisit |
      | First                | text     | Greg        |
      | Visit Type           | dropdown | ER          |
      | Admit in last N days | text     | 1           |
    And I click the "Search for Visits" button
#    And I add an "ER" visit from the Patient Search tab -- IE just doesn't seem to be able to click on menu options in PKmenus anymore
    And I sort the "Visit Search Results" table chronologically by the "Admit/Appt" column in "Descending" order
    And I select patient "MANREGVISIT, GREG E*" from the "Name" column in the "Visit Search Results" table
    And I click the "Cancel Visit(s)" button
    And I click the "Yes" button
	 #And I wait "2" seconds
    And I check the "Include Cancelled Visits" checkbox in the "Patient Search Criteria" pane
    And I click the "Search for Visits" button
    Then the following rows should appear in the "Visit Search Results" table
      | Name                 | Type           | Location    |
      | MANREGVISIT, GREG E* | ER (Cancelled) | (Cancelled) |


  @PortalSmoke @Demo
  Scenario: Select Visit and Add to Patient List
    Given I am on the "Patient List V2" tab
    And "Molly Darr" is not on the patient list
    Then I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I uncheck the "Include Cancelled Visits" checkbox
    And I uncheck the "Include Past Visits" checkbox
    And I enter "Darr" in the "Last" field
    And I enter "Molly" in the "First" field
    And I click the "Search for Visits" button
    And I select patient "Darr, Molly" from the "Name" column in the "Visit Search Results" table
    And I click the "AddtoPatientList" button
    And I click the "Add" button if it exists
    When I am on the "Patient List V2" tab
    Then patient "Molly Darr" should be on the patient list


#   Merge two of the same patient added manually and then merge 2 visits
  @PortalSmoke
  Scenario: Merge 2 of the Same Patient Then Merge 2 of the Same Visit[DEV-77628][DEV-78032][DEV-78124][DEV-79297][CI-15427]
    Given I am logged into the portal with user "patientmerge1" using the default password
    Then I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I check the "Include Cancelled Visits" checkbox
    And I check the "Include Past Visits" checkbox
    Then I enter "MergeTest" in the "Last" field in the "Patient Search Criteria" pane
    Then I enter "Patient" in the "First" field in the "Patient Search Criteria" pane
    And I click the "Search for Patients" button
    Then I click the "Add Patient" button if it exists
    And I click the "Create a new Patient from the search criteria" link if it exists in the "Search Results" pane
    Then the "Add Patient Content" pane should load
    And I enter "ONE" in the "Middle Name" field in the "Add Patient Content" pane
    And I enter "123456789" in the "MRN textbox" field in the "Add Patient Content" pane
    Then I click the "Save" button in the "Add Patient Content" pane
    And I click the "Yes" button if it exists
    And I select patient "MERGETEST, PATIENT ONE*" from the "Name" column in the "Patient Search Results" table
#    @Then("^I click the \"(.*)\" button( if it exists)? and select \"(.*)\" from the dropdown that displays$")
#    Then I click the "Create Visit" button and select "Inpatient" from the dropdown that displays  -- this one's not wokring either.  Is the pane/frame diff after adding a patient like this?
#    But works fine when just searching for visits or not adding a new patient.
# #These 2 steps below aren't working in IE anymore
    Then I click the "Create Visit" button
    And I select "Inpatient" from the "Create Visit" menu
    And I select "PKHospital" from the "AddFacility" dropdown
    And I enter "%Current Date MMDDYY%" in the "AdmitDateTime-Date" field
    And I enter "%Current Time HHMM%" in the "AdmitDateTime-Time" field
    Then I click the "Add and Save" button
    When I click the "Add Patient" button
    Then the "Add Patient Content" pane should load
    And I enter "O" in the "Middle Name" field in the "Add Patient Content" pane
    And I enter "123456789" in the "MRN textbox" field in the "Add Patient Content" pane
    Then I click the "Save" button in the "Add Patient Content" pane
    And I click the "Yes" button if it exists
    And I select patient "MERGETEST, PATIENT O*" from the "Name" column in the "Patient Search Results" table
    Then I click the "Create Visit" button
    And I select "Inpatient" from the "Create Visit" menu
    And I select "PKHospital" from the "AddFacility" dropdown
    And I enter "%Current Date MMDDYY%" in the "AdmitDateTime-Date" field
    And I enter "%Current Time HHMM%" in the "AdmitDateTime-Time" field
    Then I click the "Add and Save" button
    And I click the "Search for Visits" button
    And I sort the "Visit Search Results" table chronologically by the "Admit/Appt" column in "Descending" order
    Then I select the "Merge" link in the row with "MERGETEST, PATIENT O*" as the value under "Name" in the "Visit Search Results" table
    And I click the "Merge Patients" button
    And I select patient "MERGETEST, PATIENT ONE*" from the "Name" column in the "Merge Patients" table
    Then I click the "Resolve" button
    And the "Visit Search Results" table should have "0" rows containing the text "MERGETEST, PATIENT O*"
    And the "Visit Search Results" table should have at least "2" rows containing the text "MERGETEST, PATIENT ONE*"
    And I sort the "Visit Search Results" table chronologically by the "Admit/Appt" column in "Descending" order
    Then I select the "Merge" link in the row with "MERGETEST, PATIENT ONE*" as the value under "Name" in the "Visit Search Results" table
    And I click the "Merge Visits" button
    And I sort the "Merge Visits" table chronologically by the "Admit/Appt" column in "Descending" order
    And I select patient "MERGETEST, PATIENT ONE*" from the "Name" column in the "Merge Visits" table
    Then I click the "Resolve" button
		#		#Per Umesh, if the merge visits doesn't work the 1st time, it should work on trying it again. -- HIC 01/14/19
    Then if the "Error Dialog" pane appears try to merge the visits again
    And the "Error Dialog" pane should not appear with the text "Based on your system settings, you cannot merge these visits. Cannot merge visits from two separate patients"
    Then the "Visit Search Results" table should have at least "1" row containing the text "MERGETEST, PATIENT ONE*"
    And I select patient "MERGETEST, PATIENT ONE*" from the "Name" column in the "Visit Search Results" table
    And I click the "Edit" button
    And I enter "X" in the "Middle Name" field in the "Add Patient Content" pane
#    And I enter "%Current Date MMDDYY%" in the "AdmitDateTime-Date" field
    And I enter "%Current Time HHMM%" in the "AdmitDateTime-Time" field
    And I click the "Save" button in the "Add Patient Content" pane

## This is just for debugging
#  Scenario: Test PK Dropdown for Create Visit
#    Given I am logged into the portal with user "patientmerge1" using the default password
#    Then I am on the "Patient Search" tab
#    And I click the "Clear Criteria" button
#    And I check the "Include Cancelled Visits" checkbox
#    And I check the "Include Past Visits" checkbox
#    Then I enter "MergeTest" in the "Last" field in the "Patient Search Criteria" pane
#    Then I enter "Patient" in the "First" field in the "Patient Search Criteria" pane
#    And I click the "Search for Visits" button
#    And I select patient "MERGETEST, PATIENT X*" from the "Name" column in the "Visit Search Results" table
##      Then I select "Inpatient" from the "Create Visit" pkdropdown
#    Then I click the "Create Visit" button and select "Inpatient" from the dropdown that displays