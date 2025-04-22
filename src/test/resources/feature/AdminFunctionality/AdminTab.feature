Feature: Admin
  Validate that the Admin tab and sub tabs load correctly

  Background:
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab

  @BuildVerificationTest
  Scenario: Loading of the Admin tab and all its subtabs
    Then the following subtabs should load
      | Institution       |
      | Department        |
      | User              |
      | Bulk User Edit    |
      | System Management |
      | Preferences       |

  @BuildVerificationTest
  Scenario: Loading of the Institution subtab
    When I select the "Institution" subtab
    Then the "Institution Settings" pane should load
    And I select "Site Administration" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I select "true" from the "NoteWriter" radio list in the "Site Administration" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box

  @BuildVerificationTest
  Scenario: Loading of the Bulk User Edit subtab
    When I select the "Bulk User Edit" subtab
    And I wait "2" seconds
    Then the "User Search" pane should load
    And the "Users to Edit" pane should load
    And the "Preference Settings" pane should load
	