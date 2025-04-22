@CPOEMicro
Feature: CPOE Microbiology Validation.  New in 8.4.0.

  Background:
    Given I am logged into the portal with user "pkadminv2" using the default password

  Scenario: 5 - PK Admin Add Order String
    Given I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I select "DefaultFacilityGroup" from the "Facility Group" dropdown
    And the "CPOE Preferences" pane should load
    And I click the "Order Definitions" link in the "Facility Group Navigation" pane
    And I enter "Test Micro Lab" in the "Order Name" field in the "CPOE Order Definition Maintenance" pane
    And I click the "Search" button in the "CPOE Order Definition Maintenance" pane
    And I select "Test Micro Lab" in the "CPOE Order Def Search Results" table
    And I click the "Edit" button in the "CPOE Order Definition Detail" pane
    And I wait "2" seconds
    And I click the "View Edit Order String" button in the "Edit CPOE Order Definition" pane
    And I wait "2" seconds
    And I click the "Add Order String" link in the "Order String Maintenance" pane
    And I wait "4" seconds
    And I select "Back" from the "Source Field" dropdown
    And I select "Upper" from the "Source Description" dropdown
    And I click the "OK" button in the "Edit Order String" pane
    Then the following text should appear in the "Order String Maintenance" pane
      | Test Micro Lab today Back; Upper |
    And I click the "Cancel" button in the "Order String Maintenance" pane
    And I click the "Cancel" button in the "Edit CPOEOrder Definition" pane

  Scenario: 5A - PK Admin Add Order String Source
    Given I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I select "DefaultFacilityGroup" from the "Facility Group" dropdown
    And the "CPOE Preferences" pane should load
    And I click the "Order Definitions" link in the "Facility Group Navigation" pane
    And I enter "Test Micro Lab" in the "Order Name" field in the "CPOE Order Definition Maintenance" pane
    And I click the "Search" button in the "CPOE Order Definition Maintenance" pane
    And I select "Test Micro Lab" in the "CPOE Order Def Search Results" table
    And I click the "Edit" button in the "CPOE Order Definition Detail" pane
    And I wait "2" seconds
    And I click the "View Edit Order String" button in the "Edit CPOE Order Definition" pane
    And I wait "2" seconds
    And I click the "Add Order String" link in the "Order String Maintenance" pane
    And I wait "2" seconds
    And I select "Back" from the "Source Field" dropdown
    And I click the "OK" button in the "Edit Order String" pane
    Then the following text should appear in the "Order String Maintenance" pane
      | Test Micro Lab today Back |
    And I click the "Cancel" button in the "Order String Maintenance" pane
    And I click the "Cancel" button in the "Edit CPOEOrder Definition" pane

  Scenario: 6 - PK Admin Edit Order String Source
    Given I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I select "DefaultFacilityGroup" from the "Facility Group" dropdown
    And the "CPOE Preferences" pane should load
    And I click the "Order Definitions" link in the "Facility Group Navigation" pane
    And I enter "Test Micro Lab" in the "Order Name" field in the "CPOE Order Definition Maintenance" pane
    And I click the "Search" button in the "CPOE Order Definition Maintenance" pane
    And I select "Test Micro Lab" in the "CPOE Order Def Search Results" table
    And I click the "Edit" button in the "CPOE Order Definition Detail" pane
    And I wait "2" seconds
    And I click the "View Edit Order String" button in the "Edit CPOE Order Definition" pane
    And I wait "2" seconds
    And I click the "Test Micro Lab today" link in the "Order String Maintenance" pane
    And I wait "2" seconds
    And I select "Back" from the "Source Field" dropdown
    And I click the "OK" button in the "Edit Order String" pane
    Then the following text should appear in the "Order String Maintenance" pane
      | Test Micro Lab today Back |
    And I click the "Cancel" button in the "Order String Maintenance" pane
    And I click the "Cancel" button in the "Edit CPOEOrder Definition" pane

  Scenario: 7 - PK Admin Edit Order String Description
    Given I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I select "DefaultFacilityGroup" from the "Facility Group" dropdown
    And the "CPOE Preferences" pane should load
    And I click the "Order Definitions" link in the "Facility Group Navigation" pane
    And I enter "Test Micro Lab" in the "Order Name" field in the "CPOE Order Definition Maintenance" pane
    And I click the "Search" button in the "CPOE Order Definition Maintenance" pane
    And I select "Test Micro Lab" in the "CPOE Order Def Search Results" table
    And I click the "Edit" button in the "CPOE Order Definition Detail" pane
    And I wait "2" seconds
    And I click the "View Edit Order String" button in the "Edit CPOE Order Definition" pane
    And I wait "2" seconds
    And I click the "Test Micro Lab today" link in the "Order String Maintenance" pane
    And I wait "2" seconds
    And I select "Back" from the "Source Field" dropdown
    And I select "Upper" from the "Source Description" dropdown
    And I click the "OK" button in the "Edit Order String" pane
    Then the following text should appear in the "Order String Maintenance" pane
      | Test Micro Lab today Back; Upper |
    And I click the "Cancel" button in the "Order String Maintenance" pane
    And I click the "Cancel" button in the "Edit CPOEOrder Definition" pane

  Scenario: 8 - PK Admin Preferences Add Favorite
    Given I am on the "Admin" tab
    And I select the "Preferences" subtab
    And I select "CPOE" from the "Edit Preferences Settings" dropdown
    And I wait "1" seconds
    When I click the "Favorites" edit link in the "Preferences CPOE Settings" pane
    And I wait "3" seconds
    And I click the "My Pickers" edit category link in the "CPOE Favorites" pane
    Then the "Edit My Pickers" pane should load within "5" seconds
    And I enter "Test Micro Lab" in the "CPOE Picker Search" field in the "Edit My Pickers" pane
    And I select "Test Micro Lab" from the "CPOE All Orders" list in the search results
    And I wait "5" seconds
    And I select "Hand" from the "Source Field" dropdown in the "Add Favorite" pane
    And I select "Left" from the "Source Description" dropdown in the "Add Favorite" pane
    And I click the "Add Favorite OK" button
    Then the following text should appear in the "Edit My Pickers" pane
      | Test Micro Lab today Hand; Left |
    And I click the "Save" button in the "Edit My Pickers" pane
    Then the following text should appear in the "CPOE Favorites" pane
      | Test Micro Lab today Hand; Left |
    And I click the "Close" button in the "CPOE Favorites" pane

  Scenario: 8A - PK Admin Preferences Add Order String Source
    Given I am on the "Admin" tab
    And I select the "Preferences" subtab
    And I select "CPOE" from the "Edit Preferences Settings" dropdown
    And I wait "1" seconds
    When I click the "Favorites" edit link in the "Preferences CPOE Settings" pane
    And I wait "5" seconds
    And I click the "My Pickers" edit category link in the "CPOE Favorites" pane
    Then the "Edit My Pickers" pane should load within "5" seconds
    And I enter "Test Micro Lab" in the "CPOE Picker Search" field in the "Edit My Pickers" pane
    And I select "Test Micro Lab" from the "CPOE All Orders" list in the search results
    And I wait "5" seconds
    And I select "Back" from the "Source Field" dropdown in the "Add Favorite" pane
    And I click the "Add Favorite OK" button
    Then the following text should appear in the "Edit My Pickers" pane
      | Test Micro Lab today Back |
    And I click the "Save" button in the "Edit My Pickers" pane
    Then the following text should appear in the "CPOE Favorites" pane
      | Test Micro Lab today Back |
    And I click the "Close" button in the "CPOE Favorites" pane

  Scenario: 9 - PK Admin Preferences Edit Favorite Source
    Given I am on the "Admin" tab
    And I select the "Preferences" subtab
    And I select "CPOE" from the "Edit Preferences Settings" dropdown
    And I wait "1" seconds
    When I click the "Favorites" edit link in the "Preferences CPOE Settings" pane
    And I wait "5" seconds
    And I click the "My Pickers" edit category link in the "CPOE Favorites" pane
    Then the "Edit My Pickers" pane should load within "5" seconds
    And I click the "Test Micro Lab today Hand; Left" link in the "Edit My Pickers" pane
    Then the "Edit Favorite" pane should load within "5" seconds
    And I select "Finger" from the "Source Field" dropdown in the "Edit Favorite" pane
    And I select "Left Thumb" from the "Source Description" dropdown in the "Edit Favorite" pane
    And I click the "Edit Favorite OK" button
    Then the following text should appear in the "Edit My Pickers" pane
      | Test Micro Lab today Finger; Left Thumb |
    And I click the "Save" button in the "Edit My Pickers" pane
    Then the following text should appear in the "CPOE Favorites" pane
      | Test Micro Lab  today Finger; Left Thumb |
    And I click the "Close" button in the "CPOE Favorites" pane

  Scenario: 10 - PK Admin Preferences Edit Favorite Description
    Given I am on the "Admin" tab
    And I select the "Preferences" subtab
    And I select "CPOE" from the "Edit Preferences Settings" dropdown
    And I wait "1" seconds
    When I click the "Favorites" edit link in the "Preferences CPOE Settings" pane
    And I click the "My Pickers" edit category link in the "CPOE Favorites" pane
    Then the "Edit My Pickers" pane should load within "5" seconds
    And I click the "Test Micro Lab today Finger; Left Thumb" link in the "Edit My Pickers" pane
    Then the "Edit Favorite" pane should load within "5" seconds
    And I select "Left Thumb" from the "Source Description" dropdown in the "Edit Favorite" pane
    And I click the "Edit Favorite OK" button
    Then the following text should appear in the "Edit My Pickers" pane
      | Test Micro Lab today Finger; Left Thumb |
    And I click the "Save" button in the "Edit My Pickers" pane
    Then the following text should appear in the "CPOE Favorites" pane
      | Test Micro Lab today Finger; Left Thumb |
    And I click the "Close" button in the "CPOE Favorites" pane

  Scenario: 11 - PK Admin User Add Favorite
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "pkadminv2"
    And I select the user "pkadminv2"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "CPOE" from the "Edit User Settings" dropdown
    When I click the "Favorites" edit link in the "User CPOE Settings" pane
    And I click the "My Pickers" edit category link in the "CPOE Favorites" pane
    Then the "Edit My Pickers" pane should load within "5" seconds
    And I enter "Test Micro Lab" in the "CPOE Picker Search" field in the "Edit My Pickers" pane
    And I select "Test Micro Lab" from the "CPOE All Orders" list in the search results
    And I wait "5" seconds
    And I select "Finger" from the "Source Field" dropdown in the "Add Favorite" pane
    And I wait "5" seconds
    And I select "Left Thumb" from the "Source Description" dropdown in the "Add Favorite" pane
    And I click the "Add Favorite OK" button
    Then the following text should appear in the "Edit My Pickers" pane
      | Test Micro Lab today Finger; Left Thumb |
    And I click the "Save" button in the "Edit My Pickers" pane
    Then the following text should appear in the "CPOE Favorites" pane
      | Test Micro Lab today Finger; Left Thumb |
    And I click the "Close" button in the "CPOE Favorites" pane

  Scenario: 11A - PK Admin User Add Favorite Order Source Only
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "pkadminv2"
    And I select the user "pkadminv2"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "CPOE" from the "Edit User Settings" dropdown
    When I click the "Favorites" edit link in the "User CPOE Settings" pane
    And I click the "My Pickers" edit category link in the "CPOE Favorites" pane
    Then the "Edit My Pickers" pane should load within "5" seconds
    And I enter "Test Micro Lab" in the "CPOE Picker Search" field in the "Edit My Pickers" pane
    And I select "Test Micro Lab" from the "CPOE All Orders" list in the search results
    And I wait "1" seconds
    And I select "Hand" from the "Source Field" dropdown in the "Add Favorite" pane
    And I click the "Add Favorite OK" button
    Then the following text should appear in the "Edit My Pickers" pane
      | Test Micro Lab today Hand |
    And I click the "Save" button in the "Edit My Pickers" pane
    Then the following text should appear in the "CPOE Favorites" pane
      | Test Micro Lab today Hand |
    And I click the "Close" button in the "CPOE Favorites" pane

  Scenario: 12 - PK Admin User Edit Favorite Source
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "pkadminv2"
    And I select the user "pkadminv2"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "CPOE" from the "Edit User Settings" dropdown
    When I click the "Favorites" edit link in the "User CPOE Settings" pane
    And I click the "My Pickers" edit category link in the "CPOE Favorites" pane
    Then the "Edit My Pickers" pane should load within "5" seconds
    And I click the "Test Micro Lab today Hand" link in the "Edit My Pickers" pane
    Then the "Edit Favorite" pane should load within "5" seconds
    And I select "Finger" from the "Source Field" dropdown in the "Edit Favorite" pane
    And I click the "Edit Favorite OK" button
    Then the following text should appear in the "Edit My Pickers" pane
      | Test Micro Lab today Finger |
    And I click the "Save" button in the "Edit My Pickers" pane
    Then the following text should appear in the "CPOE Favorites" pane
      | Test Micro Lab today Finger |
    And I click the "Close" button in the "CPOE Favorites" pane

