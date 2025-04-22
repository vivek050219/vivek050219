@TechBilling
Feature: Copy and Delete E&M

	Background:
		Given I am logged into the portal with user "techbilluser1" using the default password
		And I am on the "Admin" tab
	
	Scenario: Copy E&M Section display
		Given I am on the manage sections page
		And I enter "TBTAU" in the "SearchSection" field
		And I click the "CopyLink" element
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
		When I click the "Save Settings" button in the "E&M Section" pane
		Then the "Error Information" pane should load
		And the following text should appear in the "Error Information" pane
			|Please fix the errors:     |
			|-Missing properties data.  |
		When I click the "OKErrorInfo" button
		And I click the "Close" image in the "E&M Section" pane
		Then the "E&M Section" pane should close
		When I click the "Close Section" button
		Then the "Sections List" pane should close
		
	Scenario: Copy E&M Section with Active uncheck
		Given I am on the manage sections page
		And the section "TBTCPYAU" not in the sections list
		And I enter "TBTAU" in the "SearchSection" field
		And I click the "CopyLink" element
		Then the "E&M Section" pane should load
		And I enter "TBTCPYAU" in the "Display Label" field
		And I enter "TechBill Copy Active Uncheck" in the "Description" field
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
		And the section "TBTCPYAU" should display with no active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close
	
	Scenario: Copy E&M Section with Active check
		Given I am on the manage sections page
		And the section "TBTCPYAC" not in the sections list
		And I enter "TBTAC" in the "SearchSection" field
		And I click the "CopyLink" element
		And the "E&M Section" pane should load
		And I enter "TBTCPYAC" in the "Display Label" field
		And I enter "TechBill Copy Active Check" in the "Description" field
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
		And I create new field rule "CPYField1" by selecting "1" as level selector
		When I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And the section "TBTCPYAC" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close
		
	Scenario: Select Locations in the COPY E&M Section
		Given I am on the manage sections page
		And the section "TBT Copy Locations" not in the sections list
		And I enter "TBTAC" in the "SearchSection" field
		And I click the "CopyLink" element
		And I enter "TBT Copy Locations" in the "Display Label" field in the "E&MSection" pane
		And I enter "TBT Copy Locations" in the "Description" field in the "E&MSection" pane
		And I check the "active" checkbox in the "E&MSection" pane
		And I fill in the following fields
			|Name      |Type  |Value |
			|CPT1      |text  |99220 |
			|CPT2      |text  |99221 |
			|CPT3      |text  |99222 |
		And I click the "Select Locations" button
		Then the following fields should display in the "E&MSection" pane
			|Name                      |Type   |
			|OklocationSelection       |button |
			|CancellocationSelection   |button |
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
		And I create new field rule "CPYLocation1" by selecting "1" as level selector
		And I click the "Save Settings" button in the "E&M Section" pane
		Then the section "TBT Copy Locations" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close
		
	Scenario: Select Roles in the Copy E&M Section page
		Given I am on the manage sections page
		And the section "TBTCPY Roles" not in the sections list
		And I enter "TBTAC" in the "SearchSection" field
		And I click the "CopyLink" element
		And I enter "TBTCPY Roles" in the "Display Label" field in the "E&MSection" pane
		And I enter "TBTCPY Roles" in the "Description" field in the "E&MSection" pane
		And I check the "active" checkbox in the "E&MSection" pane
		And I click the "Select Roles" button
		Then the following fields should display in the "E&MSection" pane
			|Name                   |Type    |
			|OkRolesSelection       |button  |
			|CancelRolesSelection   |button  |
			|XRolesSelection        |element |
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
		Then the following fields should display in the "E&MSection" pane
			|CPT4|
		When I click the "RemoveCPT" image in the "E&MSection" pane
		Then the following fields should not display in the "E&MSection" pane
			|CPT4|
		When I create new field rule "CPYField1" by selecting "1" as level selector
		And I click the "Save Settings" button in the "E&M Section" pane
		Then the section "TBTCPY Roles" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Verifying the Fields in the Copy E&M Section page
		Given I am on the manage sections page
		And the section "TBTCPY Fields" not in the sections list
		And I enter "TBTAC" in the "SearchSection" field
		And I click the "CopyLink" element
		And I enter "TBTCPY Fields" in the "Display Label" field in the "E&MSection" pane
		And I enter "TBTCPY Fields" in the "Description" field in the "E&MSection" pane
		And I check the "active" checkbox in the "E&MSection" pane
		And I fill in the following fields
			|Name      |Type  |Value  |
			| CPT1 | text | 99220 |
			| CPT2 | text | 99221 |
			| CPT3 | text | 99222 |
		And the following text should appear in the "E&MSection" pane
			| Field        |
			| Option/Level |
			| Selected     |
		And I click the "Select From Dictionary" button
		Then the "Dictionary List" table should load
		When I enter "medicine" in the "SearchAddField" field
		And the following fields should display in the "DictionaryAddField" pane
			| Name              | Type    |
			| OKFieldSelect     | button  |
			| CancelFieldSelect | button  |
			| FieldDescription  | element |
			| Categories        | element |
		And I click the "OKFieldSelect" button
		And I click the "Select From Dictionary" button
		Then the "Dictionary Add Field" pane should load
