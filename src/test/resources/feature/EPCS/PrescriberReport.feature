@EPCS
Feature: EPCS - Prescriber Report
#  ALM Path: eRx [PK] >>> EPCS >>> EPCS Prescriber Report

  #Admin Setting: EPCS Prescriber Report Tab will be displayed if the EPCS Prescriber report radio button is selected to 'Yes'
  #This scenario is merged with 3 test cases 1. Download Report” button available, 2. EPCS Provider Report tab available from main page in PK and 3. Password creation
  Scenario: TC001_28314_Download Report” button available, 28313_EPCS Provider Report tab available from main page in PK and 28315_Password creation
    Given I am logged into the portal with user "epcsprov7" using the default password
    And I am on the "Patient List V2" tab
    Then the "EPCS Prescriber Report Tab" "MISC_ELEMENT" should be visible
    And I click the "EPCS Prescriber Report Tab" element
    And I wait "10" seconds
    And Text "Click the button below to generate a report of your controlled substance prescriptions for a specific time-frame" should appear in the "EPCS Prescriber Report" pane
    Then the "EPCS Download Report" "BUTTON" should be visible
    And I click the "EPCS Download Report" button in the "EPCS Prescriber Report" pane
    And I enter "123" in the "Create File Password" field in the "EPCS Prescriber Report" pane
    Then The "EPCS Download" "BUTTON" should be enabled
    And I click the "EPCS Cancel" button in the "EPCS Prescriber Report" pane