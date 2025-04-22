# Test password functionality in the admin create user dialog

@PasswordTest
Feature: Create User Password Validation

  Background:
    Given I am logged into the portal with user "pkadminv2" and password "123"
    And I am on the "Admin" tab
  @PasswordTest
  Scenario: Create User - Error When Password Is Too Short
    Given I open the Create User dialog and fill it with temporary information
    When I enter "12" in the "Password" field
    And I enter "12" in the "Verify Password" field
    And I click the "Create User Save" button
    Then There should be an alert with the text "Password is too short"
    And I handle the alert
    And I click the "Cancel" button

  @PasswordTest
  Scenario: Create User - Error When Password Is Too Long
    Given I click the "Cancel" button in the "Create User" pane if it exists
    And I open the Create User dialog and fill it with temporary information
    When I enter "123456789123456789123456789" in the "Password" field
    And I enter "123456789123456789123456789" in the "Verify Password" field
    And I click the "Create User Save" button
    Then There should be an alert with the text "password can not be longer than"
    And I handle the alert
    And I click the "Cancel" button

  @PasswordTest
  Scenario: Create User - Error When Password Does Not Match Confirmation
    Given I click the "Cancel" button in the "Create User" pane if it exists
    And I open the Create User dialog and fill it with temporary information
    When I enter "123456789" in the "Password" field
    And I enter "12345" in the "Verify Password" field
    And I click the "Create User Save" button
    Then There should be an alert with the text "password fields do not match"
    And I handle the alert
    And I click the "Cancel" button

  @PasswordTest
  Scenario: Create User - No Error When Password Settings Not Enabled
    Given I click the "Cancel" button in the "Create User" pane if it exists
   # Set admin settings for this test
    When I select the "Institution" subtab
    And I select "Site Administration" from the "Edit Institution Settings" dropdown
    And I fill in the following fields
      | Name                                                  | Value   | Type     |
      | Passwords must be mixed case                          | false   | radio    |
      | Passwords must include at least 1 number and 1 letter | false   | radio    |
    And I save my new settings
    And I wait "2" seconds
   # Need to log out and log back in before settings are applied
    And I click the logout button
    Given I am logged into the portal with user "pkadminv2" and password "123"
    And I am on the "Admin" tab
    And I open the Create User dialog and fill it with temporary information
    When I enter "abcde" in the "Password" field
    And I enter "abcde" in the "Verify Password" field
    And I click the "Create User Save" button
    And the "Quick Details" pane should load
    And I check for temporary user successfull creation
    # PostCondition to delete the temp user
    Then I delete the temporary user


  @PasswordTest
  Scenario: Create User - Error When Password Is Not Mixed-Case And Mixed-Case Setting Is True
    Given I click the "Cancel" button in the "Create User" pane if it exists
   # Set admin settings for this test
    When I select the "Institution" subtab
    And I select "Site Administration" from the "Edit Institution Settings" dropdown
    And I fill in the following fields
      | Name                                                  | Value   | Type      |
      | Passwords must be mixed case                          | true    | radio     |
      | Passwords must include at least 1 number and 1 letter | false   | radio     |
    And I save my new settings
    And I wait "2" seconds
   # Need to log out and log back in before settings are applied
    And I click the logout button
    And I am logged into the portal with user "pkadminv2" and password "123"
    And I am on the "Admin" tab
    And I return to the Create User dialog
   # First check all lowercase
    When I enter "abcde" in the "Password" field
    And I enter "abcde" in the "Verify Password" field
    And I click the "Create User Save" button
    Then There should be an alert with the text "Password must contain upper and lower case characters"
    And I handle the alert
   # Then check all capitalized
    And I wait "1" seconds
    When I create a temporary user for testing passwords
    And I check the "Use Basic Authentication" checkbox if it exists
    And I enter "ABCDE" in the "Password" field
    And I enter "ABCDE" in the "Verify Password" field
    And I click the "Create User Save" button
    Then There should be an alert with the text "Password must contain upper and lower case characters"
    And I handle the alert
    And I click the "Cancel" button

  @PasswordTest
  Scenario: Create User - No Error When Password Is Mixed-Case And Mixed-Case Setting Is True
  Set admin settings for this test
    Given I click the "Cancel" button in the "Create User" pane if it exists
    And I select the "Institution" subtab
    And I select "Site Administration" from the "EditInstitutionSettings" dropdown
    And I fill in the following fields
      | Name                                                  | Value   | Type      |
      | Passwords must be mixed case                          | true    | radio     |
      | Passwords must include at least 1 number and 1 letter | false   | radio     |
    And I save my new settings
    And I wait "2" seconds
   # Need to log out and log back in before settings are applied
    And I click the logout button
    And I am logged into the portal with user "pkadminv2" and password "123"
    And I am on the "Admin" tab
    And I return to the Create User dialog
    When I enter "Abcde" in the "Password" field
    And I enter "Abcde" in the "Verify Password" field
    And I click the "Create User Save" button
    And the "Quick Details" pane should load
    And I check for temporary user successfull creation
    # PostCondition to delete the temp user
    Then I delete the temporary user

  @PasswordTest
  Scenario: Create User - Error When Password Is Not Mixed-Case And Is Not Alphanumeric When Both Settings Are True
   # Set admin settings for this test
    Given I click the "Cancel" button in the "Create User" pane if it exists
    And I select the "Institution" subtab
    And I select "Site Administration" from the "EditInstitutionSettings" dropdown
    And I fill in the following fields
      | Name                                                  | Value  | Type      |
      | Passwords must be mixed case                          | true   | radio     |
      | Passwords must include at least 1 number and 1 letter | true   | radio     |
    And I save my new settings
    And I wait "2" seconds
   # Need to log out and log back in before settings are applied
    And I click the logout button
    And I am logged into the portal with user "pkadminv2" and password "123"
    And I am on the "Admin" tab
    And I return to the Create User dialog
    When I enter "abcde" in the "Password" field
    And I enter "abcde" in the "Verify Password" field
    And I click the "Create User Save" button
    Then There should be an alert with the text "Password must contain upper and lower case characters"
    And There should be an alert with the text "Password must contain at least one letter and one number"
    And I handle the alert
    And I click the "Cancel" button

  @PasswordTest
  Scenario: Create User - Error When Password Is Mixed-Case And Is Not Alphanumeric When Both Settings Are True
  Set admin settings for this test
    Given I click the "Cancel" button in the "Create User" pane if it exists
    And I select the "Institution" subtab
    And I select "Site Administration" from the "EditInstitutionSettings" dropdown
    And I fill in the following fields
      | Name                                                  | Value  | Type      |
      | Passwords must be mixed case                          | true   | radio     |
      | Passwords must include at least 1 number and 1 letter | true   | radio     |
    And I save my new settings
    And I wait "2" seconds
   # Need to log out and log back in before settings are applied
    And I click the logout button
    And I am logged into the portal with user "pkadminv2" and password "123"
    And I am on the "Admin" tab
    And I return to the Create User dialog
    When I enter "Abcde" in the "Password" field
    And I enter "Abcde" in the "Verify Password" field
    And I click the "Create User Save" button
    Then There should be an alert with the text "Password must contain at least one letter and one number"
    And I handle the alert
    And I click the "Cancel" button

  @PasswordTest
  Scenario: Create User - Error When Password Is Not Mixed-Case But Is Alphanumeric When Both Settings Are True
   # Set admin settings for this test
    Given I click the "Cancel" button in the "Create User" pane if it exists
    And I select the "Institution" subtab
    And I select "Site Administration" from the "EditInstitutionSettings" dropdown
    And I fill in the following fields
      | Name                                                  | Value  | Type      |
      | Passwords must be mixed case                          | true   | radio     |
      | Passwords must include at least 1 number and 1 letter | true   | radio     |
    And I save my new settings
    And I wait "1" second
   # Need to log out and log back in before settings are applied
    And I click the logout button
    And I am logged into the portal with user "pkadminv2" and password "123"
    And I am on the "Admin" tab
    And I return to the Create User dialog
    When I enter "1abc3de" in the "Password" field
    And I enter "1abc3de" in the "Verify Password" field
    And I click the "Create User Save" button
    Then There should be an alert with the text "Password must contain upper and lower case characters"
    And I handle the alert
    And I click the "Cancel" button

  @PasswordTest
  Scenario:Create User - No Error When Password Is Mixed-Case And Is Alphanumeric When Both Settings Are True
  Set admin settings for this test
    Given I click the "Cancel" button in the "Create User" pane if it exists
    And I select the "Institution" subtab
    And I select "Site Administration" from the "EditInstitutionSettings" dropdown
    And I fill in the following fields
      | Name                                                  | Value  | Type      |
      | Passwords must be mixed case                          | true   | radio     |
      | Passwords must include at least 1 number and 1 letter | true   | radio     |
    And I save my new settings
    And I wait "2" seconds
   # Need to log out and log back in before settings are applied
    And I click the logout button
    And I am logged into the portal with user "pkadminv2" and password "123"
    And I am on the "Admin" tab
    And I return to the Create User dialog
    When I enter "1Abcde" in the "Password" field
    And I enter "1Abcde" in the "Verify Password" field
    And I click the "Create User Save" button
    And the "Quick Details" pane should load
    And I check for temporary user successfull creation
    # PostCondition to delete the temp user
    Then I delete the temporary user

  @PasswordTest
  Scenario: Create User - Error When Password Contains Only Letters And Passwords must be Alphanumeric
   # Set admin settings for this test
    Given I click the "Cancel" button in the "Create User" pane if it exists
    And I select the "Institution" subtab
    And I select "Site Administration" from the "EditInstitutionSettings" dropdown
    And I fill in the following fields
      | Name                                                  | Value   | Type      |
      | Passwords must be mixed case                          | false   | radio     |
      | Passwords must include at least 1 number and 1 letter | true    | radio     |
    And I save my new settings
    And I wait "2" seconds
   # Need to log out and log back in before settings are applied
    And I click the logout button
    And I am logged into the portal with user "pkadminv2" and password "123"
    And I am on the "Admin" tab
    And I return to the Create User dialog
    When I enter "abcde" in the "Password" field
    And I enter "abcde" in the "Verify Password" field
    And I click the "Create User Save" button
    Then There should be an alert with the text "Password must contain at least one letter and one number"
    And I handle the alert
    And I click the "Cancel" button

  @PasswordTest
  Scenario: Create User - Error When Password Contains Only Numbers And Passwords must be Alphanumeric
   # Set admin settings for this test
    Given I click the "Cancel" button in the "Create User" pane if it exists
    And I select the "Institution" subtab
    And I select "Site Administration" from the "EditInstitutionSettings" dropdown
    And I fill in the following fields
      | Name                                                  | Value   | Type      |
      | Passwords must be mixed case                          | false   | radio     |
      | Passwords must include at least 1 number and 1 letter | true    | radio     |
    And I save my new settings
    And I wait "2" seconds
   # Need to log out and log back in before settings are applied
    And I click the logout button
    And I am logged into the portal with user "pkadminv2" and password "123"
    And I am on the "Admin" tab
    And I return to the Create User dialog
    When I enter "12345" in the "Password" field
    And I enter "12345" in the "Verify Password" field
    And I click the "Create User Save" button
    Then There should be an alert with the text "Password must contain at least one letter and one number"
    And I handle the alert
    And I click the "Cancel" button

  @PasswordTest
  Scenario: Create User - No Error When Password Is Alphanumeric and Passwords must be Alphanumeric
#      Set admin settings for this test
    Given I click the "Cancel" button in the "Create User" pane if it exists
    And I select the "Institution" subtab
    And I select "Site Administration" from the "EditInstitutionSettings" dropdown
    And I fill in the following fields
      | Name                                                  | Value   | Type      |
      | Passwords must be mixed case                          | false   | radio     |
      | Passwords must include at least 1 number and 1 letter | true    | radio     |
    And I save my new settings
    And I wait "2" seconds
   # Need to log out and log back in before settings are applied
    And I click the logout button
    And I am logged into the portal with user "pkadminv2" and password "123"
    And I am on the "Admin" tab
    And I return to the Create User dialog
    When I enter "a1bc3d" in the "Password" field
    And I enter "a1bc3d" in the "Verify Password" field
    And I click the "Create User Save" button
    And the "Quick Details" pane should load
    And I check for temporary user successfull creation
    # PostCondition to delete the temp user
    Then I delete the temporary user