#		And I wait for loading to complete
		And I wait up to "6" seconds for the "Processing Dictionary List" field of type "MISC_ELEMENT" to be invisible
		When I select "1-4 Years preventive medicine, Established patient" in the "Dictionary List" table
		And I click the "CancelFieldSelect" button
		Then the text "1-4 Years preventive medicine" should not appear in the "FieldRules" section in the "E&MSection" pane
		And I wait up to "6" seconds for the "Processing Dictionary List" field of type "MISC_ELEMENT" to be invisible
		When I add the "1-4 Years preventive medicine, Established patient" field from dictionary by selecting "1" as level selector
		And I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And the section "TBTCPY Fields" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Verifying the modifiers and field in the Copy E&M Section
		Given I am on the manage sections page
		And the section "TBTCPY Modifiers" not in the sections list
		And I enter "TBTAC" in the "SearchSection" field
		And I click the "CopyLink" element
		And I enter "TBTCPY Modifiers" in the "Display Label" field
		And I enter "TBTCPY Modifiers" in the "Description" field
		And I check the "active" checkbox in the "E&M Section" pane
		And I fill in the following fields
			|Name      |Type  |Value  |
			|CPT1      |text  |99220  |
			|CPT2      |text  |99221  |
			|CPT3      |text  |99222  |
			|Modifier1 |text  |21     |
			|Modifier2 |text  |22     |
			|Modifier3 |text  |23     |
		And I click the "ModifierLookUp1" image in the "E&MSection" pane
		And I click the "OkSection" button
		And I enter "" in the "Quantity1" field
		And I wait for loading to complete
		And I add the "18-39 Years preventive medicine, New patient" field from dictionary by selecting "C" as level selector
		Then the following fields should display in the "E&M Section" pane
			|Name          |Type    |
			|ReorderIcon   |element |
			|AddCPT     |image   |
			|RemoveCPT3  |image   |
		When I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And the section "TBTCPY Modifiers" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Create new Field and new Group in Copy E&M section
		Given I am on the manage sections page
		And the section "TBTCPY Group" not in the sections list
		And I enter "TBTAC" in the "SearchSection" field
		And I click the "CopyLink" element
		And I enter "TBTCPY Group" in the "Display Label" field
		And I enter "TBTCPY Group" in the "Description" field
		And I check the "active" checkbox in the "E&M Section" pane
		And I fill in the following fields
			|Name      |Type  |Value  |
			|CPT1      |text  |99220  |
			|CPT2      |text  |99221  |
			|CPT3      |text  |99222  |
		When I click the "Create New" button
		Then the following should be unchecked in the "E&M Section" pane
			|VariableQuantity |
			|AdvancedOptions  |
		When I click the "CancelAddField" button
		And I create new field rule "CPYField1" by selecting "1" as level selector
		And I select "CPYField1" in the "FieldRules" table
		And I click the "Group" button
		Then the "FieldRules" table should have "1" row containing the text "New Group"
		When I click the "New Group" link in the "E&M Section" pane
		And I clear and enter "" in the "Field Group Edit" field
		And I click the "OKGroupEdit" button
		And I click the "Save Settings" button in the "E&M Section" pane
		Then the "E&M Section" pane should close
		And the section "TBTCPY Group" should display with active X in the section list
		When I click the "Close Section" button
		Then the "Sections List" pane should close

	Scenario: Delete E&M Section
		Given I am on the manage sections page
		And I enter "TBTCPYAC" in the "SearchSection" field
		When I click the "DeleteLink" button in the "Sections List" pane
		And I click the "CancelDeleteSection" button
		Then the "Sections" table should have "1" row containing the text "TBTCPYAC"
		And I click the "DeleteLink" button in the "Sections List" pane
		And I click the "OKDeleteSection" button
		Then the text "No matching records found" should appear in the "Sections List" pane