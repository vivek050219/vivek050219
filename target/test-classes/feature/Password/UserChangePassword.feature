@PasswordTest
Feature: User Change Password Validation

	# The change password dialog and behaves differently than the set password dialog (in user creation).
	# Need to test that both behave as expected.
	# Create a test user beforehand and log in as that test user.
	Background:
		Given I have created a temporary password user

	Scenario: Change Password - Error When Wrong Password Is Entered in Current Password Field
		Given I login as my temporary user
		And I am on the "Preferences" tab
		And I click the "Preference" element
		And I click the "Edit Password Link" element
		And I enter "zzz" in the "Current Password" field
		And I enter "zzz" in the "New Password" field
		And I enter "zzz" in the "New Password Verification" field
		And I click the "Save" button in the "Change Password" pane
		Then An error message should appear with the text "Password entered does not match user's current password"
		And I click the "Cancel" button in the "Change Password" pane

	# error occurred setting your new password
	# An error message should appear when the new password is the same as the old password
	Scenario: Change Password - Error When New Password Is the Same As Old Password
		Given I login as my temporary user
		And I am on the "Preferences" tab
		And I click the "Edit Password Link" element
		And I enter my temporary user's password into the "Current Password" field
		And I enter my temporary user's password into the "New Password" field
		And I enter my temporary user's password into the "New Password Verification" field
		And I click the "Save" button in the "Change Password" pane
		Then An error message should appear with the text "New password cannot be the same as previous password"
		And I click the "Cancel" button in the "Change Password" pane

  # An error message should appear when the new password does not match the new password confirmation
	Scenario: Change Password - Error When Password Does Not Match Confirmation
		Given I login as my temporary user
		And I am on the "Preferences" tab
		And I click the "Edit Password Link" element
		And I enter my temporary user's password into the "Current Password" field
		And I enter "123" in the "New Password" field
		And I enter "124" in the "New Password Verification" field
		And I click the "Save" button in the "Change Password" pane
		Then There should be an alert with the text "New password fields do not match"
		And I dismiss the alert
		And I click the "Cancel" button in the "Change Password" pane

	Scenario: Change Password - Error When New Password Is Too Short
		Given I login as my temporary user
		And I am on the "Preferences" tab
		And I click the "Edit Password Link" element
		And I enter my temporary user's password into the "Current Password" field
		And I enter "12" in the "New Password" field
		And I enter "12" in the "New Password Verification" field
		And I click the "Save" button in the "Change Password" pane
		Then An error message should appear with the text "Password is too short"
		And I click the "Cancel" button in the "Change Password" pane

	Scenario: Change Password - Error When New Password Is Too Long
		Given I login as my temporary user
		And I am on the "Preferences" tab
		And I click the "Edit Password Link" element
		And I enter my temporary user's password into the "Current Password" field
		And I enter "aaaaaaaaaaaaaaaaaaaaaaaaaaaa" in the "New Password" field
		# Replace with regex
		Then There should be an alert with the text "You can only enter 20 characters for the password field"
		And I dismiss the alert
		And I click the "Cancel" button in the "Change Password" pane

	Scenario: Change Password - User Should Be Able To Login Afterward
	# First, successfully change password
		Given I login as my temporary user
		And I am on the "Preferences" tab
		When I click the "Edit Password Link" element
		And I enter my temporary user's password into the "Current Password" field
		And I enter "123" in the "New Password" field
		And I enter "123" in the "New Password Verification" field
		And I assign password "123" to my temporary user
		And I click the "Save" button in the "Change Password" pane
		Then The password should have changed successfully
		And I click the "OK" button in the "Change Password" pane
	# Log out and log back in
		And I click the logout button
		And I login as my temporary user
		Then the portal should load

	Scenario: Change Password - Level 0 Users Can Change Passwords
		Given I am logged into the portal with user "pkadminv2" and password "123"
		And I am on the "Admin" tab
		And I select the "User" subtab
		And I search for my temporary user
		And I select my temporary user
		And I click the "Edit" button in the "Quick Details" pane
		And I click the "Edit User Password Link" element
		And I enter "123" in the "Current Password" field
		And I enter "dca" in the "New Password" field
		And I enter "dca" in the "New Password Verification" field
		And I assign password "dca" to my temporary user
		And I click the "Change User Password Save" button
		Then The password should have changed successfully
		And I click the "OK" button in the "Change User Password" pane
	  # Try to login using the new password
		And I click the logout button
		When I login as my temporary user
		Then the portal should load

	Scenario: Change Password - Level 1 Users Can Change Passwords
		# Create a temporary admin
		Given I have created a temporary admin password user
		Then I set my temporary admin user's PAT level to 1
		And I click the logout button
		When I login as my temporary admin user
		# Find the other temporary user and try to change its password
		And I am on the "Admin" tab
		And I select the "User" subtab
		And I search for my temporary user
		And I select my temporary user
		And I click the "Edit" button in the "Quick Details" pane
		And I click the "Edit User Password Link" element
		And I enter my temporary admin user's password into the "Current Password" field
		And I enter "bca" in the "New Password" field
		And I enter "bca" in the "New Password Verification" field
		And I assign password "bca" to my temporary user
		And I click the "Change User Password Save" button
		Then The password should have changed successfully
		And I click the "OK" button in the "Change User Password" pane
		And I click the logout button
		And I login as my temporary user
		Then the portal should load

	# Test that no permutation of characters causes problems
	#Scenario: Test All Characters
	Scenario: Change Password - Error When Password Is Not Mixed-Case And Mixed-Case Setting Is True
		Given I am logged into the portal with user "pkadminv2" and password "123"
		And I am on the "Admin" tab
		And I select the "Institution" subtab
		And I select "Site Administration" from the "Edit Institution Settings" dropdown
		And I fill in the following fields
		  | Name                                                  | Value   | Type      |
		  | Passwords must be mixed case                          | true    | radio     |
		  | Passwords must include at least 1 number and 1 letter | false   | radio     |
		And I click the "Save" button
		And I click "OK" in the confirmation box
		And I wait "2" seconds