#//Functionality has changed[DEV-84220]
#  Scenario: 13 - PK Admin User Edit Favorite Description
#    And I am on the "Admin" tab
#    And I select the "User" subtab
#    And I search for the user "pkadminv2"
#    And I select the user "pkadminv2"
#    And I click the "Edit" button in the "Quick Details" pane
#    And I select "CPOE" from the "Edit User Settings" dropdown
#    When I click the "Favorites" edit link in the "User CPOE Settings" pane
#    And I click the "My Pickers" edit category link in the "CPOE Favorites" pane
#    Then the "Edit My Pickers" pane should load within "5" seconds
#    And I click the "Test Micro Lab today Finger" link in the "Edit My Pickers" pane
#    Then the "Edit Favorite" pane should load within "5" seconds
#    And I select "Left Ring" from the "Source Description" dropdown in the "Edit Favorite" pane
#    And I click the "Edit Favorite OK" button
#    Then the following text should appear in the "Edit My Pickers" pane
#      | Test Micro Lab today Finger; Left Ring |
#    And I click the "Save" button in the "Edit My Pickers" pane
#    Then the following text should appear in the "CPOE Favorites" pane
#      | Test Micro Lab today Finger; Left Ring |
#    And I click the "Close" button in the "CPOE Favorites" pane

  Scenario: 14 - PK Admin OSB Add Order Source
    Given I am on the "Admin" tab
    When I select the "Facility Group" subtab
    And I select "DefaultFacilityGroup" from the "Facility Group" dropdown
    And the "CPOE Preferences" pane should load
    And I click the "Order Sets" link in the "Facility Group Navigation" pane
    And I click the "Add Order Set" button
    And I wait "4" seconds
    And I enter "VerveDel Micro Order Set Back" in the "Edit Order Set Name" field
    And I enter "1" in the "Edit Order Set Version" field
    And I check the "Edit Order Set Active" checkbox
    And I click the "Content" element
    And I drag the "Order Component" to section field in Edit order set pane
    And I wait "3" seconds
    And I enter "Test Micro Lab" in the "Order Search" field
    And I select "Test Micro Lab" in the "CPOE Order Table" table
    And I wait "3" seconds
    And I select "Back" from the "Source Field" dropdown in the "CPOE Order Prototype Contents" pane
    And I click the "OK CPOE Order Prototype" button
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    And I enter "VerveDel Micro Order Set Back" in the "Order Set Name" field
    And I click the "Search CPOE Order Set Maintenance" button
    Then the "CPOE Order Set" table should have at least "1" row containing the text "VerveDel Micro Order Set Back"

  Scenario: 14b - PK Admin OSB Add Order Source and Description
    Given I am on the "Admin" tab
    When I select the "Facility Group" subtab
    And I select "DefaultFacilityGroup" from the "Facility Group" dropdown
    And the "CPOE Preferences" pane should load
    And I click the "Order Sets" link in the "Facility Group Navigation" pane
    And I click the "Add Order Set" button
    And I wait "4" seconds
    And I enter "VerveDel Micro Order Set Back and Upper" in the "Edit Order Set Name" field
    And I enter "1" in the "Edit Order Set Version" field
    And I check the "Edit Order Set Active" checkbox
    And I click the "Content" element
    And I drag the "Order Component" to section field in Edit order set pane
    And I wait "3" seconds
    And I enter "Test Micro Lab" in the "Order Search" field
    And I select "Test Micro Lab" in the "CPOE Order Table" table
    And I select "Back" from the "Source Field" dropdown in the "CPOE Order Prototype Contents" pane
    And I select "Upper" from the "Source Description" dropdown in the "CPOE Order Prototype Contents" pane
    And I click the "OK CPOE Order Prototype" button
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    And I enter "VerveDel Micro Order Set Back and Upper" in the "Order Set Name" field
    And I click the "Search CPOE Order Set Maintenance" button
    Then the "CPOE Order Set" table should have at least "1" row containing the text "VerveDel Micro Order Set Back and Upper"
    #Order Set validated in companion scenario: Scenario: 36 - PK Order Source and Description from Order Set


