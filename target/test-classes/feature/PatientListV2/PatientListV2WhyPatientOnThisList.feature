@PatientListV2
Feature: Patient List V2 Why Patient On This List

  Background:
    Given I am logged into the portal with user "PLV2LVL3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized

  Scenario: Patient 2A3 with OP visit meets filter criteria in Patient List
    When I select "Why On My List?" from the "Patient List" menu
    And I select patient "MVTEST, 2A3" from the patient list
    And I select "Why Patient Is On This List" from the "Actions" menu
    Then the "Compare Patient To List" pane should load
    And I click the "Show Details" link if it exists in the "Compare Patient To List" pane
    And for the following options, following should be visible
      | Section		    |	Name         |Image |
      | TBC			    |	ER           | NO   |
      | TBC			    |	Inpatient    | NO   |
      | TBC			    |	Outpatient   | YES  |
      | Medical Service |	PLM2Test-MV  | YES  |
    Then I click the "OK Compare" button in the "Compare Patient To List" pane

  Scenario: Patient 2A3 with OP visit meets filter criteria in Patient Search Screen
    When I am on the "Patient Search" tab
    And I wait up to "10" seconds for the "Clear Criteria" field of type "BUTTON" to be visible
    And I click the "Clear Criteria" button
    When I enter "MVTEST" in the "Last" field
    And I enter "2A3" in the "First" field
    And I select "Outpatient" from the "Visit Type" dropdown
    And I enter "2" in the "Admit in last N days" field
    And I check the "Include Cancelled Visits" checkbox
    And I check the "Include Past Visits" checkbox
    And I click the "Search for Visits" button
    And I select patient "MVTEST, 2A3" from the "Name (\d)" column in the "Visit Search Results" table
    And I click the "Compare" button
    Then the "Compare Select A List" pane should load
    And I click the "Select A Patient List" button in the "Compare Select A List" pane
    And I click the "Why on My List?" element in the "Compare Select A List" pane
    And I click the "Compare Patient To List" button
    Then the "Compare Patient To List" pane should load
    And I click the "Show Details" link if it exists in the "Compare Patient To List" pane
    And for the following options, following should be visible
      | Section		    |	Name         |Image |
      | TBC			    |	ER           | NO   |
      | TBC			    |	Inpatient    | NO  	|
      | TBC			    |	Outpatient   | YES  |
      | Medical Service |	PLM2Test-MV  | YES  |
    Then I click the "OK Compare" button in the "Compare Patient To List" pane

  Scenario: Patient 2D3 with IP visit meets filter criteria in Patient List
    When I select "Why On My List?" from the "Patient List" menu
    And I select patient "MVTEST, 2D3" from the patient list
    And I select "Why Patient Is On This List" from the "Actions" menu
    Then the "Compare Patient To List" pane should load
    And I click the "Show Details" link if it exists in the "Compare Patient To List" pane
    And for the following options, following should be visible
      | Section		   |	Name         |Image |
      | TBC			   |	ER           | NO   |
      | TBC			   |	Inpatient    | YES  |
      | TBC			   |	Outpatient   | NO  	|
      | MedicalService |	PLM2Test-MV  | YES  |
    Then I click the "OK Compare" button in the "Compare Patient To List" pane

  Scenario: Patient 2D2 with IP visit do not meet filter criteria in Patient List,shows special warning
    When I select "Why On My List?" from the "Patient List" menu
    And I select patient "MVTEST, 2D2" from the patient list
    And I select "Why Patient Is On This List" from the "Actions" menu
    Then the "Compare Patient To List" pane should load
