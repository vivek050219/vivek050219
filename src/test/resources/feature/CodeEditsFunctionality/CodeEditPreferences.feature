@CodeEditPreferences
Feature: Code edits

	Background:
		Given I am logged into the portal with user "codeedituser3" using the default password
		#Given I am logged into the portal with user "codeedituser3" and password "123"
		And I am on the "Patient List V2" tab
#		And I use the API to create a patient list named "CCList" owned by "codeedituser3" with the following parameters
#			| Type   | Name              | Value      |
#			| Filter | Medical Service   | Card Group |
		And I click the "Refresh Patient List" button
		And I select "CCList" from the "Patient List" menu
		And "CODE* EDIT" is on the patient list
		And I select patient "CODE* EDIT" from the patient list

	#Moved to setUp in CukeRunnerTEst.java
#	@donotrun
#	Scenario: Turn on all codeedits on user server
#		And I execute the "Enable All Code Edits" query
		
	Scenario: Forced code for the L3 user where set Allowed to save forced as Draft and set Charges Sent to Holding Bin set to Nothing
		Given I am logged into the portal with user "pkadmin" using the default password
		#Given I am logged into the portal with the default user
		And I am on the "Admin" tab
		And I select the "User" subtab
		And I search for the user "codeedituser3"
        And I select the user "codeedituser3"
        And I click the "Edit" button in the "Quick Details" pane
        And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
		And I select "true" from the "AllowUsertoSaveasDraft" radio list
		And I click the "Save" button
		And I click "OK" in the confirmation box
		And I click the logout button
		Given I am logged into the portal with user "codeedituser3" using the default password
		#Given I am logged into the portal with user "codeedituser3" and password "123"
		And I am on the "Patient List V2" tab
		And "CODE* EDIT" is on the patient list
		And I select patient "CODE* EDIT" from the patient list
		And patient "CODE* EDIT" has no charges
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditNothing |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "97811"
		And I click the "Submit" button
		Then the "Confirm" pane should load
		And the text "This charge transaction has been saved as a DRAFT due to errors. Choose the next step." should appear in the "Confirm" pane
		And the following fields should display in the "Confirm" pane
			|Name             |Type   |
			|Continue Editing |button |
			|Save As Is       |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close

	Scenario: Forced code for the L3 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to All
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditAll     |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "97811"
		And I click the "Submit" button
		Then the text "This charge transaction has been saved as a DRAFT due to errors. Choose the next step." should appear in the "Confirm" pane
		And the following fields should display in the "Confirm" pane
			|Name             |Type   |
			|Continue Editing |button |
			|Save As Is       |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close
		
	Scenario: Forced and silent code for the L3 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to All
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditAll     |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "97813"
		And I click the "Submit" button
		Then the text "This charge transaction has been saved as a DRAFT due to errors. Choose the next step." should appear in the "Confirm" pane
		And the following fields should display in the "Confirm" pane
			|Name             |Type   |
			|Continue Editing |button |
			|Save As Is       |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close
		
	Scenario: Forced and silent code for the L3 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to Nothing
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditNothing |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "97813"
		And I click the "Submit" button
		Then the text "This charge transaction has been saved as a DRAFT due to errors. Choose the next step." should appear in the "Confirm" pane
		And the following fields should display in the "Confirm" pane
			|Name             |Type   |
			|Continue Editing |button |
			|Save As Is       |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close
		
	Scenario: Non Forced and silent code for the L3 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to All
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditAll     |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "92961"
		And I click the "Submit" button
		And I click the "Save As Is" button in the "Confirm" pane
		And I wait "2" seconds
