@TechBilling
Feature: Edit E&M

	Background:
		Given I am logged into the portal with user "techbilluser1" using the default password
		And I am on the "Admin" tab
	
	Scenario: Edit E&M Section display
		Given I am on the manage sections page
		And I enter "TBTAU" in the "SearchSection" field
		And I click the "EditLink" element
		Then the "E&M Section" pane should load
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
		And the value in the "Display Label" field should be "TBTAU"
		And the value in the "Description" field should be "TechBill to Test Active Uncheck"
		And the following should be unchecked in the "E&M Section" pane
			|active |
		And the value in the "CPT1" field should be "99220"
		And the value in the "CPT2" field should be "99221"
		And the value in the "CPT3" field should be "99222"
		And the value in the "Modifier1" field should be "24"
		And the value in the "Modifier2" field should be "25"
		And the value in the "Modifier3" field should be "26"
		And the value in the "Quantity1" field should be "1"
		When I click the "Close" image in the "E&M Section" pane
		Then the "E&M Section" pane should close
		When I click the "Close Section" button
		Then the "Sections List" pane should close
	
	Scenario: Cancel Edit E&M Section
		Given I am on the manage sections page
		And I enter "TBTAU" in the "SearchSection" field
		And I click the "EditLink" element
		Then the "E&M Section" pane should load
		And I enter "TBT EDIT AU" in the "Display Label" field
		And I enter "Edit TechBill to Test Active Uncheck" in the "Description" field
		And I check the "active" checkbox in the "E&M Section" pane
		And the following should be checked in the "E&M Section" pane
			|active |
		And I fill in the following fields
			|Name      |Type  |Value |
			|CPT1      |text  |99201 |
			|CPT2      |text  |99202 |
			|CPT3      |text  |99203 |
			|Modifier1 |text  |21    |
			|Modifier2 |text  |22    |
			|Modifier3 |text  |23    |
		When I click the "Close" image in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And the section "TBTAU" should display with no active X in the section list
		And the "Sections" table should have "1" row not containing the text "TBT EDIT AU"
		And the "Sections" table should have "1" row not containing the text "Edit TechBill to Test Active Uncheck"
		When I click the "Close Section" button
		Then the "Sections List" pane should close
	
	Scenario: Save Edit E&M Section with Active Checked
		Given I am on the manage sections page
		And I enter "TBTAU" in the "SearchSection" field
		And I click the "EditLink" element
		Then the "E&M Section" pane should load
		And I enter "TBT EDIT AC" in the "Display Label" field
		And I enter "Edit TechBill to Test Active Check" in the "Description" field
		And I check the "active" checkbox in the "E&M Section" pane
		And the following should be checked in the "E&M Section" pane
			|active |
		And I fill in the following fields
			|Name      |Type  |Value |
			|CPT1      |text  |99201 |
			|CPT2      |text  |99202 |
			|CPT3      |text  |99203 |
			|Modifier1 |text  |21    |
			|Modifier2 |text  |22    |
			|Modifier3 |text  |23    |
		And I create new field rule "Edit Field1" by selecting "1" as level selector
		When I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And the section "TBT EDIT AC" should display with active X in the section list
		And the "Sections" table should have "1" row containing the text "Edit TechBill to Test Active Check"
		When I click the "Close Section" button
		Then the "Sections List" pane should close
	
	Scenario: Save Edit E&M Section with Active Unchecked
		Given I am on the manage sections page
		And I enter "TBT EDIT AC" in the "SearchSection" field
		And I click the "EditLink" element
		Then the "E&M Section" pane should load
		And I enter "TBT EDIT AU" in the "Display Label" field
		And I enter "Edit TechBill to Test Active Uncheck" in the "Description" field
		And I uncheck the "active" checkbox in the "E&M Section" pane
		And the following should be unchecked in the "E&M Section" pane
			|active |
		When I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And the section "TBT EDIT AU" should display with no active X in the section list
		And the "Sections" table should have "1" row containing the text "Edit TechBill to Test Active Uncheck"
		When I click the "Close Section" button
		Then the "Sections List" pane should close
	
	Scenario: Save Edit E&M Section with CPT Modifiers and Quantity fields
		Given I am on the manage sections page
		And I enter "TBT EDIT AU" in the "SearchSection" field
		And I click the "EditLink" element
		Then the "E&M Section" pane should load
		And I fill in the following fields
			|Name      |Type  |Value |
			|CPT1      |text  |99211 |
			|CPT2      |text  |99212 |
			|CPT3      |text  |99213 |
			|Modifier1 |text  |51    |
			|Modifier2 |text  |52    |
			|Modifier3 |text  |53    |
			|Quantity1 |text  |2     |
			|Quantity2 |text  |3     |
			|Quantity3 |text  |4     |
		When I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And I enter "TBT EDIT AU" in the "SearchSection" field
		And I click the "EditLink" element
		And the value in the "CPT1" field should be "99211"
		And the value in the "CPT2" field should be "99212"
		And the value in the "CPT3" field should be "99213"
		And the value in the "Modifier1" field should be "51"
		And the value in the "Modifier2" field should be "52"
		And the value in the "Modifier3" field should be "53"
		And the value in the "Quantity1" field should be "2"
		And the value in the "Quantity2" field should be "3"
		And the value in the "Quantity3" field should be "4"
		When I click the "Close" image in the "E&M Section" pane
		Then the "E&M Section" pane should close
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Select Locations in Edit E&M Section
		Given I am on the manage sections page
        And I add "TBT EDIT AU" section in the E&M Section pane
		And I fill in the following fields
			|Name |Type |Value |
			|CPT1 |text |86000 |
			|CPT2 |text |86000 |
			|CPT3 |text |86000 |
		And I click the "Save Settings" button in the "E&M Section" pane
        And I enter "TBT EDIT AU" in the "SearchSection" field
		And I click the "EditLink" element
		Then the "E&M Section" pane should load
		And I enter "TBT EDIT Locations" in the "Display Label" field
		And I check the "active" checkbox in the "E&M Section" pane
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
		And I create new field rule "Edit Location1" by selecting "1" as level selector
		And I click the "Save Settings" button in the "E&M Section" pane
		Then the section "TBT EDIT Locations" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Select Roles in Edit E&M Section
		Given I am on the manage sections page
		And I enter "TBT EDIT Locations" in the "SearchSection" field
		And I click the "EditLink" element
		Then the "E&M Section" pane should load
		And I enter "TBT EDIT Roles" in the "Display Label" field
		And I click the "Select Roles" button
		Then the following fields should display in the "E&MSection" pane
			|Name                   |Type   |
			|OkRolesSelection       |button |
			|CancelRolesSelection   |button |
		And the text "Admin" should appear in the "SelectRolesPopup" section in the "E&MSection" pane
		And the text "Biller" should appear in the "SelectRolesPopup" section in the "E&MSection" pane
		And the text "PROVIDER" should appear in the "SelectRolesPopup" section in the "E&MSection" pane
		And the text "Referring" should appear in the "SelectRolesPopup" section in the "E&MSection" pane
		And the text "USER" should appear in the "SelectRolesPopup" section in the "E&MSection" pane
		When I select "USER" from the "Roles" dropdown
		And I click the "CancelRolesSelection" button
		Then the text "USER" should not appear in the "SelectRoles" section in the "E&MSection" pane
		When I click the "Select Roles" button
		And I select "USER" from the "Roles" dropdown
		And I click the "OkRolesSelection" button
		Then the text "USER" should appear in the "SelectRoles" section in the "E&MSection" pane
		When I click the "RemoveRoleSelection" image
		Then the text "Biller" should not appear in the "SelectRoles" section in the "E&MSection" pane
		When I click the "SelectRoles" button
		And I select "USER" from the "Roles" dropdown
		And I click the "OkRolesSelection" button in the "E&MSection" pane
		Then the text "USER" should appear in the "SelectRoles" section in the "E&MSection" pane
		And I click the "Save Settings" button in the "E&M Section" pane
		Then the section "TBT EDIT Roles" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close
		
	Scenario: Add and Remove Levels in Edit E&M Section
		Given I am on the manage sections page
		And I enter "TBT EDIT Roles" in the "SearchSection" field
		And I click the "EditLink" element
		Then the "E&M Section" pane should load
		And I enter "TBT EDIT Levels" in the "Display Label" field
		And I click the "AddCPT" image in the "E&MSection" pane
		And the following fields should display in the "E&MSection" pane
			|CPT4|
		And I click the "RemoveCPT" image in the "E&MSection" pane
		And the following fields should not display in the "E&MSection" pane
			|CPT4|
		And I click the "Save Settings" button in the "E&M Section" pane
		Then the section "TBT EDIT Levels" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close
	
	Scenario: Edit E&M Section Field verification
		Given I am on the manage sections page
		And I enter "TBT EDIT Levels" in the "SearchSection" field
		And I click the "EditLink" element
		Then the "E&M Section" pane should load
		And the following text should appear in the "E&MSection" pane
			| Field        |
			| Option/Level |
			| Selected     |
		And the "FieldRules" table should have "1" row containing the text "Edit Location1"
		When I click the "Select From Dictionary" button
		Then the "Dictionary List" table should load
		And the following fields should display in the "DictionaryAddField" pane
			| Name              | Type    |
			| OKFieldSelect     | button  |
			| CancelFieldSelect | button  |
			| FieldDescription  | element |
			| Categories        | element |
		When I click the "CancelFieldSelect" button
		And I click the "Select From Dictionary" button
		Then the "Dictionary Add Field" pane should load
		And I wait up to "6" seconds for the "Processing Dictionary List" field of type "MISC_ELEMENT" to be invisible
		And I select "1-4 Years preventive medicine, Established patient" in the "Dictionary List" table
		And I click the "CancelFieldSelect" button in the "Dictionary Add Field" pane
		And I add the "1-4 Years preventive medicine, Established patient" field from dictionary by selecting "1" as level selector
		Then the following options should be available in the "LevelSelector" dropdown
			|   |
			| 1 |
			| 2 |
			| 3 |
			| C |
		And the following fields should display in the "E&M Section" pane
			| Name        | Type    |
			| ReorderIcon | element |
			| RemoveField | element |
	   #deleting the 1st field.
		When I click the "RemoveField" element
