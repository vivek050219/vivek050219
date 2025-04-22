Feature: Patient List Charges

  @BuildVerificationTest @Charges
  Scenario: Add charge using Dollar sign icon
   #Due to DEV-43628 issue in IE10 with pkadmin user in App03, scenario updated with user "addchargeuser1"
   #And once the issue got fixed we will revertback the code.
    Given I am logged into the portal with user "addchargeuser1" and password "123"
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "Card Group" owned by "addchargeuser1" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I click the "Refresh Patient List" button
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And I select "Charges" from clinical navigation
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value           |
      | Billing Prov | KADMINV2, PERRY |
      | Bill Area    | Verve           |
      | Svc Site     | Inpatient       |
    And I enter the ICD-10 code "B36.0"
    And I enter the CPT code "0109T"
    And I click the "Submit" button
    Then the "Charge Entry" pane should close
    And I refresh the clinical display
    And I wait "2" seconds
    Then the following rows should appear in the "Charges" table
      | Date/Time             | Proc                          | Diag  |
      | %Current Date MMDDYY% | 0109T heat quant sensory test | B36.0 |

  @BuildVerificationTest
  Scenario: Edit charge
   #Avoid dependencies, add a charge to edit
   #Due to DEV-43628 issue in IE10 with pkadmin user in App03, scenario updated with user "addchargeuser1"
   #And once the issue got fixed we will revertback the code.
   #Given I am logged into the portal with user "addchargeuser1" and password "123"
#    And I am on the "Patient List v2" tab
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "Card Group" owned by "pkadminv2" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I click the "Refresh Patient List" button
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And I select "Charges" from clinical navigation
    And I "uncheck" the following
      | Show Visits     |
      | My Charges Only |
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      | Name         | Value           |
      | Billing Prov | KADMINV2, PERRY |
      | Bill Area    | Verve           |
      | Svc Site     | Inpatient       |
    And I enter the ICD-10 code "A27.9"
    And I enter the CPT code "50010"
    And I click the "Submit" button
    Then the "Charge Entry" pane should close
    And I refresh the clinical display
    And I wait "2" seconds
    Then the following rows should appear in the "Charges" table
      | Date/Time             | Proc                        | Diag  |
      | %Current Date MMDDYY% | 50010 exploration of kidney | A27.9 |
    When I select "A27.9" from the "Diag" column in the "Charges" table
    And I click the "Edit" button in the "Charge Detail" pane
    And the "Charge Entry" pane should load
    And I remove the "50010" CPT code
    And I enter the CPT code "0521F"
    And I click the "Submit" button in the "Charge Entry" pane
    Then the following rows should appear in the "Charges" table
      | Date/Time             | Proc                           | Diag  |
      | %Current Date MMDDYY% | 0521F plan of care 4 pain docd | A27.9 |

  @PortalSmoke
  Scenario: No charges on patient
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "Card Group" owned by "pkadminv2" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I click the "Refresh Patient List" button
    And I select "Card Group" from the "Patient List" menu
    When "Mona Angeline" is on the patient list
    Then I select patient "Mona Angeline" from the patient list
    And I select "Charges" from clinical navigation
    And I select "Last 30 Days" from the "Clinical Timeframe" menu
    And patient "Mona Angeline" has no charges
    When I select "Last 30 Days" from the "Clinical Timeframe" menu
    Then the text "No data found" should appear in the "Charges" pane