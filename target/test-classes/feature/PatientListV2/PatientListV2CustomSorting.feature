@PatientListV2
Feature: Patient List V2 Custom Sorting
  Test patient list sorting

  Background:
    Given I am logged into the portal with user "PLV2LVL3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized

  Scenario: To check the Custom Sort Order Location on UI
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel SortingList" in the "Name" field
    And I enter "Sorting List Description" in the "Description" field
    And I select the "Display" section
    And I select "Location" from the "Sort On" dropdown
    And I wait "1" second
    Then the following options should be available in the "Sort Order" dropdown
      | A to Z |
      | Z to A |
      | Custom |
    And I click the "Create Patient List Cancel" button

  Scenario: Adding the sort order at department level and verifying the same in Patient List
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "Custom Sort" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel List using Template" in the "Name" field
    And I enter "Sorting List using Template Description" in the "Description" field
    And I select the "Display" section
    Then patients should be custom sorted by following locations
      | PKHospital-West       |
      | PKHospital-Valley     |
      | GHDOHospital          |
      | Mercy                 |
      | PKHospital-Pediatrics |
      | PKHospital-South      |
    Then I click the "Create Patient List Create My List" button

  Scenario: To verify the patient list after adding the custom sort order through Create Patient List wizard
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel SortingList1" in the "Name" field
    And I enter "Custom Sorting List Description" in the "Description" field
    And I select the "Filters" section
    Then I click the "Delete Filter" icon if it exists
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load within "10" seconds
    When I select "Medical Service" from the "Filter On" dropdown
    Then the "Medical Service" pane should load
    When I enter "PLv2-CustomSortTest" in the "Filter Search" field
    And I check the "PLv2 - Custom Sort Test" checkbox
    And I click the "Add Filter" button
    And I select the "Display" section
    And I select "Location" from the "Sort On" dropdown
    And I wait "1" second
    And I select "Custom" from the "Sort Order" dropdown
    When I check the following location checkboxes in the "Create Patient Lists" pane
      | Mercy                 |
      | PKHospital-Pediatrics |
      | PKHospital-West       |
      | PKHospital-Valley     |
      | PKHospital-South      |
      | GHDOHospital          |
    And I click the "Save Sorting Criteria" button
    And I wait "1" second
     #the locations checked above will appear according to their order of selection
    Then patients should be custom sorted by following locations
      | Mercy                 |
      | PKHospital-Pediatrics |
      | PKHospital-West       |
      | PKHospital-Valley     |
      | PKHospital-South      |
      | GHDOHospital          |
    Then I click the "Create Patient List Create My List" button

  Scenario: To verify the list when list contains visits whose locations are not included in the custom sort order
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel SortingList2" in the "Name" field
    And I enter "Custom Sorting List Description" in the "Description" field
    And I select the "Filters" section
    Then I click the "Delete Filter" icon if it exists
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load within "10" seconds
    When I select "Medical Service" from the "Filter On" dropdown
    Then the "Medical Service" pane should load
    When I enter "PLv2-CustomSortTest" in the "Filter Search" field
    And I check the "PLv2 - Custom Sort Test" checkbox
    And I click the "Add Filter" button
    And I select the "Display" section
    And I select "Location" from the "Sort On" dropdown
    And I wait "1" second
    And I select "Custom" from the "Sort Order" dropdown
    When I check the following location checkboxes in the "Create Patient Lists" pane
      | PKHospital-Valley |
      | PKHospital-South  |
    And I mouse over and click the "Save Sorting Criteria" button in the "Create Patient Lists" pane
    And I wait "2" seconds
    #And I click the "Save Sorting Criteria" button
      #the locations checked above will appear according to their order of selection. also remaining patients will appear in ascending order of location name
    Then patients should be custom sorted starting by following locations
      | PKHospital-Valley |
      | PKHospital-South  |
    Then I click the "Create Patient List Create My List" button

  Scenario: To make sure if Cancel is clicked the custom sort order is not saved and sort option should automatically be changed to A to Z
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel SortingList3" in the "Name" field
    And I enter "Custom Sorting List Description" in the "Description" field
    And I select the "Filters" section
    Then I click the "Delete Filter" icon if it exists
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load within "10" seconds
    When I select "Medical Service" from the "Filter On" dropdown
    Then the "Medical Service" pane should load
    When I enter "PLv2-CustomSortTest" in the "Filter Search" field
    And I check the "PLv2 - Custom Sort Test" checkbox
    And I click the "Add Filter" button
    And I select the "Display" section
    And I select "Location" from the "Sort On" dropdown
    And I wait "1" second
    And I select "Custom" from the "Sort Order" dropdown
    When I check the following location checkboxes in the "Create Patient Lists" pane
      | PKHospital-Pediatrics |
      | Mercy                 |
      | PKHospital-West       |
      | PKHospital-Valley     |
      | PKHospital-South      |
      | GHDOHospital          |
