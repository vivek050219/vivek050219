#TODO: 'Base Condition' steps are outdated.  Create new lists via API rather than waste time on fixing 'Base Condition' steps.
@PatientListV2
Feature: Patient List V2 Favorite For Others
    Test favoriting of patient lists for other users
    Setup:
    Create "Verve Favorite Test" patient list
    Create PLV2LVL1 user.  Same as PLV2ADMIN but level 1.
    Create PLV2LVL2 user.  Same as PLV2ADMIN but level 2.

    Background:
        Given I am logged into the portal with user "PLV2ADMIN" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized

#[DEV-79084],  https://jira/browse/DEV-79084, "Labels for Patient List Type and Permissions are incorrect"
#    is causing almost this whole feature file to fail.

#        Pre-req for the rest of this feature file.
    Scenario: Setup Create Verve Favorite Test patient list[DEV-79084]
        When I select "Create a Patient List" from the "Actions" menu
        And I click the "System Default List" button in the "Choose Template" pane if it exists
        And I click the "OK Template" button in the "Choose Template" pane if it exists
        And I enter "VerveDel Favorite Test" in the "Name" field
        And I enter "Description" in the "Description" field
        And I select the "Filters" section
        And I click the "Add A Filter" button
        Then the "Filter Criteria" pane should load
        When I select "Medical Service" from the "Filter On" dropdown
        Then the "Medical Service" pane should load
        When I enter "PLM2Test-TBC" in the "Filter Search" field
        Then I check the "PLM2Test-TBC" checkbox
        And I click the "Add Filter" button
        And I select the "Permissions" section
        And I select "All users" from the "View" dropdown
        And I click the "Create Patient List Create My List" button
        And I wait "3" seconds
        Then the "Patient List" menu should have the following options
            |VerveDel Favorite Test|

    Scenario: Favorite patient list for Myself(PLV2ADMIN) and No Other user
        When I select "Find a Patient List" from the "Actions" menu
        And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
        And I enter "VerveDel Favorite Test" in the "Patient List Search" field
        And I click the "Search Patient List" button
        And I set the Base Condition to Favorite the "VerveDel Favorite Test" list for "PATIENTLISTV2" "user"
      And I click the "Favorite" button in the row with "VerveDel Favorite Test" as the value under "NAME (\d)" in the "Patient List Search Results" table
#        And I favorite the list by clicking the "Favorited In Edit Screen" button in the "Edit Favorite" pane
        And I enter "VerveDel Favorite For Myself And No Other User" in the "Alias" field
        And I check the "Me" checkbox
        And I uncheck the "Other Users" checkbox
        And I wait up to "10" seconds for the "Edit Favorite Save" field of type "BUTTON" to be visible
        And I click the "Edit Favorite Save" button
        And I click the "Close Search For Patient List" button
        And I click the "Refresh Patient List" button
        Then the "Patient List" menu should have the following options
            |VerveDel Favorite For Myself And No Other User|
        When I am logged into the portal with user "PLV2LVL3" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        Then the "Patient List" menu should not have the following options
            |VerveDel Favorite For Myself And No Other User|

  Scenario: Favorite patient list for Myself(PLV2ADMIN) and other user(PLV2LVL3)
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Favorite Test" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "5" seconds
    And I set the Base Condition to Favorite the "VerveDel Favorite Test" list for "PLV2LVL3" "user"
    And I click the "Favorite" button in the row with "VerveDel Favorite Test" as the value under "NAME (\d)" in the "Patient List Search Results" table
