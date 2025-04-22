Feature: Patient List display options

	Background:
		#Given I am logged into the portal with the default user
		Given I am logged into the portal with user "pkadminv2" using the default password
		And I am on the "Patient List V2" tab
		And I use the API to create a patient list named "Patient List Display" owned by "pkadminv2" with the following parameters
			| Type   | Name            | Value      |
			| Filter | Medical Service | Card Group |
		And I click the "Refresh Patient List" button
		And I select "Patient List Display" from the "Patient List" menu
		And "Molly Darr" is on the patient list
		And the patient list is maximized
		
	@PortalSmoke
	Scenario: View List [DEV-47409]
		#no patients on list - should give message as such
		Given there are no patients on the patient list
		Then the text "No patients meet the current patient list criteria." should appear in the "Patient List" pane
		#this adds Molly Darr - the second step verifies it
		Given "Molly Darr" is on the patient list
		Then patient "Molly Darr" should be on the patient list

	@PortalSmoke @donotrun
	Scenario: Action menu
		Then the "Actions" "PKMenu" should be visible
	@PortalSmoke @donotrun
	Scenario: Action menu Fail
		Then the "Fail" "PKMenu" should be visible
		
	@PortalSmoke
	Scenario: Sort Patient List by Last Name
		#need at least two patients to check sorting
		Given "Mona Angeline" is on the patient list
		#sort by something else to ensure correct order
		When I select "Location" from the "Actions" menu
		And I select "Last Name" from the "Actions" menu
		Then the "Patient List" should be sorted by "Last Name" in "Ascending" order
		When I select "Last Name" from the "Actions" menu
		Then the "Patient List" should be sorted by "Last Name" in "Descending" order

	@PortalSmoke
	Scenario: Sort Patient List by Location [DEV-53137]
		#need at least two patients to check sorting
		Given "Mona Angeline" is on the patient list
		#sort by something else to ensure correct order
		When I select "Last Name" from the "Actions" menu
		When I select "Location" from the "Actions" menu
		Then the "Patient List" should be sorted by "Location" in "Ascending" order
		When I select "Location" from the "Actions" menu
		Then the "Patient List" should be sorted by "Location" in "Descending" order

	@PortalSmoke @donotrun
	Scenario: Sort Patient List by Age
		#need at least two patients to check sorting
		Given "Mona Angeline" is on the patient list
	 	#sort by something else to ensure correct order
		When I select "Location" from the "Actions" menu
		When I select "Age" from the "Actions" menu
		Then the "Patient List" should be sorted by "Age" in "Ascending" order
		When I select "Age" from the "Actions" menu
		Then the "Patient List" should be sorted by "Age" in "Descending" order
		
	@PortalSmoke @Demo @donotrun
	Scenario: Filter menu
		Then the "Patient Filter" menu should have the following options
			|All          |
			|Non-Verified |
			|Added By User|
		When I select "Added By User" from the "Patient Filter" menu
		Then patient "Molly Darr" should be on the patient list
		When I select "All" from the "Patient Filter" menu
		Then patient "Molly Darr" should be on the patient list
	
	@PortalSmoke @Demo @donotrun
	Scenario: Profile menu
		Then the "Profile" menu should have the following options
			|No Profile Selected |
			|_Profile            |
			|CPOEPats            |
		When I select "CPOEPats" from the "Profile" menu
		Then patient "Molly Darr" should be on the patient list
		When I select "_Profile" from the "Profile" menu
		Then patient "Molly Darr" should be on the patient list
			
	@PortalSmoke @PCOnly @donotrun
	Scenario: Print patient list
		When I select "Patient List" from the "Actions" menu
		Then the "Print" window should open
		And the contents of the "Print Patient List" table should contain the results of the "Patient List Print Preview" query
		#When I run the AutoIt script "Print to XPS"
		#Then the "Print" window should close
		
	@PortalSmoke
	Scenario: Clinical rounding report screen
		When I select "Clinical Rounding Report" from the "Actions" menu
		#Then the contents of the "Clinical Rounding Report Patient List" table should contain the results of the "Patient List Clinical Rounding Report" query
		Then the "Clinical Rounding Report Patient List" table should load
		When I select "CRRSingle" from the "Select Report Type" dropdown
		And I select "the first item" in the "Clinical Rounding Report Patient List" table
		And I click the "Generate Report" button
		And I wait "2" seconds
		Then the "Clinical Rounding Report" pane should load
		When I click the "Close" button in the "Clinical Rounding Report" pane
		#Then the "Clinical Rounding Report" pane should close
		
	@PortalSmoke
	Scenario: Patient List Min/Max
		#Given there are at least "20" patients on the patient list
		#And the patient list is maximized
		And the patient list is minimized
		#Then the "Patient Filter" "Menu" should not be visible
		#And the "Profile" "Menu" should not be visible
		Then patient "Molly Darr" should be on the patient list
		#make sure still possible to select patient
		When I select patient "Molly Darr" from the patient list
		Then the text "DARR, MOLLY" should appear in the "Header" pane
		And the patient list is maximized
		#Then the "Patient Filter" "Menu" should be visible
		#And the "Profile" "Menu" should be visible