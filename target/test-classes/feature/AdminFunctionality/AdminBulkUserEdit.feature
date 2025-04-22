Feature: Admin BulkUser Edit
# feature file completely developed by Offshore team

	Background:
		Given I am logged into the portal with user "pkadminv2" using the default password
		And I am on the "Admin" tab

	@PortalSmoke
	Scenario: Admin BulkUserEdit
	#Verify the BulkUser Edit settings display on UI and the changes saved
		#Verify the BulkUser Edit settings display on UI and the changes saved
		#Check the user available in the system
		Given I select the "User" subtab
		And the user "user auto" with username "autouser" and password "123" is in the user list
		And I select the "Bulk User Edit" subtab
		And I wait "2" seconds
		Then the "User Search" pane should load
		When I enter "autouser" in the "UserName/ID" field in the "User Search" pane
		And I click the "SearchBulkUser" button
		Then the "BulkUserSearchResults" table should load
		And the user "autouser" should appear in the "Bulk User Search Results" pane
		When I select the user "autouser" in the "Bulk User Search Results" pane
		And I click the "Add Selected Users" button
		Then the "BulkUserListResults" table should load
		And the user "autouser" should appear in the "Users to Edit" pane 
		When I select the user "autouser" in the "Users to Edit" pane
		And I click the "Remove Selected Users" button
		Then the user "autouser" should not appear in the "Users to Edit" pane

	@PortalSmoke
	Scenario: Admin BulkUserEdit SetPreferenceSettings
    	#Set the preference settings for selected user
		Given I select the "Bulk User Edit" subtab
		And I wait "2" seconds
		Then the "User Search" pane should load
		When I enter "autouser" in the "UserName/ID" field in the "User Search" pane
		And I click the "SearchBulkUser" button
		Then the "BulkUserSearchResults" table should load
		And the user "autouser" should appear in the "Bulk User Search Results" pane
		When I select the user "autouser" in the "Bulk User Search Results" pane
		And I click the "Add Selected Users" button
		Then the "BulkUserListResults" table should load
		And the user "autouser" should appear in the "Users to Edit" pane
		When I select the user "autouser" in the "Users to Edit" pane
		Then the "Preference Settings" pane should load
		And I click the "General Category Expand" image in the "Preference Settings" pane if it exists
		When I check the "PATAccessLevel" checkbox in the "Preference Settings" pane
		And I select "Level 0" from the "PatAccessLevel" dropdown in the "Preference Settings" pane
		And I click the "Set Preferences" button
		Then the text "This will set the 1 selected preference(s) for the 1 user(s) you have chosen." should appear in the "Question" pane
		#And the text "This can not be undone, are you sure that you want to continue?" should appear in the "Question" pane
		When I click the "Yes" button in the "Question" pane
		And I wait "1" second
		Then the text "All preferences were set successfully!" should appear in the "Information" pane
		When I click the "OK" button in the "Information" pane
		When I click the "Reset" button in the "User Search" pane
		And I enter "autouser" in the "UserName/ID" field in the "User Search" pane
		And I select "0" from the "AccessLevel" dropdown in the "User Search" pane
		And I click the "SearchBulkUser" button
		Then the "BulkUserSearchResults" table should load
		And the user "autouser" should appear in the "Bulk User Search Results" pane