#        And I favorite the list by clicking the "Favorite In Edit Screen" button in the "Edit Favorite" pane
    And I enter "VerveDel Fave patient list for Myself, other" in the "Alias" field
    And I check the "Me" checkbox
    And I check the "Other Users" checkbox
    And I enter "PATIENTLISTV2" in the "Users" field
    And I select "PLV2LVL3" from the "Username" column in the "Users Search" table
    And I wait up to "10" seconds for the "Edit Favorite Save" field of type "BUTTON" to be visible
    And I click the "Edit Favorite Save" button
    And I click the "Close Search For Patient List" button
    And I click the "Refresh Patient List" button
        Then the "Patient List" menu should have the following options
            |VerveDel Fave patient list for Myself, other|
        When I am logged into the portal with user "PLV2LVL3" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        Then the "Patient List" menu should have the following options
            |VerveDel Fave patient list for Myself, other|

  Scenario: UnFavorite patient list for Myself(PLV2ADMIN), favorite for other user(PLV2LVL3)
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Favorite Test" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "5" seconds
    And I set the Base Condition to Favorite the "VerveDel Favorite Test" list for "PLV2LVL3" "user"
    And I click the "Favorite" button in the row with "VerveDel Favorite Test" as the value under "NAME (\d)" in the "Patient List Search Results" table
    And I unfavorite the list by clicking the "Favorited In Edit Screen" button in the "Edit Favorite" pane
    And I check the "Me" checkbox
    And I uncheck the "Other Users" checkbox
    And I click the "Edit Favorite Save" button
    And I click the "Favorite" button in the row with "VerveDel Favorite Test" as the value under "NAME (\d)" in the "Patient List Search Results" table
    And I enter "VerveDel UnFave for Myself, fave for other" in the "Alias" field
    And I uncheck the "Me" checkbox
    And I check the "Other Users" checkbox
#        And I favorite the list by clicking the "Favorite In Edit Screen" button in the "Edit Favorite" pane
    And I enter "PATIENTLISTV2" in the "Users" field
    And I select "PLV2LVL3" from the "Username" column in the "Users Search" table
    And I wait up to "10" seconds for the "Edit Favorite Save" field of type "BUTTON" to be visible
    And I click the "Edit Favorite Save" button
    And I click the "Close Search For Patient List" button
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should not have the following options
            |VerveDel UnFave for Myself, fave for other|
        When I am logged into the portal with user "PLV2LVL3" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        Then the "Patient List" menu should have the following options
            |VerveDel UnFave for Myself, fave for other|

  Scenario: UnFavorite patient list for Myself(PLV2ADMIN) and other user(PLV2LVL3)
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Favorite Test" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I click the "Favorite" button in the row with "VerveDel Favorite Test" as the value under "NAME (\d)" in the "Patient List Search Results" table
#        And I favorite the list by clicking the "Favorite In Edit Screen" button in the "Edit Favorite" pane
    And I enter "VerveDel UnFavorite patient list Myself and other" in the "Alias" field
    And I check the "Me" checkbox
    And I check the "Other Users" checkbox
    And I enter "PATIENTLISTV2" in the "Users" field
    And I select "PLV2LVL3" from the "Username" column in the "Users Search" table
    And I wait up to "10" seconds for the "Edit Favorite Save" field of type "BUTTON" to be visible
    And I click the "Edit Favorite Save" button
    And I click the "Close Search For Patient List" button
    When I am logged into the portal with user "PLV2LVL3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel UnFavorite patient list Myself and other |
    When I am logged into the portal with user "PLV2ADMIN" using the default password
    And I am on the "Patient List V2" tab
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Favorite Test" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I click the "Favorited" button in the row with "VerveDel Favorite Test" as the value under "NAME (\d)" in the "Patient List Search Results" table
    And I check the "Me" checkbox
    And I check the "Other Users" checkbox
    And I unfavorite the list by clicking the "Favorite In Edit Screen" button in the "Edit Favorite" pane
    And I enter "PATIENTLISTV2" in the "Users" field
    And I select "PLV2LVL3" from the "Username" column in the "Users Search" table
    And I wait up to "10" seconds for the "Edit Favorite Save" field of type "BUTTON" to be visible
    And I click the "Edit Favorite Save" button
    And I click the "Close Search For Patient List" button
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should not have the following options
      | VerveDel UnFavorite patient list Myself and other |
        When I am logged into the portal with user "PLV2LVL3" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        Then the "Patient List" menu should not have the following options
            |VerveDel UnFavorite patient list Myself and other|

  Scenario: Favorite patient list for multiple level 3 users
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Favorite Test" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I wait "5" seconds
    And I set the Base Condition to Favorite the "VerveDel Favorite Test" list for "PLV2LVL3" "user"
    And I click the "Favorite" button in the row with "VerveDel Favorite Test" as the value under "NAME (\d)" in the "Patient List Search Results" table
    And I wait "3" seconds
