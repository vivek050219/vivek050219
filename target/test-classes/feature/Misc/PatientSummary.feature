Feature: Patient Summary

  Background:
    Given I am logged into the portal with user "cadmin" using the default password
    And I am on the "Patient Summary" tab

  @BuildVerificationTest
  Scenario: Patient Summary title verification
    When I select the "Patient Summary" subtab
    And I select "Card Group" from the "Patient List" menu in the "Patient Summary List" pane
    And the "Patient Summary" table should load
    Then I click the "Options" button
    And the "Display Options" pane should load
    And I check the "Allergies" checkbox
    And I check the "Clinical Notes" checkbox
    And I check the "Medications" checkbox
#    This scenario is not dependent of below step and for this step to work, settings suggested in DEV-69339 need to be done.
#        And I check the "Orders" checkbox
    And I check the "Problems" checkbox
    And I check the "Test Results" checkbox
    And I click the "Options OK" button
    Then the "Patient Summary" table should load with the following columns
      | Patient                |
      | Type                   |
      | Date                   |
      | Description (\d of \d) |
      | Details                |


  @PortalSmoke @Demo
  Scenario: Verify the number of patients
        #Given I am logged into the portal with user "cadmin" using the default password
    When I select the "Sign-Out Summary" subtab
    And I select "Card Group" from the "Patient List" menu
    And I wait "2" seconds
    And I select "Sign-OutWithClinicals" from the "Department" menu
    And I wait "2" seconds
    And I select "Verve" from the "Department" menu
    And I select "All Patients" from the "Sign-OutPatients" menu
    And I wait "2" seconds
    Then the "Sign-Out" table should have at least "9" rows
    When I select "Only Patients With Incomplete Tasks" from the "Sign-OutPatients" menu
    And I wait "2" seconds
    Then the "Sign-Out" table should have at least "1" rows
    When I select "Only Patients With Sign-Out" from the "Sign-OutPatients" menu
    Then the "Sign-Out" table should have at least "1" rows


  @PortalSmoke @Demo
  Scenario: Verify print preview
    When I select the "Sign-Out Summary" subtab
    And I select "Card Group" from the "Patient List" menu
    And I select "All Patients" from the "Sign-OutPatients" menu
    Then the "Sign-Out" table should load
    Then I click the "Print Image" button
    And I click the "Select None" button
    And I select "DARR, MOLLY" from the "Patient*" column in the "Select Patients" table
    And I click the "Print" button
    And I wait "5" seconds
    Then The Print Preview Should load
    And I click the "Close" button
    Then I click the "Print Image" button
    And I click the "Select None" button
    And I click the "Select All" button
    And I click the "Print" button
    And I wait "5" seconds
    Then The Print Preview Should load
    And I click the "Close" button


