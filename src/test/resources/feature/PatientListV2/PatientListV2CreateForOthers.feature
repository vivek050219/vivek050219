@PatientListV2
Feature: Patient List V2 Create For Others
  Test creation of patient lists for other users
  Setup:
  Patient List Setting for PLV2ADMIN: Can Favorite for Others - Yes
  Patient List Setting for PLV2ADMIN: Can Create for Others - Yes
  Create departments:
  PLV2Department1
  PLV2Department2
  PLV2Department3
  VervePLV2EmptyDepartment


  Background:
    Given I am logged into the portal with user "PLV2ADMIN" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized


  @PatientSafety
  Scenario: 1. Create Patient List for Me(PLV2ADMIN)
    Given I select "Create a Patient List" from the "Actions" menu
    Then I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Create For PLV2ADMIN" in the "Name" field
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Relationship to Me" from the "Filter On" dropdown
    Then the "Relationships" pane should load
    And I click the "Admitting" button
    And I click the "Add Filter" button
    And I select the "Users" section
    And I check the "Create For Me" checkbox
    And I click the "Create Patient List Create My List" button
    And I wait "2" seconds
    And I refresh the patient list
    Then the "Patient List" menu should have the following options
      | VerveDel Create For PLV2ADMIN |
    And I select "VerveDel Create For PLV2ADMIN" from the "Patient List" menu
    And I wait "2" seconds
    And "Molly Darr" is on the patient list
    Then patient "MOLLY DARR" should be on the patient list
    When I am logged into the portal with user "PLV2LVL3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For PLV2ADMIN |


  @PatientSafety
  Scenario: 2. Create Patient List for another user(PLV2LVL3)
    Given I select "Create a Patient List" from the "Actions" menu
    Then I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Create For PLV2LVL3 User" in the "Name" field
    And I select the "Filters" section
    Then the "Filter Criteria" pane should load
    And I click the "Add A Filter" button
    When I select "Medical Service" from the "Filter On" dropdown
    Then the "Medical Service" pane should load
    When I enter "Card Group" in the "Filter Search" field
    Then I click the "Check All" element
    And I click the "Add Filter" button
    And I select the "Users" section
    And I uncheck the "Create For Me" checkbox
    And I select "Specific users/departments/facilities..." from the "Create For Additional Users" dropdown
    And I enter "PLV2LVL3" in the "Create For Additional Users Search" field
    And I wait "4" seconds
    And I click the "Create Patient List Create My List" button
    And I click the "Yes Create The Lists" button
    Then the "List Were Created For User Complete" pane should load within "20" seconds
    And I click the "OK Create" button in the "Create Patient Lists" pane
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For PLV2LVL3 User |
    When I am logged into the portal with user "PLV2LVL3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For PLV2LVL3 User |
    And I select "VerveDel Create For PLV2LVL3 User" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    Then patient "MOLLY DARR" should be on the patient list


  Scenario: 3. Create Patient List for Me(PLV2ADMIN) and another user(PLV2), Favorited
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Create For PLV2ADMIN and PLV2LVL3" in the "Name" field
    And I enter "Description" in the "Description" field
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Relationship to Me" from the "Filter On" dropdown
    Then the "Relationships" pane should load
    And I click the "Admitting" button
    And I click the "Add Filter" button
    And I select the "Users" section
    And I check the "Create For Me" checkbox
    And I select "Specific users/departments/facilities..." from the "Create For Additional Users" dropdown
    And I enter "PLV2LVL3" in the "Create For Additional Users Search" field
    And I wait "1" second
    And I click the "Create Patient List Create My List" button
    And I click the "Yes Create The Lists" button
    Then the "List Were Created For User Complete" pane should load within "20" seconds
    And I click the "OK Create" button in the "Create Patient Lists" pane
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should have the following options
      | VerveDel Create For PLV2ADMIN and PLV2LVL3 |
    When I am logged into the portal with user "PLV2LVL3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For PLV2ADMIN and PLV2LVL3 |

  Scenario: 4. Create Patient List for Me(PLV2ADMIN) and another user(PLV2), not favorited
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Create Not Favorited" in the "Name" field
    And I enter "Description" in the "Description" field
    And I click the "CreatePatientListFavorite" button
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Relationship to Me" from the "Filter On" dropdown
    Then the "Relationships" pane should load
    And I click the "Admitting" button
    And I click the "Add Filter" button
    And I select the "Permissions" section
    And I select "No other users" from the "View" dropdown
    And I wait "1" second
    And I select the "Users" section
    And I check the "Create For Me" checkbox
    And I select "Specific users/departments/facilities..." from the "Create For Additional Users" dropdown
    And I enter "PLV2LVL3" in the "Create For Additional Users Search" field
    And I click the "Create Patient List Create My List" button
    And I click the "Yes Create The Lists" button
    Then the "List Were Created For User Complete" pane should load within "20" seconds
    And I click the "OK Create" button in the "Create Patient Lists" pane
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should not have the following options
      | VerveDel Create Not Favorited |
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Create Not Favorited" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "1" second
    Then the "Patient List Search Results" table should have at least "1" row containing the text "VerveDel Create Not Favorited"
    And I click the "Close Search For PatientList" button
    When I am logged into the portal with user "PLV2LVL3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Create Not Favorited |
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Create Not Favorited" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "1" second
    Then the "Patient List Search Results" table should have at least "1" row containing the text "VerveDel Create Not Favorited"
    And I click the "Close Search For PatientList" button

  Scenario: 5. Create Patient List for Me(PLV2ADMIN) and All Users
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Create For All" in the "Name" field
    And I enter "Description" in the "Description" field
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Location" from the "Filter On" dropdown
    Then the "Location" pane should load
    And I click the "PKHospital" button
    And I click the "Add Filter" button
    And I select the "Users" section
    And I check the "Create For Me" checkbox
    And I select "All users" from the "Create For Additional Users" dropdown
    And I click the "Create Patient List Create My List" button
    And I click the "Yes Create The Lists" button
    Then the "List Were Created For User Complete" pane should load within "150" seconds
    When I click the "OK Create" button in the "Create Patient Lists" pane
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should have the following options
      | VerveDel Create For All |
    When I am logged into the portal with user "PLV2LVL3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For All |
    When I am logged into the portal with user "PLV2the2nd" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For All |
    When I am logged into the portal with user "PLV2the3rd" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For All |

  Scenario: 6. Create Patient List for Me(PLV2ADMIN) and All Users, not favorited
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Create For All Not Favorited" in the "Name" field
    And I enter "Description" in the "Description" field
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Insurance Company" from the "Filter On" dropdown
    Then the "Insurance Company" pane should load
    When I enter "Cigna" in the "Insurance Filter Search" field
    And I check the "Cigna" checkbox
    And I click the "Add Filter" button
    And I select the "Permissions" section
    And I select "No other users" from the "View" dropdown
    And I select the "Users" section
    And I check the "Create For Me" checkbox
    And I select "All users" from the "Create For Additional Users" dropdown
    And I click the "Create Patient List Create My List" button
    And I click the "Yes Create The Lists" button
    Then the "List Were Created For User Complete" pane should load within "150" seconds
    When I click the "OK Create" button in the "Create Patient Lists" pane
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For All Not Favorite |
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Create For All Not Favorite" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "1" second
    Then the "Patient List Search Results" table should have at least "1" row containing the text "VerveDel Create For All"
    And I click the "Close Search For PatientList" button
    When I am logged into the portal with user "PLV2LVL3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For All Not Favorite |
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Create For All Not Favorite" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "1" second
    Then the "Patient List Search Results" table should have at least "1" row containing the text "VerveDel Create For All"
    And I click the "Close Search For PatientList" button
    When I am logged into the portal with user "PLV2the2nd" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For All Not Favorite |
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Create For All Not Favorite" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "1" second
    Then the "Patient List Search Results" table should have at least "1" row containing the text "VerveDel Create For All"
    And I click the "Close Search For PatientList" button
    When I am logged into the portal with user "PLV2the3rd" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For All Not Favorite |
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Create For All Not Favorite" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "1" second
    Then the "Patient List Search Results" table should have at least "1" row containing the text "VerveDel Create For All"
    And I click the "Close Search For PatientList" button

  Scenario: 7. Create Patient List for All Users
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Create For All 2" in the "Name" field
    And I enter "Description" in the "Description" field
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Insurance Company" from the "Filter On" dropdown
    Then the "Insurance Company" pane should load
    When I enter "Cigna" in the "Insurance Filter Search" field
    And I check the "Cigna" checkbox
    And I click the "Add Filter" button
    And I select the "Permissions" section
    And I select "No other users" from the "View" dropdown
    And I select the "Users" section
    And I uncheck the "Create For Me" checkbox
    And I select "All users" from the "Create For Additional Users" dropdown
    And I click the "Create Patient List Create My List" button
    And I click the "Yes Create The Lists" button
    Then the "List Were Created For User Complete" pane should load within "150" seconds
    When I click the "OK Create" button in the "Create Patient Lists" pane
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should have the following options
      | VerveDel Create For All 2 |
    When I am logged into the portal with user "PLV2LVL3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For All 2 |
    When I am logged into the portal with user "PLV2the2nd" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For All 2 |
    When I am logged into the portal with user "PLV2the3rd" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For All 2 |

  Scenario: 8. Create Patient List for Multiple Users
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Create For PLV2 Users" in the "Name" field
    And I enter "Description" in the "Description" field
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Insurance Company" from the "Filter On" dropdown
    Then the "Insurance Company" pane should load
    When I enter "Cigna" in the "Insurance Filter Search" field
    And I check the "Cigna" checkbox
    And I click the "Add Filter" button
    And I select the "Users" section
    And I uncheck the "Create For Me" checkbox
    And I select "Specific users/departments/facilities..." from the "Create For Additional Users" dropdown
    And I enter "PLV2LVL3" in the "Create For Additional Users Search" field
    And I enter "PLV2the2nd" in the "Create For Additional Users Search" field
    And I enter "PATIENTLISTV2THE3RD" in the "Create For Additional Users Search" field
    And I select the "Permissions" section
    And I select "No other users" from the "View" dropdown
    And I wait "1" seconds
   #		And I enter "PATIENTLISTV2" in the "Create For Additional Users Search" field
   #		And I click the "Search the Additional Users" button
   #		And I select "PATIENTLISTV2" from the "Last Name" column in the "Create For Additional Users Search Results" table
   #		And I enter "PATIENTLISTV2" in the "Create For Additional Users Search" field
   #		And I click the "Search the Additional Users" button
   #		And I select "PATIENTLISTV2THE2ND" from the "Last Name" column in the "Create For Additional Users Search Results" table
   #		And I enter "PATIENTLISTV2" in the "Create For Additional Users Search" field
   #		And I click the "Search the Additional Users" button
   #		And I select "PATIENTLISTV2THE3RD" from the "Last Name" column in the "Create For Additional Users Search Results" table
    And I click the "Create Patient List Create My List" button
    And I click the "Yes Create The Lists" button
    Then the "List Were Created For User Complete" pane should load within "20" seconds
    And I click the "OK Create" button in the "Create Patient Lists" pane
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For PLV2 Users |
    When I am logged into the portal with user "PLV2LVL3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For PLV2 Users |
    When I am logged into the portal with user "PLV2the2nd" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For PLV2 Users |
    When I am logged into the portal with user "PLV2the3rd" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For PLV2 Users |

  Scenario: 9. Create Patient List for No One
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Create For None" in the "Name" field
    And I enter "Description" in the "Description" field
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Insurance Company" from the "Filter On" dropdown
    Then the "Insurance Company" pane should load
    When I enter "Cigna" in the "Insurance Filter Search" field
    And I check the "Cigna" checkbox
    And I click the "Add Filter" button
    And I select the "Users" section
    And I uncheck the "Create For Me" checkbox
    And I select "No other users" from the "Create For Additional Users" dropdown
    And I click the "Create Patient List Create My List" button
    Then the text "At least one User must be selected for whom this list is to be created." should appear in the "Create Patient List Users" pane
    When I check the "Create For Me" checkbox
    And I click the "Create Patient List Create My List" button
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should have the following options
      | VerveDel Create For None |

  Scenario: 10. No User/Department/Facility Selected
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Create For None" in the "Name" field
    And I enter "Description" in the "Description" field
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Insurance Company" from the "Filter On" dropdown
    Then the "Insurance Company" pane should load
    When I enter "Cigna" in the "Insurance Filter Search" field
    And I check the "Cigna" checkbox
    And I click the "Add Filter" button
    And I select the "Users" section
    And I uncheck the "Create For Me" checkbox
    And I select "Specific users/departments/facilities..." from the "Create For Additional Users" dropdown
    And I click the "Create Patient List Create My List" button
    Then the text "At least one User must be selected for whom this list is to be created." should appear in the "Create Patient List Users" pane
    And I click the "Create Patient List Cancel" button

  Scenario: 11. Attempt to Create for Department with No Users
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Create For Empty Dept" in the "Name" field
    And I enter "Description" in the "Description" field
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Insurance Company" from the "Filter On" dropdown
    Then the "Insurance Company" pane should load
    When I enter "Cigna" in the "Insurance Filter Search" field
    And I check the "Cigna" checkbox
    And I click the "Add Filter" button
    And I select the "Users" section
    And I uncheck the "Create For Me" checkbox
    And I select "Specific users/departments/facilities..." from the "Create For Additional Users" dropdown
     #Enter some text that will bring up a list of users but won't auto-complete
    And I enter "VervePLV2EmptyDepartment" in the "Create For Additional Users Search" field
    And I wait "1" second
    And I click the "Create Patient List Create My List" button
    Then the text "At least one User must be selected for whom this list is to be created." should appear in the "Create Patient List Users" pane
    And I click the "Create Patient List Cancel" button

  Scenario: 12. Create patient list for Department
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Create For a Department" in the "Name" field
    And I enter "Description" in the "Description" field
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Insurance Company" from the "Filter On" dropdown
    Then the "Insurance Company" pane should load
    When I enter "Cigna" in the "Insurance Filter Search" field
    And I check the "Cigna" checkbox
    And I click the "Add Filter" button
    And I select the "Users" section
    And I uncheck the "Create For Me" checkbox
    And I select "Specific users/departments/facilities..." from the "Create For Additional Users" dropdown
    And I enter "VervePLV2Dept1FacA" in the "Create For Additional Users Search" field
     #It is now auto-selecting upon full user/facility/dept search
     #And I click the "Search the Additional Users" button
     #And I select "VervePLV2Dept1FacA" from the "Name" column in the "Create For Additional Users Search Results" table
    And I wait "1" second
    And I click the "Create Patient List Create My List" button
    And I click the "Yes Create The Lists" button
    Then the "List Were Created For User Complete" pane should load within "20" seconds
    And I click the "OK Create" button in the "Create Patient Lists" pane
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For a Department |
    When I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For a Department |
    When I am logged into the portal with user "Verve2Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For a Department |
    When I am logged into the portal with user "Verve1Dept2FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For a Department |

  Scenario: 13. Create patient list for Department, not favorited
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Create For a Department Not Favorited" in the "Name" field
    And I enter "Description" in the "Description" field
    And I click the "CreatePatientListFavorite" button
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Insurance Company" from the "Filter On" dropdown
    Then the "Insurance Company" pane should load
    When I enter "Cigna" in the "Insurance Filter Search" field
    And I check the "Cigna" checkbox
    And I click the "Add Filter" button
    And I select the "Users" section
    And I uncheck the "Create For Me" checkbox
    And I select "Specific users/departments/facilities..." from the "Create For Additional Users" dropdown
    And I enter "VervePLV2Dept1FacA" in the "Create For Additional Users Search" field
    And I select the "Permissions" section
    And I select "No other users" from the "View" dropdown
     #It is now auto-selecting upon full user/facility/dept search
     #And I click the "Search the Additional Users" button
     #And I select "VervePLV2Dept1FacA" from the "Name" column in the "Create For Additional Users Search Results" table
    And I wait "1" second
    And I click the "Create Patient List Create My List" button
    And I click the "Yes Create The Lists" button
    Then the "List Were Created For User Complete" pane should load within "20" seconds
    And I click the "OK Create" button in the "Create Patient Lists" pane
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For a Department Not Favorited |
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Create For a Department Not Favorite" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "1" second
     #Then the "Patient List Search Results" table should have "0" rows containing the text "VerveDel Create For a Department Not Favorite"
    Then the "Patient List Search Results" table should have "0" rows containing the text "PATIENTLISTV2ADMIN, V"
    And I click the "Close Search For PatientList" button
    When I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For a Department Not Favorited |
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Create For a Department Not Favorite" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "1" second
    Then the "Patient List Search Results" table should have at least "1" row containing the text "VerveDel Create For a Department Not Favorite"
    And I click the "Close Search For PatientList" button
    When I am logged into the portal with user "Verve2Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For a Department Not Favorited |
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Create For a Department Not Favorite" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "1" second
    Then the "Patient List Search Results" table should have at least "1" row containing the text "VerveDel Create For a Department Not Favorite"
    And I click the "Close Search For PatientList" button
    When I am logged into the portal with user "Verve1Dept2FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For a Department Not Favorited |
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Create For a Department Not Favorite" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "1" second
    Then the "Patient List Search Results" table should have "0" rows containing the text "VerveDel Create For a Department Not Favorite"
    And I click the "Close Search For PatientList" button

  Scenario: 14. Create patient list for Departments
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Create For multiple Departments" in the "Name" field
    And I enter "Description" in the "Description" field
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Insurance Company" from the "Filter On" dropdown
    Then the "Insurance Company" pane should load
    When I enter "Cigna" in the "Insurance Filter Search" field
    And I check the "Cigna" checkbox
    And I click the "Add Filter" button
    And I select the "Users" section
    And I uncheck the "Create For Me" checkbox
    And I select "Specific users/departments/facilities..." from the "Create For Additional Users" dropdown
    And I enter "VervePLV2Dept1FacA" in the "Create For Additional Users Search" field
     #It is now auto-selecting upon full user/facility/dept search
     #And I click the "Search the Additional Users" button
     #And I select "VervePLV2Dept1FacA" from the "Name" column in the "Create For Additional Users Search Results" table
    And I enter "VervePLV2Dept3FacB" in the "Create For Additional Users Search" field
     #It is now auto-selecting upon full user/facility/dept search
     #And I click the "Search the Additional Users" button
     #And I select "VervePLV2Dept3FacB" from the "Name" column in the "Create For Additional Users Search Results" table
    And I wait "1" second
    And I click the "Create Patient List Create My List" button
    And I click the "Yes Create The Lists" button
    Then the "List Were Created For User Complete" pane should load within "20" seconds
    And I click the "OK Create" button in the "Create Patient Lists" pane
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For multiple Departments |
    When I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For multiple Departments |
    When I am logged into the portal with user "Verve2Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For multiple Departments |
    When I am logged into the portal with user "Verve1Dept3FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For multiple Departments |
    When I am logged into the portal with user "Verve1Dept2FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For multiple Departments |

  Scenario: 15. Attempt to Create for Facility with No Users
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Create For Empty Facility" in the "Name" field
    And I enter "Description" in the "Description" field
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Insurance Company" from the "Filter On" dropdown
    Then the "Insurance Company" pane should load
    When I enter "Cigna" in the "Insurance Filter Search" field
    And I check the "Cigna" checkbox
    And I click the "Add Filter" button
    And I select the "Users" section
    And I uncheck the "Create For Me" checkbox
    And I select "Specific users/departments/facilities..." from the "Create For Additional Users" dropdown
    And I enter "PKHospital-Lakeside" in the "Create For Additional Users Search" field
     #It is now auto-selecting upon full user/facility/dept search
     #And I click the "Search the Additional Users" button
     #And I select "PKHospital-Lakeside" from the "Name" column in the "Create For Additional Users Search Results" table
    And I wait "1" second
    And I click the "Create Patient List Create My List" button
    Then the text "At least one User must be selected for whom this list is to be created." should appear in the "Create Patient List Users" pane
    And I click the "Create Patient List Cancel" button

  Scenario: 16. Create patient list for Facility
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Create For a Facility" in the "Name" field
    And I enter "Description" in the "Description" field
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Insurance Company" from the "Filter On" dropdown
    Then the "Insurance Company" pane should load
    When I enter "Cigna" in the "Insurance Filter Search" field
    And I check the "Cigna" checkbox
    And I click the "Add Filter" button
    And I select the "Users" section
    And I uncheck the "Create For Me" checkbox
    And I select "Specific users/departments/facilities..." from the "Create For Additional Users" dropdown
    And I enter "PKHospital-Central" in the "Create For Additional Users Search" field
     #It is now auto-selecting upon full user/facility/dept search
     #And I click the "Search the Additional Users" button
     #And I select "PKHospital-Central" from the "Name" column in the "Create For Additional Users Search Results" table
    And I wait "5" second
    And I click the "Create Patient List Create My List" button
    And I click the "Yes Create The Lists" button
    Then the "List Were Created For User Complete" pane should load within "40" seconds
    And I click the "OK Create" button in the "Create Patient Lists" pane
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For a Facility |
    When I am logged into the portal with user "Verve1Dept3FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For a Facility |
    When I am logged into the portal with user "Verve1Dept4FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For a Facility |
    When I am logged into the portal with user "Verve2Dept4FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For a Facility |
    When I am logged into the portal with user "Verve3Dept4FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For a Facility |
    When I am logged into the portal with user "Verve1Dept5FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For a Facility |
    When I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For a Facility |

  Scenario: 17. Create patient list for Facility, not favorited
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Create For a Facility Not Favorited" in the "Name" field
    And I click the "CreatePatientListFavorite" button
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Insurance Company" from the "Filter On" dropdown
    Then the "Insurance Company" pane should load
    When I enter "Cigna" in the "Insurance Filter Search" field
    And I check the "Cigna" checkbox
    And I click the "Add Filter" button
    And I select the "Users" section
    And I uncheck the "Create For Me" checkbox
    And I select "Specific users/departments/facilities..." from the "Create For Additional Users" dropdown
    And I enter "PKHospital-Central" in the "Create For Additional Users Search" field
    And I select the "Permissions" section
    And I select "No other users" from the "View" dropdown
     #It is now auto-selecting upon full user/facility/dept search
     #And I click the "Search the Additional Users" button
     #And I select "PKHospital-Central" from the "Name" column in the "Create For Additional Users Search Results" table
    And I wait "1" seconds
    And I click the "Create Patient List Create My List" button
    And I click the "Yes Create The Lists" button
    Then the "List Were Created For User Complete" pane should load within "20" seconds
    And I click the "OK Create" button in the "Create Patient Lists" pane
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For a Facility Not Favorited |
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Create For a Facility Not Favorited" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "1" second
    Then the "Patient List Search Results" table should have "0" rows containing the text "PATIENTLISTV2ADMIN, V"
    And I click the "Close Search For PatientList" button
    When I am logged into the portal with user "Verve1Dept3FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For a Facility Not Favorited |
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Create For a Facility Not Favorited" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "1" second
    Then the "Patient List Search Results" table should have "1" rows containing the text "VerveDel Create For a Facility Not Favorited"
    And I click the "Close Search For PatientList" button
    When I am logged into the portal with user "Verve1Dept4FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For a Facility Not Favorited |
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Create For a Facility Not Favorited" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "1" second
    Then the "Patient List Search Results" table should have "1" rows containing the text "VerveDel Create For a Facility Not Favorited"
    And I click the "Close Search For PatientList" button
    When I am logged into the portal with user "Verve2Dept4FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For a Facility Not Favorited |
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Create For a Facility Not Favorited" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "1" second
    Then the "Patient List Search Results" table should have "1" rows containing the text "VerveDel Create For a Facility Not Favorited"
    And I click the "Close Search For PatientList" button
    When I am logged into the portal with user "Verve3Dept4FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For a Facility Not Favorited |
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Create For a Facility Not Favorited" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "1" second
    Then the "Patient List Search Results" table should have "1" rows containing the text "VerveDel Create For a Facility Not Favorited"
    And I click the "Close Search For PatientList" button
    When I am logged into the portal with user "Verve1Dept5FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For a Facility Not Favorited |
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Create For a Facility Not Favorited" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "1" second
    Then the "Patient List Search Results" table should have "1" rows containing the text "VerveDel Create For a Facility Not Favorited"
    And I click the "Close Search For PatientList" button
    When I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For a Facility Not Favorited |
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Create For a Facility Not Favorited" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "1" second
    Then the "Patient List Search Results" table should have "0" rows containing the text "VerveDel Create For a Facility Not Favorited"
    And I click the "Close Search For PatientList" button

  Scenario: 18. Create patient list for Facilities
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Create For a Facilities" in the "Name" field
    And I enter "Description" in the "Description" field
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Insurance Company" from the "Filter On" dropdown
    Then the "Insurance Company" pane should load
    When I enter "Cigna" in the "Insurance Filter Search" field
    And I check the "Cigna" checkbox
    And I click the "Add Filter" button
    And I select the "Users" section
    And I uncheck the "Create For Me" checkbox
    And I select "Specific users/departments/facilities..." from the "Create For Additional Users" dropdown
    And I enter "PKHospital-Alliance" in the "Create For Additional Users Search" field
     #It is now auto-selecting upon full user/facility/dept search
     #And I click the "Search the Additional Users" button
     #And I select "PKHospital-Alliance" from the "Name" column in the "Create For Additional Users Search Results" table
    And I enter "PKHospital-Central" in the "Create For Additional Users Search" field
     #It is now auto-selecting upon full user/facility/dept search
     #And I click the "Search the Additional Users" button
     #And I select "PKHospital-Central" from the "Name" column in the "Create For Additional Users Search Results" table
    And I select the "Permissions" section
    And I select "No other users" from the "View" dropdown
    And I wait "1" second
    And I click the "Create Patient List Create My List" button
    And I click the "Yes Create The Lists" button
    Then the "List Were Created For User Complete" pane should load within "20" seconds
    And I click the "OK Create" button in the "Create Patient Lists" pane
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For a Facilities |
    When I am logged into the portal with user "Verve1Dept3FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For a Facilities |
    When I am logged into the portal with user "Verve1Dept4FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For a Facilities |
    When I am logged into the portal with user "Verve2Dept4FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For a Facilities |
    When I am logged into the portal with user "Verve3Dept4FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For a Facilities |
    When I am logged into the portal with user "Verve1Dept5FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For a Facilities |
    When I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For a Facilities |
    When I am logged into the portal with user "Verve2Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For a Facilities |
    When I am logged into the portal with user "Verve1Dept2FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For a Facilities |

  Scenario: 19. Create patient list for a User, a Department and a Facility
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Create For User Department Facility" in the "Name" field
    And I enter "Description" in the "Description" field
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Insurance Company" from the "Filter On" dropdown
    Then the "Insurance Company" pane should load
    When I enter "Cigna" in the "Insurance Filter Search" field
    And I check the "Cigna" checkbox
    And I click the "Add Filter" button
    And I select the "Users" section
    And I check the "Create For Me" checkbox
    And I select "Specific users/departments/facilities..." from the "Create For Additional Users" dropdown
    And I enter "PLV2LVL3" in the "Create For Additional Users Search" field
    And I enter "VervePLV2Dept1FacA" in the "Create For Additional Users Search" field
     #It is now auto-selecting upon full user/facility/dept search
     #And I click the "Search the Additional Users" button
     #And I select "VervePLV2Dept1FacA" from the "Name" column in the "Create For Additional Users Search Results" table
    And I enter "PKHospital-Central" in the "Create For Additional Users Search" field
     #It is now auto-selecting upon full user/facility/dept search
     #And I click the "Search the Additional Users" button
     #And I select "PKHospital-Central" from the "Name" column in the "Create For Additional Users Search Results" table
    And I select the "Permissions" section
    And I select "No other users" from the "View" dropdown
    And I wait "1" seconds
    And I click the "Create Patient List Create My List" button
    And I click the "Yes Create The Lists" button
    Then the "List Were Created For User Complete" pane should load within "20" seconds
    And I click the "OK Create" button in the "Create Patient Lists" pane
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should have the following options
      | VerveDel Create For User Department Facility |
    When I am logged into the portal with user "PLV2LVL3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For User Department Facility |
    When I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For User Department Facility |
    When I am logged into the portal with user "Verve2Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For User Department Facility |
    When I am logged into the portal with user "Verve1Dept3FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For User Department Facility |
    When I am logged into the portal with user "Verve1Dept4FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For User Department Facility |
    When I am logged into the portal with user "Verve2Dept4FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For User Department Facility |
    When I am logged into the portal with user "Verve3Dept4FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For User Department Facility |
    When I am logged into the portal with user "Verve1Dept5FacB" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Create For User Department Facility |
    When I am logged into the portal with user "Verve1Dept2FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Create For User Department Facility |

