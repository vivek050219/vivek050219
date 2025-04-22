Feature: User Preferences
	User and Preferences subtabs under Admin
	
	Background:
		Given I am logged into the portal with user "pkadminv2" using the default password
		And I am on the "Admin" tab
		And I select the "User" subtab
		
	@BuildVerificationTest @QuickTest
	Scenario: Loading of the User subtab
		Then the "User Settings" pane should load

	@QuickTestTimeout
	Scenario: Loading of the User subtab test for Jenkins timeout
		Then the "User Settings" pane should load
		And I wait "300" seconds
		Then the "User Settings" pane should load

   #Helper scenario used to test the handling of failures.  Not part of a proper admin test suite.
	@QuickTestFail
	Scenario: Fail to find the Create User pane
		Then the "Create User" pane should load
	
	@BuildVerificationTest @PortalSmoke
	Scenario: Create User
		When I click the "Create User" button
		And I wait "3" seconds
		Then the "Create User" pane should load
		When I create a temporary user
		And I wait "2" seconds
		And I click the "Create User Save" button
		And I wait "2" seconds
		And I click the "Yes" button in the "Question" pane if it exists
		And I wait "1" second
		Then I search for the temporary user
		When I select the temporary user
		And I click the "Edit" button in the "Quick Details" pane
		And I select "Provider Info" from the "Edit User Settings" dropdown
		Then the text "USER" should appear in the "Roles" field of the "Provider Information" table
		
	@PortalSmoke
	Scenario: Cancel Delete User
		Given a temporary user is in the user list
		When I search for the temporary user
		And I select the temporary user
		And I click the "Delete" button in the "Quick Details" pane
		Then the text "Do you want to proceed with deleting this user" should appear in the "Delete User" pane
		When I click the "No" button in the "Delete User" pane
		And I search for the temporary user
		Then the temporary user should appear in the user list
		
	@BuildVerificationTest @PortalSmoke
	Scenario: Delete User
		Given a temporary user is in the user list
		When I search for the temporary user
		And I select the temporary user
		And I click the "Delete" button in the "Quick Details" pane
		Then the text "Do you want to proceed with deleting this user" should appear in the "Delete User" pane
		When I check the "Delete Provider" checkbox
		And I click the "Yes" button in the "Delete User" pane
		And I search for the temporary user
		Then the temporary user should not appear in the user list	