#		And I click the "SaveAsIs" button
		And I refresh the clinical display
		And I select "the first item" in the "Charges" table
		Then the text "Holding Bin" should appear in the "Charge Detail" pane
	
	Scenario: Non Forced and silent code for the L3 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to Nothing
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditNothing |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "92961"
		And I click the "Submit" button
		And I wait "2" seconds
		And I click the "ConfirmNo" button in the "Confirm" pane
		Then the "Charges" table should load
		When I refresh the clinical display
		And I wait "2" seconds
		And I select "the first item" in the "Charges" table
		Then the text "Outbox" should appear in the "Charge Detail" pane

	Scenario: Department based and Non Forced and silent code for the L3 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to All
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditAll     |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "90460"
		And I enter the CPT code "90461"		
		And I click the "Submit" button
		Then the following fields should display in the "Confirm" pane
			|Name             |Type   |
			|Continue Editing |button |
			|Save As Is       |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close
	
	Scenario: Department based and Non Forced and silent code for the L3 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to Nothing
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditNothing |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "90460"
		And I enter the CPT code "90461"
		And I click the "Submit" button
		And the following fields should display in the "Confirm" pane
			|Name       |Type   |
			|ConfirmYes |button |
			|ConfirmNo  |button |
		And I click the "ConfirmNo" button in the "Confirm" pane
		Then the "Charges" table should load
		When I refresh the clinical display
		And I wait "2" seconds
		And I select "the first item" in the "Charges" table
		Then the text "Outbox" should appear in the "Charge Detail" pane	
		
	Scenario: Department based and Forced and Silent code for the L3 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to All
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditAll     |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "90675"
		And I enter the CPT code "90676"		
		And I click the "Submit" button
		Then the following fields should display in the "Confirm" pane
			|Name             |Type   |
			|Continue Editing |button |
			|Save As Is       |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close
	
	Scenario: Department based and Forced and Silent code for the L3 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to Nothing
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditNothing |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "90675"
		And I enter the CPT code "90676"
		And I click the "Submit" button
		Then the following fields should display in the "Confirm" pane
			|Name             |Type   |
			|Continue Editing |button |
			|Save As Is       |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close
		
	Scenario: Non Forced code for the L3 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to All
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditAll     |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "92960"
		And I click the "Submit" button
		Then the text "The charge transaction has been saved as a COMPLETED transaction, but code edits now exist. Choose the next step." should appear in the "Confirm" pane
		And the following fields should display in the "Confirm" pane
			|Name             |Type   |
			|Continue Editing |button |
			|Save As Is       |button |
			|Code Edit Save as Draft    |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close

	Scenario: Non Forced code for the L3 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to Nothing
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditNothing |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "92960"
		And I click the "Submit" button
		Then the text "This charge transaction has been saved as a COMPLETED transaction and sent to the Outbox, but it has errors. Would you like to send it back to the Holding Bin to correct errors now?" should appear in the "Confirm" pane
		And the following fields should display in the "Confirm" pane
			|Name       |Type   |
			|ConfirmYes |button |
			|ConfirmNo  |button |
		When I click the "ConfirmYes" button in the "Confirm" pane
		And I click the "Close" image
		Then the "Charge Entry" pane should close
	
	Scenario: Department base and Non Forced code for the L3 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to All
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditAll     |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "90471"
		And I enter the CPT code "90472"
		And I click the "Submit" button
		Then the text "The charge transaction has been saved as a COMPLETED transaction, but code edits now exist. Choose the next step." should appear in the "Confirm" pane
		And the following fields should display in the "Confirm" pane
			|Name                    |Type   |
			|Continue Editing        |button |
			|Save As Is              |button |
			|Code EditSave as Draft |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close

	Scenario: Department base and Non Forced code for the L3 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to Nothing
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditNothing |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "90471"
		And I enter the CPT code "90472"
		And I click the "Submit" button
		Then the text "This charge transaction has been saved as a COMPLETED transaction and sent to the Outbox, but it has errors. Would you like to send it back to the Holding Bin to correct errors now?" should appear in the "Confirm" pane
		And the following fields should display in the "Confirm" pane
			|Name       |Type   |
			|ConfirmYes |button |
			|ConfirmNo  |button |
		When I click the "ConfirmYes" button in the "Confirm" pane
		And I click the "Close" image
		Then the "Charge Entry" pane should close

	Scenario: Department based and Forced code for the L3 user where set Allowed to save forced as Draft and set Charges Sent to Holding Bin set to Nothing
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditNothing |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "90473"
		And I enter the CPT code "90474"
		And I click the "Submit" button
		Then the "Confirm" pane should load
		And the text "This charge transaction has been saved as a DRAFT due to errors. Choose the next step." should appear in the "Confirm" pane
		And the following fields should display in the "Confirm" pane
			|Name             |Type   |
			|Continue Editing |button |
			|Save As Is       |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close

	Scenario: Department based and Forced code for the L3 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to All
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditAll     |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "90473"
		And I enter the CPT code "90474"
		And I click the "Submit" button
		Then the text "This charge transaction has been saved as a DRAFT due to errors. Choose the next step." should appear in the "Confirm" pane
		And the following fields should display in the "Confirm" pane
			|Name             |Type   |
			|Continue Editing |button |
			|Save As Is       |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close

	Scenario: Role based and Non Forced code for the L3 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to All
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditAll     |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "93925"
		And I enter the CPT code "93926"
		And I click the "Submit" button
		Then the text "The charge transaction has been saved as a COMPLETED transaction, but code edits now exist. Choose the next step." should appear in the "Confirm" pane
		And the following fields should display in the "Confirm" pane
			|Name                    |Type   |
			|Continue Editing        |button |
			|Save As Is              |button |
			|Code Edit Save as Draft |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close

	Scenario: Role based and Non Forced code for the L3 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to Nothing
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditNothing |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "92960"
		And I click the "Submit" button
		Then the text "This charge transaction has been saved as a COMPLETED transaction and sent to the Outbox, but it has errors. Would you like to send it back to the Holding Bin to correct errors now?" should appear in the "Confirm" pane
		And the following fields should display in the "Confirm" pane
			|Name       |Type   |
			|ConfirmYes |button |
			|ConfirmNo  |button |
		When I click the "ConfirmYes" button in the "Confirm" pane
		And I click the "Close" image
		Then the "Charge Entry" pane should close

	Scenario: Role based and Non Forced and Silent code for the L3 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to All
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditAll     |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "93922"
		And I enter the CPT code "93923"
		And I click the "Submit" button
		And the following fields should display in the "Confirm" pane
			|Name                    |Type   |
			|Continue Editing        |button |
			|SaveAsIs                |button |
			|Code Edit Save as Draft |button |