#		Then the "Institution Status Summary" pane should load within "15" seconds
		And I click the logout button
		And I login as my temporary user
		And I am on the "Preferences" tab
		And I click the "Edit Password Link" element
		# First test all lowercase
		And I enter my temporary user's password into the "Current Password" field
		And I enter "acd" in the "New Password" field
		And I enter "acd" in the "New Password Verification" field
		When I click the "Save" button in the "Change Password" pane
		Then An error message should appear with the text "Password must contain upper and lower case characters"
		And I click the "Cancel" button in the "Change Password" pane
		# Now test all uppercase
		When I click the "Edit Password Link" element
		And I enter my temporary user's password into the "Current Password" field
		And I enter "ACD" in the "New Password" field
		And I enter "ACD" in the "New Password Verification" field
		And I click the "Save" button in the "Change Password" pane
		Then An error message should appear with the text "Password must contain upper and lower case characters"
		And I click the "Cancel" button in the "Change Password" pane

	Scenario: Change Password - No Error When Password Is Mixed-Case And Mixed-Case Setting Is True
		# Set admin settings for this test
		Given I am logged into the portal with user "pkadminv2" and password "123"
		And I am on the "Admin" tab
		And I select the "Institution" subtab
		And I select "Site Administration" from the "EditInstitutionSettings" dropdown
		And I fill in the following fields
			| Name                                                  | Value   | Type      |
			| Passwords must be mixed case                          | true    | radio     |
			| Passwords must include at least 1 number and 1 letter | false   | radio     |
		And I click the "Save" button
		And I click "OK" in the confirmation box
		And I wait "2" seconds
#		Then the "Institution Status Summary" pane should load within "15" seconds
			# Need to log out and log back in before settings are applied
		And I click the logout button
		And I login as my temporary user
		And I am on the "Preferences" tab
		And I click the "Edit Password Link" element
		And I enter my temporary user's password into the "Current Password" field
		And I enter "ABcde" in the "New Password" field
		And I enter "ABcde" in the "New Password Verification" field
		And I assign password "ABcde" to my temporary user
		And I click the "Save" button in the "Change Password" pane
		Then The password should have changed successfully
		And I click the "OK" button in the "Change Password" pane
		And I click the logout button
		And I login as my temporary user
		Then the portal should load

	Scenario: Change Password - Error When Password Is Not Mixed-Case And Is Not Alphanumeric When Both Settings Are True
		# Set admin settings for this test
		Given I am logged into the portal with user "pkadminv2" and password "123"
		And I am on the "Admin" tab
		And I select the "Institution" subtab
		And I select "Site Administration" from the "EditInstitutionSettings" dropdown
		And I fill in the following fields
			| Name                                                  | Value  | Type      |
			| Passwords must be mixed case                          | true   | radio     |
			| Passwords must include at least 1 number and 1 letter | true   | radio     |
		And I click the "Save" button
		And I click "OK" in the confirmation box
		And I wait "2" seconds
