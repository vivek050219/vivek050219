@OneWindow_MultiTab_DMR
Feature: Multi Tab DMR

#  Background:
#    Given I am logged into the portal with user "pkadmin" using the default password
#    And I am on the "Patient List V2" tab
#
#  @OneWindow_MultiTab
#  Scenario: Test Scenarios
#    Then I open new tab and log into the portal with user "pkadmin" using the default password
#    Then I switch the focus to tab "2"
#    And I am on the "Patient List V2" tab
#    Given "Molly Darr" is on the patient list
#    When I select patient "Molly Darr" from the patient list
#    Then I switch the focus to tab "1"
#    And I select patient "Molly Darr" from the patient list


  Background:
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "MultiTab" owned by "medrecuser3" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I use the API to favorite patient list "MultiTab" for user "medrecuser3" owned by "medrecuser3"
    And I click the "Refresh Patient List" button
    And I select "MultiTab" from the "Patient List" menu
    And there should not be any unfinished orders


  Scenario: Pre-requisite Setup scenario
    Given I am logged into the portal with the default user
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "medrecuser3"
    And I select the user "medrecuser3"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "CPOE" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I edit the following user settings and I click save
      |Page |Name                     |Type  |Value |
      |CPOE |Can Enter Orders         |radio |true  |
      |CPOE |Enable Admission Med Rec |radio |true  |
      |CPOE |Enable Discharge Med Rec |radio |true  |
      |CPOE |Add Home Medications     |radio |true  |
      |CPOE |Continue Home Meds       |radio |true  |


  Scenario: Open Discharge Med Rec on Multi Tabs with same user
    Given I open new tab and validate the text "You are already logged into PatientKeeper from this computer. Please return to this session to continue or to log out."
    Then I switch the focus to tab "1"
    When "MEDREC RECON1" is on the patient list
    And I select patient "MEDREC RECON1" from the patient list
    And I select "Orders" from clinical navigation
    Then the "Orders" table should load
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load

    ## Commenting the below cucumber steps as 9x classic application behavior changed
#    Then I switch the focus to tab "2"
#    When "MEDREC RECON1" is on the patient list
#    And I select patient "MEDREC RECON1" from the patient list
#    And I select "Orders" from clinical navigation
#    And I click the "Discharge Med Rec" button in the "Orders" pane
#    Then the "Discharge Medication Reconciliation" pane should load
#    And I click the "Warning OK" button
#    Then the "Orders" table should load
#   Then I switch the focus to tab "1"

    Then I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close


  Scenario: Enter Discharge Med Rec Orders on tab 1 while Note Writer window is open in tab 2 with same user
    Given I open new tab and validate the text "You are already logged into PatientKeeper from this computer. Please return to this session to continue or to log out."

  ## Commenting the below cucumber steps as 9x classic application behavior changed
#    Then I switch the focus to tab "1"
#    When "MOLLY DARR" is on the patient list
#    And I select patient "MOLLY DARR" from the patient list
#
#    #Steps to delete previous Discharge Orders if Present!!
#    Then I delete previous Discharge Orders if Present
#
#    And I select "Orders" from clinical navigation
#    Then the "Orders" table should load
#    And I click the "Discharge Med Rec" button in the "Orders" pane
#    Then the "Discharge Medication Reconciliation" pane should load
#    And I click the "Stop Remaining Meds" button if it exists
#    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
#    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
#    And I enter "Antivert tablet" in the "Discharge Search For Order" field in the "Search for order" pane
#    And I select "Antivert tablet (meclizine)  25MG Oral" from the "Searched Combined Med Orders" list in the search results
#    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
#    Then I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
#    And I enter "Tylenol" in the "Discharge Search For Order" field in the "Search for order" pane
#    And I select "Tylenol 8 Hour tablet,extended release (acetaminophen)  650MG Oral Daily" from the "Searched Combined Med Orders" list in the search results
#    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
#
#    Then I switch the focus to tab "2"
#    When "MOLLY DARR" is on the patient list
#    And I select patient "MOLLY DARR" from the patient list
#    And I select "Orders" from clinical navigation
#    And I select "Write Note" from the "Patient Header Actions" menu
#
#    Then I switch the focus to tab "1"
#    And I reconcile and Submit the Orders
#    Then the "Discharge Medication Reconciliation" pane should close
#    When I select "Discharge Orders" from clinical navigation
#    Then the "Discharge Orders" pane should load within "5" seconds
#    And rows containing the following should appear in the "Discharge Orders" table
#      | Discharge Order                                                          | Rx Destination |
#      | Antivert tablet (meclizine) 25MG Oral Daily                              |                |
#      | Tylenol 8 Hour tablet,extended release (acetaminophen) 650MG Oral Daily  |                |
#
#    Then I switch the focus to tab "2"
#    And I click the "Cancel" button in the "NoteWriterMain" pane
#    Then the "Orders" table should load

