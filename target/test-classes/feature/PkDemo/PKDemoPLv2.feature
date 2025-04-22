@simpk
Feature: PK Demo - SimPK validation
	Various screens on PK Demo dependent on SimPK need to have the correct data
	
	Background:
		Given I am logged into the portal with user "simpk-test" and password "eieio"
		And I am on the "Patient List V2" tab
	@PKDEMO
	Scenario Outline: Verify number of labs on screen
		When I select "City Demo Patients" from the "Patient List" menu
		And I select patient "Molly Darr" from the patient list
		And I select "Lab Results" from clinical navigation
		And I select "Last Year" from the "Clinical Timeframe" menu
		And I select "All" from the "Lab Type" menu
		And I select "Panel Summary" from the "Lab Results View" menu
		Then the "Lab Panels" table should have at least "<results>" rows

	@pkdemo1PLV2
		Examples:
			| results |
			| 31      |

	@pkdemo2PLV2
		Examples:
			| results |
			| 31      |

	@pkdemo3PLV2
		Examples:
			| results |
			| 31      |

	@pkdemo4PLV2
		Examples:
			| results |
			| 31      |

	@pkdemo5PLV2
		Examples:
			| results |
			| 31      |
	@PKDEMO
	Scenario Outline: Verify number of test results on screen
		When I select "City Demo Patients" from the "Patient List" menu
		And I select patient "Molly Darr" from the patient list
		And I select "Test Results" from clinical navigation
		And I select "Last Year" from the "Clinical Timeframe" menu
		And I select "All" from the "Test Type" menu
		Then the "Test Results" table should have at least "<results>" rows

	@pkdemo1PLV2
		Examples:
			| results |
			| 11      |

	@pkdemo2PLV2
		Examples:
			| results |
			| 11      |

	@pkdemo3PLV2
		Examples:
			| results |
			| 11      |

	@pkdemo4PLV2
		Examples:
			| results |
			| 11      |

	@pkdemo5PLV2
		Examples:
			| results |
			| 11      |
	@PKDEMO
	Scenario Outline: Verify number of patients in facility
		When I select "<option>" from the "<menu>" menu
		And I wait "1" second
		Then there should be at least "<patients>" patients on the patient list

		@pkdemo1PLV2
		Examples:
			| option                  | menu         | patients |
			| Alliance Demo Patients  | Patient List | 20       |
			| City Demo Patients      | Patient List | 20       |
			| Easton Demo Patients    | Patient List | 20       |
			| Lakeside Demo Patients  | Patient List | 20       |
			| NWHealth Demo Patients  | Patient List | 20       |
			| Samaritan Demo Patients | Patient List | 20       |
			| Williams Demo Patients  | Patient List | 20       |

		@pkdemo2PLV2
		Examples:
			| option                  | menu         | patients |
			| Alliance Demo Patients  | Patient List | 20       |
			| City Demo Patients      | Patient List | 20       |
			| Easton Demo Patients    | Patient List | 20       |
			| Lakeside Demo Patients  | Patient List | 20       |
			| NWHealth Demo Patients  | Patient List | 20       |
			| Samaritan Demo Patients | Patient List | 20       |
			| Williams Demo Patients  | Patient List | 20       |

		@pkdemo3PLV2PLV2
		Examples:
			| option                  | menu         | patients |
			| Alliance Demo Patients  | Patient List | 20       |
			| City Demo Patients      | Patient List | 20       |
			| Easton Demo Patients    | Patient List | 20       |
			| Lakeside Demo Patients  | Patient List | 20       |
			| NWHealth Demo Patients  | Patient List | 20       |
			| Samaritan Demo Patients | Patient List | 20       |
			| Williams Demo Patients  | Patient List | 20       |

		@pkdemo4PLV2
		Examples:
			| option                  | menu         | patients |
			| Alliance Demo Patients  | Patient List | 20       |
			| City Demo Patients      | Patient List | 20       |
			| Easton Demo Patients    | Patient List | 20       |
			| Lakeside Demo Patients  | Patient List | 21       |
			| NWHealth Demo Patients  | Patient List | 20       |
			| Samaritan Demo Patients | Patient List | 21       |
			| Williams Demo Patients  | Patient List | 20       |

		@pkdemo5PLV2
		Examples:
			| option             | menu         | patients |
			| City Demo Patients | Patient List | 20       |
			| Hosp Assignment    | Patient List | 62       |
			| Coverage           | Patient List | 100      |
			
	@pkdemo1PLV2 @pkdemo2PLV2 @pkdemo3PLV2 @pkdemo4PLV2 @pkdemo5PLV2 @PKDEMO
	Scenario: No rejected HL7 messages
		Given I am on the "Admin" tab
		When I select the "Institution" subtab
		And I select "Interface Activity" from the "Edit Department Settings" dropdown in the "Department Edit Settings" pane
		And I click the "View Messages" link in the "Institution Main" pane
		And I select "Account Number" from the "SelectthesearchCriteria" dropdown
		And I enter "%" in the "Account Number" field
		And I enter "1" in the "Last N Days" field
		And I select "Rejected" from the "Message Status" dropdown
		And I click the "Submit Query" button in the "Admin Main" pane
		Then the text "There are no results for this query" should appear in the "Admin Main" pane
		
	@pkdemo1PLV2 @pkdemo3PLV2 @pkdemo4PLV2 @PKDEMO
	Scenario: Verify number of charges in holding bin
		Given I am on the "Charges" tab
		When I select the "Holding Bin" subtab
		And I click the "Reset Criteria" button in the "Holding Bin" pane
		And I select "Yesterday" from the "Timeframe" dropdown in the "Holding Bin" pane
		And I check the "Imported Charges Only" checkbox
		And I click the "Show Charges" button in the "Holding Bin" pane
		Then the "Holding Bin" table should have at least "7" rows
	@PKDEMO
	Scenario Outline: Verify number of patients with sign-out data
		Given I am on the "Patient Summary" tab
		When I select the "Sign-Out Summary" subtab
		And I select "Only Patients With Sign-Out" from the "Sign-Out Patients" menu
		And I select "<option>" from the "<menu>" menu
		And I wait "3" seconds
		Then the "Sign-Out" table should have at least "<results>" rows

		@pkdemo1PLV2
		Examples:
			| option                  | menu         | results |
			| Alliance Demo Patients  | Patient List | 10      |
			| City Demo Patients      | Patient List | 10      |
			| Easton Demo Patients    | Patient List | 10      |
			| Lakeside Demo Patients  | Patient List | 10      |
			| NWHealth Demo Patients  | Patient List | 10      |
			| Samaritan Demo Patients | Patient List | 10      |
			| Williams Demo Patients  | Patient List | 10      |

		@pkdemo3PLV2
		Examples:
			| option                  | menu         | results |
			| Alliance Demo Patients  | Patient List | 10      |
			| City Demo Patients      | Patient List | 10      |
			| Easton Demo Patients    | Patient List | 10      |
			| Lakeside Demo Patients  | Patient List | 10      |
			| NWHealth Demo Patients  | Patient List | 10      |
			| Samaritan Demo Patients | Patient List | 10      |
			| Williams Demo Patients  | Patient List | 10      |

		@pkdemo4PLV2
		Examples:
			| option                  | menu         | results |
			| Alliance Demo Patients  | Patient List | 10      |
			| City Demo Patients      | Patient List | 10      |
			| Easton Demo Patients    | Patient List | 10      |
			| Lakeside Demo Patients  | Patient List | 10      |
			| NWHealth Demo Patients  | Patient List | 10      |
			| Samaritan Demo Patients | Patient List | 10      |
			| Williams Demo Patients  | Patient List | 10      |
	@PKDEMO
	Scenario Outline: Verify number of patients with incomplete tasks
		Given I am on the "Patient Summary" tab
		When I select the "Sign-Out Summary" subtab
		And I select "Only Patients With Incomplete Tasks" from the "Sign-Out Patients" menu
		And I select "<option>" from the "<menu>" menu
		Then the "Sign-Out" table should have at least "<results>" rows

		@pkdemo1PLV2
		Examples:
			| option                  | menu         | results |
			| Alliance Demo Patients  | Patient List | 10      |
			| City Demo Patients      | Patient List | 10      |
			| Easton Demo Patients    | Patient List | 10      |
			| Lakeside Demo Patients  | Patient List | 10      |
			| NWHealth Demo Patients  | Patient List | 10      |
			| Samaritan Demo Patients | Patient List | 10      |
			| Williams Demo Patients  | Patient List | 10      |

		@pkdemo3PLV2
		Examples:
			| option                  | menu         | results |
			| Alliance Demo Patients  | Patient List | 10      |
			| City Demo Patients      | Patient List | 10      |
			| Easton Demo Patients    | Patient List | 10      |
			| Lakeside Demo Patients  | Patient List | 10      |
			| NWHealth Demo Patients  | Patient List | 10      |
			| Samaritan Demo Patients | Patient List | 10      |
			| Williams Demo Patients  | Patient List | 10      |

		@pkdemo4PLV2
		Examples:
			| option                  | menu         | results |
			| Alliance Demo Patients  | Patient List | 10      |
			| City Demo Patients      | Patient List | 10      |
			| Easton Demo Patients    | Patient List | 10      |
			| Lakeside Demo Patients  | Patient List | 10      |
			| NWHealth Demo Patients  | Patient List | 10      |
			| Samaritan Demo Patients | Patient List | 10      |
			| Williams Demo Patients  | Patient List | 10      |
			
			
	@pkdemo1PLV2 @pkdemo2PLV2 @pkdemo3PLV2 @pkdemo4PLV2 @PKDEMO
	Scenario: Verify number of documents to be signed
		Given I am on the "Inbox" tab
		When I select the "Messages" subtab
		Then the "Messages" table should have at least "4" rows containing the text "Scanned:"
		And the "Messages" table should have at least "21" rows not containing the text "Scanned:"
		
	@pkdemo1PLV2 @pkdemo3PLV2 @pkdemo4PLV2 @PKDEMO
	Scenario: Verify progress note(s) loaded from note cloner
		When I select "City Demo Patients" from the "Patient List" menu
		And I select patient "Mona Angeline" from the patient list
		And I select "Clinical Notes" from clinical navigation
		And I select "Last 24 Hours" from the "Clinical Timeframe" menu
		And I click the "Clinical Notes Filter" button in the "Clinical Notes Detail" pane
		And I wait "3" seconds
		And I check the "All" checkbox
		And I click the "OK Filter" button
		#inconsistencies in portal - Date vs Date/Time
		Then rows starting with the following should appear in the "Clinical Notes" table
			| Date*              | Note Type            |
			| %1 day ago MMDDYY% | Progress Note        |