#    And the "Warning" pane should load
    And for the following options, following should be visible
      | Section		   |	Name         |Image |
      | TBC			   |	ER           | NO   |
      | TBC			   |	Inpatient    | YES  |
      | TBC			   |	Outpatient   | NO  	|
      | MedicalService |	PLM2Test-MV  | NO  	|
    Then I click the "OK Compare" button in the "Compare Patient To List" pane

  Scenario: Patient 2D3 with IP visit meets filter criteria in Patient Search
    When I am on the "Patient Search" tab
    And I wait up to "10" seconds for the "Clear Criteria" field of type "BUTTON" to be visible
    And I click the "Clear Criteria" button
    When I enter "MVTEST" in the "Last" field
    And I enter "2D3" in the "First" field
    And I select "Inpatient" from the "Visit Type" dropdown
    And I uncheck the "Include Cancelled Visits" checkbox
    And I uncheck the "Include Past Visits" checkbox
    And I click the "Search for Visits" button
    And I select patient "MVTEST, 2D3" from the "Name (\d)" column in the "Visit Search Results" table
    And I wait up to "10" seconds for the "Compare" field of type "BUTTON" to be visible
    And I click the "Compare" button
    Then the "Compare Select A List" pane should load
    And I click the "Select A Patient List" button in the "Compare Select A List" pane
    And I click the "Why on My List?" element in the "Compare Select A List" pane
    And I click the "Compare Patient To List" button
    Then the "Compare Patient To List" pane should load
    And I click the "Show Details" link if it exists in the "Compare Patient To List" pane
    And for the following options, following should be visible
      | Section		    |	Name         |Image |
      | TBC			    |	ER           | NO   |
      | TBC			    |	Inpatient    | YES  |
      | TBC			    |	Outpatient   | NO   |
      | Medical Service |	PLM2Test-MV  | YES  |
    Then I click the "OK Compare" button in the "Compare Patient To List" pane

  Scenario: Patient 2D2 with IP visit do not meet filter criteria in Patient Search, shows special warning
    When I am on the "Patient Search" tab
    And I wait up to "10" seconds for the "Clear Criteria" field of type "BUTTON" to be visible
    And I click the "Clear Criteria" button
    When I enter "MVTEST" in the "Last" field
    And I enter "2D2" in the "First" field
    And I select "Inpatient" from the "Visit Type" dropdown
    And I uncheck the "Include Cancelled Visits" checkbox
    And I uncheck the "Include Past Visits" checkbox
    And I click the "Search for Visits" button
    And I select patient "MVTEST, 2D2" from the "Name (\d)" column in the "Visit Search Results" table
    And I click the "Compare" button
    Then the "Compare Select A List" pane should load
    And I click the "Select A Patient List" button in the "Compare Select A List" pane
    And I click the "Why on My List?" element in the "Compare Select A List" pane
    And I click the "Compare Patient To List" button
    Then the "Compare Patient To List" pane should load