# Functionality changed[DEV84220]
#  Scenario: 15 - PK Admin OSB Edit Order Source
#    Given I am on the "Admin" tab
#    When I select the "Facility Group" subtab
#    And I select "DefaultFacilityGroup" from the "Facility Group" dropdown
#    And the "CPOE Preferences" pane should load
#    And I click the "Order Sets" link in the "Facility Group Navigation" pane
#    And I click the "Add Order Set" button
#    And I wait "4" seconds
#    And I enter "VerveDel Micro Order Set Edit1" in the "Edit Order Set Name" field
#    And I enter "1" in the "Edit Order Set Version" field
#    And I check the "Edit Order Set Active" checkbox
#    And I click the "Content" element
#    And I drag the "Order Component" to section field in Edit order set pane
#    And I wait "3" seconds
#    And I enter "Test Micro Lab" in the "Order Search" field
#    And I select "Test Micro Lab" in the "CPOE Order Table" table
#    And I select "Back" from the "Source Field" dropdown in the "CPOE Order Prototype Contents" pane
#    And I select "Upper" from the "Source Description" dropdown in the "CPOE Order Prototype Contents" pane
#    And I click the "OK CPOE Order Prototype" button
#    And I click the "Save Edit Order Set" button
#    And I click the "Close Edit Order Set" button
#    And I enter "VerveDel Micro Order Set Edit1" in the "OrderSet Name" field
#    And I click the "Search CPOE Order Set Maintenance" button
#    And I wait "4" seconds
#    Then the "CPOE Order Set" table should load
#    And I select "VerveDel Micro Order Set Edit1" in the "CPOE Order Set" table
#    And I click the "Edit CPOE Order Set Maintenance" button
#    And I click "OK" in the confirmation box if it exists
#    And I wait "2" seconds
#    And I click the "Content" element
#    And I wait "1" seconds
#    And I open the "Test Micro Lab today Back; Upper" section item for editing in Edit Order Set
#    And I select "Lower" from the "Source Description" dropdown in the "CPOE Order Prototype Contents" pane
#    And I click the "OK CPOE Order Prototype" button
#    And I click the "Save Edit Order Set" button
#    And I click the "Close Edit Order Set" button
#    And I enter "VerveDel Micro Order Set Edit1" in the "Order Set Name" field
#    And I click the "Search CPOE Order Set Maintenance" button
#    Then the "CPOE Order Set" table should have at least "1" row containing the text "VerveDel Micro Order Set Edit1"

  Scenario: 16 - PK Admin OSB Edit Order Description
    Given I am on the "Admin" tab
    When I select the "Facility Group" subtab
    And I select "DefaultFacilityGroup" from the "Facility Group" dropdown
    And the "CPOE Preferences" pane should load
    And I click the "Order Sets" link in the "Facility Group Navigation" pane
    And I click the "Add Order Set" button
    And I wait "4" seconds
    And I enter "VerveDel Micro Order Set Edit2" in the "Edit Order Set Name" field
    And I enter "1" in the "Edit Order Set Version" field
    And I check the "Edit Order Set Active" checkbox
    And I click the "Content" element
    And I drag the "Order Component" to section field in Edit order set pane
    And I wait "3" seconds
    And I enter "Test Micro Lab" in the "Order Search" field
    And I select "Test Micro Lab" in the "CPOE Order Table" table
    And I select "Back" from the "Source Field" dropdown in the "CPOE Order Prototype Contents" pane
    And I select "Upper" from the "Source Description" dropdown in the "CPOE Order Prototype Contents" pane
    And I click the "OK CPOE Order Prototype" button
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    And I enter "VerveDel Micro Order Set Edit2" in the "OrderSet Name" field
    And I click the "Search CPOE Order Set Maintenance" button
    And I wait "4" seconds
    Then the "CPOE Order Set" table should load
    And I select "VerveDel Micro Order Set Edit2" in the "CPOE Order Set" table
    And I click the "Edit CPOE Order Set Maintenance" button
    And I click "OK" in the confirmation box if it exists
    And I wait "2" seconds
    And I click the "Content" element
    And I open the "Test Micro Lab today Back; Upper" section item for editing in Edit Order Set
    And I wait "1" seconds
    And I select "Finger" from the "Source Field" dropdown in the "CPOE Order Prototype Contents" pane
    And I select "Left Thumb" from the "Source Description" dropdown in the "CPOE Order Prototype Contents" pane
    And I click the "OK CPOE Order Prototype" button
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    And I enter "VerveDel Micro Order Set Edit2" in the "Order Set Name" field
    And I click the "Search CPOE Order Set Maintenance" button
    Then the "CPOE Order Set" table should have at least "1" row containing the text "VerveDel Micro Order Set Edit2"

  Scenario: Run incremental SOLR Indexer
    Given I am on the "Admin" tab
    And I select the "Facility Group" subtab
    When I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    Then the "CPOE Utility" pane should load
    And I wait up to "5" seconds for the "OHA/SearchIndex" field of type "MISC_ELEMENT" to be visible
    And I click the "Run Search Index" button
    And I check the "Run Incremental Update" checkbox
    And I click the "Run the Indexer" button
    And I click the "InformationOK" button if it exists

  Scenario: PK Order with description required
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT13, TEST13" is on the patient list
    And I select patient "CPOEPAT13, TEST13" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    #And I click the "OK" button in the "Warning" pane if it exists
    And I enter "Test Micro Lab" in the "Add Order" field in the "Enter Orders" pane
    And I select "Test Micro Lab" from the "CPOE All Orders" list in the search results
    And I select "Test Micro Lab today" in the "New Orders" table
    And I select "Back" from the "Source Field" dropdown
    And I click on the element "SourceDescription" in the "Edit Medication Order CPOE Micro" pane
    And Text exact "Upper" should appear in the "SourceDescriptionContainer" section in the "Edit Medication Order CPOE Micro" pane
    And I click the "Enter Order OK" button
