Feature: Provider Directory
	Validate that the Provider Directory window loads correctly
	
	Background:
		Given I am logged into the portal with user "pkadminv2" using the default password
		And I am on the "Provider Directory" tab
		
	@BuildVerificationTest 
	Scenario: Loading of the Provider Directory window
		Then the "Provider Directory" pane should load

	@PortalSmoke @Demo
	Scenario: Provider Directory results
	When I click the "Search" button in the "Provider Directory Search" pane
	Then the "Provider Directory" table should load
	And the "Provider Directory" table should have at least "2" rows