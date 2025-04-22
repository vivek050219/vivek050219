@javascript
Feature: Department Preferences Admin
  Department subtab under Admin

  Background:
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Department" subtab

  @BuildVerificationTest
  Scenario: Setup testcase to turn off all codeedits on user server
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    #And I turn "off" all codeedits on "server"
    And I execute the "Disable All Code Edits" query


  @BuildVerificationTest @PortalSmoke
  Scenario: Add Department
    Given I click the "New Department" button
    Then the text "Create Department" should appear in the "Edit Department" pane
    When I enter "Autocreated-%Current Date%-%Current Time%" in the "Department Name" field
    And I enter "Autocreated-%Current Date%-%Current Time%" in the "Department Label" field
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "1" second
    Then the text "Autocreated-%Current Date%-" should appear in the "Edit Department" pane
    When I click the "Return to Choose Departments" link in the "Edit Settings" pane
    And I wait "1" second
    Then the department "Autocreated-%Current Date%-" should appear in the department list


  @PortalSmoke
  Scenario:Create Department Settings
  #Verify the elements display in the General, Forms, Notewriter, patientList, LabResults, CCSettings,CPOE Settings page
    When I select the department "Autocreated-%Current Date%-"
    And I click the "Edit" button in the "Quick Details" pane
    When I select "General" from the "Edit Department Settings" dropdown
    And I wait "3" seconds
    Then the text "Edit Department:" should appear in the "Edit Department" pane
    And the text "Autocreated-%Current Date%-" should appear in the "Edit Department" pane
    Then the following fields should display in the "Department General Settings" pane
      | Name                                                           | Type  |
      | Department Name                                                | text  |
      | Department Label                                               | text  |
      | Exclude from department checks when sharing data between users | radio |
      | Sign-out                                                       | radio |
      | Facilities                                                     | check |
      | Users [Edit]                                                   | link  |
    When I select "Forms" from the "Edit Department Settings" dropdown
    And I wait "3" seconds
    Then the "Department Forms Settings" pane should load
    And the following fields should display in the "Department Forms Settings" pane
      | Name                 | Type |
      | Form Pickers  [Edit] | link |
    When I select "NoteWriter" from the "Edit Department Settings" dropdown
    And I wait "3" seconds
    Then the "Department NoteWriter Settings" pane should load
    And the following fields should display in the "Department NoteWriter Settings" pane
      | Name                             | Type |
      | Note Pickers [Edit]              | link |
      | Quick Text (Summary View) [Edit] | link |
      #|Quick Text (Template View) [Edit] |link |
      | Quick Text (Template View)       | link |
    When I select "Patient List" from the "Edit Department Settings" dropdown
    And I wait "3" seconds
    Then the "Department PatientList Settings" pane should load
    And the text "Patient List Settings:" should appear in the "Department PatientList Settings" pane
#    Then the following fields should display in the "Department PatientList Settings" pane
#      | Name                                    | Type |
#      | Stock View Filters [Edit]               | link |
#      | Stock Short List Data Filters [Edit]    | link |
#      | Stock Short List Data Populators [Edit] | link |
#      | Stock Long List Data Filters [Edit]     | link |
#      | Stock Rounding Order Lists [Edit]       | link |
#      | Stock Profiles [Edit]                   | link |
    When I select "Lab Results" from the "Edit Department Settings" dropdown
    And I wait "3" seconds
    Then the "Department Lab Results Settings" pane should load
    And the following fields should display in the "Department Lab Results Settings" pane
      | Name                   | Type |
      | Stock Snapshots [Edit] | link |
    When I select "Charge Capture" from the "Edit Department Settings" dropdown
    And I wait "3" seconds
    Then the "Department Charge Capture Settings" pane should load
    Then the following fields should display in the "Department Charge Capture Settings" pane
      | Name                                                                   | Type     |
      | Department Billing Router                                              | dropdown |
      | For charges in this department apply CPT-CPT code edits to set charges | radio    |
      | Department Enable Batch Entry                                          | radio    |
      | Batch Charges by Billing Area or Department                            | radio    |
      | Minimum number of Diagnoses Required per Charge                        | text     |
      | Maximum Number of Diagnoses Allowed per Transaction                    | text     |
      | Configure Billing Areas [Edit]                                         | link     |
      | Add/Edit Charge Pickers [Edit]                                         | link     |
      | Add/Edit Department Macros [Edit]                                      | link     |
    When I select "Problem List" from the "Edit Department Settings" dropdown
    And I wait "3" seconds
    Then the following fields should display in the "Department Problem List Settings" pane
      | Name                     | Type |
      | Diagnosis Pickers [Edit] | link |
    When I select "CPOE" from the "Edit Department Settings" dropdown
    And I wait "3" seconds
    Then the "Department CPOE Settings" pane should load
    And the following fields should display in the "Department CPOE Settings" pane
      | Name             | Type |
      | Favorites [Edit] | link |
    And I click the "Return to Choose Departments" link in the "Edit Settings" pane

  @PortalSmoke
  Scenario: Create Department - General Sign Out Settings
  #Verify the elements display in the Department SignoutSettings page
    When I select the department "Autocreated-%Current Date%-"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "General" from the "Edit Department Settings" dropdown
    And I select "true" from the "Sign-out" radio list in the "Department General Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "2" seconds
    Then the "Department General Settings" pane should load
    When I select "Sign-Out" from the "Edit Department Settings" dropdown
    Then the following fields should display in the "Department Signout Settings" pane
      | Name                                              | Type  |
      | Task Pickers [Edit]                               | link  |
      | Form Lookup                                       | link  |
      | Include Clinical Data on Sign-out Summary         | radio |
      | Delete Sign-Out info after N days after discharge | text  |
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "3" seconds
    Then the "Department General Settings" pane should load
    And I click the "Return to Choose Departments" link in the "Department Edit Settings" pane
    Then the "Department Settings" pane should load

  @PortalSmoke
  Scenario: Edit Department
  #Edit the Newly created department and Add users to the department
    When I select the department "Autocreated-%Current Date%-"
    Then the text "Autocreated-%Current Date%-" should appear in the "Quick Details" pane
    And I click the "Edit" button in the "Quick Details" pane
   #done by offshore, acc to new step defination
    When I click the "Users" edit link in the "Department General Settings" pane
    And I search for the user "autouser"
    Then the user "autouser" should appear in the department user list
    When I check the "User Select" checkbox in the "DepartmentUsers" pane
    And I click the "Save" button in the "Quick Details" pane
    Then the text "AUTO, USER" should appear in the "Department General Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait "3" seconds
    Then the "Department General Settings" pane should load
    And I click the "Return to Choose Departments" link in the "Department Edit Settings" pane


  # Create Department picker
  @PortalSmoke
  Scenario: Edit Pickers
    Given I select the department "Autocreated-%Current Date%-"
    And I click the "Edit" button in the "Quick Details" pane
    When I select "Charge Capture" from the "Edit Department Settings" dropdown
    And I click the "Charge Pickers" edit link in the "Department Charge Capture Settings" pane
    And I wait "3" seconds
    Then the "Department Charge Pickers Header" pane should load
    When I click the "Delete All Pickers" button in the "Department Charge Pickers" pane
    And I click the "Yes" button in the "Warning" pane
    And I click the "Department Pickers" edit category link in the "Department Charge Pickers" pane
    And I wait "2" seconds
    Then the "Edit Department Pickers" pane should load
    And I click the "Add Category" button in the "Edit Department Pickers" pane
    Then the "Add Category" pane should load
    When I enter "autopicker" in the "Enter new category name" field
    And I click the "OK" button in the "Add Category Contents" pane
    #Then the "Add Category" pane should close
    And I wait "2" second
    When I click the "Save" button in the "Edit Department Pickers" pane
    Then the "Department Pickers Edit" table should have "1" rows containing the text "autopicker"
    When I click the "Close" button in the "Department Charge Pickers" pane
    #Then the "Department Charge Pickers Header" pane should close
    And I wait "1" second
    And I click the "Return to Choose Departments" link in the "Edit Settings" pane


  @PortalSmoke @donotrun
  Scenario: Edit Filters
