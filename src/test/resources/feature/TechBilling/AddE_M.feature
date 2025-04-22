@TechBilling
Feature: Add E&M

	Background:
		Given I am logged into the portal with user "techbilluser1" using the default password
		And I am on the "Admin" tab

	Scenario: E&M Section display
		Given I am on the manage sections page
		Then I am on the "E&M" add section page
		And the "E&M Section" pane should load
		And I wait "1" seconds
		And the following fields should display in the "E&M Section" pane
			|Name                       |Type     |
			|Display Label              |text     |
			|Description                |text     |
			|Select Financial Class     |button   |
			|Select Locations           |button   |
			|Select Roles               |button   |
			|active                     |check    |
			|Group                      |button   |
			|Select From Dictionary     |button   |
			|Create New                 |button   |
		When I click the "Save Settings" button in the "E&M Section" pane
		Then the "Error Information" pane should load
		And the following text should appear in the "Error Information" pane
			|Please fix the errors:     |
			|-Missing properties data.  |
			|-Missing levels data.      |
		When I click the "OKErrorInfo" button
		And I click the "Close" image in the "E&M Section" pane
		Then the "E&M Section" pane should close
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Add New E&M Section with CPT and Modifiers and Active uncheck
		Given I am on the manage sections page
		And the section "TBTAU" not in the sections list
		And I am on the "E&M" add section page
		Then the "E&M Section" pane should load
		And I enter "TBTAU" in the "Display Label" field
		And I enter "TechBill to Test Active Uncheck" in the "Description" field
		And I uncheck the "active" checkbox in the "E&M Section" pane
		And the following should be unchecked in the "E&M Section" pane
			|active |
		And I fill in the following fields
			|Name      |Type  |Value |
			|CPT1      |text  |99220 |
			|CPT2      |text  |99221 |
			|CPT3      |text  |99222 |
			|Modifier1 |text  |24    |
			|Modifier2 |text  |25    |
			|Modifier3 |text  |26    |
		When I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And the section "TBTAU" should display with no active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Add New E&M Section with CPT and Modifiers and Active check
		Given I am on the manage sections page
		And the section "TBTAC" not in the sections list
		And I am on the "E&M" add section page
		And the "E&M Section" pane should load
		And I enter "TBTAC" in the "Display Label" field
		And I enter "TechBill to Test Active Check" in the "Description" field
		And I check the "active" checkbox in the "E&M Section" pane
		And the following should be checked in the "E&M Section" pane
			|active |
		And I fill in the following fields
			|Name      |Type  |Value |
			|CPT1      |text  |99220 |
			|CPT2      |text  |99221 |
			|CPT3      |text  |99222 |
			|Modifier1 |text  |24    |
			|Modifier2 |text  |25    |
			|Modifier3 |text  |26    |
	 #to clear the quantity from field
		And I enter "" in the "Quantity1" field
		And I create new field rule "Field1" by selecting "1" as level selector
		When I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And the section "TBTAC" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Validate CPT fields with Invalid Data
		Given I am on the manage sections page
		Then I am on the "E&M" add section page
		And the "E&M Section" pane should load
		And I enter "TBT" in the "Display Label" field
		And I enter "TechBill to Test" in the "Description" field
		And I check the "active" checkbox in the "E&M Section" pane
		And I fill in the following fields
			|Name      |Type  |Value  |
			|CPT1      |text  |992214 |
			|CPT2      |text  |99221  |
			|CPT3      |text  |99222  |
			|Modifier1 |text  |333    |
			|Modifier2 |text  |25     |
			|Modifier3 |text  |26     |
		And I create new field rule "Field1" by selecting "1" as level selector
		When I click the "Save Settings" button in the "E&M Section" pane
		Then the "Error Information" pane should load
		And the following text should appear in the "Error Information" pane
			|Please fix the errors:                         |
			|-Cpt 992214 is not found in the dictionary.    |
			|-Modifier 333 is not found in the dictionary.  |
		When I click the "OKErrorInfo" button
		And I click the "Close" image in the "E&M Section" pane
		Then the "E&M Section" pane should close
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Validate CPT Lookup screen in E&M Section
		Given I am on the manage sections page
		And the section "TBTCPT" not in the sections list
		And I am on the "E&M" add section page
		And the "E&M Section" pane should load
		And I enter "TBTCPT" in the "Display Label" field
		And I enter "TechBill CPT LookUp" in the "Description" field
		And I check the "active" checkbox in the "E&M Section" pane
		And I enter "992" in the "CPT1" field
		And I click the "CPT LookUp1" image
		Then the "CPT Lookup" pane should load
		And the following fields should display in the "CPT Lookup" pane
			|Name              |Type     |
			|searchCpt         |button   |
			|Next              |button   |
			|Last              |button   |
			|InfoIcon          |element  |
			|SearchCPT         |text     |
		And the "CPT List" table should load
		When I click the "CancelCPTLookup" button in the "CPT Lookup" pane
		And I wait "3" second
		When I click the "CPT LookUp1" image
		And I wait "1" second
		Then the "CPT Lookup" pane should load
		And the "CPT List" table should load
		And I click the "99201" link in the "CPT Lookup" pane
   #		Then the "CPT Lookup" pane should close
		And the value in the "CPT1" field should be "99201"
		And I enter "99202" in the "CPT2" field
		And I enter "99203" in the "CPT3" field
		And I create new field rule "Field1" by selecting "1" as level selector
		And I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And the section "TBTCPT" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Validate Modifier Lookup screen in E&M Section
		Given I am on the manage sections page
		And the section "TBT Modifier" not in the sections list
		And I am on the "E&M" add section page
		And I enter "TBT Modifier" in the "Display Label" field in the "E&MSection" pane
		And I enter "TBT Modifier" in the "Description" field in the "E&MSection" pane
		And I check the "active" checkbox in the "E&MSection" pane
		And I fill in the following fields
			|Name      |Type  |Value |
			|CPT1      |text  |86000 |
			|CPT2      |text  |86000 |
			|CPT3      |text  |86000 |
			|Modifier1 |text  |21    |
			|Modifier2 |text  |22    |
			|Modifier3 |text  |23    |
		And I click the "ModifierLookUp1" image in the "E&MSection" pane
		And I click the "CancelImg" image in the "Modifier Selection" pane
		And I click the "CancelSection" button
		Then the value in the "Modifier1" field should be "21"
		And I click the "ModifierLookUp2" image in the "E&MSection" pane
		And I click the "CancelImg" image in the "Modifier Selection" pane
		And I click the "CancelSection" button
		Then the value in the "Modifier2" field should be "22"
		And I click the "ModifierLookUp3" image in the "E&MSection" pane
		And I click the "CancelImg" image in the "Modifier Selection" pane
		And I click the "CancelSection" button
		Then the value in the "Modifier3" field should be "23"
		And I click the "ModifierLookUp1" image in the "E&MSection" pane
		And I click the "CancelImg" image in the "Modifier Selection" pane
		And I click the "OkSection" button
		Then the value in the "Modifier1" field should be blank
		And I click the "ModifierLookUp2" image in the "E&MSection" pane
		And I click the "CancelImg" image in the "Modifier Selection" pane
		And I click the "OkSection" button
		Then the value in the "Modifier2" field should be blank
		And I click the "ModifierLookUp3" image in the "E&MSection" pane
		And I click the "CancelImg" image in the "Modifier Selection" pane
		And I click the "OkSection" button
		Then the value in the "Modifier3" field should be blank
		And I create new field rule "Modifier1" by selecting "1" as level selector
		And I click the "Save Settings" button in the "E&M Section" pane
		And the section "TBT Modifier" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Select Locations in the E&M Section page
		Given I am on the manage sections page
		And the section "TBT Locations" not in the sections list
		When I am on the "E&M" add section page
		And I enter "TBT Locations" in the "Display Label" field in the "E&MSection" pane
		And I enter "TBT Locations" in the "Description" field in the "E&MSection" pane
		And I check the "active" checkbox in the "E&MSection" pane
		And I fill in the following fields
			|Name      |Type  |Value |
			|CPT1      |text  |86000 |
			|CPT2      |text  |86000 |
			|CPT3      |text  |86000 |
		And I click the "Select Locations" button
		Then the following fields should display in the "E&MSection" pane
			|Name                      |Type   |
			|OklocationSelection     |button |
			|CancellocationSelection |button |
		And I select the "GHDOHospital" in the locations list
		And I click the "CancellocationSelection" button
		Then the text "GHDOHospital" should not appear in the "SelectLocations" section in the "E&MSection" pane
		When I click the "Select Locations" button
		And I click the "OklocationSelection" button
		Then the text "GHDOHospital" should appear in the "SelectLocations" section in the "E&MSection" pane
		And I delete the locations from the locations list
		Then the text "GHDOHospital" should not appear in the "SelectLocations" section in the "E&MSection" pane
		When I click the "Select Locations" button
		And I click the "OklocationSelection" button
		Then the text "GHDOHospital" should appear in the "SelectLocations" section in the "E&MSection" pane
		And I create new field rule "Location1" by selecting "1" as level selector
		And I click the "Save Settings" button in the "E&M Section" pane
		Then the section "TBT Locations" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Select Roles in the E&M Section page
		Given I am on the manage sections page
		And the section "TBT Roles" not in the sections list
		When I am on the "E&M" add section page
		And I enter "TBT Roles" in the "Display Label" field in the "E&MSection" pane
		And I enter "TBT Roles" in the "Description" field in the "E&MSection" pane
		And I check the "active" checkbox in the "E&MSection" pane
		And I click the "Select Roles" button
		Then the following fields should display in the "E&MSection" pane
			|Name                   |Type   |
			|OkRolesSelection       |button |
			|CancelRolesSelection   |button |
		When I select "Biller" from the "Roles" dropdown
		And I click the "CancelRolesSelection" button
		Then the text "Biller" should not appear in the "SelectRoles" section in the "E&MSection" pane
		When I click the "Select Roles" button
		And I select "Biller" from the "Roles" dropdown
		And I click the "OkRolesSelection" button
		And I click the "RemoveRoleSelection" image
		Then the text "Biller" should not appear in the "SelectRoles" section in the "E&MSection" pane
		When I click the "SelectRoles" button
		And I select "Biller" from the "Roles" dropdown
		And I click the "OkRolesSelection" button in the "E&MSection" pane
		Then the text "Biller" should appear in the "SelectRoles" section in the "E&MSection" pane
		And I fill in the following fields
			|Name      |Type  |Value |
			|CPT1      |text  |86000 |
			|CPT2      |text  |86000 |
			|CPT3      |text  |86000 |
			|Modifier1 |text  |21    |
			|Modifier2 |text  |22    |
			|Modifier3 |text  |23    |
		And I enter "" in the "Quantity1" field in the "E&MSection" pane
		And I click the "AddCPT" image in the "E&MSection" pane
		And the following fields should display in the "E&MSection" pane
			|CPT4|
		And I click the "RemoveCPT" image in the "E&MSection" pane
		And the following fields should not display in the "E&MSection" pane
			|CPT4|
		And I create new field rule "Field1" by selecting "1" as level selector
		And I click the "Save Settings" button in the "E&M Section" pane
		Then the section "TBT Roles" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Verifying the Fields in the E&M Section page
		Given I am on the manage sections page
		And the section "TBT Fields" not in the sections list
		When I am on the "E&M" add section page
		And I enter "TBT Fields" in the "Display Label" field in the "E&MSection" pane
		And I enter "TBT Fields" in the "Description" field in the "E&MSection" pane
		And I check the "active" checkbox in the "E&MSection" pane
		And I fill in the following fields
			|Name      |Type  |Value  |
			|CPT1      |text  |99220  |
			|CPT2      |text  |99221  |
			|CPT3      |text  |99222  |
		And the following text should appear in the "E&MSection" pane
			|Field        |
			|Option/Level |
			|Selected     |
		When I click the "Select From Dictionary" button
	 #Should verify the links for the below steps
		Then the "Dictionary List" table should load
		And I wait "2" seconds
		And I enter "medicine" in the "SearchAddField" field
		And the following fields should display in the "DictionaryAddField" pane
			|Name                |Type    |
			|OKFieldSelect       |button  |
			|CancelFieldSelect   |button  |
			|FieldDescription    |element |
			|Categories          |element |
		And I click the "OKFieldSelect" button
		And I click the "Select From Dictionary" button
		Then the "Dictionary Add Field" pane should load