#		Then the following should be unchecked in the "E&M Section" pane
#			|SelectField |
		When I check the "SelectField" checkbox in the "E&M Section" pane
		And I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		When I enter "TBT EDIT Levels" in the "SearchSection" field
		And I click the "Edit Link" element
		Then the "FieldRules" table should have "1" row containing the text "1-4 Years preventive medicine, Established patient"
		When I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And the section "TBT EDIT Levels" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Edit E&M Section Reorder and new group verification
		Given I am on the manage sections page
		When I enter "TBT EDIT Levels" in the "SearchSection" field
		And I click the "EditLink" element
		Then the "E&M Section" pane should load
		When I click the "Select From Dictionary" button
		Then the "Dictionary List" table should load
		When I select "1-4 Years preventive medicine, New patient" in the "Dictionary List" table
		And I select "18-39 Years preventive medicine, Established patient" in the "Dictionary List" table
		And I click the "OKFieldSelect" button in the "Dictionary Add Field" pane
		Then the "FieldRules" table should load
	   #    Added again below step because to select level selector
		And I add the "1-4 Years preventive medicine, New patient" field from dictionary by selecting "1" as level selector
		And I add the "18-39 Years preventive medicine, Established patient" field from dictionary by selecting "1" as level selector
		And the "FieldRules" table should have "1" row containing the text "1-4 Years preventive medicine, New patient"
		And the "FieldRules" table should have "1" row containing the text "18-39 Years preventive medicine, Established patient"
		And I click the "Group" button
		Then the "FieldRules" table should have at least "1" row not containing the text "New Group"
		When I select "18-39 Years preventive medicine, Established patient" in the "FieldRules" table
		When I click the "Group" button
		Then the "FieldRules" table should have "1" row containing the text "New Group"
		When I click the "New Group" link in the "E&M Section" pane
		And I clear and enter "" in the "Field Group Edit" field
		And I click the "OKGroupEdit" button
		And I select "1-4 Years preventive medicine, New patient" in the "FieldRules" table
		And I click the "Group" button
		Then the "FieldRules" table should have at least "2" row containing the text "New Group"
		When I click the "New Group" link in the "E&M Section" pane
		And I clear and enter "New Group1" in the "Field Group Edit" field
		And I click the "OKGroupEdit" button
		And I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		When I enter "TBT EDIT Levels" in the "SearchSection" field
		And I click the "EditLink" element
		And I select "1-4 Years preventive medicine, New patient" in the "FieldRules" table
		And I click the "Group" button
		Then the "FieldRules" table should have at least "1" row containing the text "New Group"
		When I click the "New Group" link in the "E&M Section" pane
		And I clear and enter "New Group" in the "Field Group Edit" field
		And I click the "OKGroupEdit" button
		And I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And the section "TBT EDIT Levels" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Edit E&M Section Relation Levels verification
		Given I am on the manage sections page
		When I enter "TBT EDIT Levels" in the "SearchSection" field
		And I click the "EditLink" element
		Then the "E&M Section" pane should load
		And the following options should be available in the "LevelSelector" dropdown
			|  |
			|1 |
			|2 |
			|3 |
			|C |
		When I click the "RemoveCPT3" image in the "E&MSection" pane
		Then the following options should be available in the "LevelSelector" dropdown
			|  |
			|1 |
			|2 |
			|C |
		When I click the "RemoveCPT2" image in the "E&MSection" pane
		Then the following options should be available in the "LevelSelector" dropdown
			|  |
			|1 |
			|C |
		When I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And the section "TBT EDIT Levels" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close
	
	#to delete all the newly created sections from the list to clean up
	Scenario: Delete all the newly added E&M sections from the list
		Given I am on the manage sections page
		And the section "TBT" not in the sections list
		And the text "No matching records found" should appear in the "Sections List" pane
		And I click the "Close Section" button
		Then the "Sections List" pane should close
