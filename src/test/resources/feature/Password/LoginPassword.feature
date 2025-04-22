Feature: Login/Logout
  It is necessary to login to the portal to complete any further tasks
  Attempting to login with an invalid or blank username and/or password gives an error message

  @PasswordTest @BuildVerificationTest
  Scenario: LoginAs_ScenarioUser
    Given I am logged into the portal with user "pkadminv2" and password "123"
    Then the portal should load

  @PasswordTest @BuildVerificationTest
  Scenario: Logging out of portal returns to login page with blank Username and Password fields
    Given I am logged into the portal with user "pkadminv2" and password "123"
    And I am logged out of the portal
    Then the value in the "Username" field should be ""
    Then the value in the "Password" field should be ""

  @PasswordTest @BuildVerificationTest
  Scenario: Logging in with correct username and incorrect password gives error message
    When I login as "badpassword" with password "abc"
    Then I should receive an error message "Login Failed: Incorrect password."
    When I login as "badpassword" with password "123"
    And I click the logout button

  @PasswordTest
  Scenario: Logging in with username and blank password gives error message
    When I login as "badpassword" with password ""
    Then I should receive an error message "Please Enter a Password"
    When I login as "badpassword" with password "123"
    And I click the logout button

  @PasswordTest
  Scenario: Logging in with blank username gives error message
    When I login as "" with password ""
    Then I should receive an error message "Please Enter a Username"

  @PasswordTest
  Scenario: Logging in with invalid username gives error message
    When I login as "notavaliduser" with password "123"
    Then I should receive an error message "Login Failed: Invalid Credentials"