#    Scenario: Deselect Users/Departments/Facilities
#        When I select "Create a Patient List" from the "Actions" menu
#        And I click the "System Default List" button in the "Choose Template" pane if it exists
#        And I click the "OK Template" button in the "Choose Template" pane if it exists
#        And I enter "VerveDel Create For Empty Fac" in the "Name" field
#        And I enter "Description" in the "Description" field
#        And I select the "Users" section
#        And I uncheck the "Create For Me" checkbox
#        And I select "Specific users/departments/facilities..." from the "Create For Additional Users" dropdown
#        And I enter "PLV2LVL3" in the "Create For Additional Users Search" field
#        And I enter "VervePLV2EmptyDepartment" in the "Create For Additional Users Search" field
#     #It is now auto-selecting upon full user/facility/dept search
#     #And I click the "Search the Additional Users" button
#     #And I select "VervePLV2EmptyDepartment" from the "Name" column in the "Create For Additional Users Search Results" table
#        And I enter "PKHospital-Lakeside" in the "Create For Additional Users Search" field
#     #It is now auto-selecting upon full user/facility/dept search
#     #And I click the "Search the Additional Users" button
#     #And I select "PKHospital-Lakeside" from the "Name" column in the "Create For Additional Users Search Results" table
#        Then the exact text "PATIENTLISTV2, VERVE" should appear in the "Additional Users" pane
#        Then the exact text "VervePLV2EmptyDepartment" should appear in the "Additional Users" pane
#        Then the exact text "PKHospital-Lakeside" should appear in the "Additional Users" pane
#        When I click the "Remove Additional User" button for the "PATIENTLISTV2, VERVE" entry
#        Then the exact text "PATIENTLISTV2, VERVE" should not appear in the "Additional Users" pane
#        When I click the "Remove Additional User" button for the "VervePLV2EmptyDepartment" entry
#        Then the exact text "VervePLV2EmptyDepartment" should not appear in the "Additional Users" pane
#        When I click the "Remove Additional User" button for the "PKHospital-Lakeside" entry
#        Then the exact text "PKHospital-Lakeside" should not appear in the "Additional Users" section in the "Additional Users" pane

  @donotrun
  Scenario: Create patient list with Admitting relationship based filter for a User
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel User Rel Filter" in the "Name" field
    And I enter "Description" in the "Description" field
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Relationship to Me" from the "Filter On" dropdown
    Then the "Relationships" pane should load
     #Treating relationship's checkbox as button for now, workaround for checkbox
    And I click the "Admitting" button
    And I click the "Add Filter" button
    And I select the "Users" section
    And I uncheck the "Create For Me" checkbox
    And I select "Specific users/departments/facilities..." from the "Create For Additional Users" dropdown
    And I enter "PLV2LVL3" in the "Create For Additional Users Search" field
    And I wait "1" second
    And I click the "Create Patient List Create My List" button
    And I click the "Yes Create The Lists" button
    Then the "List Were Created For User Complete" pane should load within "20" seconds
    And I click the "OK Create" button in the "Create Patient Lists" pane
    When I am logged into the portal with user "PLV2LVL3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When I select "VerveDel User Rel Filter" from the "Patient List" menu
    Then the following patients should be on "Patient Visit" PatientList
      | PLV2UserRel1, Verve |
    Then the following patients should not be on "Patient Visit" PatientList
      | PLV2UserRel2, Verve |

  @donotrun
  Scenario: Create patient list with Admitting relationship based filter for a Department
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Dept Rel Filter" in the "Name" field
    And I enter "Description" in the "Description" field
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Relationship to Me" from the "Filter On" dropdown
    Then the "Relationships" pane should load
     #Treating relationship's checkbox as button for now, workaround for checkbox
    And I click the "Admitting" button
    And I click the "Add Filter" button
    And I select the "Users" section
    And I uncheck the "Create For Me" checkbox
    And I select "Specific users/departments/facilities..." from the "Create For Additional Users" dropdown
    And I enter "VervePLV2Dept1FacA" in the "Create For Additional Users Search" field
    And I wait "1" second
    And I click the "Create Patient List Create My List" button
    And I click the "Yes Create The Lists" button
    Then the "List Were Created For User Complete" pane should load within "20" seconds
    And I click the "OK Create" button in the "Create Patient Lists" pane
    When I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When I select "VerveDel Dept Rel Filter" from the "Patient List" menu
    Then the following patients should be on "Patient Visit" PatientList
      | PLV2DeptRel1, Verve* |
      | PLV2DeptRel2, Verve* |
    Then the following patients should not be on "Patient Visit" PatientList
      | PLV2DeptRel3, Verve* |
    When I am logged into the portal with user "Verve2Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When I select "VerveDel Dept Rel Filter" from the "Patient List" menu
    Then the following patients should be on "Patient Visit" PatientList
      | PLV2DeptRel4, Verve* |

  @donotrun
  Scenario: Create patient list with Admitting relationship based filter for a Facility
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel Dept Fac Filter" in the "Name" field
    And I enter "Description" in the "Description" field
    And I select the "Filters" section
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load
    When I select "Relationship to Me" from the "Filter On" dropdown
    Then the "Relationships" pane should load
     #Treating relationship's checkbox as button for now, workaround for checkbox
    And I click the "Admitting" button
    And I click the "Add Filter" button
    And I select the "Users" section
    And I uncheck the "Create For Me" checkbox
    And I select "Specific users/departments/facilities..." from the "Create For Additional Users" dropdown
    And I enter "PKHospital-Alliance" in the "Create For Additional Users Search" field
     #It is now auto-selecting upon full user/facility/dept search
     #And I click the "Search the Additional Users" button
     #And I select "PKHospital-Alliance" from the "Last Name" column in the "Create For Additional Users Search Results" table
    And I wait "1" second
    And I click the "Create Patient List Create My List" button
    And I click the "Yes Create The Lists" button
    Then the "List Were Created For User Complete" pane should load within "20" seconds
    And I click the "OK Create" button in the "Create Patient Lists" pane
    When I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When I select "VerveDel Dept Rel Filter" from the "Patient List" menu
    Then the following patients should be on "Patient Visit" PatientList
      | PLV2DeptRel1, Verve |
      | PLV2DeptRel2, Verve |
    Then the following patients should not be on "Patient Visit" PatientList
      | PLV2DeptRel3, Verve |
    When I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When I select "VerveDel Dept Rel Filter" from the "Patient List" menu
    Then the following patients should be on "Patient Visit" PatientList
      | PLV2DeptRel4, Verve |
    When I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When I select "VerveDel Dept Rel Filter" from the "Patient List" menu
    Then the following patients should be on "Patient Visit" PatientList
      | PLV2FACREL1, VERVE |
    Then the following patients should not be on "Patient Visit" PatientList
      | PLV2FACREL2, VERVE |