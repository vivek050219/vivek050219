@OrderSetBuilder
Feature: Order Set Builder - Orders

  #  Scenarios came from ALM: Test Plan > CPOE(PK) > Admin > Institution > Order Sets

  Background:
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "Order Sets" link in the "Facility Group Navigation" pane
    And I click the "Add Order Set" button
    And I wait "4" seconds


  Scenario: Delete Order from Order Set
    And I enter "Test: Delete Order from Set" in the "Edit Order Set Name" field
    And I enter "Test: DO" in the "Edit Order Set Abbreviation" field
    And I enter "Test: Delete an order from the Order Set" in the "Edit Order Set Description" field
    And I check the "Edit Order Set Active" checkbox
    And I click the "Content" tab
    And I drag the "Order Component" to section field in Edit order set pane
    And I wait "1" seconds
    And I enter "cbc" in the "Order Search" field
    And I wait "4" seconds
    And I select "CBC" in the "CPOE Order Table" table
    And I click the "OK CPOE Order Prototype" button
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    Then I enter "test" in the "Order Set Name" field in the "CPOE Order Set Maintenance" pane
    And I click the "Search CPOE Order Set Maintenance" button
    And I select "Test: Delete Order from Set" in the "CPOE Order Set" table
    And I click the "Edit CPOE Order Set Maintenance" button
    And I click "OK" in the confirmation box if it exists
    And I wait "1" seconds
    Then I click the "Content" tab
    And I open the "CBC today" section item for editing in Edit Order Set
    And I click the "Delete This Item" button in the "Order Dialog" pane
    Then I click the "Confirm Delete This Item" button in the "Delete Item Dialog" pane
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    Then I wait "2" seconds
    And I select "Test: Delete Order from Set" in the "CPOE Order Set" table
    And I click the "Edit CPOE Order Set Maintenance" button
    And I click "OK" in the confirmation box if it exists
    And I wait "1" seconds
    And I click the "Preview" tab
    And I wait "4" seconds
    Then the "Order Set Preview" table should have "0" rows containing the text "CBC today"
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    And I select "Test: Delete Order from Set" in the "CPOE Order Set" table
    And I click the "Delete CPOE Order Set Maintenance" button
    And I click the "Confirm Delete" button in the "Delete Dialog" pane

#Confirms that even if you delete the order from the Order Set, if you don't save the Order Set, the order
#  won't delete -- the order will still be present on the Order Set.
  Scenario: Delete Order from Order Set Without Saving
    And I enter "Test: Delete Order from Set Without Saving" in the "Edit Order Set Name" field
    And I enter "Test: DOWOS" in the "Edit Order Set Abbreviation" field
    And I enter "Test: Delete an order from the Order Set, but don't save" in the "Edit Order Set Description" field
    And I check the "Edit Order Set Active" checkbox
    And I click the "Content" tab
    And I drag the "Order Component" to section field in Edit order set pane
    And I wait "1" seconds
    And I enter "cbc" in the "Order Search" field
    And I wait "4" seconds
    And I select "CBC" in the "CPOE Order Table" table
    And I click the "OK CPOE Order Prototype" button
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    Then I enter "test" in the "Order Set Name" field in the "CPOE Order Set Maintenance" pane
    And I click the "Search CPOE Order Set Maintenance" button
    And I select "Test: Delete Order from Set Without Saving" in the "CPOE Order Set" table
    And I click the "Edit CPOE Order Set Maintenance" button
    And I click "OK" in the confirmation box if it exists
    And I wait "1" seconds
    Then I click the "Content" tab
    And I open the "CBC today" section item for editing in Edit Order Set
    And I click the "Delete This Item" button
    Then I click the "Confirm Delete This Item" button in the "Delete Item Dialog" pane
    And I click the "Close Edit Order Set" button
    And I click the "Confirm Close Yes" button
    Then I select "Test: Delete Order from Set Without Saving" in the "CPOE Order Set" table
    And I click the "Edit CPOE Order Set Maintenance" button
    And I click "OK" in the confirmation box if it exists
    And I wait "1" seconds
    And I click the "Content" tab
    And I open the "CBC today" section item for editing in Edit Order Set
    And I click the "OK CPOE Order Prototype" button
    And I click the "Preview" tab
    And the "Order Set Preview" table should have "1" row containing the text "CBC today"
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    And I select "Test: Delete Order from Set Without Saving" in the "CPOE Order Set" table
    And I click the "Delete CPOE Order Set Maintenance" button
    And I click the "Confirm Delete" button in the "Delete Dialog" pane

  Scenario: OSB Delete Private Section
    And I enter "Test: Delete Private Section" in the "Edit Order Set Name" field
    And I enter "Test: DPS" in the "Edit Order Set Abbreviation" field
    And I check the "Edit Order Set Active" checkbox
    Then I click the "Content" tab
    Then I open the "[Section - no label]" component for editing in the Content Tab
    And I enter "Main Section" in the "Section Label" field
    And I click the "Detail Ok" button in the "Detail Dialog" pane
    And I drag the "Section - This Order Set Only Component" to section field in Edit order set pane