#		And I click the "SaveAsIs" button
		And I click the "Save As Is" button in the "Confirm" pane if it exists
		And I wait "5" seconds
		And I refresh the clinical display
		And I select "the first item" in the "Charges" table
		Then the text "Holding Bin" should appear in the "Charge Detail" pane
	
	Scenario: Role based and Non Forced and Silent code for the L3 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to Nothing
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditNothing |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "93922"
		And I enter the CPT code "93923"
		And I click the "Submit" button
		And the following fields should display in the "Confirm" pane
			|Name       |Type   |
			|ConfirmYes |button |
			|ConfirmNo  |button |
		And I click the "ConfirmNo" button in the "Confirm" pane
		Then the "Charges" table should load
		When I refresh the clinical display
		And I wait "2" seconds
		And I select "the first item" in the "Charges" table
		Then the text "Outbox" should appear in the "Charge Detail" pane
		
	Scenario: Forced code And Not Allowed to save forced as Draft for the L3 user and set Charges Sent to Holding set to All
		Given I am logged into the portal with user "pkadmin" using the default password
		#Given I am logged into the portal with the default user
		And I am on the "Admin" tab
		And I select the "User" subtab
		And I search for the user "codeedituser3"
        And I select the user "codeedituser3"
        And I click the "Edit" button in the "Quick Details" pane
        And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
		And I select "false" from the "AllowUsertoSaveasDraft" radio list
		And I click the "Save" button
		And I click "OK" in the confirmation box
		And I click the logout button
		Given I am logged into the portal with user "codeedituser3" using the default password
		#Given I am logged into the portal with user "codeedituser3" and password "123"
		And I am on the "Patient List V2" tab
		And "CODE* EDIT" is on the patient list
		And I select patient "CODE* EDIT" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditAll     |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "97811"
		And I click the "Submit" button
		Then the following text should appear in the "Confirm" pane
			|This charge transaction was NOT SAVED due to errors. Choose the next step.|
			|Please note that if you discard the transaction, all changes will be lost. |
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		When I click the "Discard Transaction" button
		Then the "Charge Entry" pane should close

	Scenario: Forced code And Not Allowed to save forced as Draft for the L3 user and set Charges Sent to Holding set to Nothing
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditNothing |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "97811"
		And I click the "Submit" button
		Then the following text should appear in the "Confirm" pane
			|This charge transaction was NOT SAVED due to errors. Choose the next step.|
			|Please note that if you discard the transaction, all changes will be lost.|
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		When I click the "Discard Transaction" button
		Then the "Charge Entry" pane should close
		
	Scenario: Department Based and Silent and Forced code for the L3 user where set Not Allowed to save forced as Draft and set Charges Sent to Holding Bin set to All
		Given I am logged into the portal with user "codeedituser3" using the default password
		#Given I am logged into the portal with user "codeedituser3" and password "123"
		And I am on the "Patient List V2" tab
		And I select patient "CODE* EDIT" from the patient list
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditAll     |
			|Billing Prov |EDITUSER2, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "90675"
		And I enter the CPT code "90676"
		And I click the "Submit" button
		Then the following text should appear in the "Confirm" pane
			|This charge transaction was NOT SAVED due to errors. Choose the next step.|
			|Please note that if you discard the transaction, all changes will be lost.|
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		When I click the "Discard Transaction" button
		Then the "Charge Entry" pane should close		

	Scenario: Department Based and Silent and Forced code for the L3 user where set Not Allowed to save forced as Draft and set Charges Sent to Holding Bin set to Nothing
		Given I am logged into the portal with user "codeedituser3" using the default password
		#Given I am logged into the portal with user "codeedituser3" and password "123"
		And I am on the "Patient List V2" tab
		And I select patient "CODE* EDIT" from the patient list
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditNothing |
			|Billing Prov |EDITUSER2, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "90675"
		And I enter the CPT code "90676"
		And I click the "Submit" button
		Then the following text should appear in the "Confirm" pane
			|This charge transaction was NOT SAVED due to errors. Choose the next step.|
			|Please note that if you discard the transaction, all changes will be lost.|
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		When I click the "Discard Transaction" button
		Then the "Charge Entry" pane should close
	
	Scenario: Forced and Silent code for L3 User And Not Allowed to save forced as Draft and set Charges Sent to Holding set to Nothing
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditNothing |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "97813"
		And I click the "Submit" button
		Then the following text should appear in the "Confirm" pane
			|This charge transaction was NOT SAVED due to errors. Choose the next step.|
			|Please note that if you discard the transaction, all changes will be lost.|
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		When I click the "Discard Transaction" button
		Then the "Charge Entry" pane should close
		
	Scenario: Forced and Silent code  for L3 User And Not Allowed to save forced as Draft and set Charges Sent to Holding set to All
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditAll     |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "97813"
		And I click the "Submit" button
		Then the following text should appear in the "Confirm" pane
			|This charge transaction was NOT SAVED due to errors. Choose the next step.|
			|Please note that if you discard the transaction, all changes will be lost.| 
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		When I click the "Discard Transaction" button
		Then the "Charge Entry" pane should close

	Scenario: Forced code for the L2 user where set Allowed to save forced as Draft and set Charges Sent to Holding Bin set to Nothing
		Given I am logged into the portal with user "pkadmin" using the default password
		#Given I am logged into the portal with the default user
		And I am on the "Admin" tab
		And I select the "User" subtab
		And I search for the user "codeedituser2"
        And I select the user "codeedituser2"
        And I click the "Edit" button in the "Quick Details" pane
        And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
		And I select "false" from the "AllowUsertoSaveasDraft" radio list
		And I click the "Save" button
		And I click "OK" in the confirmation box
		And I wait "3" seconds
		And I select "User Permissions" from the "Edit User Settings" dropdown in the "User Preferences" pane
		And I select "false" from the "CanSendChargestoOutbox" radio list
		And I click the "Save" button
		And I click "OK" in the confirmation box
		And I click the logout button
		Given I am logged into the portal with user "codeedituser2" using the default password
		#Given I am logged into the portal with user "codeedituser2" and password "123"
		And I am on the "Patient List V2" tab
