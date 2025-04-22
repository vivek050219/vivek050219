Feature: Admin
#Admin feature file completely developed by Offshore team===

  Background:
    Given I am logged into the portal with the default user
    And I am on the "Admin" tab
    And I select the "Institution" subtab

  @PortalSmoke
  Scenario: Admin Site Admin
  #Verify the SiteAdministration settings display on UI and the changes saved
    Then the "Institution Settings" pane should load
    When I select "Site Administration" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    Then the "Site Administration" pane should load
    #And I wait "3" seconds
    Then the following fields should display in the "Site Administration" pane
      |Name                                                 |Type     |
      |System Name                                          |text     |
      |Login page upper custom message frame height         |text     |
      |Login page lower custom message frame height         |text     |
      |Hide from Active Order List after NN Hours           |text     |
      |Recipients for CPOE Critical Alert Notifications     |text     |
      |Minimum Password length                              |text     |
      |Bulk User Edit                                       |radio    |
      |Provider Directory                                   |radio    |
      |Charge Capture                                       |radio    |
      |Outpatient Visits                                    |radio    |
      |Allergies                                            |radio    |
      |Clinical Notes                                       |radio    |
      |Lab Results                                          |radio    |
      |Medication                                           |radio    |
      |Orders                                               |radio    |
#      |Patient Assignment                                   |radio    |
      |Patient List                                         |radio    |
      |Patient Summary                                      |radio    |
      |Patient Registration                                 |radio    |
      |Patient/Visit Search                                 |radio    |
      |Problem List                                         |radio    |
      |Test Results                                         |radio    |
      |Vitals                                               |radio    |
      |IOs                                                  |radio    |
      |MAR Medication Data                                  |radio    |
      |Forms                                                |radio    |
      |Sign-outTask                                         |radio    |
      |eSignature                                           |radio    |
      |Vitals Capture                                       |radio    |
      |NoteWriter                                           |radio    |
      |CPOE                                                 |radio    |
      |Home Medication                                      |radio    |
      |Medication Reconciliation                            |radio    |
      |CPOE Facility Groups                                 |radio    |
      |HIE                                                  |radio    |
      |Enable Emergency Access                              |radio    |
      |Passwords must include atleast 1 number and 1 letter |radio    |
      |Passwords must be mixed case                         |radio    |
      |Force Password change upon initial login             |radio    |
      |Force Password change after days                     |radio    |
    When I select "true" from the "Bulk User Edit" radio list in the "Site Administration" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    Then the following subtabs should load
      |BulkUserEdit  |