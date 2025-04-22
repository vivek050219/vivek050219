Feature: Forms
	Validate that the Forms window loads correctly

	Background:
        Given I am logged into the portal with user "pkadminv2" using the default password
		And I am on the "Forms" tab
	
	@BuildVerificationTest
	Scenario: Loading of the Forms tab with correct subtabs
		Then the following subtabs should load
			|Forms				|
			|Measures			|