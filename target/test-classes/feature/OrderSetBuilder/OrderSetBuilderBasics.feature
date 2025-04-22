@OrderSetBuilder
Feature: Order Set Builder - Basics

  #  Scenarios came from ALM: Test Plan > CPOE(PK) > Admin > Institution > Order Sets

  Background:
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "Order Sets" link in the "Facility Group Navigation" pane
    And I click the "Add Order Set" button
    And I wait "4" seconds


  Scenario: OSB Add Order Set
    And I enter "Test: Add Order Set" in the "Edit Order Set Name" field
    And I enter "Test: AOS" in the "Edit Order Set Abbreviation" field
    And I enter "Test: Add Order Set - Description" in the "Edit Order Set Description" field
    And I check the "Edit Order Set Active" checkbox
    And I click the "Content" tab
    And I click the "Preview" tab
    And I wait "4" seconds
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    Then I enter "test" in the "Order Set Name" field in the "CPOE Order Set Maintenance" pane
    And I click the "Search CPOE Order Set Maintenance" button
    Then the "CPOE Order Set" table should have at least "1" row containing the text "Test: Add Order Set"
#    #To delete test order sets via the UI at the end of running your test, use these steps: (for running tests repeatedly)
    And I select "Test: Add Order Set" in the "CPOE Order Set" table
    And I click the "Delete CPOE Order Set Maintenance" button
    And I click the "Confirm Delete" button in the "Delete Dialog" pane


  Scenario: OSB Edit Order Set - No Edits
    And I enter "Test: Edit Order Set - No Edits" in the "Edit Order Set Name" field
    And I enter "Test: EOS - No edits" in the "Edit Order Set Abbreviation" field
    And I enter "Test: Edit Order Set - No Edits: Description" in the "Edit Order Set Description" field
    And I check the "Edit Order Set Active" checkbox
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    Then I enter "test" in the "Order Set Name" field in the "CPOE Order Set Maintenance" pane
    And I click the "Search CPOE Order Set Maintenance" button
    Then the "CPOE Order Set" table should have at least "1" row containing the text "Test: Edit Order Set - No Edits"
    And I select "Test: Edit Order Set - No Edits" in the "CPOE Order Set" table
    And I click the "Edit CPOE Order Set Maintenance" button
    And I click "OK" in the confirmation box if it exists
    And I wait "2" seconds
    And I click the "Content" tab
    And I wait "1" seconds
    And I click the "Preview" tab
    And I wait "4" seconds
#    #The step below isn't necessary to the test and isn't working in 8.4 (not sure why), so commented out. Works fine in 8.2.1. -- HIC 11/15/18
#    And I click the "Info" tab
#    And I wait "1" seconds
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    And I select "Test: Edit Order Set - No Edits" in the "CPOE Order Set" table
    And I click the "Delete CPOE Order Set Maintenance" button
    And I click the "Confirm Delete" button in the "Delete Dialog" pane


  Scenario: OSB Edit Order Set - Make Edits
    And I enter "Test: Edit Order Set - Make Edits" in the "Edit Order Set Name" field
    And I enter "Test: EOS - Make edits" in the "Edit Order Set Abbreviation" field
    And I enter "Test: Edit Order Set - Make Edits: Description" in the "Edit Order Set Description" field
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
    Then the "CPOE Order Set" table should have at least "1" row containing the text "Test: Edit Order Set - Make Edits"
    And I select "Test: Edit Order Set - Make Edits" in the "CPOE Order Set" table
    And I click the "Edit CPOE Order Set Maintenance" button
    And I click "OK" in the confirmation box if it exists
    And I wait "1" seconds
    And I enter "Added this edit" in the "Edit Order Set Description" field
    And I click the "Content" tab
    And I open the "CBC today" section item for editing in Edit Order Set
    And I select "Weekly" from the "Frequency List" multiselect in the "CPOE Order Prototype Contents" pane
    And I click the "OK CPOE Order Prototype" button
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    And I select "Test: Edit Order Set - Make Edits" in the "CPOE Order Set" table
    And I click the "Edit CPOE Order Set Maintenance" button
    And I click "OK" in the confirmation box if it exists
    Then the value in the "Edit Order Set Description" field should be "Added this edit"
    And I click the "Content" tab