#        And I favorite the list by clicking the "Favorite In Edit Screen" button in the "Edit Favorite" pane
    And I enter "VerveDel Favorite for multiple level 3 users" in the "Alias" field
    And I uncheck the "Me" checkbox
    And I check the "Other Users" checkbox
    And I enter "PATIENTLISTV2" in the "Users" field
    And I select "PLV2LVL2" from the "Username" column in the "Users Search" table
    And I enter "PATIENTLISTV2" in the "Users" field
    And I select "PLV2LVL3" from the "Username" column in the "Users Search" table
       #And I select "PATIENTLISTV2THE3RD" from the "Last Name" column in the "Users Search" table
    And I enter "PATIENTLISTV2THE2ND" in the "Users" field
        And I enter "PATIENTLISTV2THE3RD" in the "Users" field
        And I wait up to "10" seconds for the "Edit Favorite Save" field of type "BUTTON" to be visible
        And I click the "Edit Favorite Save" button
        And I click the "Close Search For Patient List" button
        When I am logged into the portal with user "PLV2LVL3" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        Then the "Patient List" menu should have the following options
            |VerveDel Favorite for multiple level 3 users|
        When I am logged into the portal with user "PLV2the2nd" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        Then the "Patient List" menu should have the following options
            |VerveDel Favorite for multiple level 3 users|
        When I am logged into the portal with user "PLV2the3rd" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        Then the "Patient List" menu should have the following options
            |VerveDel Favorite for multiple level 3 users|

  Scenario: Unfavorite patient list for multiple level 3 users
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Favorite Test" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I click the "Favorite" button in the row with "VerveDel Favorite Test" as the value under "NAME (\d)" in the "Patient List Search Results" table
    And I unfavorite the list by clicking the "Favorited In Edit Screen" button in the "Edit Favorite" pane
    Then the "Alias" pane should close
    And I uncheck the "Me" checkbox
    And I check the "Other Users" checkbox
    And I enter "PATIENTLISTV2" in the "Users" field
    And I select "PLV2LVL3" from the "Username" column in the "Users Search" table
    And I enter "PATIENTLISTV2THE2ND" in the "Users" field
     #It is now auto-selecting upon full user/facility/dept search for all below commented steps
     #And I select "PATIENTLISTV2THE2ND" from the "Last Name" column in the "Users Search" table
    And I enter "PATIENTLISTV2THE3RD" in the "Users" field
     #And I select "PATIENTLISTV2THE3RD" from the "Last Name" column in the "Users Search" table
        And I wait up to "10" seconds for the "Edit Favorite Save" field of type "BUTTON" to be visible
        And I click the "Edit Favorite Save" button
        And I click the "Close Search For Patient List" button
        When I am logged into the portal with user "PLV2LVL3" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        Then the "Patient List" menu should not have the following options
            |VerveDel Favorite for multiple level 3 users|
        When I am logged into the portal with user "PLV2the2nd" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        Then the "Patient List" menu should not have the following options
            |VerveDel Favorite for multiple level 3 users|
        When I am logged into the portal with user "PLV2the3rd" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        Then the "Patient List" menu should not have the following options
            |VerveDel Favorite for multiple level 3 users|

    Scenario: Favorite patient list for list owner.  Verify alias prompt does not occur.
        Given I am logged into the portal with user "PLV2LVL3" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        When I select "Create a Patient List" from the "Actions" menu
        And I click the "System Default List" button in the "Choose Template" pane if it exists
        And I click the "OK Template" button in the "Choose Template" pane if it exists
        And I enter "VerveDel Favorite For Owner Test" in the "Name" field
        And I enter "Description" in the "Description" field
        And I unfavorite the list by clicking the "Favorite" button in the "CreatePatientLists" pane
        And I select the "Filters" section
        And I click the "Add A Filter" button
        Then the "Filter Criteria" pane should load
        When I select "Medical Service" from the "Filter On" dropdown
      Then the "Medical Service" pane should load
      When I enter "PLM2Test-TBC" in the "Filter Search" field
      Then I check the "PLM2Test-TBC" checkbox
      And I click the "Add Filter" button
      And I select the "Permissions" section
      And I select "All users" from the "View" dropdown
      And I click the "Create Patient List Create My List" button
      When I select "Find a Patient List" from the "Actions" menu
      And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
      And I enter "VerveDel Favorite For Owner Test" in the "Patient List Search" field
      And I click the "Search Patient List" button
      And I click the "Favorite" button in the row with "VerveDel Favorite For Owner Test" as the value under "NAME (\d)" in the "Patient List Search Results" table
      And I click the "Close Search For Patient List" button
      And I click the "Refresh Patient List" button
      Then the "Patient List" menu should have the following options
        | VerveDel Favorite For Owner Test |

    Scenario: Unfavorite some sub-lists
        When I select "Create a Patient List" from the "Actions" menu
        And I click the "System Default List" button in the "Choose Template" pane if it exists
        And I click the "OK Template" button in the "Choose Template" pane if it exists
        And I enter "VerveDel MasterFavoriteList" in the "Name" field
        And I enter "Assignment List Description" in the "Description" field
      And I select "ASSIGNMENT" from the "Type" radio list
      Then the "Assignment Sub List" pane should load
      And I add the following Assignment Sub List
        | VerveDel FavAlpha |
        | VerveDel FavBeta  |
        | VerveDel FavGamma |
      And I select the "Filters" section
      And I click the "Add A Filter" button
      Then the "Filter Criteria" pane should load
      When I select "Medical Service" from the "Filter On" dropdown
      Then the "Medical Service" pane should load
      When I enter "PLM2Test-TBC" in the "Filter Search" field
      Then I check the "PLM2Test-TBC" checkbox
      And I click the "Add Filter" button
      And I click the "Create Patient List Create My List" button
      And I click the "Refresh Patient List" button
      When I select "Find a Patient List" from the "Actions" menu
      And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
      And I enter "VerveDel FavAlpha" in the "Patient List Search" field
      And I click the "Search Patient List" button
      And I click the "Favorited" button in the row with "VerveDel FavAlpha" as the value under "NAME (\d)" in the "Patient List Search Results" table