#		Then the "Institution Status Summary" pane should load within "15" seconds
		# Need to log out and log back in before settings are applied
		And I click the logout button
		And I login as my temporary user
		And I am on the "Preferences" tab
		And I click the "Edit Password Link" element
		And I enter my temporary user's password into the "Current Password" field
		And I enter "abcd" in the "New Password" field
		And I enter "abcd" in the "New Password Verification" field
		And I click the "Save" button in the "Change Password" pane
		Then An error message should appear with the text "Password must contain at least one letter and one number"
		And An error message should appear with the text "Password must contain upper and lower case characters"
		And I click the "Cancel" button in the "Change Password" pane

	Scenario: Change Password - Error When Password Is Mixed-Case But Is Not Alphanumeric When Both Settings Are True
		# Set admin settings for this test
		Given I am logged into the portal with user "pkadminv2" and password "123"
		And I am on the "Admin" tab
		And I select the "Institution" subtab
		And I select "Site Administration" from the "EditInstitutionSettings" dropdown
		And I fill in the following fields
			| Name                                                  | Value  | Type      |
			| Passwords must be mixed case                          | true   | radio     |
			| Passwords must include at least 1 number and 1 letter | true   | radio     |
		And I click the "Save" button
		And I click "OK" in the confirmation box
		And I wait "2" seconds
#		Then the "Institution Status Summary" pane should load within "15" seconds
		# Need to log out and log back in before settings are applied
		And I click the logout button
		And I login as my temporary user
		And I am on the "Preferences" tab
		And I click the "Edit Password Link" element
		And I enter my temporary user's password into the "Current Password" field
		And I enter "Abcd" in the "New Password" field
		And I enter "Abcd" in the "New Password Verification" field
		And I click the "Save" button in the "Change Password" pane
		Then An error message should appear with the text "Password must contain at least one letter and one number"
		And I click the "Cancel" button in the "Change Password" pane

	Scenario: Change Password - Error When Password Is Not Mixed-Case But Is Alphanumeric When Both Settings Are True
		# Set admin settings for this test
		Given I am logged into the portal with user "pkadminv2" and password "123"
		And I am on the "Admin" tab
		And I select the "Institution" subtab
		And I select "Site Administration" from the "EditInstitutionSettings" dropdown
		And I fill in the following fields
			| Name                                                  | Value  | Type      |
			| Passwords must be mixed case                          | true   | radio     |
			| Passwords must include at least 1 number and 1 letter | true   | radio     |
		And I click the "Save" button
		And I click "OK" in the confirmation box
		And I wait "2" seconds
#		Then the "Institution Status Summary" pane should load within "15" seconds
		# Need to log out and log back in before settings are applied
		And I click the logout button
		And I login as my temporary user
		And I am on the "Preferences" tab
		And I click the "Edit Password Link" element
		And I enter my temporary user's password into the "Current Password" field
		And I enter "a1b32" in the "New Password" field
		And I enter "a1b32" in the "New Password Verification" field
		And I click the "Save" button in the "Change Password" pane
		Then An error message should appear with the text "Password must contain upper and lower case characters"
		And I click the "Cancel" button in the "Change Password" pane

	Scenario: Change Password - No Error When Password Is Mixed-Case And Is Alphanumeric When Both Settings Are True
		# Set admin settings for this test
		Given I am logged into the portal with user "pkadminv2" and password "123"
		And I am on the "Admin" tab
		And I select the "Institution" subtab
		And I select "Site Administration" from the "EditInstitutionSettings" dropdown
		And I fill in the following fields
			| Name                                                  | Value  | Type      |
			| Passwords must be mixed case                          | true   | radio     |
			| Passwords must include at least 1 number and 1 letter | true   | radio     |
		And I click the "Save" button
		And I click "OK" in the confirmation box
		And I wait "2" seconds
