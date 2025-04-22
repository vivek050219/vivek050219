Feature: System Management
	System Management subtab under Admin
	
	Background:
		#Given I am logged into the portal with the default user
		Given I am logged into the portal with user "pkadminv2" using the default password
		And I am on the "Admin" tab
		And I select the "System Management" subtab
	
	@BuildVerificationTest @PortalSmoke
	Scenario: Loading of the System Management subtab
		Then the following links should display in the "System Management Navigation" pane
			|Reference Lists           |
			|Providers                 |
			|Relationships             |
			|Audit Report              |
			|PK Visit Types            |
			|ADT Visit Types           |
			|Misc                      |
			|Import Provider Directory |
			|XML Customizations        |
			|External Systems          |
			|Self Assign Report        |
			|Broadcast Message         |
			|Handheld Devices          |
			|Purge Criteria            |
			|Vitals Edit               |
			|PQRS Measures             |
			|PQRS Measure Import       |
			|SQL Logging Config        |
			|View Notices              |
		
	@BuildVerificationTest @PortalSmoke
	Scenario: Loading of the Reference Lists content
		When I click the "Reference Lists" link in the "System Management Navigation" pane
		Then the "Reference List Maintenance" pane should load
		
	@BuildVerificationTest
	Scenario: Loading of the Providers pane
		When I click the "Providers" link in the "System Management Navigation" pane
		Then the "Provider Maintenance" pane should load
		
	@BuildVerificationTest @PortalSmoke
	Scenario: Loading of the PK Visit Types pane
		When I click the "PK Visit Types" link in the "System Management Navigation" pane
		Then the "PK Visit Type Maintenance" pane should load
	
	@BuildVerificationTest @PortalSmoke
	Scenario: Loading of the ADT Visit Types pane
		When I click the "ADT Visit Types" link in the "System Management Navigation" pane
		Then the "ADT Visit Type Maintenance" pane should load
		
	@BuildVerificationTest
	Scenario: Title and Build tag verification
		When I click the "Misc" link in the "System Management Navigation" pane
		Then the text "%Version%(%Build Tag%)" should appear in the "Web System Control" pane

	# All the following scenarios are developed by Offshore team====
	@PortalSmoke
	Scenario: Create a New Provider Group
		When I click the "Provider Groups" link in the "System Management Navigation" pane
		Then the "Provider Group Maintenance" pane should load
		Given the provider group "PG_1234" is not in the provider group list
		And I click the "Create New Provider Group" button
		When I enter "PG_1234" in the "Provider Group Name" field in the "Enter Provider Group Name" pane
		And I click the "OK" button in the "Enter Provider Group Name" pane
		Then the provider group "PG_1234" should appear in the list
		When I select the provider group "PG_1234" in the list
		And I click the "Delete Selected Provider Group" button
		And I click the "Yes" button in the "Question" pane
		Then the provider group "PG_1234" should not appear in the list

	@PortalSmoke @donotrun
	Scenario: Add and Delete Provider to Group
		#Check providers availability by navigating to the Providers pane, Since need to add providers to Provider Group
		When I click the "Providers" link in the "System Management Navigation" pane
		Given the provider with firstname "AUTO" and lastname "PROVIDER%Current Date%" is in the provider list
		And the provider with firstname "AUTO" and lastname "PROVIDER" is in the provider list
		And I click the "Provider Groups" link in the "System Management Navigation" pane
		#Check Provider groups are in the provider group list
		And the provider group "PG_1234" is in the provider group list
		And the provider group "testprovidergroup" is in the provider group list
		And I select the provider group "PG_1234" in the list
		And I click the "Add Provider To Group" button
		And I wait "2" seconds
		Then the "Add Provider to Group" pane should load
		#Search for provider(s) by role
		When I search for provider "PROVIDER" by "PROVIDER" role in the "Provider Search" pane
		Then the "Add Provider Search Results" table should load
		#Select the provider(s) by FullName
		And I select provider "PROVIDER%Current Date%, AUTO" in the "Add Provider Search Results" pane
		And I select provider "PROVIDER, AUTO" in the "Add Provider Search Results" pane
		And I click the "Add" button in the "Add Provider to Group" pane
		And I click the "Close" button in the "Add Provider to Group" pane
		And I click the "Save" button in the "Provider Group Detail" pane
		When I select the provider group "PG_1234" in the list
		Then the provider "PROVIDER, AUTO" should appear in the provider group detail list
		And the provider "PROVIDER%Current Date%, AUTO" should appear in the provider group detail list
		When I click the "Remove Provider" image in the "Provider Group Detail" pane
		Then the provider "PROVIDER, AUTO" should not appear in the provider group detail list
		When I select the provider group "testprovidergroup" in the list
		Then the text "You have made changes to the current Provider Group." should appear in the "Question" pane
		When I click the "No" button in the "Question" pane
		And I select the provider group "PG_1234" in the list
		Then the provider "PROVIDER, AUTO" should appear in the provider group detail list
		And the provider "PROVIDER%Current Date%, AUTO" should appear in the provider group detail list
		When I click the "Remove Provider" image in the "Provider Group Detail" pane
		Then the provider "PROVIDER, AUTO" should not appear in the provider group detail list
		When I select the provider group "testprovidergroup" in the list
		Then the text "You have made changes to the current Provider Group." should appear in the "Question" pane
		When I click the "Yes" button in the "Question" pane
		And I select the provider group "PG_1234" in the list
		Then the provider "PROVIDER, AUTO" should not appear in the provider group detail list
		And the provider "PROVIDER%Current Date%, AUTO" should appear in the provider group detail list
		
	@PortalSmoke @donotrun
	Scenario: Edit Providers and Merge
		When I click the "Providers" link in the "System Management Navigation" pane
		Then the "Provider Maintenance" pane should load
		#Check providers are in the provider list
		Given the provider with firstname "AUTO" and lastname "PROVIDER%Current Date%" is in the provider list
		And the provider with firstname "AUTO" and lastname "PROVIDER" is in the provider list
		And I search for provider "PROVIDER, AUTO" by "Referring" role in the "Provider Main" pane
		Then the text "No results found." should appear in the "Provider Referring" pane
		When I search for provider "PROVIDER, AUTO" by "PROVIDER" role in the "Provider Main" pane
		Then the "Provider Main Search Results" table should load
		When I select provider "PROVIDER, AUTO" in the "Provider Main Search" pane
		And I click the "Edit" button in the "Provider Details" pane
		And I wait "2" seconds
		Then the "Edit Provider" pane should load
		When I enter "pkaddress123" in the "Provider Address" field
		And I enter "pkcity123" in the "Provider City" field
		And I enter "1234567890" in the "Provider Home Phone" field
		And I click the "Save" button in the "Edit Provider Detail" pane
		Then the "Edit Provider" pane should close
		And the text "pkaddress" should appear in the "Provider Details" pane
		And the text "pkcity" should appear in the "Provider Details" pane
		And the text "1234567890" should appear in the "Provider Details" pane
		When I click the "Merge" button
		And I wait "2" seconds
		Then the "Merge Provider" pane should load
		And the "Merge Survivor" pane should load
		And the "Merge Candidate" pane should load
		And the text "PROVIDER" should appear in the "Merge Survivor Detail" pane
		When I search for provider "AUTO, USER" by "USER" role in the "Search Merge Candidate" pane
		Then the "Merge Candidate Results" pane should load
		When I select provider "AUTO, USER" in the "Merge Candidate Results" pane
		Then the text "You cannot merge this provider because they are a PatientKeeper user." should appear in the "Warning" pane
		When I click the "OK" button in the "Warning" pane
		And I click the "Close" button in the "Merge Candidate" pane
		And I click the "Merge" button
		And I wait "2" seconds
		When I search for provider "PROVIDER%Current Date%, AUTO" by "PROVIDER" role in the "Search Merge Candidate" pane
		And I select provider "PROVIDER%Current Date%, AUTO" in the "Merge Candidate Results" pane
		Then the text "PROVIDER%Current Date%" should appear in the "Merge Candidate Detail" pane
		When I click the "Perform Merge" button in the "Merge Candidate" pane
		And I wait "2" seconds
		Then the "Resolve Alias Conflicts" pane should load
		When I click the "Perform Merge" button in the "Resolve Alias Conflicts Detail" pane
		And I search for provider "PROVIDER%Current Date%, AUTO" by "PROVIDER" role in the "Provider Main" pane
		Then the text "PROVIDER%Current Date%" should not appear in the "ProviderMainSearch" pane
		When I click the "Upload Providers" button
		Then the "Upload Providers Data" pane should load
		When I click the "Close" button in the "Add Provider to Group" pane
		Then the "Upload Providers Data" pane should close

	@PortalSmoke @donotrun
	Scenario: Loading of the WEB System Control pane
		When I click the "Misc" link in the "System Management Navigation" pane
		And the following fields should display in the "Web System Control" pane
			|Name                    |Type   |
			|Clear WebSession Caches |button |
			|Purge Mobilizer Cache   |button |
			|Ping Server             |button |
		
	@PortalSmoke @donotrun
	Scenario: Loading of the Import Provider Directory pane
		When I click the "Import Provider Directory" link in the "System Management Navigation" pane
		Then the "Import Provider Directory" pane should load
	
	#Since the issue DEV-39543 has fixed in 8.0, This scenario can be executed on 8.X environment onwards.
	@PortalSmoke @donotrun
	Scenario: Import Provider Directory
		When I click the "Import Provider Directory" link in the "System Management Navigation" pane
		And I enter "C:\ProviderDirectory07.10.07.csv" in the "CSVInputFile" field
		And I click the "Load Data" button in the "Import Provider Directory" pane
		Then the following fields should display in the "Import Provider Directory" pane
			|Name         |Type   |
			|GoBack       |button |
			|Save Mappings|button |
		#Map Mondatory columns to fields
		When I select "Last Name" from the "NAME_LAST" dropdown
		And I select "First Name" from the "NAME_FIRST" dropdown
		And I click the "Save Mappings" button
		Then the "Mappings" table should load
		And the following rows should appear in the "Mappings" table
			|Field Name |
			|NAME_FIRST |
			|NAME_LAST  |
		When I click the "Save" button in the "Import Provider Directory" pane
		Then the text "Success!" should appear in the "Import Provider Directory" pane
		When I am on the "Provider Directory" tab
		Then the "Provider Directory" pane should load
		When I enter "Jacobs" in the "Last Name" field in the "Provider Directory Search" pane
		And I click the "Search" button in the "Provider Directory Search" pane
		Then the following rows should appear in the "Provider Directory" table
			|Last Name |First Name |
			|Jacobs    |Jeffery    |
			
	@PortalSmoke @donotrun
	Scenario: Verify the Title in Preferences General Settings
		When I select the "Preferences" subtab
		Then the "General Setting Preference" pane should load
		When I enter "PK" in the "General Settings Title" field
		And I click the "Save" button
		And I click "OK" in the confirmation box
		And I wait "2" seconds
		Then the value in the "General Settings Title" field should be "PK"
		#Revert back the title name settings
		When I enter "" in the "General Settings Title" field
		And I click the "Save" button
		And I click "OK" in the confirmation box
		
	@PortalSmoke @donotrun
	Scenario: Loading of the Self Assignment Report pane
		When I click the "Self Assign Report" link in the "System Management Navigation" pane
		Then the "Self Assignment Report" pane should load
		When I enter "%Current Date%" in the "Start Date" field in the "Self Assignment Report" pane
		And I enter "%Current Date%" in the "End Date" field in the "Self Assignment Report" pane
		And I click the "Show Report" button
		Then the "Report" pane should load
		#When I click the " Export Report To CSV File" button
		#Then the "info" pane should load
		#When I click the "Close" button
		#When I click the "Print" button
	
	@PortalSmoke @donotrun
	Scenario: Verify the Portal Broadcast Message
		#Portal Broadcast Message popup not getting handled after re-login
		When I click the "Portal Broadcast Message" link in the "System Management Navigation" pane
		Then the "Portal Broad Cast Message" pane should load
		And I click the "Edit..Message" button in the "Portal Broad Cast Message" pane
		And I select "true" from the "Message Status" radio list
		#Selecting "Only Once per User" from "Display Message" radio list
		And I select "1" from the "Display Message" radio list
		#Selecting "Simple Acknowledgement " from "User Message Interaction" radio list
		And I select "1" from the "User Message Interaction" radio list
		And I enter "test" in the "Broad Cast Message" field
		And I click the "Save" button in the "Portal Broad Cast Message" pane
		And I click the "Yes" button in the "Question" pane
		And I click the logout button
		And I login as "pkadmin" with password "123"
		Then the "Broad Cast Pop Up Message" pane should load
		And I click the "OK..Broad Cast Message" button
		#Revert back the settings
		And I click the "Edit..Message" button in the "Portal Broad Cast Message" pane
		And I select "false" from the "MessageStatus" radio list
		And I click the "Save" button in the "Portal Broad Cast Message" pane
		And I click the "Yes" button in the "Question" pane
		And I click the logout button
		And I login as "pkadmin" with password "123"
		Then the "Broad Cast Pop Up Message" pane should not load
	
	@PortalSmoke @donotrun
	Scenario: Adding and Deleting External Systems
		When I click the "External Systems" link in the "System Management Navigation" pane
		Then the "External Systems" pane should load
		When I click the "Add External System" button in the "External System Search" pane
		And I wait "2" seconds
		Then the "Add External System" pane should load
		When I enter "autoextsys-%Current Date%-" in the "Name" field in the "Add External System Content" pane
		And I enter "ExternalSysID-%Current Date%-%Current Time%" in the "External System Id" field in the "Add External System Content" pane
		And I click the "Save" button in the "Add External System Content" pane
		Then the exact text "autoextsys-%Current Date%-" should appear in the "External System Search Results" pane
		When I click the "Edit" button in the "External System Details" pane
		And I wait "2" seconds
		And I enter "TestID-%Current Date%-%Current Time%" in the "External System Id" field
		And I click the "Save" button in the "Add External System Content" pane
		Then the text "TestID-%Current Date%-" should appear in the "External System Details" pane
		When I click the "Refresh" button in the "External System Search" pane
		Then the exact text "autoextsys-%Current Date%-" should appear in the "External System Search Results" pane
		And the text "TestID-%Current Date%-" should appear in the "External System Details" pane
		When I click the "Delete" button in the "External System Details" pane
		And I click the "Yes" button in the "Warning" pane
		Then the exact text "autoextsys-%Current Date%-" should not appear in the "External System Search Results" pane
	
	@PortalSmoke @donotrun
	Scenario: Add Edit and Delete XML Customization
		When I click the "XML Customizations" link in the "System Management Navigation" pane
		Then the "XML Customizations" pane should load
		When I click the "Add Customization" button in the "XML Customization Search" pane
		And I wait "2" seconds
		Then the "Add XML Customization" pane should load
		When I enter "AutoXMLCustomization-%Current Date%" in the "AddXMLCustomization...Name" field in the "Add XML Customization Content" pane
		And I enter "AutoDesc" in the "AddXMLCustomization...Description" field in the "Add XML Customization Content" pane
		And I select "DXMLAllergy.xml" from the "AddXMLCustomization...File" dropdown in the "Add XML Customization Content" pane
		And I enter "Progress Note" in the "AddXMLCustomization...Template" field in the "Add XML Customization Content" pane
		And I click the "Template Search" button in the "Add XML Customization Content" pane
		And I select "the first item" from the "Form Name" column in the "Form Template Search" table if it exists
		Then the value in the "AddXMLCustomization...Template" field should be "Progress Note"
		When I enter "GHDOHospital" in the "AddXMLCustomization...Facilities" field in the "Add XML Customization Content" pane
		And I click the "Facilities Search" button in the "Add XML Customization Content" pane
		Then the exact text "GHDOHospital" should appear in the "Add XML Customization Content" pane
		When I enter "Cardiology" in the "AddXMLCustomization...Departments" field in the "Add XML Customization Content" pane
		And I click the "Department Search" button in the "Add XML Customization Content" pane
		And I wait "2" seconds
		And I select "Cardiology" from the "Department" column in the "Form Template Search" table if it exists
		Then the exact text "Cardiology" should appear in the "Add XML Customization Content" pane
		When I enter "KADMIN, PERRY" in the "AddXMLCustomization...Users" field in the "Add XML Customization Content" pane
		And I click the "Users Search" button in the "Add XML Customization Content" pane
		And I select "KADMIN" in the "LookupUser" table if it exists
		Then the exact text "KADMIN, PERRY" should appear in the "Add XML Customization Content" pane
		When I enter "<begin></begin>" in the "AddXMLCustomization...XMLArea" field in the "Add XML Customization Content" pane
		And I check the "Apply to all users" checkbox in the "Add XML Customization Content" pane
		Then the following should be checked in the "Add XML Customization Content" pane
			|Apply to all users |
		When I click the "View Elements" button in the "Add XML Customization Content" pane
		Then the "ViewElement" table should have at least "1" rows
		When I click the "Save" button in the "Add XML Customization Content" pane
		Then the exact text "AutoXMLCustomization-%Current Date%" should appear in the "XML Customization Search Results" pane
		When I click the "Edit" button in the "XML Customization Details" pane
		And I wait "2" seconds
		And I enter "TestDesc" in the "AddXMLCustomization...Description" field in the "Add XML Customization Content" pane
		And I click the "Save" button in the "Add XML Customization Content" pane
		Then the exact text "TestDesc" should appear in the "XML Customization Details" pane
		When I click the "Refresh" button in the "XML Customization Search" pane
		Then the exact text "TestDesc" should appear in the "XML Customization Details" pane
		Then the exact text "AutoXMLCustomization-%Current Date%" should appear in the "XML Customization Search Results" pane
		When I click the "Delete" button in the "XML Customization Details" pane
		And I click the "Yes" button in the "Warning" pane
		Then the exact text "AutoXMLCustomization-%Current Date%" should not appear in the "XML Customization Search Results" pane

	@PortalSmoke @donotrun
	Scenario: Loading of the Audit Report pane
		When I click the "Audit Report" link in the "System Management Navigation" pane
		Then the "Audit Report" pane should load
		When I enter "%5 days ago MMDDYY%" in the "Start Date" field in the "Audit Report" pane
		And I enter "%Current Date MMDDYY%" in the "End Date" field in the "Audit Report" pane
		And I enter "pkadminv2" in the "Select Users" field in the "Audit Report" pane
		And I click the "Lookup User" element in the "Audit Report" pane
		And I click the "Select Patient" button in the "Audit Report" pane
		And I wait "2" seconds
		And I enter "Angeline" in the "Last" field in the "Select Patient" pane
		And I enter "Mona" in the "First" field in the "Select Patient" pane
		And I click the "Search for Patients" button in the "Select Patient" pane
		And I select patient "Mona Angeline" from the "Name (\d)" column in the "Patient Search Results" table
		And I click the "Show Audit Records" button in the "Audit Report" pane
		Then the "Audit Report" table should load
		
	#TODO: Complete this scenario
	@PortalSmoke @donotrun
	Scenario: Verify the Relationship Property Settings
		When I click the "Relationships" link in the "System Management Navigation" pane
		And I uncheck the "Declarable" checkbox in the row with "HOSPITALIST" as the value in the "Relationship" table
		And I click the "Save" button in the "Relationship Property Maintenance Result" pane
		And I click the "OK" button in the "Information" pane
		And I click the logout button
		Given I am logged into the portal with user "pkadminv2" using the default password
		# After logout and login, Webdriver failing to locate the frame.
		#And I am on the "Patient List" tab
		#And I select "Add Patient" from the "Actions" menu
		#Then the option "HOSPITALIST" should not be available in the "Relationship" dropdown list