##    #Open the default "[Section - no label]" and name it main or default b4 adding a new section
##    #Sections have to have unique names in order for the WebDriver to select/click them properly
    Then I open the "[Section - no label]" component for editing in the Content Tab
    And I enter "New Order Area" in the "Section Label" field
    And I click the "Detail Ok" button in the "Detail Dialog" pane
    And I click the "Preview" tab
    And I wait "4" seconds
    Then the content should contain the text "New Order Area" in the "Preview Content" pane
    Then I click the "Content" tab
    And I open the "New Order Area" component for editing in the Content Tab
    Then I click the "Detail Delete This Item" button in the "Detail Dialog" pane
    And I click the "Confirm Delete This Item" button in the "Delete Item Dialog" pane
    Then I click the "Preview" tab
    And I wait "4" seconds
    Then the content should not contain the text "New Order Area" in the "Preview Content" pane
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    Then I enter "test" in the "Order Set Name" field in the "CPOE Order Set Maintenance" pane
    And I click the "Search CPOE Order Set Maintenance" button
    And I select "Test: Delete Private Section" in the "CPOE Order Set" table
    And I click the "Delete CPOE Order Set Maintenance" button
    Then I click the "Confirm Delete" button in the "Delete Dialog" pane

  Scenario: OSB Edit Private Section Label
    And I enter "Test: Edit Private Section Label" in the "Edit Order Set Name" field
    And I enter "Test: EPSL" in the "Edit Order Set Abbreviation" field
    And I check the "Edit Order Set Active" checkbox
    Then I click the "Content" tab
    Then I open the "[Section - no label]" component for editing in the Content Tab
    And I enter "Main Section" in the "Section Label" field
    And I click the "DetailOk" button in the "Detail Dialog" pane
#    Added hyphen in Section - This Order Set Only Component to better match UI. -- HIC 12/13/18
    And I drag the "Section - This Order Set Only Component" to section field in Edit order set pane
    Then I open the "[Section - no label]" component for editing in the Content Tab
    And I enter "New Label One" in the "Section Label" field
    And I click the "Detail Ok" button in the "Detail Dialog" pane
    And I drag the "Section - This Order Set Only Component" to section field in Edit order set pane
    And I click the "Preview" tab
    And I wait "4" seconds
    Then the content should contain the text "New Label One" in the "Preview Content" pane
    And the content should not contain the text "[Section - no label]" in the "Preview Content" pane
    Then I click the "Content" tab
    And I open the "New Label One" component for editing in the Content Tab
    And I enter "New Label Two" in the "Section Label" field
    And I click the "Detail Ok" button in the "Detail Dialog" pane
    And I click the "Preview" tab
    And I wait "4" seconds
    Then the content should contain the text "New Label Two" in the "Preview Content" pane
    And the content should not contain the text "[Section - no label]" in the "Preview Content" pane
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    Then I enter "test" in the "Order Set Name" field in the "CPOE Order Set Maintenance" pane
    And I click the "Search CPOE Order Set Maintenance" button
    And I select "Test: Edit Private Section Label" in the "CPOE Order Set" table
    And I click the "Delete CPOE Order Set Maintenance" button
    Then I click the "Confirm Delete" button in the "Delete Dialog" pane

  Scenario: OSB Add a Medication Order
    And I enter "Test: Add a Med Order" in the "Edit Order Set Name" field
    And I enter "Test: AMO" in the "Edit Order Set Abbreviation" field
    And I enter "Test: Add a Med Order" in the "Edit Order Set Description" field
    And I check the "Edit Order Set Active" checkbox
    And I click the "Content" tab
    And I drag the "Order Component" to section field in Edit order set pane
    And I wait "1" seconds
    And I enter "tylenol" in the "Order Search" field
    And I wait "4" seconds
    And I click the "Medications Tab" element
    And I select "Tylenol 8 Hour tablet,extended release (acetaminophen)" in the "Formulary" table
