@performance @selfassign
Feature: Self-Assign Report
	
	Background:
		#Given I am logged into the portal with the default user
		Given I am logged into the portal with user "pkadminv2" using the default password
		And I am on the "Admin" tab
		And I select the "System Management" subtab
		And I click the "Self Assign Report" link in the "System Management Navigation" pane
	
	#repeat these for today, 1 week, and 1 month
	@selfassign-today
	Scenario: Generate report - today
		When I enter "%Current Date MMDDYY%" in the "Start Date" field in the "Self Assignment Report" pane
		And I enter "%Current Date MMDDYY%" in the "End Date" field in the "Self Assignment Report" pane
		And I select "PKHospital-Central" from the "Facility" dropdown in the "Self Assignment Report" pane
		And I click the "Show Report" button
		Then the "Report" pane should load
	
	@selfassign-week
	Scenario: Generate report - 7 days
		When I enter "%7 days ago MMDDYYYY%" in the "Start Date" field in the "Self Assignment Report" pane
		And I enter "%Current Date MMDDYYYY%" in the "End Date" field in the "Self Assignment Report" pane
		And I select "PKHospital-Central" from the "Facility" dropdown in the "Self Assignment Report" pane
		And I click the "Show Report" button
		Then the "Report" pane should load
	
	@selfassign-month
	Scenario: Generate report - 30 days
		When I enter "%30 days ago MMDDYYYY%" in the "Start Date" field in the "Self Assignment Report" pane
		And I enter "%Current Date MMDDYYYY%" in the "End Date" field in the "Self Assignment Report" pane
		And I select "PKHospital-Central" from the "Facility" dropdown in the "Self Assignment Report" pane
		And I click the "Show Report" button
		Then the "Report" pane should load