#    Then the text "Please enter all required (*) fields." should appear in the "RequiredFieldsMissingWarning" section in the "Required Fields Missing Warning" pane
#    And I click the "Ok" button in the "Required Fields Missing Warning" pane
#    And I select "Lower" from the "Source Description" dropdown
#    And I click the "Enter Order OK" button
    Then the following rows should appear in the "New Orders" table
      | New Orders                       |
      | Test Micro Lab today Back; Upper |
    And I click the "Add Order Cancel" button
    And I click the "Yes" button in the "Question" pane if it exists

  Scenario: PK Order Source with no available descriptions
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT14, TEST14" is on the patient list
    And I select patient "CPOEPAT14, TEST14" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    #And I click the "OK" button in the "Warning" pane if it exists
    And I enter "Test Micro Lab" in the "Add Order" field in the "Enter Orders" pane
    And I select "Test Micro Lab" from the "CPOE All Orders" list in the search results
    And I select "Test Micro Lab today" in the "New Orders" table
    And I select "Neck" from the "Source Field" dropdown
    And I click the "Enter Order OK" button
    Then the following rows should appear in the "New Orders" table
      | New Orders                |
      | Test Micro Lab today Neck |
    And I click the "Add Order Cancel" button
    And I click the "Yes" button in the "Question" pane if it exists

# [duplicate scenario]
#  Scenario: 32 - PK Order Source and Description
#    When I am on the "Patient List V2" tab
#    And I select "Verve CPOE" from the "Patient List" menu
#    And "CPOEPAT15, TEST15" is on the patient list
#    And I select patient "CPOEPAT15, TEST15" from the patient list
#    And I select "Orders" from clinical navigation
#    And I click the "Enter Orders" button
#    #And I click the "OK" button in the "Warning" pane if it exists
#    And I enter "Test Micro Lab" in the "Add Order" field in the "Enter Orders" pane
#    And I select "Test Micro Lab" from the "CPOE All Orders" list in the search results
#    And I select "Test Micro Lab today" in the "New Orders" table
#    And I select "Back" from the "Source Field" dropdown
#    And I select "Lower" from the "Source Description" dropdown
#    And I click the "Enter Order OK" button
#    Then the following rows should appear in the "New Orders" table
#      | New Orders                        |
#      | Test Micro Lab today Back; Lower |
#    And I click the "Add Order Cancel" button
#    And I click the "Yes" button in the "Question" pane if it exists



#  [Cannot change the description as per DEV-84220]
#  Scenario: 33 - PK Order change Description
#    When I am on the "Patient List V2" tab
#    And I select "Verve CPOE" from the "Patient List" menu
#    And "CPOEPAT16, TEST16" is on the patient list
#    And I select patient "CPOEPAT16, TEST16" from the patient list
#    And I select "Orders" from clinical navigation
#    And I click the "Enter Orders" button
#    #And I click the "OK" button in the "Warning" pane if it exists
#    And I enter "Test Micro Lab" in the "Add Order" field in the "Enter Orders" pane
#    And I select "Test Micro Lab" from the "CPOE All Orders" list in the search results
#    And I select "Test Micro Lab today" in the "New Orders" table
#    And I select "Back" from the "Source Field" dropdown
#    And I select "Lower" from the "Source Description" dropdown
#    And I click the "Enter Order OK" button
#    When I select "Test Micro Lab  today Back; Lower" in the "New Orders" table
#    And I select "Upper" from the "Source Description" dropdown
#    And I click the "Enter Order OK" button
#    Then the following rows should appear in the "New Orders" table
#      | New Orders                       |
#      | Test Micro Lab today Back; Upper |
#    And I click the "Add Order Cancel" button
#    And I click the "Yes" button in the "Question" pane if it exists

  Scenario: 34 - PK Order Source and Description Submit
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT17, TEST17" is on the patient list
    And I select patient "CPOEPAT17, TEST17" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    #And I click the "OK" button in the "Warning" pane if it exists
    And I enter "Test Micro Lab" in the "Add Order" field in the "Enter Orders" pane
    And I select "Test Micro Lab" from the "CPOE All Orders" list in the search results
    And I select "Test Micro Lab today" in the "New Orders" table
    And I select "Back" from the "Source Field" dropdown
    And I click on the element "SourceDescription" in the "Edit Medication Order CPOE Micro" pane
    And Text exact "Upper" should appear in the "Source Description Container" section in the "Edit Medication Order CPOE Micro" pane
    And I click the "Enter Order OK" button
    And I Submit the Orders
    And I select "All" from the "Order Type" menu
    And I wait "1" seconds
    And I select "Today" from the "Past Order Date" dropdown
    Then the "Orders" table should load