#		And I wait for loading to complete
		And I wait up to "20" seconds for the "Processing Dictionary List" field of type "MISC_ELEMENT" to be invisible
		And I select "1-4 Years preventive medicine, Established patient" in the "Dictionary List" table
		And I click the "CancelFieldSelect" button
		Then the text "1-4 Years preventive medicine" should not appear in the "FieldRules" section in the "E&MSection" pane
		And I click the "Select From Dictionary" button
		Then the "Dictionary Add Field" pane should load
		And I wait up to "20" seconds for the "Processing Dictionary List" field of type "MISC_ELEMENT" to be invisible
		And I select "1-4 Years preventive medicine, Established patient" in the "Dictionary List" table
		And I click the "OKFieldSelect" button
		Then the "FieldRules" table should have "1" row containing the text "1-4 Years preventive medicine"
		And I select "1" from the "LevelSelector" dropdown
		And I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And the section "TBT Fields" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Verifying the Level Selector in E&M Section page
		Given I am on the manage sections page
		And the section "TBT FieldSelect" not in the sections list
		When I am on the "E&M" add section page
		And I enter "TBT FieldSelect" in the "Display Label" field
		And I enter "TBT FieldSelect" in the "Description" field
		And I check the "active" checkbox in the "E&M Section" pane
		And I fill in the following fields
			| Name | Type | Value |
			| CPT1 | text | 99220 |
			| CPT2 | text | 99221 |
			| CPT3 | text | 99222 |
		And I wait up to "6" seconds for the "Processing Dictionary List" field of type "MISC_ELEMENT" to be invisible
		And I add the "18-39 Years preventive medicine, New patient" field from dictionary by selecting "C" as level selector
		Then the following options should be available in the "LevelSelector" dropdown
			|   |
			| 1 |
			| 2 |
			| 3 |
			| C |
		And the following fields should display in the "E&M Section" pane
			| Name        | Type    |
			| ReorderIcon | element |
		When I click the "RemoveCPT3" image in the "E&MSection" pane
		Then the text "99222" should not appear in the "E&MSection" pane
		When I click the "RemoveCPT2" image in the "E&MSection" pane
		Then the text "99221" should not appear in the "E&MSection" pane
		Then the following options should be available in the "LevelSelector" dropdown
			|   |
			| 1 |
			| C |
		And I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And the section "TBT FieldSelect" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Create New Field and Group in E&M section
		Given I am on the manage sections page
		And the section "TBTGroup" not in the sections list
		And I am on the "E&M" add section page
		And I enter "TBTGroup" in the "Display Label" field
		And I enter "TechBill Group" in the "Description" field
		And I check the "active" checkbox in the "E&M Section" pane
		And I fill in the following fields
			|Name      |Type  |Value  |
			|CPT1      |text  |99220  |
			|CPT2      |text  |99221  |
			|CPT3      |text  |99222  |
		And I click the "Group" button
		Then the "FieldRules" table should have "0" row not containing the text "New Group"
		And I create new field rule "Field1" by selecting "1" as level selector
		And I select "Field1" in the "FieldRules" table
		And I click the "Group" button
		Then the "FieldRules" table should have "1" row containing the text "New Group"
		And I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And the section "TBTGroup" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Create Multiple Fields and Groups in E&M section
		Given I am on the manage sections page
		And the section "TBT Multi Group" not in the sections list
		And I am on the "E&M" add section page
		And I enter "TBT Multi Group" in the "Display Label" field
		And I enter "TechBill Multi Group" in the "Description" field
		And I check the "active" checkbox in the "E&M Section" pane
		And I fill in the following fields
			|Name      |Type  |Value  |
			|CPT1      |text  |99220  |
			|CPT2      |text  |99221  |
			|CPT3      |text  |99222  |
		And I create new field rule "Field1" by selecting "1" as level selector
		And I create new field rule "Field2" by selecting "2" as level selector
		When I select "Field1" in the "FieldRules" table
		And I click the "Group" button
		Then the "FieldRules" table should have "1" row containing the text "New Group"
		When I select "Field2" in the "FieldRules" table
		And I click the "Group" button
		Then the "FieldRules" table should have "1" row containing the text "New Group1"
		And I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And the section "TBT Multi Group" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Rename Group in E&M section
		Given I am on the manage sections page
		And the section "TBT Rename Group" not in the sections list
		And I am on the "E&M" add section page
		And I enter "TBT Rename Group" in the "Display Label" field
		And I enter "TechBill Rename Group" in the "Description" field
		And I check the "active" checkbox in the "E&M Section" pane
		And I fill in the following fields
			|Name      |Type  |Value  |
			|CPT1      |text  |99220  |
			|CPT2      |text  |99221  |
			|CPT3      |text  |99222  |
		And I create new field rule "Field1" by selecting "1" as level selector
		When I select "Field1" in the "FieldRules" table
		And I click the "Group" button
		Then the "FieldRules" table should have "1" row containing the text "New Group"
		When I click the "New Group" link in the "E&M Section" pane
		And I clear and enter "" in the "Field Group Edit" field in the "E&M Section" pane
		And I click the "OKGroupEdit" button
		Then the "FieldRules" table should have "1" row containing the text "New Group"
		When I click the "New Group" link in the "E&M Section" pane
		And I clear and enter "Revised Group" in the "Field Group Edit" field
		And I click the "OKGroupEdit" button
		Then the "FieldRules" table should have "1" row containing the text "Revised Group"
		And I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And the section "TBT Rename Group" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Add E&M section selecting from Dictionary
		Given I am on the manage sections page
		And the section "TBT Dictionary" not in the sections list
		And I am on the "E&M" add section page
		And I enter "TBT Dictionary" in the "Display Label" field
		And I enter "TechBill Dictionary" in the "Description" field
		And I check the "active" checkbox in the "E&M Section" pane
		And I fill in the following fields
			|Name      |Type  |Value  |
			|CPT1      |text  |99220  |
			|CPT2      |text  |99221  |
			|CPT3      |text  |99222  |
		And I click the "Select From Dictionary" button
		Then the "Dictionary Add Field" pane should load
		And I wait up to "20" seconds for the "Processing Dictionary List" field of type "MISC_ELEMENT" to be invisible
		And I select "1-4 Years preventive medicine, Established patient" in the "Dictionary List" table
		And I click the "OKFieldSelect" button
		Then the "FieldRules" table should have "1" row containing the text "1-4 Years preventive medicine"
		And I select "1" from the "LevelSelector" dropdown
		And I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And the section "TBT Dictionary" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close