#   #If the Content tab has/can open the correct section below, then it has the correct order section w/ Frequency on it.
    And I open the "CBC starting today Weekly" section item for editing in Edit Order Set
    And I click the "OK CPOE Order Prototype" button
    And I click the "Preview" tab
    And I wait "4" seconds
    Then the "Order Set Preview" table should have at least "1" row containing the text "CBC starting today Weekly"
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    And I select "Test: Edit Order Set - Make Edits" in the "CPOE Order Set" table
    And I click the "Delete CPOE Order Set Maintenance" button
    And I click the "Confirm Delete" button in the "Delete Dialog" pane


  Scenario: OSB Delete Order Set
    And I enter "Test: Delete This Order Set" in the "Edit Order Set Name" field
    And I enter "Test: DTOS" in the "Edit Order Set Abbreviation" field
    And I enter "Test: Delete This Order Set - Description" in the "Edit Order Set Description" field
    And I check the "Edit Order Set Active" checkbox
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    Then I enter "test" in the "Order Set Name" field in the "CPOE Order Set Maintenance" pane
    And I click the "Search CPOE Order Set Maintenance" button
    Then the "CPOE Order Set" table should have at least "1" row containing the text "Test: Delete This Order Set"
    And I select "Test: Delete This Order Set" in the "CPOE Order Set" table
    And I click the "Delete CPOE Order Set Maintenance" button
    And I click the "Cancel Delete" button in the "Delete Dialog" pane
    Then the "CPOE Order Set" table should have at least "1" row containing the text "Test: Delete This Order Set"
    And I select "Test: Delete This Order Set" in the "CPOE Order Set" table
    And I click the "Delete CPOE Order Set Maintenance" button
    And I click the "Confirm Delete" button in the "Delete Dialog" pane
    Then the "CPOE Order Set" table should have "0" rows containing the text "Test: Delete This Order Set"


  Scenario: OSB Copy Order Set
    And I enter "Test: Copy This Order Set" in the "Edit Order Set Name" field
    And I enter "Test: CTOS" in the "Edit Order Set Abbreviation" field
    And I enter "Test: Copy This Order Set - Description" in the "Edit Order Set Description" field
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
    Then the "CPOE Order Set" table should have at least "1" row containing the text "Test: Copy This Order Set"
    And I select "Test: Copy This Order Set" in the "CPOE Order Set" table
    And I click the "Copy CPOE Order Set Maintenance" button
#   #Enter a new name and abbreviation into the Copy Order Set popup
    And I enter "Test: Copied Order Set" in the "Copy Order Set Name" field in the "Copy Order Set" pane
    And I enter "Test: COS" in the "Copy Order Set Abbreviation" field in the "Copy Order Set" pane
    And I click the "Save Copy" button in the "Copy Order Set" pane
    Then I check the "Include Inactive" checkbox in the "CPOE Order Set Maintenance" pane
    And I click the "Search CPOE Order Set Maintenance" button
    Then the "CPOE Order Set" table should have at least "1" row containing the text "Test: Copied Order Set"
    And I select "Test: Copied Order Set" in the "CPOE Order Set" table
    And I wait "2" seconds
    And I click the "Edit CPOE Order Set Maintenance" button
    And I click "OK" in the confirmation box if it exists
    And I wait "4" seconds
    And I enter "This is a copy of order set Test: CTOS" in the "Edit Order Set Description" field
    And I check the "Edit Order Set Active" checkbox
    And I click the "Content" tab
#    #If the Content tab has/can open the correct section below, then the copy has the correct order section on it.
    And I open the "CBC today" section item for editing in Edit Order Set
    And I click the "OK CPOE Order Prototype" button
    Then I click the "Preview" tab
    And I wait "4" seconds
    Then the "Order Set Preview" table should have at least "1" row containing the text "CBC today"
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    And I select "Test: Copy This Order Set" in the "CPOE Order Set" table
    And I click the "Delete CPOE Order Set Maintenance" button
    And I click the "Confirm Delete" button in the "Delete Dialog" pane
    And I select "Test: Copied Order Set" in the "CPOE Order Set" table
    And I click the "Delete CPOE Order Set Maintenance" button
    And I click the "Confirm Delete" button in the "Delete Dialog" pane
