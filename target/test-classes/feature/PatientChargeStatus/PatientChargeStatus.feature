@PatientChargeStatus
Feature: Patient Charge Status
Scenarios for testing the various Charges tabs.
Admin User and Department test cases have expected results from 'Admin Test Plan Results.xls'

	Scenario: Admin User - My Patients
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		When I select the "Patient Charge Status" subtab
		And I select "My Patients" from the "Patient Charge Status" menu
		And I select "All" from the "PCS Filter" menu
		And I uncheck the " My Charges Only" checkbox
		And I uncheck the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox
		Then the "Patient Charge Status" table should have "0" rows

	@PatientChargeStatus
	Scenario: Admin User - Dr. Smith, Selected Provider, Do Not Include All Visits (D14)
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Provider's Patients" from the "Patient Charge Status" menu
		And I enter "SMITH, JANE" in the "Provider Search" field in the "Patient Charge Status" pane
		And I select "Selected Provider" from the "Include Charges For" dropdown in the "Patient Charge Status" pane
		And I uncheck the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox
		And I click the "Provider Criteria Search" button in the "Patient Charge Status" pane
		And I wait "5" seconds
		Then the "PatientChargeStatus" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |     |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |

	@PatientChargeStatus
	Scenario: Admin User - Dr. Smith, Selected Provider, Include All Visits (D17)
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Provider's Patients" from the "Patient Charge Status" menu
		And I enter "SMITH, JANE" in the "Provider Search" field in the "Patient Charge Status" pane
		And I select "Selected Provider" from the "Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox
		And I click the "Provider Criteria Search" button in the "Patient Charge Status" pane
		Then the "PatientChargeStatus" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |     |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |

	@PatientChargeStatus
	Scenario: Admin User - Dr. Smith, Provider's Departments, Include All Visits (D18)
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Provider's Patients" from the "Patient Charge Status" menu
		And I enter "SMITH, JANE" in the "Provider Search" field in the "Patient Charge Status" pane
		And I select "Provider's Departments" from the "Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox
		And I click the "Provider Criteria Search" button in the "Patient Charge Status" pane
		Then the "PatientChargeStatus" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |     |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |

	@PatientChargeStatus
	Scenario: Admin User - Dr. Smith, All Departments, Include All Visits (D19)
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Provider's Patients" from the "Patient Charge Status" menu
		And I enter "SMITH, JANE" in the "Provider Search" field in the "Patient Charge Status" pane
		And I select "All Departments" from the "Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox
		And I click the "Provider Criteria Search" button in the "Patient Charge Status" pane
		Then the "PatientChargeStatus" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |     |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |

	@PatientChargeStatus
	Scenario: Admin User - Dr. Smith, Selected Provider, Include All Visits, Only Patients Missing Charges (D22)
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Provider's Patients" from the "Patient Charge Status" menu
		And I enter "SMITH, JANE" in the "Provider Search" field in the "Patient Charge Status" pane
		And I select "Selected Provider" from the "Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I check the "Only Patients Missing Charges" checkbox
		And I click the "Provider Criteria Search" button in the "Patient Charge Status" pane
		Then the "PatientChargeStatus" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |     |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |


   #TODO: Table does not match with Ruby table. Verify.
	@PatientChargeStatus
	Scenario: Admin User - Dr. Smith, Provider's Departments, Include All Visits (D23)
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Provider's Patients" from the "Patient Charge Status" menu
		And I enter "SMITH, JANE" in the "Provider Search" field in the "Patient Charge Status" pane
		And I select "Provider's Departments" from the "Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I check the "Only Patients Missing Charges" checkbox
		And I click the "Provider Criteria Search" button in the "Patient Charge Status" pane
		Then the "PatientChargeStatus" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |     |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |


  #TODO: Table does not match with Ruby table. Verify.
	@PatientChargeStatus
	Scenario: Admin User - Dr. Smith, All Departments, Include All Visits (D24)
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Provider's Patients" from the "Patient Charge Status" menu
		And I enter "SMITH, JANE" in the "Provider Search" field in the "Patient Charge Status" pane
		And I select "All Departments" from the "Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I check the "Only Patients Missing Charges" checkbox
		And I click the "Provider Criteria Search" button in the "Patient Charge Status" pane
		Then the "PatientChargeStatus" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |     |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |


  #TODO: Table does not match with Ruby table. Verify.
	@PatientChargeStatus
	Scenario: Admin User - Dr. Smith, Selected Provider, Do Not Include All Visits, Only Patients Missing Charges (D27)
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Provider's Patients" from the "Patient Charge Status" menu
		And I enter "SMITH, JANE" in the "Provider Search" field in the "Patient Charge Status" pane
		And I select "Selected Provider" from the "Include Charges For" dropdown in the "Patient Charge Status" pane
		And I uncheck the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I check the "Only Patients Missing Charges" checkbox
		And I click the "Provider Criteria Search" button in the "Patient Charge Status" pane
		Then the "PatientChargeStatus" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |     |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |

	@PatientChargeStatus
	Scenario: Admin User - Dr. Jones, Selected Provider, Include All Visits Deselected, Missing Charges Deselected (D35)
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Provider's Patients" from the "Patient Charge Status" menu
		And I enter "JONES, JUDY" in the "Provider Search" field in the "Patient Charge Status" pane
		And I select "Selected Provider" from the "Include Charges For" dropdown in the "Patient Charge Status" pane
		And I uncheck the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox in the "Patient Charge Status" pane
		And I click the "Provider Criteria Search" button in the "Patient Charge Status" pane
		Then the "PatientChargeStatus" table should look like this:
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT08 | DetailsIcon | 70Y | M | PCS.clin.1.PKHospital (Outpatient) | %1 day ago MMDD% 1:30pm        |  |  |  |  |     | Add  |     |
			| PCSTEST, PATIENT09 | DetailsIcon | 48Y | M | PCS.109.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT10 | DetailsIcon | 16Y | F | PCS.110.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT11 | DetailsIcon | 75Y | F | PCS.111.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |

	@PatientChargeStatus
	Scenario: Admin User - Dr. Jones, Selected Provider, Include All Visits, Missing Charges Deselected (D38)
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Provider's Patients" from the "Patient Charge Status" menu
		And I enter "JONES, JUDY" in the "Provider Search" field in the "Patient Charge Status" pane
		And I select "Selected Provider" from the "Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox
		And I click the "Provider Criteria Search" button in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT08 | DetailsIcon | 70Y | M | PCS.clin.1.PKHospital (Outpatient) | %1 day ago MMDD% 1:30pm        |  |  |  |  |     | Add  |     |
			| PCSTEST, PATIENT09 | DetailsIcon | 48Y | M | PCS.109.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT10 | DetailsIcon | 16Y | F | PCS.110.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT11 | DetailsIcon | 75Y | F | PCS.111.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |

	@PatientChargeStatus
	Scenario: Admin User - Dr. Jones, Provider's Departments, Include All Visits, Missing Charges Deselected (D39)
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Provider's Patients" from the "Patient Charge Status" menu
		And I enter "JONES, JUDY" in the "Provider Search" field in the "Patient Charge Status" pane
		And I select "Provider's Departments" from the "Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox in the "Patient Charge Status" pane
		And I click the "Provider Criteria Search" button in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT08 | DetailsIcon | 70Y | M | PCS.clin.1.PKHospital (Outpatient) | %1 day ago MMDD% 1:30pm        |  |  |  |  |     | Add  |     |
			| PCSTEST, PATIENT09 | DetailsIcon | 48Y | M | PCS.109.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT10 | DetailsIcon | 16Y | F | PCS.110.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT11 | DetailsIcon | 75Y | F | PCS.111.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |

	@PatientChargeStatus
	Scenario: Admin User - Dr. Jones, All Departments, Include All Visits, Missing Charges Deselected (D40)
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Provider's Patients" from the "Patient Charge Status" menu
		And I enter "JONES, JUDY" in the "Provider Search" field in the "Patient Charge Status" pane
		And I select "All Departments" from the "Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox
		And I click the "Provider Criteria Search" button in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT08 | DetailsIcon | 70Y | M | PCS.clin.1.PKHospital (Outpatient) | %1 day ago MMDD% 1:30pm        |  |  |  |  |     | Add  |     |
			| PCSTEST, PATIENT09 | DetailsIcon | 48Y | M | PCS.109.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT10 | DetailsIcon | 16Y | F | PCS.110.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT11 | DetailsIcon | 75Y | F | PCS.111.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |


  #TODO: Table does not match with Ruby table. Verify.
	@PatientChargeStatus
	Scenario: Admin User - Dr. Jones, Selected Provider, Include All Visits, Only Missing Charges (D43)
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Provider's Patients" from the "Patient Charge Status" menu
		And I enter "JONES, JUDY" in the "Provider Search" field in the "Patient Charge Status" pane
		And I select "Selected Provider" from the "Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I check the "Only Patients Missing Charges" checkbox
		And I click the "Provider Criteria Search" button in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT08 | DetailsIcon | 70Y | M | PCS.clin.1.PKHospital (Outpatient) | %1 day ago MMDD% 1:30pm        |  |  |  |  |     | Add  |     |
			| PCSTEST, PATIENT09 | DetailsIcon | 48Y | M | PCS.109.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT10 | DetailsIcon | 16Y | F | PCS.110.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT11 | DetailsIcon | 75Y | F | PCS.111.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |


  #TODO: Table does not match with Ruby table. Verify.
	@PatientChargeStatus
	Scenario: Admin User - Dr. Jones, Provider's Departments, Include All Visits, Only Missing Charges (D44)
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Provider's Patients" from the "Patient Charge Status" menu
		And I enter "JONES, JUDY" in the "Provider Search" field in the "Patient Charge Status" pane
		And I select "Provider's Departments" from the "Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I check the "Only Patients Missing Charges" checkbox
		And I click the "Provider Criteria Search" button in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT08 | DetailsIcon | 70Y | M | PCS.clin.1.PKHospital (Outpatient) | %1 day ago MMDD% 1:30pm        |  |  |  |  |     | Add  |     |
			| PCSTEST, PATIENT09 | DetailsIcon | 48Y | M | PCS.109.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT10 | DetailsIcon | 16Y | F | PCS.110.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT11 | DetailsIcon | 75Y | F | PCS.111.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |


  #TODO: Table does not match with Ruby table. Verify.
	@PatientChargeStatus
	Scenario: Admin User - Dr. Jones, All Departments, Include All Visits, Only Missing Charges (D45)
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Provider's Patients" from the "Patient Charge Status" menu
		And I enter "JONES, JUDY" in the "Provider Search" field in the "Patient Charge Status" pane
		And I select "All Departments" from the "Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I check the "Only Patients Missing Charges" checkbox
		And I click the "Provider Criteria Search" button in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT08 | DetailsIcon | 70Y | M | PCS.clin.1.PKHospital (Outpatient) | %1 day ago MMDD% 1:30pm        |  |  |  |  |     | Add  |     |
			| PCSTEST, PATIENT09 | DetailsIcon | 48Y | M | PCS.109.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT10 | DetailsIcon | 16Y | F | PCS.110.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT11 | DetailsIcon | 75Y | F | PCS.111.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |


  #TODO: Table does not match with Ruby table. Verify.
	@PatientChargeStatus
	Scenario: Admin User - Dr. Jones, Selected Provider, Do Not Include All Visits, Only Missing Charges (D48)
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Provider's Patients" from the "Patient Charge Status" menu
		And I enter "JONES, JUDY" in the "Provider Search" field in the "Patient Charge Status" pane
		And I select "Selected Provider" from the "Include Charges For" dropdown in the "Patient Charge Status" pane
		And I uncheck the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I check the "Only Patients Missing Charges" checkbox
		And I click the "Provider Criteria Search" button in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT08 | DetailsIcon | 70Y | M | PCS.clin.1.PKHospital (Outpatient) | %1 day ago MMDD% 1:30pm        |  |  |  |  |     | Add  |     |
			| PCSTEST, PATIENT09 | DetailsIcon | 48Y | M | PCS.109.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT10 | DetailsIcon | 16Y | F | PCS.110.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT11 | DetailsIcon | 75Y | F | PCS.111.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |

	@PatientChargeStatus
	Scenario: Department A - Selected Department, Include All Visits (D53) : DEV-69480
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Department's Patients" from the "Patient Charge Status" menu
		And I enter "PCSDepartmentA" in the "Department Search" field in the "Patient Charge Status" pane
		And I select "Selected Department" from the "Department Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox
		And I click the "Department Criteria Search" button in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |     |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |

	@PatientChargeStatus
	Scenario: Department A - All Departments, Include All Visits (D54) : DEV-69480
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Department's Patients" from the "Patient Charge Status" menu
		And I enter "PCSDepartmentA" in the "Department Search" field in the "Patient Charge Status" pane
		And I select "All Departments" from the "Department Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox
		And I click the "Department Criteria Search" button in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |     |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |

	@PatientChargeStatus
	Scenario: Department B - Selected Department, Include All Visits (D57) : DEV-69480
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Department's Patients" from the "Patient Charge Status" menu
		And I enter "PCSDepartmentB" in the "Department Search" field in the "Patient Charge Status" pane
		And I select "Selected Department" from the "Department Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox
		And I click the "Department Criteria Search" button in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |      |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |      |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |      |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |      | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT08 | DetailsIcon | 70Y | M | PCS.clin.1.PKHospital (Outpatient) | %1 day ago MMDD% 1:30pm        |  |  |  |  |     | Add  |     |
			| PCSTEST, PATIENT09 | DetailsIcon | 48Y | M | PCS.109.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT10 | DetailsIcon | 16Y | F | PCS.110.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT11 | DetailsIcon | 75Y | F | PCS.111.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |

	@PatientChargeStatus
	Scenario: Department B - All Departments, Include All Visits (D58) : DEV-69480
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Department's Patients" from the "Patient Charge Status" menu
		And I enter "PCSDepartmentB" in the "Department Search" field in the "Patient Charge Status" pane
		And I select "All Departments" from the "Department Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox
		And I click the "Department Criteria Search" button in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |      |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |      |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |      |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |      | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT08 | DetailsIcon | 70Y | M | PCS.clin.1.PKHospital (Outpatient) | %1 day ago MMDD% 1:30pm        |  |  |  |  |     | Add  |     |
			| PCSTEST, PATIENT09 | DetailsIcon | 48Y | M | PCS.109.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT10 | DetailsIcon | 16Y | F | PCS.110.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT11 | DetailsIcon | 75Y | F | PCS.111.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |

	@PatientChargeStatus
	Scenario: Department C - Selected Department, Include All Visits (D61) : DEV-69480
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Department's Patients" from the "Patient Charge Status" menu
		And I enter "PCSDepartmentC" in the "Department Search" field in the "Patient Charge Status" pane
		And I select "Selected Department" from the "Department Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox
		And I click the "Department Criteria Search" button in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |     |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |

	@PatientChargeStatus
	Scenario: Department C - All Departments, Include All Visits (D62) : DEV-69480
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Department's Patients" from the "Patient Charge Status" menu
		And I enter "PCSDepartmentC" in the "Department Search" field in the "Patient Charge Status" pane
		And I select "All Departments" from the "Department Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox
		And I click the "Department Criteria Search" button in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |     |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |

	@PatientChargeStatus
	Scenario: Department A - Selected Department, Include All Visits, Only Missing Charges (D66) : DEV-69480
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Department's Patients" from the "Patient Charge Status" menu
		And I enter "PCSDepartmentA" in the "Department Search" field in the "Patient Charge Status" pane
		And I select "Selected Department" from the "Department Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I check the "Only Patients Missing Charges" checkbox
		And I click the "Department Criteria Search" button in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |     |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |

	@PatientChargeStatus
	Scenario: Department A - All Departments, Include All Visits, Only Missing Charges (D67) : DEV-69480
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Department's Patients" from the "Patient Charge Status" menu
		And I enter "PCSDepartmentA" in the "Department Search" field in the "Patient Charge Status" pane
		And I select "All Departments" from the "Department Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I check the "Only Patients Missing Charges" checkbox
		And I click the "Department Criteria Search" button in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |     |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |

	@PatientChargeStatus
	Scenario: Department B - Selected Department, Include All Visits, Only Missing Charges (D70) : DEV-69480
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Department's Patients" from the "Patient Charge Status" menu
		And I enter "PCSDepartmentB" in the "Department Search" field in the "Patient Charge Status" pane
		And I select "Selected Department" from the "Department Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I check the "Only Patients Missing Charges" checkbox
		And I click the "Department Criteria Search" button in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |      |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |      |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |      |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |      | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT08 | DetailsIcon | 70Y | M | PCS.clin.1.PKHospital (Outpatient) | %1 day ago MMDD% 1:30pm        |  |  |  |  |     | Add  |     |
			| PCSTEST, PATIENT09 | DetailsIcon | 48Y | M | PCS.109.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT10 | DetailsIcon | 16Y | F | PCS.110.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT11 | DetailsIcon | 75Y | F | PCS.111.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |

	@PatientChargeStatus
	Scenario: Department B - All Departments, Include All Visits, Only Missing Charges (D71) : DEV-69480
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Department's Patients" from the "Patient Charge Status" menu
		And I enter "PCSDepartmentB" in the "Department Search" field in the "Patient Charge Status" pane
		And I select "All Departments" from the "Department Include Charges For" dropdown in the "Patient Charge Status" pane
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I check the "Only Patients Missing Charges" checkbox
		And I click the "Department Criteria Search" button in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |      |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |      |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |      |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |      | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT08 | DetailsIcon | 70Y | M | PCS.clin.1.PKHospital (Outpatient) | %1 day ago MMDD% 1:30pm        |  |  |  |  |     | Add  |     |
			| PCSTEST, PATIENT09 | DetailsIcon | 48Y | M | PCS.109.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT10 | DetailsIcon | 16Y | F | PCS.110.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT11 | DetailsIcon | 75Y | F | PCS.111.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |


#No medical services are returned when performing Medical Service search as adminpcs user
	@PatientChargeStatus @donotrun
	Scenario: Medical Service PCS-1 - Selected Department, Include All Visits, Only Missing Charges (D76)
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I select "Medical Service's Patients" from the "Patient Charge Status" menu
		And I enter "PCS-1" in the "Medical Service Search" field in the "Patient Charge Status" pane
		And I click the "Medical Service Criteria Search" button in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |     |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |

	@PatientChargeStatus
	Scenario: Dr. Jones - Include All Visits Deselected, Missing Charges Deselected (B8)
		Given I am logged into the portal with user "JonesPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I uncheck the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT08 | DetailsIcon | 70Y | M | PCS.clin.1.PKHospital (Outpatient) | %1 day ago MMDD% 1:30pm        |  |  |  |  |     | Add  |     |
			| PCSTEST, PATIENT09 | DetailsIcon | 48Y | M | PCS.109.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT10 | DetailsIcon | 16Y | F | PCS.110.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT11 | DetailsIcon | 75Y | F | PCS.111.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |

	@PatientChargeStatus
	Scenario: Dr. Jones - Include All Visits, Missing Charges Deselected (B9)
		Given I am logged into the portal with user "JonesPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT08 | DetailsIcon | 70Y | M | PCS.clin.1.PKHospital (Outpatient) | %1 day ago MMDD% 1:30pm        |  |  |  |  |     | Add  |     |
			| PCSTEST, PATIENT09 | DetailsIcon | 48Y | M | PCS.109.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT10 | DetailsIcon | 16Y | F | PCS.110.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT11 | DetailsIcon | 75Y | F | PCS.111.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |

	@PatientChargeStatus
	Scenario: Dr. Jones - Include All Visits Deselected, Missing Charges (B10)
		Given I am logged into the portal with user "JonesPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I uncheck the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I check the "Only Patients Missing Charges" checkbox in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT08 | DetailsIcon | 70Y | M | PCS.clin.1.PKHospital (Outpatient) | %1 day ago MMDD% 1:30pm        |  |  |  |  |     | Add |     |
			| PCSTEST, PATIENT09 | DetailsIcon | 48Y | M | PCS.109.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT10 | DetailsIcon | 16Y | F | PCS.110.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT11 | DetailsIcon | 75Y | F | PCS.111.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |

	@PatientChargeStatus
	Scenario: Dr. Smith - Include All Visits Deselected, Missing Charges Deselected (B18)
		Given I am logged into the portal with user "SmithPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I uncheck the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |     |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |

	@PatientChargeStatus
	Scenario: Dr. Smith - Include All Visits, Missing Charges Deselected (B19)
		Given I am logged into the portal with user "SmithPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |     |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |     |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |

	@PatientChargeStatus
	Scenario: Dr. Smith - Include All Visits Deselected, Missing Charges (B20)
		Given I am logged into the portal with user "SmithPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I uncheck the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I check the "Only Patients Missing Charges" checkbox in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |     |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add | Add |

	@PatientChargeStatus
	Scenario: Dr. Smith - Level 2 user, Include All Visits Deselected, Missing Charges (B24,B25,B28,B29)
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Admin" tab
		And I select the "User" subtab
		And I search for the user "SmithPCS"
		When I select the user "SmithPCS"
		When I click the "Edit" button in the "Quick Details" pane
		When I edit the following user settings and I click save
			| Page    | Type     | Name       | Value   |
			| General | dropdown | Pat Access | Level 2 |
		Given I am logged into the portal with user "SmithPCS" and password "123"
		And I am on the "Charges" tab
		And I select the "Patient Charge Status" subtab
		And I check the "Include All Visits" checkbox in the "Patient Charge Status" pane
		And I uncheck the "Only Patients Missing Charges" checkbox
		And I select "Department's Patients" from the "Patient Charge Status" menu
		And I enter "PCSDepartmentB" in the "Department Search" field in the "Patient Charge Status" pane
		And I select "Selected Department" from the "Department Include Charges For" dropdown in the "Patient Charge Status" pane
		And I click the "Department Criteria Search" button in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |      |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |      |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |      |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |      | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT08 | DetailsIcon | 70Y | M | PCS.clin.1.PKHospital (Outpatient) | %1 day ago MMDD% 1:30pm        |  |  |  |  |     | Add  |     |
			| PCSTEST, PATIENT09 | DetailsIcon | 48Y | M | PCS.109.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT10 | DetailsIcon | 16Y | F | PCS.110.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT11 | DetailsIcon | 75Y | F | PCS.111.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
		When I select "All Departments" from the "Department Include Charges For" dropdown in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |      |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |      |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |      |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT08 | DetailsIcon | 70Y | M | PCS.clin.1.PKHospital (Outpatient) | %1 day ago MMDD% 1:30pm        |  |  |  |  |     | Add  |     |
			| PCSTEST, PATIENT09 | DetailsIcon | 48Y | M | PCS.109.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT10 | DetailsIcon | 16Y | F | PCS.110.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT11 | DetailsIcon | 75Y | F | PCS.111.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
		When I check the "Only Patients Missing Charges" checkbox
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |      |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |      |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |      |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT08 | DetailsIcon | 70Y | M | PCS.clin.1.PKHospital (Outpatient) | %1 day ago MMDD% 1:30pm        |  |  |  |  |     | Add  |     |
			| PCSTEST, PATIENT09 | DetailsIcon | 48Y | M | PCS.109.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT10 | DetailsIcon | 16Y | F | PCS.110.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT11 | DetailsIcon | 75Y | F | PCS.111.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
		When I select "Selected Department" from the "Department Include Charges For" dropdown in the "Patient Charge Status" pane
		Then the "Patient Charge Status" table should look like this:
			| PCSTEST, PATIENT01 | DetailsIcon | 65Y | F | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 1:30pm       |  |  |  |  | Add |      |     |
			|                    |             |     |   | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 2:30pm       |  |  |  |  | Add |      |     |
			| PCSTEST, PATIENT02 | DetailsIcon | 38Y | M | PCS.clin.1.PKHospital (Outpatient) | %2 days ago MMDD% 8:00am       |  |  |  |  | Add |      |     |
			|                    |             |     |   | PCS.102.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:9% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT03 | DetailsIcon | 41Y | M | PCS.103.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT04 | DetailsIcon | 67Y | M | PCS.104.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT05 | DetailsIcon | 55Y | M | PCS.105.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:0 time:6% |  |  |  |  |     |     | Add |
			| PCSTEST, PATIENT06 | DetailsIcon | 42Y | M | PCS.106.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT07 | DetailsIcon | 19Y | F | PCS.107.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT08 | DetailsIcon | 70Y | M | PCS.clin.1.PKHospital (Outpatient) | %1 day ago MMDD% 1:30pm        |  |  |  |  |     | Add  |     |
			| PCSTEST, PATIENT09 | DetailsIcon | 48Y | M | PCS.109.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT10 | DetailsIcon | 16Y | F | PCS.110.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT11 | DetailsIcon | 75Y | F | PCS.111.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
			| PCSTEST, PATIENT12 | DetailsIcon | 61Y | M | PCS.112.1.PKHospital (Inpatient)   | LOS:%calcLOS daysAgo:2 time:8% |  |  |  |  | Add | Add  | Add |
		Given I am logged into the portal with user "AdminPCS" and password "123"
		And I am on the "Admin" tab
		And I select the "User" subtab
		And I search for the user "SmithPCS"
		When I select the user "SmithPCS"
		When I click the "Edit" button in the "Quick Details" pane
		When I edit the following user settings and I click save
			| Page    | Type     | Name       | Value   |
			| General | dropdown | Pat Access | Level 3 |