#    Making it donotrun as it is PLV1 feature
  #Adding Stock View Filters to the department
    When I select the department "Autocreated-%Current Date%-"
    And I click the "Edit" button in the "Quick Details" pane
    When I select "Patient List" from the "Edit Department Settings" dropdown
    And I wait "2" seconds
    Then the "Department Patient List Settings" pane should load
    When I click the "Stock View Filters" edit link in the "Department Patient List Settings" pane
    Then the "Stock View Filters" pane should load
    When I click the "New Filter" button
    Then the "Create Stock View Filter" pane should load
    When I enter "autofilter-%Current Date%-%Current Time%" in the "Filter Name" field in the "Quick Details" pane
    And I select "All Related Encounters" from the "Filter Scope" dropdown in the "Quick Details" pane
    And I select "Appointment Time" from the "Filter Property" dropdown in the "Create Stock View Filter" pane
    And I select "2 Days ago" from the "Property Value" dropdown in the "Create Stock View Filter" pane
    And I click the "Add Filter" button in the "Create Stock View Filter" pane
    And I click the "Save" button in the "Quick Details" pane
    Then the "Stock View Filters" pane should load
    When I click the "Return to Patient List Settings" link in the "Department Settings" pane
    Then the "Department Patient List Settings" pane should load
    And the text "autofilter-%Current Date%-" should appear in the "Department Patient List Settings" pane
    And I click the "Return to Choose Departments" link in the "Edit Settings" pane

  @PortalSmoke @donotrun
  Scenario: Edit Populators
  #    Making it donotrun as it is PLV1 feature
  #Adding Stock Short List Data Populators to the department
    When I select the department "Autocreated-%Current Date%-"
    And I click the "Edit" button in the "Quick Details" pane
    When I select "Patient List" from the "Edit Department Settings" dropdown
    And I wait "3" seconds
    Then the "Department Patient List Settings" pane should load
    When I click the "Stock Short List Data Populators" edit link in the "Department Patient List Settings" pane
    Then the "Short List Data Populators" pane should load
    When I click the "New Populator" button
    Then the "Create Short List DataPopulator" pane should load
    And the following fields should display in the "Create Short List Data Populator" pane
      | Name                   | Type |
      | Location [Edit]        | link |
      | Visit Type  [Edit]     | link |
      | Medical Service [Edit] | link |
      | Provider Groups [Edit] | link |
      | Financial Class [Edit] | link |
      | Insurance Type [Edit]  | link |
#    #commented this as it is known issue in 803 DEV-43581
#    #|Backend List Type [Edit]|link |
    When I enter "autopopulator-%Current Date%-%Current Time%" in the "Populator Name" field in the "QuickDetails" pane
    And I click the "Save" button in the "Quick Details" pane
    Then the "Short List Data Populators" pane should load
    When I click the "Return to Patient List Settings" element in the "Department Settings" pane
    Then the "Department Patient List Settings" pane should load
    And the text "autopopulator-%Current Date%-" should appear in the "Department Patient List Settings" pane
    And I click the "Return to Choose Departments" link in the "Edit Settings" pane