#    And I wait "1" seconds
    And rows containing the following should appear in the "Orders" table
      | Existing orders            | Start          |
      | Test Micro Lab Back; Upper | %Current Date% |

  Scenario: 35 - PK Order Source and Description Order String Validation
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT18, TEST18" is on the patient list
    And I select patient "CPOEPAT18, TEST18" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
   #And I click the "OK" button in the "Warning" pane if it exists
    And I enter "Test Micro Lab" in the "Add Order" field in the "Enter Orders" pane
    And I select "Test Micro Lab  starting today Daily Finger; Left Thumb" from the "CPOE All Orders" list in the search results
    Then the following rows should appear in the "New Orders" table
      | New Orders                                             |
      | Test Micro Lab starting today Daily Finger; Left Thumb |
    And I click the "AddOrderCancel" button
    And I click the "Yes" button in the "Question" pane if it exists

  Scenario: 36 - PK Order Source and Description from Order Set
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT20, TEST20" is on the patient list
    And I select patient "CPOEPAT20, TEST20" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
   #And I click the "OK" button in the "Warning" pane if it exists
    And I enter "VerveDel Micro Order Set Back and Upper" in the "Add Order" field in the "Enter Orders" pane
    And I select "VerveDel Micro Order Set Back and Upper" from the "CPOE All Orders" list in the search results
    And I wait "1" seconds
    And I check all checkboxes in "Order Set Content" pane
    And I click the "Done with Order Set" button
    Then the following rows should appear in the "New Orders" table
      | New Orders                       |
      | Test Micro Lab today Back; Upper |
    And I Submit the Orders
    And I select "All" from the "Order Type" menu
    And I wait "1" seconds
    And I select "Today" from the "Past Order Date" dropdown
    Then the "Orders" table should load
#    And I wait "1" seconds
    And rows containing the following should appear in the "Orders" table
      | Existing orders            | Start          |
      | Test Micro Lab Back; Upper | %Current Date% |

  Scenario: 41 - PK Order Source and Description Modify
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT19, TEST19" is on the patient list
    And I select patient "CPOEPAT19, TEST19" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    #And I click the "OK" button in the "Warning" pane if it exists
    And I enter "Test Micro Lab" in the "Add Order" field in the "Enter Orders" pane
    And I select "Test Micro Lab" from the "CPOE All Orders" list in the search results
    And I select "Test Micro Lab today" in the "New Orders" table
    And I select "Back" from the "Source Field" dropdown
    And I click on the element "SourceDescription" in the "Edit Medication Order CPOE Micro" pane
    And Text exact "Upper" should appear in the "Source Description Container" section in the "Edit Medication Order CPOE Micro" pane
    And I click the "Enter Order OK" button
    When I select "Test Micro Lab  today Back; Upper" in the "New Orders" table
    And I select "Finger" from the "Source Field" dropdown
    And I click on the element "SourceDescription" in the "Edit Medication Order CPOE Micro" pane
    And Text exact "Left Thumb" should appear in the "Source Description Container" section in the "Edit Medication Order CPOE Micro" pane
    And I click the "Enter Order OK" button
    Then the following rows should appear in the "New Orders" table
      | New Orders                                |
      | Test Micro Lab today Finger; Left Thumb   |
    And I click the "AddOrderCancel" button
    And I click the "Yes" button in the "Question" pane if it exists

  Scenario: 45 - PK Transfer Order Continue with Source and Description
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT17, TEST17" is on the patient list
    And I select patient "CPOEPAT17, TEST17" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Transfer Order Rec" button in the "Orders" pane
    And I uncheck the "Transfer From" checkbox
    And I select the "Continue" radio in the row with the text "Test Micro Lab Back; Upper" from the "Medication Reconciliation" table
    #And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Transfer Orders*                           |
      | Continue: Test Micro Lab today Back; Upper |
    And I click the "Reconcile and Submit" button
    And I select "All" from the "Order Type" menu
    And I wait "1" seconds
    And I select "Today" from the "Past Order Date" dropdown
    Then the "Orders" table should load
    And rows containing the following should appear in the "Orders" table
      | Existing orders            | Start          |
      | Test Micro Lab Back; Upper | %Current Date% |
    And I click the "Transfer Order Rec" button in the "Orders" pane
    And I wait "5" seconds
    And I click the "TOR - Cancel" button
    And I click the "Yes" button in the "Question" pane

#  Cannot change the description as per DEV-84220
#  Scenario: 46A - PK Transfer Order Change with Description
#    When I am on the "Patient List V2" tab
#    And I select "Verve CPOE" from the "Patient List" menu
#    And "CPOEPAT17, TEST17" is on the patient list
#    And I select patient "CPOEPAT17, TEST17" from the patient list
#    And I select "Orders" from clinical navigation
#    And I click the "Transfer Order Rec" button in the "Orders" pane
#    And I uncheck the "Transfer From" checkbox
#    And I select the "Change" link in the row with the text "Test Micro Lab Back; Lower" in the "Medication Reconciliation" table
#    And I wait "1" seconds
#    And I select "Upper" from the "Source Description" dropdown in the "Edit Medication Order" pane
#    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
#    And I click the "Reconcile and Submit" button
#    And I select "All" from the "Order Type" menu
#    And I wait "1" seconds
#    And I select "Today" from the "Past Order Date" dropdown
#    Then the "Orders" table should load
#    And rows containing the following should appear in the "Orders" table
#      | Existing orders                  | Start          |
#      | Test Micro Lab today Back; Upper | %Current Date% |

  Scenario: 46B - PK Transfer Order Change with Description
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT17, TEST17" is on the patient list
    And I select patient "CPOEPAT17, TEST17" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Transfer Order Rec" button in the "Orders" pane
    And I uncheck the "Transfer From" checkbox
    And I select the "Change" link in the row with the text "Test Micro Lab Back; Upper" in the "Medication Reconciliation" table
    And I wait "1" seconds
    And I select "Hand" from the "Source Field" dropdown in the "Edit Medication Order" pane
    And I click on the element "SourceDescription" in the "Edit Medication Order" pane
    And Text exact "Left" should appear in the "Source Description Container" section in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    And I click the "Reconcile and Submit" button
    And I select "All" from the "Order Type" menu
    And I wait "1" seconds
    And I select "Today" from the "Past Order Date" dropdown
    Then the "Orders" table should load
    And rows containing the following should appear in the "Orders" table
      | Existing orders                  | Start          |
      | Test Micro Lab today Hand; Left  | %Current Date% |

  Scenario: 47 - PK Transfer Order DC with Source and Description
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT17, TEST17" is on the patient list
    And I select patient "CPOEPAT17, TEST17" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Transfer Order Rec" button in the "Orders" pane
    And I wait "3" seconds
    And I uncheck the "Transfer From" checkbox
    And I select the "Stop" radio in the row with the text "Test Micro Lab Hand; Left" from the "Medication Reconciliation" table
    And I wait "3" seconds
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | New Orders*                              |
      | Discontinued: Test Micro Lab Hand; Left  |
    And I click the "Reconcile and Submit" button
    And I select "All" from the "Order Type" menu
    And I wait "1" seconds
    And I select "Today" from the "Past Order Date" dropdown
    Then the "Orders" table should load
    And rows containing the following should appear in the "Orders" table
      | Existing orders            | Start          |
      | Test Micro Lab Hand; Left  | %Current Date% |

  Scenario: 49 - PK Transfer Order Add with Source and Description
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT24, TEST24" is on the patient list
    And I select patient "CPOEPAT24, TEST24" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Transfer Order Rec" button in the "Orders" pane
    And I uncheck the "Transfer From" checkbox