#    And I click the "Cancel Sorting Criteria" button
    And I mouse over and click the "Cancel Sorting Criteria" button in the "Create Patient Lists" pane
    And I wait "3" seconds
     #by default the list will be sorted in ascending order of location names
    Then patients should be custom sorted by following locations
      | GHDOHospital          |
      | Mercy                 |
      | PKHospital-Pediatrics |
      | PKHospital-South      |
      | PKHospital-Valley     |
      | PKHospital-West       |
    Then I click the "Create Patient List Create My List" button

  Scenario: To verify the sorting order of patient list after editing the custom sort order through Edit Patient List wizard
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I enter "VerveDel SortingList4" in the "Name" field
    And I enter "Custom Sorting List Description" in the "Description" field
    And I select the "Filters" section
    Then I click the "Delete Filter" icon if it exists
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load within "10" seconds
    When I select "Insurance Company" from the "Filter On" dropdown
    Then the "Insurance Company" pane should load
    When I enter "Cigna" in the "Insurance Filter Search" field
    And I check the "Cigna" checkbox
    And I click the "Add Filter" button
    And I select the "Display" section
    And I select "Location" from the "Sort On" dropdown
    And I wait "1" second
    And I select "Custom" from the "Sort Order" dropdown
    And I check the following location checkboxes in the "Create Patient Lists" pane
      | PKHospital-Central |
      | Mercy              |
#    And I click the "Save Sorting Criteria" button
    And I mouse over and click the "Save Sorting Criteria" button in the "Create Patient Lists" pane
    And I wait "2" seconds
    Then I click the "Create Patient List Create My List" button
    When I select "VerveDel SortingList4" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "8" seconds
    And I select the "Display" section
    And I select "Location" from the "Sort On" dropdown
    And I wait "1" second
    And I select "Custom" from the "Sort Order" dropdown
    And I click the "Edit Sorting Criteria" button
    And I wait "3" seconds
    And I drag and drop following locations one by one at the top in "locations" pane
      | Mercy.4R              |
      | Mercy.5R              |
#    #Split this dragAndDrop into 3 steps, to see if that would work.
#    #IDK why, but Selenium doesn't like this Hospital (PKHospital-Central.5G). It keeps skipping selecting it and
#    #dragging and dropping it. The others are all fine. -- HIC 3/15/19
#    Then I drag and drop following locations one by one at the top in "locations" pane
#      | PKHospital-Central.5G |
#    And I drag and drop following locations one by one at the top in "locations" pane
#      | Mercy.5R              |
    And I wait "4" seconds
      #the item dropped last would be at top, so order would become  Mercy.5R at top then PKHospital-Central.5G and then Mercy.4R
    Then patients should be custom sorted by following specific locations
      | Mercy.5R              |
#      | PKHospital-Central.5G |
      | Mercy.4R              |
    And I click the "Create Patient List Cancel" button

  Scenario: Verifying the sort order after adding a new visit to the List
    When I select "Create a Patient List" from the "Actions" menu
    And I click the "System Default List" button in the "Choose Template" pane if it exists
    And I click the "OK Template" button in the "Choose Template" pane if it exists
    And I wait "2" seconds
    And I enter "VerveDel SortingList5" in the "Name" field
    And I enter "Custom Sorting List Description" in the "Description" field
    And I select the "Filters" section
    Then I click the "Delete Filter" icon if it exists
    And I click the "Add A Filter" button
    Then the "Filter Criteria" pane should load within "10" seconds
    When I select "Medical Service" from the "Filter On" dropdown
    Then the "Medical Service" pane should load
    When I enter "PLv2-CustomSortTest" in the "Filter Search" field
    And I check the "PLv2 - Custom Sort Test" checkbox
    And I click the "Add Filter" button
    And I select the "Display" section
    And I select "Location" from the "Sort On" dropdown
    And I wait "1" second
    And I select "Custom" from the "Sort Order" dropdown
    When I check the following location checkboxes in the "Create Patient Lists" pane
      | PKHospital-Valley |
      | PKHospital-South  |
#    And I click the "Save Sorting Criteria" button
    And I mouse over and click the "Save Sorting Criteria" button in the "Create Patient Lists" pane
    And I wait "2" seconds
    Then I click the "Create Patient List Create My List" button
    When I select "VerveDel SortingList5" from the "Patient List" menu
    And I select "Add Patient" from the "Actions" menu
    And I wait "3" second
    And I click the "Clear Criteria" button
    And I check the "Include Cancelled Visits" checkbox
    And I check the "Include Past Visits" checkbox
    And I search for patient "2A3 MVTEST"
    And I select "the first item" from the "Name (\d)" column in the "Add Patient Search" table
    And I select "ER" from the "Create Visit" menu
    When I fill in the following fields
      | Name                | Type     | Value                 |
      | Add Facility        | dropdown | PKHospital-Valley     |
#            |Unit            		 |dropdown  |2G                      |
      | Unit                | dropdown | 5G                    |
#            |Room            		 |dropdown  |208                     |
      | Room                | dropdown | 501                   |
      | Admit DateTime-Date | text     | %Current Date MMDDYY% |
      | Admit DateTime-Time | text     | %Current Time HHMM%   |
    And I click the "AddAndSave" button
    And I wait "3" second
    And I click the "Clear Criteria" button
    And I search for patient "2A3 MVTEST"
    And I select "the first item" from the "Name (\d)" column in the "Add Patient Search" table
    And I click the "Add" button in the "Add patient(s) to your patient list" pane
    And I wait "3" seconds
    And I click the "Close" button in the "Add patient(s) to your patient list" pane
    And I wait "1" second
    Then patient "2A3 MVTEST" should be on the patient list
    And I select "Edit" from the "Actions" menu
    And I select the "Display" section
    Then patients should be custom sorted starting by following locations
      | PKHospital-Valley |
      | PKHospital-South  |
#            | GHDOHospital              |
#            | Mercy 					|
#            | PKHospital-Pediatrics     |
#            | PKHospital-West           |
    And I click the "Create Patient List Save" button