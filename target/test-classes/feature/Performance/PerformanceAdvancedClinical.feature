@DemoPerformance @OneWindow_Performance
Feature: Performance Tests - Advanced Clinicals

    Scenario: Orders Module
        Given I am logged into the portal with user "simpk-test" and password "eieio"
        When I am on the "Patient List V2" tab
        And there should not be any unfinished orders
        And the patient list is maximized
        And "LOLA BONNET" is on the patient list
        And I select patient "LOLA BONNET" from the patient list
        And I select "Orders" from clinical navigation
      #To display time taken for the action/Page load in the report
        And I start the page load timer
        Then the "Orders" table should load
        And I stop the page load timer
        And I click the logout button

    Scenario: Show Clinical Data from within AMR page
        Given I am logged into the portal with user "simpk-test" and password "eieio"
        When I am on the "Patient List V2" tab
        And there should not be any unfinished orders
        And the patient list is maximized
        And "LOLA BONNET" is on the patient list
        And I select patient "LOLA BONNET" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Adm Med Rec" button in the "Orders" pane
        And I start the page load timer
        And the "Admission Medication Reconciliation" pane should load within "2" seconds
        And I stop the page load timer
        And I click the "Show Clinical Data" button
        And I start the page load timer
        Then the "PTDetail" pane should load within "2" seconds
        And I stop the page load timer
        And I click the "Return To Med Rec" button
        And I click the "MedRec Cancel" button in the "Admission Medication Reconciliation" pane
        And I click the "Yes" button in the "Question" pane

    Scenario: Order Search and Select -Complete Med String
        Given I am logged into the portal with user "simpk-test" and password "eieio"
        When I am on the "Patient List V2" tab
        And there should not be any unfinished orders
        And "LOLA BONNET" is on the patient list
        And I select patient "LOLA BONNET" from the patient list
        And I select "Orders" from clinical navigation
        And I click the "Enter Orders" button
        And I start the page load timer
        And the "Enter Orders" pane should load within "3" seconds
        And I stop the page load timer
        Then I enter "Cipro Tab (ciprofloxacin)" in the "Add Order" field in the "Enter Orders" pane
        And I start the page load timer
        And the text "Cipro Tab (ciprofloxacin)" should appear in the "Enter Orders" pane
        And I stop the page load timer
#        When I select "the first item" in the "Formulary MedOrders" table
        When I select "Cipro tablet (ciprofloxacin) 250MG Oral" in the "Non Formulary MedOrders" table
        And I start the page load timer
        And the "New Edit Order" pane should load
        And I stop the page load timer
        Then I fill the mandatory order details in the "New Edit Order" pane if it exists
        Then I click the "Add Order Cancel" button
        And I click the "Question Yes" button in the "Question" pane

    Scenario: Start Note Entry and Load Template
        Given I am logged into the portal with user "simpk-test" and password "eieio"
        When I am on the "Patient List V2" tab
        And the patient list is maximized
        And "LOLA BONNET" is on the patient list
        And I select patient "LOLA BONNET" from the patient list
        And I select "Clinical Notes" from clinical navigation
        And I start the page load timer
        And the "ClinicalNotes" table should load
        And I stop the page load timer
        And I click the "Clinical Notes+" button
#        And I click the "Clinical Notes Add" button
  #    And I wait "2" seconds
        And I click the "Create New" button in the "Notes in Draft Status" pane if it exists
        And I start the page load timer
        And the "Write A Note" pane should load within "2" seconds
        And I stop the page load timer
#        And I select "Discharge Summary" from the select template list
        And I load the "Discharge Summary" template note for the selected patient
        And I find out all active windows
		And I switch the focus to the "popoutWindow" window
        And I start the page load timer
        Then the "NoteWriter Main" pane should load within "2" seconds
        And I stop the page load timer
        And I wait "3" seconds
        And I click the "NoteWriterCancel" button in the "NoteWriter Main" pane
        And I click the "Confirm" button in the "Question" pane
        And I switch the focus to the "LoginWindow" window
        And I am on the "Patient List V2" tab
        When I click the "Clinical Notes+" button
        And I click the "Create New" button in the "Notes in Draft Status" pane if it exists
#        And I select "Progress Note with Charge Validation" from the select template list
#        And I select "Progress Note" from the select template list
        And I load the "Progress Note" template note for the selected patient
        And I start the page load timer
        Then the "NoteWriter Main" pane should load within "2" seconds
        And I stop the page load timer
#        And I click the "Cancel" button in the "NoteWriter Main" pane
#        And I click the "Yes" button in the "Question" pane
#        When I click the "Clinical Notes+" button
#        And I click the "Create New" button in the "Notes in Draft Status" pane if it exists
#        And I select "Consult Note" from the select template list
#        And I start the page load timer
#        Then the "NoteWriter Main" pane should load within "2" seconds
#        And I stop the page load timer
#        And I enter "was" in the "Requested By" field
#        And I click the "enter" key in the "Requested By" field
#        And I start the page load timer
#        And the "Provider LookUp" pane should load within "2" seconds
#        And I stop the page load timer
        And I click the "NoteWriterCancelNote" button in the "NoteWriter Main" pane
        And I click the "Confirm" button in the "Question" pane if it exists
        And I click the logout button