#    When I click the "New Orders Add" button
    When I click the "here" link if it exists in the "Transfer Order Reconciliation" pane
    And I enter "Test Micro Lab" in the "Search For Order" field
    And I select "Test Micro Lab" from the "Searched All Orders" list in the search results
    When I choose "Modify" option by clicking "Edit" icon against "New: Test Micro Lab today" text in the row with "New: Test Micro Lab today" as the value under "New Orders*" in the "Medication Reconciliation" table
    And I wait "1" seconds
    And I select "Finger" from the "Source Field" dropdown in the "Edit Medication Order" pane
    And I click on the element "SourceDescription" in the "Edit Medication Order" pane
    And Text exact "Left Thumb" should appear in the "Modify Source Description Container" section in the "Edit Medication Order" pane
#    And I select "Left Middle" from the "Source Description" dropdown in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    And I click the "Reconcile and Submit" button
    And I select "All" from the "Order Type" menu
    And I wait "1" seconds
    And I select "Today" from the "Past Order Date" dropdown
    Then the "Orders" table should load
    And rows containing the following should appear in the "Orders" table
      | Existing orders                   | Start          |
      | Test Micro Lab Finger; Left Thumb | %Current Date% |

  Scenario: 48A - PK Transfer Order Add OS with Source and Description
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT21, TEST21" is on the patient list
    And I select patient "CPOEPAT21, TEST21" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Transfer Order Rec" button in the "Orders" pane
    And I uncheck the "Transfer From" checkbox
    When I click the "here" link if it exists in the "Transfer Order Reconciliation" pane
    And I enter "VerveDel Micro Order Set Back and Upper" in the "Search For Order" field
    And I select "VerveDel Micro Order Set Back and Upper" from the "Searched All Orders" list in the search results
    And I wait "1" seconds
    And I check all checkboxes in "TOR - Order Set Content" pane
    And I click the "Done with Order Set" button in the "TOR - Order Set Content" pane
    And I click the "Reconcile and Submit" button
    And I select "All" from the "Order Type" menu
    And I wait "1" seconds
    And I select "Today" from the "Past Order Date" dropdown
    Then the "Orders" table should load
    And rows containing the following should appear in the "Orders" table
      | Existing orders                  | Start          |
      | Test Micro Lab today Back; Upper | %Current Date% |

  Scenario: 50 - PK Order Source and Description Order again
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT25, TEST25" is on the patient list
    And I select patient "CPOEPAT25, TEST25" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    #And I click the "OK" button in the "Warning" pane if it exists
    And I enter "Test Micro Lab" in the "Add Order" field in the "Enter Orders" pane
    And I select "Test Micro Lab" from the "CPOE All Orders" list in the search results
    And I select "Test Micro Lab today" in the "New Orders" table
    And I select "Hand" from the "Source Field" dropdown
    And I click on the element "SourceDescription" in the "Edit Medication Order CPOE Micro" pane
    And Text exact "Left" should appear in the "SourceDescriptionContainer" section in the "Edit Medication Order CPOE Micro" pane
    And I click the "Enter Order OK" button
    And I Submit the Orders
    And I select "All" from the "Order Type" menu
    And I wait "1" seconds
    And I select "Today" from the "Past Order Date" dropdown
    Then the "Orders" table should load
    And rows containing the following should appear in the "Orders" table
      | Existing orders            | Start          |
      | Test Micro Lab Hand; Left  | %Current Date% |

  Scenario: 51 - PK Order Source and Description Add Favorite
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT26, TEST26" is on the patient list
    And I select patient "CPOEPAT26, TEST26" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I click the "Manage Favorites" link in the "Enter Orders" pane
    And I click the "Order Favorite - New Favorite" button
    And I enter "Test Micro Lab" in the "Add Order" field in the "Add Favorite to Favorites" pane
    And I select "Test Micro Lab" from the "Order Favorite - All Orders" list in the search results
    And I select "Back" from the "Manage Favorite SourceField" dropdown in the "Add Favorite" pane
    And I select "Upper" from the "ManageFavoriteSourceDescription" dropdown in the "Add Favorite" pane
    And I click the "Manage Favorite OK" button in the "Add Favorite" pane
    And I click the "Order Favorite - Save" button
    Then the following text should appear in the "Order - Favorites" pane
      | Test Micro Lab today Back; Upper |
    And I click the "Add Order Cancel" button


#[Cannot edit the sorce description as per DEV-84220]
#  Scenario: 52 - PK Order Source and Description Edit Favorite
#    When I am on the "Patient List V2" tab
#    And I select "Verve CPOE" from the "Patient List" menu
#    And "CPOEPAT27, TEST27" is on the patient list
#    And I select patient "CPOEPAT27, TEST27" from the patient list
#    And I select "Orders" from clinical navigation
#    And I click the "Enter Orders" button
#    And I click the "Manage Favorites" link in the "Enter Orders" pane
#    And I click the "Order Favorite - New Favorite" button
#    And I enter "Test Micro Lab" in the "Add Order" field in the "Add Favorite to Favorites" pane
#    And I select "Test Micro Lab" from the "Order Favorite - All Orders" list in the search results
#    And I select "Back" from the "Manage Favorite SourceField" dropdown in the "Add Favorite" pane
#    And I select "Upper" from the "Manage Favorite Source Description" dropdown in the "Add Favorite" pane
#    And I click the "Manage Favorite OK" button in the "Add Favorite" pane
#    And I click the "Order Favorite - Save" button
#    Then the following text should appear in the "Order - Favorites" pane
#      | Test Micro Lab today Back; Upper |
#    And I click the "Manage Favorites" link in the "Enter Orders" pane
#    And I wait up to "4" seconds for loading to complete
#    And I click on the text "Test Micro Lab today Back; Upper" in the "Manage Favorites" pane
#    And I click the "Order Favorite - Edit" button
#    And I select "Finger" from the "Manage Favorite SourceField" dropdown in the "Order Favorite - Edit Favorite" pane
#    And I select "Right Thumb" from the "Manage Favorite Source Description" dropdown in the "Order Favorite - Edit Favorite" pane
#    And I click the "Manage Favorite OK" button in the "Order Favorite - Edit Favorite" pane
#    And I click the "Order Favorite - Save" button
#    Then the following text should appear in the "Order - Favorites" pane
#      | Test Micro Lab today Finger; Right Thumb |
#    And I click the "Add Order Cancel" button

  Scenario: 55 - PK Order Source and Description from AMR
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT28, TEST28" is on the patient list
    And I select patient "CPOEPAT28, TEST28" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
#    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "aspirin" in the "Search for order" field in the "Search for order" pane
    And I select "ASPIRIN EC  1 TAB 325MG Oral Daily" from the "Searched Combined Med Orders" list in the search results
    And I select the "Continue" radio in the row with "New: ASPIRIN EC 1 TAB 325MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