#        And I unfavorite the list by clicking the "Favorite In Edit Screen" button in the "Edit Favorite" pane
      And I check the "Me" checkbox
      And I wait up to "10" seconds for the "Edit Favorite Save" field of type "BUTTON" to be visible
      And I click the "Edit Favorite Save" button
      And I click the "Close Search For Patient List" button if it exists
      When I select "Find a Patient List" from the "Actions" menu
      And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
      And I enter "VerveDel FavGamma" in the "Patient List Search" field
      And I click the "Search Patient List" button
      And I click the "Favorited" button in the row with "VerveDel FavGamma" as the value under "NAME (\d)" in the "Patient List Search Results" table
#        And I unfavorite the list by clicking the "Favorite In Edit Screen" button in the "Edit Favorite" pane
      And I check the "Me" checkbox
      And I wait up to "10" seconds for the "Edit Favorite Save" field of type "BUTTON" to be visible
      And I click the "Edit Favorite Save" button
      And I click the "Close Search For Patient List" button
      And I refresh the patient list
      Then the "Patient List" menu should have the following options
        | VerveDel MasterFavoriteList |
        | VerveDel FavBeta            |
      Then the "Patient List" menu should not have the following options
        | VerveDel FavAlpha |
        | VerveDel FavGamma |

    Scenario: Favorite for others available to level 1 user
        Given I am logged into the portal with user "PLV2LVL1" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        When I select "Find a Patient List" from the "Actions" menu
        And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
        And I enter "VerveDel Favorite Test" in the "Patient List Search" field
        And I click the "Search Patient List" button
#        And I set the Base Condition to Favorite the "VerveDel Favorite Test" list for "PATIENTLISTV2THE2ND" "user"
      And I click the "Favorite" button in the row with "VerveDel Favorite Test" as the value under "NAME (\d)" in the "Patient List Search Results" table