#		And I use the API to create a patient list named "CCList" owned by "codeedituser2" with the following parameters
#			| Type   | Name              | Value      |
#			| Filter | Medical Service   | Card Group |
		And I click the "Refresh Patient List" button
		And I select "CCList" from the "Patient List" menu
		And "CODE* EDIT" is on the patient list
		And I select patient "CODE* EDIT" from the patient list
		And patient "CODE* EDIT" has no charges
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           			|
			|Bill Area    |CodeEditNothing 			|
			|Billing Prov |EDITUSER2, CODE 			|
			|Svc Site     |Inpatient       			|
			|Date	      |%Current Date MMDDYYYY%	|
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "97811"
#		And I enter "%Current Date MMDDYYYY%" in the "Date" field
		And I click the "Submit" button
		Then the "Confirm" pane should load
		And the following text should appear in the "Confirm" pane
            |This charge transaction was NOT SAVED due to errors. Choose the next step. |
            |Please note that if you discard the transaction, all changes will be lost. |
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close
	
	Scenario: Forced code for the L2 user where set Allowed to save forced as Draft and set Charges Sent to Holding Bin set to All
		Given I am logged into the portal with user "codeedituser2" using the default password
		#Given I am logged into the portal with user "codeedituser2" and password "123"
		And I am on the "Patient List V2" tab
		And I select patient "CODE* EDIT" from the patient list
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           			|
			|Bill Area    |CodeEditAll     			|
			|Billing Prov |EDITUSER2, CODE 			|
			|Svc Site     |Inpatient       			|
			|Date	      |%Current Date MMDDYYYY%	|
		And I wait "2" seconds
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "97811"
#		And I enter "%Current Date MMDDYYYY%" in the "Date" field
		And I click the "Submit" button
		Then the "Confirm" pane should load
		And the following text should appear in the "Confirm" pane
            |This charge transaction was NOT SAVED due to errors. Choose the next step. |
            |Please note that if you discard the transaction, all changes will be lost. |
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close
		
	Scenario: Non Forced code for the L2 User and set Allowed to save forced as Draft and set Charges Sent to Holding Bin set to All
		Given I am logged into the portal with user "codeedituser2" using the default password
		#Given I am logged into the portal with user "codeedituser2" and password "123"
		And I am on the "Patient List V2" tab
		And I select patient "CODE* EDIT" from the patient list
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           			|
			|Bill Area    |CodeEditAll     			|
			|Billing Prov |EDITUSER2, CODE 			|
			|Svc Site     |Inpatient       			|
			|Date	      |%Current Date MMDDYYYY%	|
		And I wait "2" seconds
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "92960"
#		And I enter "%Current Date MMDDYYYY%" in the "Date" field
		And I click the "Submit" button
		Then the text "The charge transaction has been saved as a COMPLETED transaction, but code edits now exist. Choose the next step." should appear in the "Confirm" pane
		And the following fields should display in the "Confirm" pane
			|Name                    |Type   |
			|Continue Editing        |button |
			|Save As Is              |button |
		And I click the "Save As Is" button in the "Confirm" pane if it exists
		And I refresh the clinical display
		And I select "the first item" in the "Charges" table		
		Then the text "Holding Bin" should appear in the "Charge Detail" pane
		
	Scenario: Non Forced code for the L2 User and set Allowed to save forced as Draft and set Charges Sent to Holding Bin set to Nothing
		Given I am logged into the portal with user "codeedituser2" using the default password
		#Given I am logged into the portal with user "codeedituser2" and password "123"
		And I am on the "Patient List V2" tab
		And I select patient "CODE* EDIT" from the patient list
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           			|
			|Bill Area    |CodeEditNothing 			|
			|Billing Prov |EDITUSER2, CODE 			|
			|Svc Site     |Inpatient       			|
			|Date	      |%Current Date MMDDYYYY%	|
		And I wait "2" seconds
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "92960"
#		And I enter "%Current Date MMDDYYYY%" in the "Date" field
		And I click the "Submit" button
		Then the "Confirm" pane should load
		And the text "This charge transaction has been saved as a COMPLETED transaction and sent to the Outbox, but it has errors. Would you like to send it back to the Holding Bin to correct errors now?" should appear in the "Confirm" pane
		And the following fields should display in the "Confirm" pane
			|Name       |Type   |
			|ConfirmYes |button |
			|ConfirmNo  |button |
		When I click the "ConfirmYes" button in the "Confirm" pane
		And I click the "Close" image
		Then the "Charge Entry" pane should close
		And I refresh the clinical display
		When I select "the first item" in the "Charges" table	
		Then the text "Holding Bin" should appear in the "ChargeDetail" pane
				
	Scenario: Role based and Forced and Silent code for the L2 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to All
		Given I am logged into the portal with user "codeedituser2" using the default password
		#Given I am logged into the portal with user "codeedituser2" and password "123"
		And I am on the "Patient List V2" tab
		And I select patient "CODE* EDIT" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           			|
			|Bill Area    |CodeEditAll     			|
			|Billing Prov |EDITUSER2, CODE 			|
			|Svc Site     |Inpatient       			|
			|Date	      |%Current Date MMDDYYYY%	|
		And I wait "2" seconds
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "93930"
		And I enter the CPT code "93931"