#    And I click the "Yes" button if it exists
    When I click the "Hospital Orders Add" button
    And I enter "Test Micro Lab" in the "Search For Order" field
    And I select "Test Micro Lab" from the "Searched All Orders" list in the search results
    When I choose "Modify" option by clicking "Edit" icon against "New: Test Micro Lab today" text in the row with "New: Test Micro Lab today" as the value under "Hospital Orders*" in the "Medication Reconciliation" table
    And I select "Finger" from the "Source Field" dropdown in the "Edit Medication Order" pane
    And I click on the element "SourceDescription" in the "Edit Medication Order" pane
    And Text exact "Left Thumb" should appear in the "SourceDescriptionContainer" section in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    And I click the "Reconcile and Submit" button
    And I select "All" from the "Order Type" menu
    And I wait "1" seconds
    And I select "Today" from the "Past Order Date" dropdown
    Then the "Orders" table should load
    And rows containing the following should appear in the "Orders" table
      | Existing orders                   | Start          |
      | Test Micro Lab Finger; Left Thumb | %Current Date% |

  #Create Order Set broken: DEV-73289
  Scenario: 58 - PK Order Source and Description from AMR Order Set
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT22, TEST22" is on the patient list
    And I select patient "CPOEPAT22, TEST22" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I enter "aspirin" in the "Search for order" field in the "Search for order" pane
    And I select "ASPIRIN EC  1 TAB 325MG Oral Daily" from the "Searched Combined Med Orders" list in the search results
#    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with "New: ASPIRIN EC 1 TAB 325MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    When I click the "Hospital Orders Add" button
    And I enter "VerveDel Micro Order Set Back and Upper" in the "Search For Order" field
    And I select "VerveDel Micro Order Set Back and Upper" from the "Searched All Orders" list in the search results
    And I wait "1" seconds
    And I check all checkboxes in "AMR - Order Set Content" pane
    And I click the "Done with Order Set" button in the "AMR - Order Set Content" pane
    And I click the "Reconcile and Submit" button
    And I select "All" from the "Order Type" menu
    And I wait "1" seconds
    And I select "Today" from the "Past Order Date" dropdown
    Then the "Orders" table should load
    And rows containing the following should appear in the "Orders" table
      | Existing orders            | Start          |
      | Test Micro Lab Back; Upper | %Current Date% |

#  [Duplicate Scenario]
#  Scenario: PK Order Source and Description from Favorite from AMR
#    When I am on the "Patient List V2" tab
#    And I select "Verve CPOE" from the "Patient List" menu
#    And "CPOEPAT29, TEST29" is on the patient list
#    And I select patient "CPOEPAT29, TEST29" from the patient list
#    And I select "Orders" from clinical navigation
#    And I click the "Adm Med Rec" button in the "Orders" pane
#    Then the "Admission Medication Reconciliation" pane should load
#    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
##    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
#    And I enter "Cafergot" in the "Search for order" field in the "Search for order" pane
#    And I select "Cafergot 1 mg-100 mg tablet (ergotamine-caffeine)  Oral" from the "Searched Combined Med Orders" list in the search results
#    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
#    And I select the "Continue" radio in the row with "New: Cafergot 1 mg-100 mg tablet (ergotamine-caffeine) Oral (test order)" as the value under "Home Medications*" in the "Medication Reconciliation" table
##    And I click the "Yes" button if it exists
#    When I click the "Hospital Orders Add" button
#    And I click on the text "Test Micro Lab today Back; Lower" in the "Search For Order" pane
#    And I click the "Reconcile and Submit" button
#    And I select "All" from the "Order Type" menu
#    And I wait "1" seconds
#    And I select "Today" from the "Past Order Date" dropdown
#    Then the "Orders" table should load
#    And rows containing the following should appear in the "Orders" table
#      | Existing orders            | Start          |
#      | Test Micro Lab Back; Lower | %Current Date% |

  Scenario: 60 - PK Order Source and Description from DMR
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT30, TEST30" is on the patient list
    And I select patient "CPOEPAT30, TEST30" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    And I click the "Stop Remaining Meds" button if it exists
#    When I click the "Discharge Orders Add" button
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I enter "Test Micro Lab" in the "DMR - Search For Order" field
    And I select "Test Micro Lab" from the "Searched All Orders" list in the search results
    When I choose "Modify" option by clicking "Edit" icon against "New: Test Micro Lab today" text in the row with "New: Test Micro Lab today" as the value under "Discharge Orders*" in the "Medication Reconciliation" table
    And I select "Finger" from the "Source Field" dropdown in the "Edit Medication Order" pane
    And I click on the element "SourceDescription" in the "Edit Medication Order" pane
    And Text exact "Left Thumb" should appear in the "Source Description Container" section in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    And I click the "Reconcile and Submit" button
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Discharge Orders*                 |
      | Test Micro Lab Finger; Left Thumb |
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane if it exists

  Scenario: 63- PK Order Source and Description from DMR Order Set
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT23, TEST23" is on the patient list
    And I select patient "CPOEPAT23, TEST23" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    And I click the "Stop Remaining Meds" button if it exists
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I enter "VerveDel Micro Order Set Back and Upper" in the "DMR - Search For Order" field
    And I select "VerveDel Micro Order Set Back and Upper" from the "Searched All Orders" list in the search results
    And I wait "1" seconds
    And I check all checkboxes in "DMR - Order Set Content" pane
    And I click the "Done with Order Set" button in the "DMR - Order Set Content" pane
    And I click the "Reconcile and Submit" button
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then rows starting with the following should appear in the "Medication Reconciliation" table
      | Discharge Orders*          |
      | Test Micro Lab Back; Upper |
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane if it exists

  Scenario: Setup - Enable Medication Duplicate Display for CDSW testing
    When I am on the "Patient List V2" tab
    And I execute the "Popup With Reason Duplication - Non-Medication Between New Orders" query

  Scenario: 37 - PK Order from OS with CDSW
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT30, TEST30" is on the patient list
    And I select patient "CPOEPAT30, TEST30" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I enter "VerveDel Micro Order Set Back and Upper" in the "Add Order" field in the "Enter Orders" pane
    And I select "VerveDel Micro Order Set Back and Upper" from the "CPOE All Orders" list in the search results
    And I wait "1" seconds
    And I check all checkboxes in "Order Set Content" pane
    And I click the "Done with Order Set" button
    And I enter "VerveDel Micro Order Set Back and Upper" in the "Add Order" field in the "Enter Orders" pane
    And I select "VerveDel Micro Order Set Back and Upper" from the "CPOE All Orders" list in the search results
    And I wait "1" seconds
    And I check all checkboxes in "Order Set Content" pane
    And I click the "Done with Order Set" button
    Then the "Clinical Decision Support Warnings" pane should load
    And I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    And I click the "Add Order Cancel" button
    And I click the "Yes" button in the "Question" pane if it exists

  Scenario: 38 - PK Order Source and Description with CDSW
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT30, TEST30" is on the patient list
    And I select patient "CPOEPAT30, TEST30" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    #And I click the "OK" button in the "Warning" pane if it exists
    And I enter "Test Micro Lab" in the "Add Order" field in the "Enter Orders" pane
    And I select "Test Micro Lab" from the "CPOE All Orders" list in the search results
    And I enter "Test Micro Lab" in the "Add Order" field in the "Enter Orders" pane
    And I select "Test Micro Lab" from the "CPOE All Orders" list in the search results
    Then the "CDSWarnings" pane should load
    And I click the "Lab DontOrder" button
    And I click the "AddOrderCancel" button
    And I click the "Yes" button in the "Question" pane if it exists

  Scenario: 48 - PK Transfer Order Add with Source and Description CDSW
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT30, TEST30" is on the patient list
    And I select patient "CPOEPAT30, TEST30" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Transfer Order Rec" button in the "Orders" pane
    And I wait "3" seconds
    And I uncheck the "Transfer From" checkbox