#   #If one doesn't bother clicking on the Medications tab specifically, and the med shows up in the All tab (not all meds do)...
#   #Then, you can use the step below to select the med from the All tab -- HIC 11/20/18
#    #And I select "Tylenol 8 Hour tablet,extended release (acetaminophen)  650MG Oral Daily" in the "CPOE Order Table" table
    And I click the "OK CPOE Order Prototype" button
    Then I click the "Preview" tab
    And I wait "4" seconds
    Then the "Order Set Preview" table should have at least "1" row containing the text "Tylenol 8 Hour tablet,extended release (acetaminophen) 650MG Oral Daily"
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    Then I enter "test" in the "Order Set Name" field in the "CPOE Order Set Maintenance" pane
    And I click the "Search CPOE Order Set Maintenance" button
    Then the "CPOE Order Set" table should have at least "1" row containing the text "Test: Add a Med Order"
    And I select "Test: Add a Med Order" in the "CPOE Order Set" table
    And I click the "Delete CPOE Order Set Maintenance" button
    And I click the "Confirm Delete" button in the "Delete Dialog" pane

  Scenario: OSB Delete Shared Section
    And I enter "Test: Delete Shared Section" in the "Edit Order Set Name" field
    And I enter "Test: DSS" in the "Edit Order Set Abbreviation" field
    And I check the "Edit Order Set Active" checkbox
    Then I click the "Content" tab
    Then I open the "[Section - no label]" component for editing in the Content Tab
    And I enter "Main Section" in the "Section Label" field
    And I click the "Detail Ok" button in the "Detail Dialog" pane
    And I drag the "Section - This Order Set Only Component" to section field in Edit order set pane
##    #Open the default "[Section - no label]" and name it main or default b4 adding a new section
##    #Sections have to have unique names in order for the WebDriver to select/click them properly
    Then I open the "[Section - no label]" component for editing in the Content Tab
    And I enter "New Shared Order Container" in the "Section Label" field
    And I click the "Detail Ok" button in the "Detail Dialog" pane
    And I drag the "Section - Shared Component" to section field in Edit order set pane
    Then the "Section Search" pane should load
    And I enter "Test: This is a shared section" in the "Shared Section Name" field
#    Note: The button's text, below, is "None Selected" in the UI.  The label reads "Order Definition".
    And I click the "Order Definition Search" button in the "Section Search" pane
    Then I enter "cbc" in the "Order Definition Name" field
    And I click the "Search CPOE Order Definitions" button
    Then I select "CBC" from the "Order Name" column in the "CPOEOrderDefinitions" table
    And I click the "Ok Add Order" button
    Then the "Section Search" pane should load
    And I click the "Close Section Search" button in the "Section Search" pane
    And I drag the "Section - Shared Component" to section field in Edit order set pane
    Then the "Section Search" pane should load
    And the value in the "Shared Section Name" field in the "Section Search" pane should be "Test: This is a shared section"
    And I click the "Close Section Search" button in the "Section Search" pane
    Then I click the "Preview" tab
    And the content should contain the text "New Shared Order Container" in the "Preview Content" pane
    Then I click the "Content" tab
    And I open the "New Shared Order Container" component for editing in the Content Tab
    Then I click the "Detail Delete This Item" button in the "Detail Dialog" pane
    Then I click the "Cancel Delete This Item" button in the "Delete Item Dialog" pane
    Then I click the "Detail Ok" button in the "Detail Dialog" pane
    Then I click the "Preview" tab
    And I wait "4" seconds
    Then the content should contain the text "New Shared Order Container" in the "Preview Content" pane
    Then I click the "Content" tab
    And I open the "New Shared Order Container" component for editing in the Content Tab
    Then I click the "Detail Delete This Item" button in the "Detail Dialog" pane
    And I click the "Confirm Delete This Item" button in the "Delete Item Dialog" pane
    Then I click the "Preview" tab
    Then the content should not contain the text "New Shared Order Container" in the "Preview Content" pane
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    Then I enter "test" in the "Order Set Name" field in the "CPOE Order Set Maintenance" pane
    And I click the "Search CPOE Order Set Maintenance" button
    And I select "Test: Delete Shared Section" in the "CPOE Order Set" table
    And I click the "Delete CPOE Order Set Maintenance" button
    Then I click the "Confirm Delete" button in the "Delete Dialog" pane