#		And I enter "%Current Date MMDDYYYY%" in the "Date" field
		And I click the "Submit" button
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		#When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close
		
	Scenario: Role based and Forced and Silent code for the L2 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to Nothing
		Given I am logged into the portal with user "codeedituser2" using the default password
		#Given I am logged into the portal with user "codeedituser2" and password "123"
		And I am on the "Patient List V2" tab
		And I select patient "CODE* EDIT" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           			|
			|Bill Area    |CodeEditNothing 			|
			|Billing Prov |EDITUSER2, CODE 			|
			|Svc Site     |Inpatient       			|
			|Date	      |%Current Date MMDDYYYY%	|
		And I wait "2" seconds
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "93930"
		And I enter the CPT code "93931"
#		And I enter "%Current Date MMDDYYYY%" in the "Date" field
		And I click the "Submit" button
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close
		
	Scenario: Non Forced and silent code for the L2 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to All
		Given I am logged into the portal with user "codeedituser2" using the default password
		#Given I am logged into the portal with user "codeedituser2" and password "123"
		And I am on the "Patient List V2" tab
		And I select patient "CODE* EDIT" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           			|
			|Bill Area    |CodeEditAll     			|
			|Billing Prov |EDITUSER2, CODE 			|
			|Svc Site     |Inpatient       			|
			|Date	      |%Current Date MMDDYYYY%	|
		And I wait "2" seconds
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "92961"
#		And I enter "%Current Date MMDDYYYY%" in the "Date" field
		And I click the "Submit" button
		Then the text "The charge transaction has been saved as a COMPLETED transaction, but code edits now exist. Choose the next step." should appear in the "Confirm" pane
		And the following fields should display in the "Confirm" pane
			|Name             |Type   |
			|Continue Editing |button |
			|Save As Is       |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close
	
	Scenario: Non Forced and silent code for the L2 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to Nothing
		Given I am logged into the portal with user "codeedituser2" using the default password
		#Given I am logged into the portal with user "codeedituser2" and password "123"
		And I am on the "Patient List V2" tab
		And I select patient "CODE* EDIT" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           			|
			|Bill Area    |CodeEditNothing 			|
			|Billing Prov |EDITUSER3, CODE 			|
			|Svc Site     |Inpatient       			|
			|Date	      |%Current Date MMDDYYYY%	|
		And I wait "2" seconds
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "92961"
#		And I enter "%Current Date MMDDYYYY%" in the "Date" field
		And I click the "Submit" button
		And the following fields should display in the "Confirm" pane
			|Name       |Type   |
			|ConfirmYes |button |
			|ConfirmNo  |button |
		And I click the "ConfirmNo" button in the "Confirm" pane
		And I wait "2" seconds
		Then the "Charges" table should load
		And I select "the first item" in the "Charges" table
		Then the text "Outbox" should appear in the "Charge Detail" pane
			
	Scenario: Role Based and Forced code for the L2 user where set Allowed to save forced as Draft and set Charges Sent to Holding Bin set to Nothing
		Given I am logged into the portal with user "codeedituser2" using the default password
		#Given I am logged into the portal with user "codeedituser2" and password "123"
		And I am on the "Patient List V2" tab
		And I select patient "CODE* EDIT" from the patient list
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           		  |
			|Bill Area    |CodeEditNothing 		  |
			|Billing Prov |EDITUSER2, CODE 		  |
			|Svc Site     |Inpatient       		  |
			|Date     	  |%Current Date MMDDYYYY%|
		And I wait "2" seconds
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "93970"
		And I enter the CPT code "93971"