#    When I click the "New Orders Add" button
    When I click the "here" link if it exists in the "Transfer Order Reconciliation" pane
    And I enter "Test Micro Lab" in the "Search For Order" field
    And I select "Test Micro Lab" from the "Searched All Orders" list in the search results
    When I click the "New Orders Add" button
    And I enter "Test Micro Lab" in the "Search For Order" field
    And I select "Test Micro Lab" from the "Searched All Orders" list in the search results
    And I click the "Reconcile and Submit" button
    Then the "TOR - CDSW" pane should load
    And I click the "Dont Order" button in the "TOR - CDSW" pane
    And I click the "TOR - Cancel" button
    And I click the "Yes" button in the "Question" pane

  Scenario: 48A - PK Transfer Order Add OS with Source and Description with CDSW
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT30, TEST30" is on the patient list
    And I select patient "CPOEPAT30, TEST30" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Transfer Order Rec" button in the "Orders" pane
    And I wait "3" seconds
    And I uncheck the "Transfer From" checkbox
    When I click the "here" link if it exists in the "Transfer Order Reconciliation" pane
    And I enter "VerveDel Micro Order Set Back and Upper" in the "Search For Order" field
    And I select "VerveDel Micro Order Set Back and Upper" from the "Searched All Orders" list in the search results
    And I wait "1" seconds
    And I check all checkboxes in "TOR - Order Set Content" pane
    And I click the "Done with Order Set" button in the "TOR - Order Set Content" pane
    When I click the "New Orders Add" button
    And I enter "VerveDel Micro Order Set Back and Upper" in the "Search For Order" field
    And I select "VerveDel Micro Order Set Back and Upper" from the "Searched All Orders" list in the search results
    And I wait "1" seconds
    And I check all checkboxes in "TOR - Order Set Content" pane
    And I click the "Done with Order Set" button in the "TOR - Order Set Content" pane
    And I click the "Reconcile and Submit" button
    Then the "TOR - CDSW" pane should load
    And I click the "Dont Order" button in the "TOR - CDSW" pane
    And I click the "TOR - Cancel" button
    And I click the "Yes" button in the "Question" pane

  Scenario: PK Order Source and Description from AMR with CDSW
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT30, TEST30" is on the patient list
    And I select patient "CPOEPAT30, TEST30" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I enter "aspirin" in the "Search for order" field in the "Search for order" pane
    And I select "ASPIRIN EC  1 TAB 325MG Oral Daily" from the "Searched Combined Med Orders" list in the search results
#    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    When I click the "Hospital Orders Add" button
    And I enter "Test Micro Lab" in the "Search For Order" field
    And I select "Test Micro Lab" from the "Searched All Orders" list in the search results
    When I click the "Hospital Orders Add" button
    And I enter "Test Micro Lab" in the "Search For Order" field
    And I select "Test Micro Lab" from the "Searched All Orders" list in the search results
    Then the "AMR - CDSW" pane should load
    And I click the "Dont Order" button in the "TOR - CDSW" pane
    And I click the "AMR - Cancel" button
    And I click the "Yes" button in the "Question" pane

  Scenario: PK Order Source and Description from DMR with CDSW
    When I am on the "Patient List V2" tab
    And I select "Verve CPOE" from the "Patient List" menu
    And "CPOEPAT30, TEST30" is on the patient list
    And I select patient "CPOEPAT30, TEST30" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    When I click the "Discharge Orders Add" button
    And I enter "Test Micro Lab" in the "DMR - Search For Order" field
    And I select "Test Micro Lab" from the "Searched All Orders" list in the search results
    When I click the "Discharge Orders Add" button
    And I enter "Test Micro Lab" in the "DMR - Search For Order" field
    And I select "Test Micro Lab" from the "Searched All Orders" list in the search results
    Then the "DMR - CDSW" pane should load
    And I click the "Dont Order" button in the "DMR - CDSW" pane
    And I click the "Med Rec Cancel" button
    And I click the "Yes" button in the "Question" pane if it exists

  Scenario: 8.4.0:DEV-72180-Support Dynamic Microbiology Descriptions in CPOE
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I click the "OK" button in the "Warning" pane if it exists
    And I enter "Test Micro Lab" in the "Add Order" field in the "Enter Orders" pane
    And I select "Test Micro Lab" from the "CPOE All Orders" list in the search results
    And I select "Test Micro Lab today" in the "New Orders" table
          #  Selecting source field "Back" and validating it's values
    And I select "Back" from the "Source Field" dropdown
    And I click on the element "SourceDescription" in the "Edit Medication Order CPOE Micro" pane
    And Text exact "Upper" should appear in the "SourceDescriptionContainer" section in the "Edit Medication Order CPOE Micro" pane
          #  Selecting source field "Finger" and validating it's values
    And I select "Finger" from the "Source Field" dropdown
    And I click on the element "SourceDescription" in the "Edit Medication Order CPOE Micro" pane
    And Text exact "Left Thumb" should appear in the "SourceDescriptionContainer" section in the "Edit Medication Order CPOE Micro" pane
       #Selecting source field "Hand" and validating it's values
    And I select "Hand" from the "Source Field" dropdown
    And I click on the element "SourceDescription" in the "Edit Medication Order CPOE Micro" pane
    And Text exact "Left" should appear in the "SourceDescriptionContainer" section in the "Edit Medication Order CPOE Micro" pane
          #Selecting source field "Neck" and validating it's values
    And I select "Neck" from the "Source Field" dropdown
    Then The following fields should not display in the "Edit Order" pane
      | Type     | Name               |
      | Dropdown | Source Description |
    And I click the "Enter Order OK" button
    And I Submit the Orders
    And I select "All" from the "Order Type" menu
    And I wait "1" seconds
    And I select "Today" from the "Past Order Date" dropdown
    Then the "Orders" table should load
    And rows containing the following should appear in the "Orders" table
      |Existing orders            | Start         |
      | Test Micro Lab Neck | %Current Date% |

  Scenario: Tear Down - Disable Medication Duplicate Display for CDSW testing
    When I am on the "Patient List V2" tab
    And I execute the "Disable Duplication - Non-Medication Between New Orders" query