#		Then the "Institution Status Summary" pane should load within "15" seconds
		# Need to log out and log back in before settings are applied
		And I click the logout button
		And I login as my temporary user
		And I am on the "Preferences" tab
		And I click the "Edit Password Link" element
		And I enter my temporary user's password into the "Current Password" field
		And I enter "AbCd12" in the "New Password" field
		And I enter "AbCd12" in the "New Password Verification" field
		And I assign password "AbCd12" to my temporary user
		And I click the "Save" button in the "Change Password" pane
		Then The password should have changed successfully
		And I click the "OK" button in the "Change Password" pane
		And I click the logout button
		When I login as my temporary user
		Then the portal should load

	Scenario: Change Password - Error When Password Contains Only Letters And Passwords must be Alphanumeric
		# Set admin settings for this test
		Given I am logged into the portal with user "pkadminv2" and password "123"
		And I am on the "Admin" tab
		And I select the "Institution" subtab
		And I select "Site Administration" from the "Edit Institution Settings" dropdown
		And I fill in the following fields
			| Name                                                  | Value   | Type      |
			| Passwords must be mixed case                          | false   | radio     |
			| Passwords must include at least 1 number and 1 letter | true    | radio     |
		And I click the "Save" button
		And I click "OK" in the confirmation box
		And I wait "2" seconds
#		Then the "Institution Status Summary" pane should load within "15" seconds
		# Need to log out and log back in before settings are applied
		And I click the logout button
		When I login as my temporary user
		And I am on the "Preferences" tab
		And I click the "Edit Password Link" element
		And I enter my temporary user's password into the "Current Password" field
		And I enter "aaaaa" in the "New Password" field
		And I enter "aaaaa" in the "New Password Verification" field
		And I click the "Save" button in the "Change Password" pane
		Then An error message should appear with the text "Password must contain at least one letter and one number"
		And I click the "Cancel" button in the "Change Password" pane

	Scenario: Change Password - Error When Password Contains Only Numbers And Passwords must be Alphanumeric
		# Set admin settings for this test
		Given I am logged into the portal with user "pkadminv2" and password "123"
		And I am on the "Admin" tab
		And I select the "Institution" subtab
		And I select "Site Administration" from the "EditInstitutionSettings" dropdown
		And I fill in the following fields
			| Name                                                  | Value   | Type      |
			| Passwords must be mixed case                          | false   | radio     |
			| Passwords must include at least 1 number and 1 letter | true    | radio     |
		And I click the "Save" button
		And I click "OK" in the confirmation box
		And I wait "2" seconds
#		Then the "Institution Status Summary" pane should load within "15" seconds
		# Need to log out and log back in before settings are applied
		And I click the logout button
		When I login as my temporary user
		And I am on the "Preferences" tab
		And I click the "Edit Password Link" element
		And I enter my temporary user's password into the "Current Password" field
		And I enter "111" in the "New Password" field
		And I enter "111" in the "New Password Verification" field
		And I click the "Save" button in the "Change Password" pane
		Then An error message should appear with the text "Password must contain at least one letter and one number"
		And I click the "Cancel" button in the "Change Password" pane

	Scenario: Change Password - No Error When Password Is Alphanumeric And Passwords must be Alphanumeric
		# Set admin settings for this test
		Given I am logged into the portal with user "pkadminv2" and password "123"
		And I am on the "Admin" tab
		And I select the "Institution" subtab
		And I select "Site Administration" from the "EditInstitutionSettings" dropdown
		And I fill in the following fields
			| Name                                                  | Value   | Type      |
			| Passwords must be mixed case                          | false   | radio     |
			| Passwords must include at least 1 number and 1 letter | true    | radio     |
		And I click the "Save" button
		And I click "OK" in the confirmation box
		And I wait "2" seconds
#		Then the "Institution Status Summary" pane should load within "15" seconds
		# Need to log out and log back in before settings are applied
		And I click the logout button
		When I login as my temporary user
		And I am on the "Preferences" tab
		And I click the "Edit Password Link" element
		And I enter my temporary user's password into the "Current Password" field
		And I enter "abcd12" in the "New Password" field
		And I enter "abcd12" in the "New Password Verification" field
		And I assign password "abcd12" to my temporary user
		And I click the "Save" button in the "Change Password" pane
		Then The password should have changed successfully
		And I click the "OK" button in the "Change Password" pane
	  # Log out and log back in
		And I click the logout button
		And I login as my temporary user
		Then the portal should load

	Scenario:  Change Password - PostCondition- Delete Temporary users
		Given I am logged into the portal with user "pkadminv2" and password "123"
		And I am on the "Admin" tab
		And I select the "User" subtab
		Then I delete the temporary user
		And I delete the temporary admin user