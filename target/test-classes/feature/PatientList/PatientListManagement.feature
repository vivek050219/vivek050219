Feature: Patient List Management
    Manage a user's patient list via adding/removing and filtering

    Background:
     #Given I am logged into the portal with the default user
        Given I am logged into the portal with user "pkadminv2" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized

    @BuildVerificationTest @PortalSmoke
    Scenario: Add Patient by Name
        Given "Roy Blazer" is not on the patient list
        When I select "Add Patient" from the "Actions" menu
        And I wait "2" seconds
        And I click the "Clear Criteria" button
        And I "check" the following
            |Include Past Visits     |
        And I select "Inpatient" from the "Visit Type" dropdown
        And I search for patient "Roy Blazer", admitted in the last "4" days
        And I select patient "Roy Blazer" from the "Name (\d)" column in the "Add Patient Search" table
   #		And I select "Interested Party" from the "Relationship" dropdown
        And I click the "Add" button in the "Add patient(s) to your patient list" pane
        And I wait "3" seconds
        And I click the "Close" button in the "Add patient(s) to your patient list" pane
        And I refresh the patient list
        Then patient "Roy Blazer" should be on the patient list
        When I select patient "Roy Blazer" from the patient list
        And I select "Patient Detail" from clinical navigation
   #		Then the text "KADMIN, PERRY" should appear in the "Interested party" field in the "Physicians" section of the "Patient Detail" table
        Then the text "KING, SCOTT" should appear in the "Admitting" field in the "Physicians" section of the "Patient Detail" table

 #TODO: Fails in Chrome and breaks following scenarios.  DEV-45992.