#		And I enter "%Current Date MMDDYYYY%" in the "Date" field
		And I click the "Submit" button
		Then the "Confirm" pane should load
		And the following text should appear in the "Confirm" pane
            |This charge transaction was NOT SAVED due to errors. Choose the next step. |
            |Please note that if you discard the transaction, all changes will be lost. |
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close	

	Scenario: Role Based and Forced code for the L2 user where set Allowed to save forced as Draft and set Charges Sent to Holding Bin set to All
		Given I am logged into the portal with user "codeedituser2" using the default password
		#Given I am logged into the portal with user "codeedituser2" and password "123"
		And I am on the "Patient List V2" tab
		And I select patient "CODE* EDIT" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           			|
			|Bill Area    |CodeEditAll     			|
			|Billing Prov |EDITUSER2, CODE 			|
			|Svc Site     |Inpatient       			|
			|Date	      |%Current Date MMDDYYYY%	|
		And I wait "2" seconds
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "93970"
		And I enter the CPT code "93971"
#		And I enter "%Current Date MMDDYYYY%" in the "Date" field
		And I click the "Submit" button
		Then the "Confirm" pane should load
		And the following text should appear in the "Confirm" pane
            |This charge transaction was NOT SAVED due to errors. Choose the next step. |
            |Please note that if you discard the transaction, all changes will be lost. |
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close

	Scenario: Forced and silent code for the L2 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to All
		Given I am logged into the portal with user "codeedituser2" using the default password
		#Given I am logged into the portal with user "codeedituser2" and password "123"
		And I am on the "Patient List V2" tab
		And I select patient "CODE* EDIT" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           			|
			|Bill Area    |CodeEditAll     			|
			|Billing Prov |EDITUSER2, CODE 			|
			|Svc Site     |Inpatient       			|
			|Date	      |%Current Date MMDDYYYY%	|
		And I wait "2" seconds
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "97813"
#		And I enter "%Current Date MMDDYYYY%" in the "Date" field
		And I click the "Submit" button
		Then the following text should appear in the "Confirm" pane
            |This charge transaction was NOT SAVED due to errors. Choose the next step. |
            |Please note that if you discard the transaction, all changes will be lost. |
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close
	
	Scenario: Forced and silent code for the L2 user where set Allowed to save forced as Draft and Charges Sent to Holding Bin set to Nothing
		Given I am logged into the portal with user "codeedituser2" using the default password
		#Given I am logged into the portal with user "codeedituser2" and password "123"
		And I am on the "Patient List V2" tab
		And I select patient "CODE* EDIT" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditNothing |
			|Billing Prov |EDITUSER2, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "97813"
		And I enter "%Current Date MMDDYYYY% " in the "Date" field
		And I click the "Submit" button
		Then the following text should appear in the "Confirm" pane
            |This charge transaction was NOT SAVED due to errors. Choose the next step. |
            |Please note that if you discard the transaction, all changes will be lost. |
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		When I click the "Continue Editing" button
		And I click the "Close" image
		Then the "Charge Entry" pane should close
		
	Scenario: Forced code for the L2 user where set to save forced as Drafts Not Allowed and set Charges Sent to Holding Bin set to Nothing
		Given I am logged into the portal with user "pkadmin" using the default password
		#Given I am logged into the portal with user "pkadmin" and password "123"
		And I am on the "Admin" tab
		And I select the "User" subtab
		And I search for the user "codeedituser2"
        And I select the user "codeedituser2"
        And I click the "Edit" button in the "Quick Details" pane
        And I select "Charge Capture" from the "Edit User Settings" dropdown in the "User Preferences" pane
		And I select "false" from the "AllowUsertoSaveasDraft" radio list
		And I click the "Save" button
		And I click "OK" in the confirmation box
		Given I am logged into the portal with user "codeedituser2" using the default password
		#Given I am logged into the portal with user "codeedituser2" and password "123"
		And I am on the "Patient List V2" tab
		And I select patient "CODE* EDIT" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           		  |
			|Bill Area    |CodeEditNothing 		  |
			|Billing Prov |EDITUSER2, CODE 		  |
			|Svc Site     |Inpatient       		  |
			|Date     	  |%Current Date MMDDYYYY%|
		And I wait "2" seconds
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "97811"
#		And I enter "%Current Date MMDDYYYY%" in the "Date" field
		And I click the "Submit" button
		Then the "Confirm" pane should load
		And the following text should appear in the "Confirm" pane
			|This charge transaction was NOT SAVED due to errors. Choose the next step.|
			|Please note that if you discard the transaction, all changes will be lost. |
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		And I click the "Discard Transaction" button
		Then the "Charge Entry" pane should close

	Scenario: Forced code for the L2 user where set to save forced as Drafts Not Allowed and set Charges Sent to Holding Bin set to All
		Given I am logged into the portal with user "codeedituser2" using the default password
		#Given I am logged into the portal with user "codeedituser2" and password "123"
		And I am on the "Patient List V2" tab
		And I select patient "CODE* EDIT" from the patient list
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           			|
			|Bill Area    |CodeEditAll     			|
			|Billing Prov |EDITUSER2, CODE 			|
			|Svc Site     |Inpatient       			|
			|Date	      |%Current Date MMDDYYYY%	|
		And I wait "2" seconds
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "97811"
#		And I enter "%Current Date MMDDYYYY%" in the "Date" field
		And I click the "Submit" button
		Then the "Confirm" pane should load
		And the following text should appear in the "Confirm" pane
			|This charge transaction was NOT SAVED due to errors. Choose the next step.|
			|Please note that if you discard the transaction, all changes will be lost. |
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		And I click the "Discard Transaction" button
		Then the "Charge Entry" pane should close	

	Scenario: Forced and Silent code for the L2 User and set Not Allowed to save forced as Draft and set Charges Sent to Holding Bin set to Nothing
		Given I am logged into the portal with user "codeedituser2" using the default password
		#Given I am logged into the portal with user "codeedituser2" and password "123"
		And I am on the "Patient List V2" tab
		And I select patient "CODE* EDIT" from the patient list
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           			|
			|Bill Area    |CodeEditNothing 			|
			|Billing Prov |EDITUSER2, CODE 			|
			|Svc Site     |Inpatient       			|
			|Date	      |%Current Date MMDDYYYY%	|
		And I wait "2" seconds
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "97813"
#		And I enter "%Current Date MMDDYYYY%" in the "Date" field
		And I click the "Submit" button
		Then the "Confirm" pane should load
		And the following text should appear in the "Confirm" pane
			|This charge transaction was NOT SAVED due to errors. Choose the next step.|
			|Please note that if you discard the transaction, all changes will be lost. |
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		And I click the "Discard Transaction" button
		Then the "Charge Entry" pane should close	
	
	Scenario: Forced and Silent code for the L2 User and set Not Allowed to save forced as Draft and set Charges Sent to Holding Bin set to All
		Given I am logged into the portal with user "codeedituser2" using the default password
		#Given I am logged into the portal with user "codeedituser2" and password "123"
		And I am on the "Patient List V2" tab
		And I select patient "CODE* EDIT" from the patient list
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           			|
			|Bill Area    |CodeEditAll     			|
			|Billing Prov |EDITUSER2, CODE 			|
			|Svc Site     |Inpatient       			|
			|Date	      |%Current Date MMDDYYYY%	|
		And I wait "2" seconds
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "97813"
#		And I enter "%Current Date MMDDYYYY%" in the "Date" field
		And I click the "Submit" button
		Then the "Confirm" pane should load
		And the following text should appear in the "Confirm" pane
			|This charge transaction was NOT SAVED due to errors. Choose the next step.|
			|Please note that if you discard the transaction, all changes will be lost. |
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		And I click the "Discard Transaction" button
		Then the "Charge Entry" pane should close
		
	Scenario: Role based and Forced and Silent code for the L2 User and set Not Allowed to save forced as Draft and set Charges Sent to Holding Bin set to Nothing
		Given I am logged into the portal with user "codeedituser2" using the default password
		#Given I am logged into the portal with user "codeedituser2" and password "123"
		And I am on the "Patient List V2" tab
		And I select patient "CODE* EDIT" from the patient list
		When I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           			|
			|Bill Area    |CodeEditNothing 			|
			|Billing Prov |EDITUSER2, CODE 			|
			|Svc Site     |Inpatient       			|
			|Date	      |%Current Date MMDDYYYY%	|
		And I wait "2" seconds
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "93930"
		And I enter the CPT code "93931"