#    And the "Warning" pane should load
    And for the following options, following should be visible
      | Section		    |	Name         |Image |
      | TBC			    |	ER           | NO   |
      | TBC			    |	Inpatient    | YES  |
      | TBC			    |	Outpatient   | NO   |
      | Medical Service |	PLM2Test-MV  | NO   |
    Then I click the "OK Compare" button in the "Compare Patient To List" pane

  Scenario: Patient 2K2 with IP visit do not meet filter criteria in Patient Search
    When I am on the "Patient Search" tab
    And I wait up to "10" seconds for the "Clear Criteria" field of type "BUTTON" to be visible
    And I click the "Clear Criteria" button
    When I enter "MVTEST" in the "Last" field
    And I enter "2K2" in the "First" field
    And I select "Inpatient" from the "Visit Type" dropdown
    And I uncheck the "Include Cancelled Visits" checkbox
    And I uncheck the "Include Past Visits" checkbox
    And I click the "Search for Visits" button
    And I select patient "MVTEST, 2K2" from the "Name (\d)" column in the "Visit Search Results" table
    And I click the "Compare" button
    Then the "Compare Select A List" pane should load
    And I click the "Select A Patient List" button in the "Compare Select A List" pane
    And I click the "Why on My List?" element in the "Compare Select A List" pane
    And I click the "Compare Patient To List" button
    Then the "Compare Patient To List" pane should load
    And I click the "Show Details" link if it exists in the "Compare Patient To List" pane
    And for the following options, following should be visible
      | Section		    |	Name         |Image |
      | TBC			    |	ER           | NO   |
      | TBC			    |	Inpatient    | YES  |
      | TBC			    |	Outpatient   | NO   |
      | Medical Service |	PLM2Test-MV  | NO  |
    Then I click the "OK Compare" button in the "Compare Patient To List" pane

  @donotrun
  Scenario: Patient 2K2 with IP2 visit do not meet filter criteria in Patient Search
    When I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I uncheck the "Include Cancelled Visits" checkbox
    And I uncheck the "Include Past Visits" checkbox
    When I enter "MVTEST" in the "Last" field
    And I enter "2D3" in the "First" field
    And I select "Inpatient2" from the "Visit Type" dropdown
    And I uncheck the "Include Cancelled Visits" checkbox
    And I uncheck the "Include Past Visits" checkbox
    And I click the "Search for Visits" button
    And I select patient "MVTEST, 2K2" from the "Name (\d)" column in the "Visit Search Results" table
    And I click the "Compare" button
    Then the "Compare Select A List" pane should load
    And I click the "Select A Patient List" button in the "Compare Select A List" pane
    And I click the "Why on My List?" element in the "Compare Select A List" pane
    And I click the "Compare Patient To List" button
    Then the "Compare Patient To List" pane should load
    And I click the "Show Details" link if it exists in the "Compare Patient To List" pane
    And for the following options, following should be visible
      | Section		    |	Name         |Image |
      | TBC			    |	ER           | NO   |
      | TBC			    |	Inpatient    | YES  |
      | TBC			    |	Outpatient   | NO   |
      | Medical Service |	PLM2Test-MV  | NO  |
    Then I click the "OK Compare" button in the "Compare Patient To List" pane

  Scenario: Patient 2D2 with ER visit meets filter criteria in Patient Search,shows special warning
    When I am on the "Patient Search" tab
    And I wait up to "10" seconds for the "Clear Criteria" field of type "BUTTON" to be visible
    And I click the "Clear Criteria" button
    When I enter "MVTEST" in the "Last" field
    And I enter "2D2" in the "First" field
    And I select "ER" from the "Visit Type" dropdown
    And I uncheck the "Include Cancelled Visits" checkbox
    And I uncheck the "Include Past Visits" checkbox
    And I click the "Search for Visits" button
    And I select patient "MVTEST, 2D2" from the "Name (\d)" column in the "Visit Search Results" table
    And I click the "Compare" button
    Then the "Compare Select A List" pane should load
    And I click the "Select A Patient List" button in the "Compare Select A List" pane
    And I click the "Why on My List?" element in the "Compare Select A List" pane
    And I click the "Compare Patient To List" button
    Then the "Compare Patient To List" pane should load
#    And the "Warning" pane should load
    And for the following options, following should be visible
      | Section		    |	Name         |Image |
      | TBC			    |	ER           | YES  |
      | TBC			    |	Inpatient    | NO  	|
      | TBC			    |	Outpatient   | NO   |
      | Medical Service |	PLM2Test-MV  | YES  |
    Then I click the "OK Compare" button in the "Compare Patient To List" pane

  Scenario: Patient 2D3 with ER visit do not meet filter criteria in Patient Search
    When I am on the "Patient Search" tab
    And I wait up to "10" seconds for the "Clear Criteria" field of type "BUTTON" to be visible
    And I click the "Clear Criteria" button
    When I enter "MVTEST" in the "Last" field
    And I enter "2D3" in the "First" field
    And I select "ER" from the "Visit Type" dropdown
    And I uncheck the "Include Cancelled Visits" checkbox
    And I uncheck the "Include Past Visits" checkbox
    And I click the "Search for Visits" button
    And I select patient "MVTEST, 2D3" from the "Name (\d)" column in the "Visit Search Results" table
    And I click the "Compare" button
    Then the "Compare Select A List" pane should load
    And I click the "Select A Patient List" button in the "Compare Select A List" pane
    And I click the "Why on My List?" element in the "Compare Select A List" pane
    And I click the "Compare Patient To List" button
    Then the "Compare Patient To List" pane should load
    And I click the "Show Details" link if it exists in the "Compare Patient To List" pane
    And for the following options, following should be visible
      | Section		    |	Name         |Image |
      | TBC			    |	ER           | YES  |
      | TBC			    |	Inpatient    | NO  	|
      | TBC			    |	Outpatient   | NO  	|
      | Medical Service |	PLM2Test-MV  | NO  	|
    Then I click the "OK Compare" button in the "Compare Patient To List" pane