#	@BuildVerificationTest
    Scenario: Send Patients to Another User
        Given "Roy Blazer" is on the patient list
        When I select "Send Patients to Another User" from the "Actions" menu
        And I enter "getsend" in the "User Name/ID" field
        And I click the "Search for Users" button in the "Send Patient(s) to Other User(s)" pane
     #if only one user, may auto-select it, causing problems when then attempting to manually select it
        And I click the "Select None" button in the "Send Patient User Search Results" pane
        And I click the "Send" button
        Then the text "You must select at least one user to send patients to." should appear in the "Warning" pane
        When I click the "OK" button in the "Warning" pane
        And I select "getsend" from the "Username" column in the "Search for Users" table
        And I click the "Send" button
        Then the text "You must select at least one visit to send to another user." should appear in the "Warning" pane
        When I click the "OK" button in the "Warning" pane
        And I select patient "Roy Blazer" from the "Name (\d)" column in the "SendPatient" table
        And I click the "Send" button
        And I click the "OK" button in the "Information" pane
        And I click the "Close" button
        Given I am logged into the portal with user "getsend" and password "123"
        And I am on the "Patient List V2" tab
        Then patient "Roy Blazer" should be on the patient list

    @BuildVerificationTest @PortalSmoke @donotrun
    Scenario: Getting patients from another user_7.0 [DEV-47440]
        Given I am logged into the portal with user "getsend" using the default password
        And I am on the "Patient List V2" tab
        And "Roy Blazer" is on the patient list
     #log back in with pkadmin
        Given I am logged into the portal with user "pkadminv2" using the default password
        And I am on the "Patient List V2" tab
        But "Roy Blazer" is not on the patient list
        When I select "Get Patients from Another User" from the "Actions" menu
        Then the "Get Patients from Another User" pane should load
        When I enter "getsend" in the "User Name/ID" field in the "Select User" pane
        And I click the "Search" button in the "Select User" pane
        And I select "getsend" from the "Username" column in the "Get Search for Users" table
        And I click the "Add Patient(s)" button
        Then the text "Please search for and select at least one patient to add." should appear in the "Information" pane
        And I click the "OK" button in the "Information" pane
        And I select "BLAZER, ROY" from the "Name (\d)" column in the "Select Patient to Add" table
        And I click the "Add Patient(s)" button
   #		Then the text "You must select a valid relationship to assign to the selected accounts before continuing." should appear in the "Warning" pane
   #		And I click the "OK" button in the "Warning" pane
   #		And I select "Interested Party" from the "Relationship" dropdown
   #		And I click the "Add Patient(s)" button
        And I click the "Close" button
        Then patient "Roy Blazer" should be on the patient list

    @BuildVerificationTest
    Scenario: Patients list appearance  with N number of patients
        Then the number of patients should be displayed

    @BuildVerificationTest @PortalSmoke
    Scenario: Remove Current Patient
        Given "Roy Blazer" is on the patient list
     #refresh patient list to ensure no patient selected
        When I refresh the patient list
   #		And I select "Remove Patient" from the "Actions" menu
   #		Then the text "You must first select a patient to remove" should appear in the "Warning" pane
   #		When I click the "OK" button in the "Warning" pane
        And I select patient "Roy Blazer" from the patient list
        And I select "Remove Patient" from the "Actions" menu
   #		Then the text "Are you sure that you want to remove the selected patient and all of your relationships to it?" should appear in the "Question" pane
        Then the text "Are you sure that you want to remove the selected patient?" should appear in the "Question" pane
        When I click the "No" button in the "Question" pane
        Then patient "Roy Blazer" should be on the patient list
        And I select "Remove Patient" from the "Actions" menu
        And I click the "Yes" button in the "Question" pane
        Then patient "Roy Blazer" should not be on the patient list

    @PortalSmoke
    Scenario: Add Patient Smoke
        Given "Roy Blazer" is not on the patient list
        When I select "Add Patient" from the "Actions" menu
        And I select "Inpatient" from the "Visit Type" dropdown
        And I "check" the following
            |Include Cancelled Visits|
            |Include Past Visits     |
        And I enter "4" in the "Admit in last N days" field
        And I select "Display 25 Results" from the "Max Search Results" dropdown
        And I search for patient "Roy Blazer"
        Then all values under the "Name (\d)" column in the "Add Patient Search" table should start with "BLAZER, ROY"
        And all values under the "Type" column in the "Add Patient Search" table should start with "Inpatient"
        When I click the "Clear Criteria" button
        Then the following should be checked
            |Include Cancelled Visits|
            |Include Past Visits     |
        And the value in the "Admit in last N days" field should be blank
        And the value in the "Search First Name" field should be blank
        And the value in the "Search Last Name" field should be blank
        And Nothing should be selected in the "Visit Type" dropdown
        When I click the "Close" button in the "Add patient(s) to your patient list" pane
        Then patient "Roy Blazer" should not be on the patient list

    @BuildVerificationTest
    Scenario: Patient name appearance on the top of the right pane
        Given "Molly Darr" is on the patient list
        When I select patient "Molly Darr" from the patient list
        Then the text "DARR, MOLLY" should appear in the "Header" pane

    @BuildVerificationTest
    Scenario: Remove All Patients [DEV-47409]
        Given there should be at least "1" patients on the patient list
        When I select "Remove Multiple Patients" from the "Actions" menu
        And I click the "Select All" button in the "Remove Patients from your Short List" pane
        And I click the "Remove" button
        Then the patient list should be empty

    @PortalSmoke
    Scenario: Remove Multiple Patients [DEV-47409]
        Given "Molly Darr" is on the patient list
        And "Mona Angeline" is on the patient list
        And "Roy Blazer" is on the patient list
        When I select "Remove Multiple Patients" from the "Actions" menu
        And I click the "Remove" button
        Then the text "You need to select at least one patient to remove" should appear in the "Warning" pane
        When I click the "OK" button in the "Warning" pane
        And I select patient "Mona Angeline" from the "Name (\d)" column in the "Remove Patients" table
        And I select patient "Roy Blazer" from the "Name (\d)" column in the "Remove Patients" table
        And I click the "Remove" button
        And I wait "3" seconds
        And I click the "Close" button if it exists
        And I refresh the patient list
        Then patient "Mona Angeline" should not be on the patient list
        And patient "Roy Blazer" should not be on the patient list
        And patient "Molly Darr" should be on the patient list

    @BuildVerificationTest
    Scenario: Add Active to PatientList
        When I select "Add Patient" from the "Actions" menu
        And I "uncheck" the following
            |Include Cancelled Visits|
            |Include Past Visits     |
        And I search for patient "Mona Angeline"
        And I select patient "Mona Angeline" from the "Name (\d)" column in the "Add Patient Search" table
#        And I select "ADMITTING" from the "Relationship" dropdown
        And I click the "Add" button in the "Add patient(s) to your patient list" pane
        And I click the "Close" button in the "Add patient(s) to your patient list" pane
        Then patient "Mona Angeline" should be on the patient list