#		And I enter "%Current Date MMDDYYYY%" in the "Date" field
		And I click the "Submit" button
		Then the "Confirm" pane should load
		And the following text should appear in the "Confirm" pane
			|This charge transaction was NOT SAVED due to errors. Choose the next step.|
			|Please note that if you discard the transaction, all changes will be lost. |
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		And I click the "Discard Transaction" button
		Then the "Charge Entry" pane should close

	Scenario: Role based and Forced and Silent code for the L2 User and set Not Allowed to save forced as Draft and set Charges Sent to Holding Bin set to Nothing
		Given I am logged into the portal with user "codeedituser2" using the default password
		#Given I am logged into the portal with user "codeedituser2" and password "123"
		And I am on the "Patient List V2" tab
		And I select patient "CODE* EDIT" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           			|
			|Bill Area    |CodeEditAll     			|
			|Billing Prov |EDITUSER2, CODE 			|
			|Svc Site     |Inpatient       			|
			|Date	      |%Current Date MMDDYYYY%	|
		And I wait "2" seconds
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT code "93930"
		And I enter the CPT code "93931"
#		And I enter "%Current Date MMDDYYYY%" in the "Date" field
		And I click the "Submit" button
		Then the "Confirm" pane should load
		And the following text should appear in the "Confirm" pane
			|This charge transaction was NOT SAVED due to errors. Choose the next step.|
			|Please note that if you discard the transaction, all changes will be lost. |
		And the following fields should display in the "Confirm" pane
			|Name                |Type   |
			|Continue Editing    |button |
			|Discard Transaction |button |
		And I click the "Discard Transaction" button
		Then the "Charge Entry" pane should close
	
	Scenario: Add a charge with edits and fix edits
		When "Molly Darr" is on the patient list
		And I select patient "Molly Darr" from the patient list
		And patient "Molly Darr" has no charges
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CodeEditAll     |
			|Billing Prov |EDITUSER3, CODE |
			|Svc Site     |Inpatient       |
		And I enter the ICD-10 code "B36.0"
		And I enter the CPT codes "99201"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This service is inconsistent with an inpatient setting. Consider another code based on this site of service." should appear in the "Charge Entry" pane
		When I remove the "99201" CPT code
		And I enter the CPT codes "86001"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "No Errors Found" should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario: Enter charge and diagnosis to product PQRS form. Complete PQRS form
		Given I am logged into the portal with user "drjones" and password "123"
		And I am on the "Patient List V2" tab
