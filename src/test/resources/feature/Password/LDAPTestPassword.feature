@PasswordTest
Feature: Test Passwords On LDAP System
  These scenarios assume that there is an Active Directory user and corresponding PK user with login information
  Username: pwdtest
  Password: Password12

  @PasswordTest @BuildVerificationTest
  Scenario: User Can Login When Authenticated Against LDAP
    Given I am logged into the portal with user "pwdtest" and password "Password12"
    Then the portal should load

  @PasswordTest @BuildVerificationTest
  Scenario: Login as LDAP authenticated user with old password gives error message
    When I login as "pwdtest" with password "123"
    Then I should receive an error message "Login Failed: Invalid Credentials"

  @PasswordTest @BuildVerificationTest
  Scenario: Login as a PK LDAP user that does not have an account in AD [DEV-76192]
    When I login as "noadaccount" with password "123"
    Then I should receive an error message "Login Failed: Invalid Credentials"

  @PasswordTest @BuildVerificationTest
  Scenario: Login as a PK LDAP user that does not have an account in AD using empty password [DEV-76192]
    When I login as "noadaccount" with password ""
    Then I should receive an error message "Please enter a Password"

  @PasswordTest
  Scenario: User Cannot Change Password Through PatientKeeper UI
    Given I am logged into the portal with user "pwdtest" and password "Password12"
    And I am on the "Preferences" tab
    And the following fields should not display in the "General Settings" pane
      | Type  | Name             |
      | link  | Password[Edit]   |

  @PasswordTest
  Scenario: Admin Cannot Change User's Password Through PatientKeeper UI
    Given I am logged into the portal with user "pkadminv2" and password "123"
    When I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "pwdtest"
    And I select the user "pwdtest"
    And I click the "Edit" button in the "Quick Details" pane
    Then the following fields should not display in the "Admin Main" pane
      | Type  | Name             |
      | link  | Password[Edit]   |

  @PasswordTest
  Scenario: PK Password Rules Do Not Affect LDAP User Passwords - Mixed Case
    Given I am logged into the portal with user "pkadminv2" and password "123"
    When I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "Site Administration" from the "Edit Institution Settings" dropdown
    And I fill in the following fields
      | Name                                                  | Value   | Type      |
      | Passwords must be mixed case                          | true    | radio     |
      | Passwords must include at least 1 number and 1 letter | false   | radio     |
    And I save my new settings
    And I click the logout button
    And I am logged into the portal with user "pwdtest" and password "Password12"
    Then the portal should load
    Given I am logged into the portal with user "pkadminv2" and password "123"
    When I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "Site Administration" from the "Edit Institution Settings" dropdown
    And I fill in the following fields
      | Name                                                  | Value   | Type      |
      | Passwords must be mixed case                          | false   | radio     |
      | Passwords must include at least 1 number and 1 letter | false   | radio     |
    And I save my new settings
    And I click the logout button

 # Old password should become invalid after 10 minutes, not going to wait 10 minutes just to run this scenario.
#  @donotrun
#  Scenario: User Can Login After Changing Password in Active Directory, Old Password Should Not Work
#    Given I change user "pwdtest"'s Active Directory password to "P4ssw0rd"
#    When I login as "pwdtest" with password "P4ssw0rd"
#    Then the portal should load
#    When I click the logout button
#    And I login as "pwdtest" with password "Password12"
#    Then I should receive an error message "Login Failed: Invalid Credentials"