#        And I favorite the list by clicking the "Favorite In Edit Screen" button in the "Edit Favorite" pane
        Then I enter "VerveDel Fave for others available to lvl 1" in the "Alias" field in the "Alias" pane
        And I uncheck the "Me" checkbox
        And I check the "Other Users" checkbox
        And I enter "PATIENTLISTV2THE2ND" in the "Users" field
        And I wait up to "10" seconds for the "Edit Favorite Save" field of type "BUTTON" to be visible
        And I click the "Edit Favorite Save" button
        And I click the "Close Search For Patient List" button
        When I am logged into the portal with user "PLV2the2nd" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        Then the "Patient List" menu should have the following options
            |VerveDel Fave for others available to lvl 1|

  Scenario: Favorite for others available to level 2 user
    Given I am logged into the portal with user "PLV2LVL2" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Favorite Test" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I set the Base Condition to Favorite the "VerveDel Favorite Test" list for "PATIENTLISTV2THE3RD" "user"
    And I click the "Favorite" button in the row with "VerveDel Favorite Test" as the value under "NAME (\d)" in the "Patient List Search Results" table
#        And I favorite the list by clicking the "Favorite In Edit Screen" button in the "Edit Favorite" pane
    Then I enter "VerveDel Fave for others available to lvl 2" in the "Alias" field in the "Alias" pane
     #Then the text "VerveDel Favorite Test (PATIENTLISTV2ADMIN, V)" should appear in the "Alias" pane
    And I uncheck the "Me" checkbox
    And I check the "Other Users" checkbox
    And I enter "PATIENTLISTV2THE3RD" in the "Users" field
    And I wait up to "10" seconds for the "Edit Favorite Save" field of type "BUTTON" to be visible
    And I click the "Edit Favorite Save" button
    And I click the "Close Search For Patient List" button
    When I am logged into the portal with user "PLV2the3rd" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        Then the "Patient List" menu should have the following options
            |VerveDel Fave for others available to lvl 2|

  Scenario: Favorite for others not available to level 3 user
    Given I am logged into the portal with user "PLV2LVL3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "VerveDel Favorite Test" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I click the "Favorite" button in the row with "VerveDel Favorite Test" as the value under "NAME (\d)" in the "Patient List Search Results" table
    Then the "Other Users" "checkbox" should not be visible
    And I click the "Edit Favorite Cancel" button
    And I click the "Close Search For Patient List" button

 # new enhancement for 811
    Scenario: Favorite patient list for Myself(PLV2ADMIN) and other Department(VervePLV2DeptFavorites) (DEV-43385)
        When I select "Find a Patient List" from the "Actions" menu
        And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
        And I enter "Favorite Test - Department" in the "Patient List Search" field
        And I click the "Search Patient List" button
        And I set the Base Condition to Favorite the "Favorite Test - Department" list for "PLV2ADMIN" "user"
#        And I set the Base Condition to Favorite the "Favorite Test - Department" list for "VervePLV2DeptFavorites" "department"
      And I click the "Favorite" button in the row with "Favorite Test - Department" as the value under "NAME (\d)" in the "Patient List Search Results" table
#        And I favorite the list by clicking the "Favorite In Edit Screen" button in the "Edit Favorite" pane
        And I enter "VerveDel Fave for Myself and Department" in the "Alias" field in the "Alias" pane
        And I check the "Me" checkbox
        And I check the "Other Users" checkbox
      #this following step auto-selects the facility/department
        And I enter "VervePLV2DeptFavorites" in the "Users" field
        And I wait up to "10" seconds for the "Edit Favorite Save" field of type "BUTTON" to be visible
        And I click the "Edit Favorite Save" button
        And I click the "Close Search For Patient List" button
        And I click the "Refresh Patient List" button
        Then the "Patient List" menu should have the following options
            |VerveDel Fave for Myself and Department|
     #level 3 user in VervePLV2DeptFavorites department
        When I am logged into the portal with user "Verve3DeptFave" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        Then the "Patient List" menu should have the following options
            |VerveDel Fave for Myself and Department|
      #level 2 user in VervePLV2DeptFavorites department
        When I am logged into the portal with user "Verve2DeptFave" using the default password
        And I am on the "Patient List V2" tab
      And the patient list is maximized
      Then the "Patient List" menu should have the following options
        | VerveDel Fave for Myself and Department |
      #level 1 user in VervePLV2DeptFavorites department
      When I am logged into the portal with user "Verve1DeptFave" using the default password
      And I am on the "Patient List V2" tab
      And the patient list is maximized
      Then the "Patient List" menu should have the following options
        | VerveDel Fave for Myself and Department |

  Scenario: Unfavorite patient list for Department(VervePLV2DeptFavorites) (DEV-43385)
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "Favorite Test - Department" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I click the "Favorited" button in the row with "Favorite Test - Department" as the value under "NAME (\d)" in the "Patient List Search Results" table
    And I unfavorite the list by clicking the "Favorite In Edit Screen" button in the "Edit Favorite" pane
    And I uncheck the "Me" checkbox
    And I check the "Other Users" checkbox
    And I enter "VervePLV2DeptFavorites" in the "Users" field
    And I wait up to "10" seconds for the "Edit Favorite Save" field of type "BUTTON" to be visible
    And I click the "Edit Favorite Save" button
    And I click the "Close Search For Patient List" button
      #level 3 user in VervePLV2DeptFavorites department
    When I am logged into the portal with user "Verve3DeptFave" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Fave for Myself and Department |
       #level 2 user in VervePLV2DeptFavorites department
    When I am logged into the portal with user "Verve2DeptFave" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Fave for Myself and Department |
       #level 1 user in VervePLV2DeptFavorites department
    When I am logged into the portal with user "Verve1DeptFave" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        Then the "Patient List" menu should not have the following options
            |VerveDel Fave for Myself and Department|

  # new enhancement for 811
  Scenario: Favorite patient list for Myself(PLV2ADMIN) and other Facility(PKHospital-Central) (DEV-43385)
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "Favorite Test - Department" in the "Patient List Search" field
    And I click the "Search Patient List" button