#		And I use the API to create a patient list named "CCList" owned by "drjones" with the following parameters
#			| Type   | Name              | Value      |
#			| Filter | Medical Service   | Card Group |
		And I click the "Refresh Patient List" button
		And I select "CCList" from the "Patient List" menu
		And "TEST SCHEDULE-1" is on the patient list
		And I select "Charges" from clinical navigation
		And patient "TEST SCHEDULE-1" has no charges
		And I am on the "Schedule" tab
		And I click the "Clear Criteria" button in the "Search Criteria" pane
#		And I check the "Show Group Service Appointments" checkbox
		And I click the "Delete Entry" image in the "Provider Search" pane if it exists
		And I enter "JONES, DOCTOR" in the "Providers" field
		And I click the "ProviderSearch" button in the "SearchCriteria" pane
		And I click the "Not Coded Outpatient" link in the "ScheduledVisits" pane
		And I wait "5" seconds
		And I set the following charge headers
			|Name         |Value         |
			|Bill Area    |scheduledeptA |
			|Billing Prov |JONES, DOCTOR |
			|Svc Site     |Outpatient    |
		And I enter the ICD-10 codes "N39.41" in the "Charge Entry" pane
		Then the text "N39.41" should appear in the "Diagnosis List" section in the "Charge Entry" pane
		And I wait "5" seconds
		And I enter the CPT codes "15734" in the "Charge Entry" pane
		When I click the "Submit" button
		And I click the "Save As Is" button in the "Confirm" pane if it exists
		And I select "Yes" from the "PQRS" radio list in the "Measures and Questions" pane
		And I click the "PQRS Submit" button

	#Moved to tearDown in CukeRunnerTEst.java
#	@donotrun
#	Scenario: Turn off all codeedits on user server
#		And I execute the "Disable All Code Edits" query