#        And I set the Base Condition to Favorite the "Favorite Test - Department" list for "PKHospital-Central" "facility"
    And I click the "Favorited" button in the row with "Favorite Test - Department" as the value under "NAME (\d)" in the "Patient List Search Results" table
#        And I favorite the list by clicking the "Favorite In Edit Screen" button in the "Edit Favorite" pane
    And I click the "Favorite In Edit Screen" button in the "Edit Favorite" pane
    And I enter "VerveDel Fave for Myself and Facility" in the "Alias" field in the "Alias" pane
    And I check the "Me" checkbox
    And I check the "Other Users" checkbox
      #this following step auto-selects the facility/department
    And I enter "PKHospital-Central" in the "Users" field
    And I wait up to "10" seconds for the "Edit Favorite Save" field of type "BUTTON" to be visible
    And I click the "Edit Favorite Save" button
    And I click the "Close Search For Patient List" button
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should have the following options
      | VerveDel Fave for Myself and Facility |
      #level 3 user in PKHospital-Central facility
        When I am logged into the portal with user "Verve3DeptFave" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        Then the "Patient List" menu should have the following options
            |VerveDel Fave for Myself and Facility|
       #level 2 user in PKHospital-Central facility
        When I am logged into the portal with user "Verve2DeptFave" using the default password
        And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Fave for Myself and Facility |
       #level 1 user in PKHospital-Central facility
    When I am logged into the portal with user "Verve1DeptFave" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should have the following options
      | VerveDel Fave for Myself and Facility |

  Scenario: Unfavorite patient list for Facility(PKHospital-Central) (DEV-43385)
    When I select "Find a Patient List" from the "Actions" menu
    And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
    And I enter "Favorite Test - Department" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I click the "Favorited" button in the row with "Favorite Test - Department" as the value under "NAME (\d)" in the "Patient List Search Results" table
    And I unfavorite the list by clicking the "Favorite In Edit Screen" button in the "Edit Favorite" pane
    And I uncheck the "Me" checkbox
    And I check the "Other Users" checkbox
    And I enter "PKHospital-Central" in the "Users" field
    And I wait up to "10" seconds for the "Edit Favorite Save" field of type "BUTTON" to be visible
    And I click the "Edit Favorite Save" button
    And I click the "Close Search For Patient List" button
      #level 3 user in VervePLV2DeptFavorites department
    When I am logged into the portal with user "Verve3DeptFave" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Fave for Myself and Facility |
       #level 2 user in VervePLV2DeptFavorites department
    When I am logged into the portal with user "Verve2DeptFave" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    Then the "Patient List" menu should not have the following options
      | VerveDel Fave for Myself and Facility |
       #level 1 user in VervePLV2DeptFavorites department
    When I am logged into the portal with user "Verve1DeptFave" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        Then the "Patient List" menu should not have the following options
            |VerveDel Fave for Myself and Facility|