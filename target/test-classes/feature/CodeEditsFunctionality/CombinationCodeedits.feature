@CombinationCodeEdits
Feature: CombinationCodeedit

	Background:
		Given I am logged into the portal with user "combcodeedit3" using the default password
		And I am on the "Patient List V2" tab

 #Moved to setUp in CukeRunnerTEst.java
#	Scenario: Turn on all codeedits on user server
#		And I execute the "Enable All Code Edits" query

	Scenario Outline: Age-Inpatient
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT             |ICD           |Message                                                                                            |
			|MOLLY DARR       |19396           |              |This charge is inconsistent with the female patients of this age                                   |
			|MOLLY DARR       |94011           |              |This charge is inconsistent with the patient's age for this CPT.                                   |
			|ATENA* FINANCIAL |49496           |              |This charge is inconsistent with this patient's age range(15y to 90y) for 'AETNA' financial class. |
			|Test Codeedit-2  |23420           |              |This charge is inconsistent for this patient's age at this Place of Service                        |
			|TEST CODEEDIT-15 |68760           |              |This charge is inappropriate with this patient's age range(15y - 75y) for this medical necessity.  |
			|MOLLY DARR       |21206           |M86.10;A78    |This charge is inconsistent for this patient's age with this Dx combination.                       |
			|MOLLY DARR       |89125           |R94.112;B95.8 |This charge is inconsistent for this patient's age group(18y to 90y) with the specified Dx Order.  |
			|Test Codeedit-16 |35013           |              |If you are the admitting and/or attending physician, please select modifier:                       |
			|Test Codeedit-16 |93286           |              |This charge is inconsistent with the patient's age for this role.                                  |
			|MOLLY DARR       |21181           |              |This modifier is inappropriate for this CPT for this patient's age.                                |
			|MOLLY DARR       |64630:2;36440:1 |              |This charge is inconsistent for this patients age for this CPT comparision Required Quantity       |
			|Test Codeedit-2  |90708           |T88.1XXA      |This charge is inappropriate for this patient's age range(0y - 90y) for this diagnosis.            |
			|MOLLY DARR       |00103           |              |This charge is inconsistent for this patients age for this included header.                        |
			|MOLLY DARR       |00120           |              |This charge is inconsistent with the patient's age for this excluded Billing Provider header      |

	Scenario Outline: Age-Outpatient
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Outpatient             |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient    |CPT   |Message                                                                                                              |
			|MOLLY DARR |00561 |This service is inconsistent with the selected site of service. Consider another code based on this site of service. |

	Scenario: Age Department
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "MOLLY DARR" is on the patient list
		When I select patient "MOLLY DARR" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Outpatient             |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "25505"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent for this patients age and department" should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario: Age Role User
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "TEST CODEEDIT-16" is on the patient list
		When I select patient "TEST CODEEDIT-16" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "93286"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent with the patient's age for this role." should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario Outline: Gender-Inpatient
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "CloseMod" element if it exists
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT             |ICD           |Message                                                                       |
			|MOLLY DARR       |89353           |              |This charge is inappropriate with female patients with this age.              |
			|ROY BLAZER       |58825           |              |This charge is inconsistent for male patients                                 |
			|ATENA* FINANCIAL |89264           |              |This charge is inconsistent with female patients for 'AETNA' financial class. |
			|ROY BLAZER       |45000           |M95.5;M12.9   |This charge is inconsistent for male patients for this Dx order               |
			|ROY BLAZER       |00952           |              |This charge is inconsistent with male patients with this role.                |
			|ROY BLAZER       |74742           |              |This charge is inconsistent for male patients for this included header        |
			|ROY BLAZER       |58615           |C80.1         |The CPT 58615 is inconsistent with the patient's listed gender of Male.       |
			|ROY BLAZER       |58600           |              |This charge is inconsistent with male patients for this medical necessity.    |
			|ROY BLAZER       |50722           |P00.5;E34.8   |This charge is inconsistent with male patients for this Dx combination.       |
			|ROY BLAZER       |58822           |              |This charge is inconsistent with male patients with this missing modifier.    |
			|ROY BLAZER       |58752-LD        |              |This charge and modifier are inappropriate for male patient.                  |
			|ROY BLAZER       |58951:2;58957:2 |              |This charge is inconsistent for male patient for this quantity.               |

	Scenario Outline: Gender-Outpatient
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT   |Message                                                                           |
			|Test Codeedit-12 |58970 |This charge is inconsistent with male patients with this visit type.               |
			|ROY BLAZER       |84830 |This charge is inconsistent with this patient's gender and this place of service. |

	Scenario: Gender Header excluded
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "ROY BLAZER" is on the patient list
		When I select patient "ROY BLAZER" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
			|Referring    |DEV1, PK               |
		And I enter the CPT codes "99501"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent for male patients for this excluded header" should appear in the "Charge Entry" pane
		And I click the "Close" image
		And I click the logout button

	Scenario Outline: CPT-Inpatient
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT             |ICD              |Message                                                                |
			|Neil Heath       |94013           |                 |This charge is inconsistent for this patient's age with this CPT.      |
			|ROY BLAZER       |77059           |                 |This charge is inconsistent with this CPT for male patients            |
			|ATENA* FINANCIAL |72255           |                 |This charge is inconsistent with this CPT for 'AETNA' financial class. |
			|ROY BLAZER       |50845           |                 |This charge is inappropriate with this CPT for this Place of Service.  |
			|ROY BLAZER       |15150           |F43.29;R89.8     |This charge is inconsistent with this CPT for this Dx order            |
			|MOLLY DARR       |01810           |                 |This charge is inconsistent with this CPT for inpatient visits         |
			|MOLLY DARR       |64744           |                 |This charge is inconsistent with this CPT for this Role                |
			|MOLLY DARR       |72202           |                 |This charge is inconsistent for this CPT with this excluded header.    |
			|MOLLY DARR       |15776           |Q84.9            |This charge is inconsistent with this CPT for this diagnosis.          |
			|MOLLY DARR       |64823           |                 |This charge is inconsistent with this CPT for this medical necessity.  |
			|MOLLY DARR       |26030           |L03.119;T14.8XXD |This charge is inconsistent with this CPT for this Dx Combination.     |
			|MOLLY DARR       |26025           |                 |This charge is inconsistent with this CPT for this Missing Modifier    |
			|MOLLY DARR       |26121           |                 |This charge is inconsistent with this CPT and this modifier.           |
			|MOLLY DARR       |26489:2;64722:2 |                 |This charge is inconsistent with this CPT and this quantity.           |
			|ROY BLAZER       |43644           |                 |This charge is inconsistent for this CPT with this included header.    |

	Scenario: CPT Department
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "ROY BLAZER" is on the patient list
		When I select patient "ROY BLAZER" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |tczbill                |
			|Svc Site     |Outpatient             |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "62100"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent with this CPT for this department." should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario Outline: Department-Inpatient
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "CloseMod" element if it exists
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT             |ICD          |Message                                                                                             |
			|MOLLY DARR       |29065           |             |This charge is inconsistent with 'CC-D1' department for the patients with age range 0y to 90y.      |
			|Neil Heath       |64561           |             |This charge is inconsistent with CC - D1' department for the patient listed gender male             |
			|MOLLY DARR       |96902           |             |This charge is inconsistent with 'CC - D1' department for this CPT.                                 |
			|ATENA* FINANCIAL |22112           |             |This charge is inconsistent with 'CC - D1' department for 'AETNA' financial class.                  |
			|MOLLY DARR       |11311           |             |This charge is inconsistent with 'CC - D1' department for this medical necessity.                   |
			|MOLLY DARR       |89330           |N97.8;N87.9  |This service is inconsistent with the patient's listed gender of Female.                            |
			|MOLLY DARR       |87252           |             |This CPT requires to add CPT:87220 as an add on code with 'CC-D1' department                        |
			|MOLLY DARR       |27495           |             |This charge is inconsistent with 'CC - D1' department for Inpatient Visit Type.                     |
			|MOLLY DARR       |64727           |             |This charge is inconsistent with this Department for this role.                                     |
			|MOLLY DARR       |90887           |             |This charge is inconsistent with 'CC - D1' Department for this excluded header.                     |
			|MOLLY DARR       |53240           |D49.511      |This charge is inappropriate for 'CC - D1' department for this diagnosis.                           |
			|MOLLY DARR       |11752           |L60.9;Q38.3  |This charge is inconsistent with 'CC - D1' department for this Dx combination.                      |
			|MOLLY DARR       |11730           |             |This charge is inconsistent with 'CC - D1' department with this missing modifier.                   |
			|MOLLY DARR       |24470-25        |             |This charge is inappropriate with 'CC - D1' department with this modifier.                          |
			|MOLLY DARR       |28160:2;14350:2 |             |This charge is inappropriate with this department for this Quantity.Minimum Qty to be specified:15. |
			|ROY BLAZER       |28825;28010     |             |This charge is inappropriate with 'CC - D1' department for this Global Period                       |

	Scenario Outline: Department Outpatient
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Outpatient             |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT      |Message                                                                        |
			|Test Codeedit-12 |45330    |This charge is inconsistent for 'CC - D1' department for this included header. |
			|ROY BLAZER       |15776    |This charge is inconsistent with this place of service for this department     |

	Scenario: Gender Department
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "ROY BLAZER" is on the patient list
		When I select patient "ROY BLAZER" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |tczbill                |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
			|Referring    |DEV1, PK               |
		And I enter the CPT codes "57540"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent with male patients for TCZ department." should appear in the "Charge Entry" pane
		And I click the "Close" image
		And I click the logout button

	Scenario Outline: PK Visit Type-Inpatient
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "CloseMod" element if it exists
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

	Examples:
			|Patient          |CPT             |ICD           |Message                                                                                  |
			|Test Codeedit-2  |99326           |              |This charge is inconsistent with the Inpatient of this age                               |
			|MOLLY DARR       |4266F           |              |This charge is inconsistent with the Inpatient for this Department                       |
			|MOLLY DARR       |99310C          |              |This charge is inconsistent with the Inpatient for this Role                             |
			|ATENA* FINANCIAL |80101           |              |This charge is inconsistent with the Inpatient for this Financial Class                  |
			|MOLLY DARR       |95929           |R29.898;R20.9 |This charge is inconsistent with the Dx order for this PK Visit Type                     |
			|MOLLY DARR       |33786           |I72.9         |This charge is inconsistent with the Inpatient for this Dx Alert                         |
			|MOLLY DARR       |4171F           |              |This charge is inconsistent with the Inpatient for this included Header                  |
			|MOLLY DARR       |99455           |              |This charge is inconsistent with the Inpatient for this Diagnosis Med Necessity          |
			|MOLLY DARR       |99285           |              |This charge is inconsistent with the Inpatient for this missing modifier                 |
			|MOLLY DARR       |99255-22        |              |This charge is inconsistent with the Inpatient for this inappropriate modifier           |
			|MOLLY DARR       |64714           |              |This charge is inconsistent with the Inpatient for this CPT Comparison Add on Codes      |
			|MOLLY DARR       |84484:1;87482:1 |              |This charge is inconsistent with the Inpatient for this CPT Comparison Required Quantity |
			|MOLLY DARR       |4172F           |              |This charge is inconsistent with the Inpatient for this excluded Header                  |

	Scenario Outline: PK Visit Type Outpatient
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT   |Message                                                                  |
			|Test Codeedit-13 |73702 |This charge is inconsistent with the Outpatient for this gender          |
			|MOLLY DARR       |3112F |This charge is inconsistent with the Inpatient for this Place of Service |

	Scenario: PK Visit Type - ER
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "25 AUTODCTEST" is on the patient list
		When I select patient "25 AUTODCTEST" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |ER                     |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "20985"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent with the ER for this CPT" should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario Outline: Global Period
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		And I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT         |Message                                                                                                                           |
			|ROY BLAZER       |61864;61875 |This charge is inconsistent with 'Inpatient' OR 'Other' Place of service with this missing modifer:                               |
			|MOLLY DARR       |61850;61860 |This charge is inconsistent with the CPT Comparison Global Period for this PK Visit Type                                          |
			|MOLLY DARR       |29871;29873 |This charge is inconsistent with the Global Period having Primary CPT : 29871 and Secondary CPT : 29873 for this Department       |
			|MOLLY DARR       |26755;26770 |This charge is inconsistent with the Global Period having Primary CPT : 26755 and Secondary CPT : 26770 for this Place of Service |
			|ATENA* FINANCIAL |87210;88160 |This charge is inconsistent with 'AETNA' financial class for this global period                                                   |
			|ATENA* FINANCIAL |01714;01740 |This charge is inconsistent with the Global Period having Primary CPT : 01714 and Secondary CPT : 01740 for this Financial Class  |

	Scenario Outline: Mod Missing -Inpatient
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT             |ICD      |Message                                                                                              |
			|Test Codeedit-2  |3284F           |         |This charge is inconsistent with the Missing modifier 52 for this age                                |
			|ROY BLAZER       |53860           |         |This charge is inconsistent with the Missing Modifier 56 for this Gender                             |
			|MOLLY DARR       |99071           |         |This charge is inconsistent with the Missing Modifier 57 for this CPT                                |
			|MOLLY DARR       |94003           |         |This charge is inconsistent with the Missing modifier CA for this PK Visit Type                      |
			|MOLLY DARR       |45327           |         |This charge is inconsistent with the Missing modifier 25 for this Place of Service                   |
			|MOLLY DARR       |4043F           |         |This charge is inconsistent with the Missing modifier 53 for this Department                         |
			|MOLLY DARR       |99383           |T50.991A |This charge is inconsistent with the Missing Modifier 91 for this Diagnosis                          |
			|MOLLY DARR       |29065;29085     |         |This charge is inconsistent with the Inappropriate Modifier 23 for this Add on Codes 29065 and 29085 |
			|ATENA* FINANCIAL |80101           |         |This charge is inconsistent with the Missing Modifier 26 for this Financial Class                    |
			|MOLLY DARR       |88165           |         |This charge is inconsistent with the Missing modifier 81 for this Role                               |

	Scenario: Mod missing - Header excluded
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "ROY BLAZER" is on the patient list
		When I select patient "ROY BLAZER" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
			|Injury Type  |MVA                    |
		And I enter the CPT codes "26034"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent with the Missing Modifier F1 for this excluded Header" should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario: Mod Missing Header included
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "Test Codeedit-12" is on the patient list
		When I select patient "Test Codeedit-12" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Outpatient             |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "29085"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent with the Missing Modifier FA for this included Header" should appear in the "Charge Entry" pane
		And I click the "Close" image
		And I click the logout button

	Scenario Outline: Mod Missing -Inappropriate
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT>"
		And I click the "CloseMod" element if it exists
		And I enter the ICD-10 codes "<ICD>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT       |ICD    |Message                                                                                  |
			|Test Codeedit-2  |59820-54  |       |This charge is inconsistent with the inappropriate modifier 54 for this Age              |
			|ROY BLAZER       |59830-66  |       |This charge is inconsistent with the Inappropriate Modifier 66 for this Gender           |
			|ROY BLAZER       |99144-77  |       |This charge is inconsistent with the Inappropriate Modifier 77 for this CPT              |
			|ROY BLAZER       |99356-27  |       |This charge is inconsistent with the Inappropriate Modifier 27 for this PK Visit Type    |
			|ROY BLAZER       |3100F-90  |       |This charge is inconsistent with the Inappropriate Modifier 90 for this Place of Service |
			|ROY BLAZER       |1015F-47  |       |This charge is inconsistent with the inappropriate Modifier 47 for this Department       |
			|ROY BLAZER       |43325-50  |K31.84 |This charge is inconsistent with the Inappropriate Modifier 50 for this Diagnosis        |

	Scenario: Mod Inappropriate Excluded Header
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "Test Codeedit-12" is on the patient list
		When I select patient "Test Codeedit-12" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Outpatient             |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "35860-55"
		And I click the "CloseMod" element if it exists
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent with the Inappropriate Modifier 55 for this excluded Header" should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario: Mod Inappropriate Roles
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "MOLLY DARR" is on the patient list
		When I select patient "MOLLY DARR" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "1015F-47"
#		And I add the modifier "47" to the CPT code "1015F"
		And I click the "CloseMod" element if it exists
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent with the inappropriate Modifier 47 for this Department" should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario: Mod Inappropriate Header Included
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "MOLLY DARR" is on the patient list
		When I select patient "MOLLY DARR" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "90816-82"
#		And I add the modifier "55" to the CPT code "90816"
		And I click the "CloseMod" element if it exists
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent with the Inappropriate Modifier 82 for this included Header" should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario Outline: Qty - Inpatient
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value     |
			|Bill Area    |CC-D1     |
			|Svc Site     |Inpatient |
			|Billing Prov |DEV0, PK  |
			|Injury Type  |MVA       |
		And I enter the CPT codes "<CPT>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT             |ICD      |Message                                                                                                                       |
			|Test Codeedit-2  |84378:1;84379:1 |         |This charge is inconsistent with the Primary CPT : 84378 and Secondary CPT : 84379 having Required Quantity 2 for this Age    |
			|Molly Darr       |54900:1;54901:1 |         |This charge is inconsistent with the Primary CPT : 54900 and Secondary CPT : 54901 having Required Quantity 2 for this Gender |
			|Molly Darr       |33973:1;33974:1 |         |This charge is inconsistent having Required Quantity 2 for this CPT                                                           |
			|TEST CODEEDIT-6  |45334:1;45335:1 |         |This charge is inconsistent with the having Required Quantity 2 for this Financial Class                                      |
			|Molly Darr       |48120:1;48140:1 |         |This charge is inconsistent with the CPTs 48120 and 48140 having the required quantity 2 for this Place of Service            |
			|Molly Darr       |44721:1;44720:1 |         |This charge is inconsistent with the CPT 44721 having the Required Quantity 2 for this Department                             |
			|Molly Darr       |15630:1;15650:1 |T85.890A |This charge is inconsistent with the CPT 15630 having the Required Quantity 2 for this Diagnosis                              |
			|Molly Darr       |61797:1         |         |This charge is inconsistent with the CPT 61797 having the Required Quantity 2 for this CPT Comparison Add on Codes            |
			|ROY BLAZER       |97535:1;97537:1 |         |This charge is inconsistent with the CPT 97535 having the Required Quantity 2 for this Role                                   |

	Scenario Outline: Qty - Headers
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value     |
			|Bill Area    |CC-D1     |
			|Svc Site     |Inpatient |
			|Billing Prov |DEV0, PK  |
			|Injury Type  |MVA       |
		And I enter the CPT codes "<CPT>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient         |CPT             |Message                                                                                                |
			|Molly Darr      |95149:1;95148:1 |This charge is inconsistent with the CPT 95149 having the Required Quantity 2 for this excluded Header |
			|Molly Darr      |70310:1;70320:1 |This charge is inconsistent with the CPT 70310 having the Required Quantity 2 for this included Header |

	Scenario: Quantity PK Visit Type
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "TEST CODEEDIT-14" is on the patient list
		When I select patient "TEST CODEEDIT-14" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Outpatient             |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "11444;11426"
#		And I change the Qty by "1"
#		And I set the quantity on the CPT code "2" to "1"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent with the CPT 11444 having the Required Quantity 2 for this PK Visit Type" should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario Outline: Financial Class
#		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |<Site Detail>          |
			|Billing Prov |CODEEDIT3, COMBINATION |
			|Injury Type  |MVA                    |
		And I enter the CPT codes "<CPT>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "CloseMod" element if it exists
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient         |CPT         |ICD           |Message                                                                                                                                          |Site Detail |
			|TEST CODEEDIT-6 |90460       |              |This charge is inconsistent with this Financial Class for this patient's age.                                                                    |Inpatient   |
			|TEST CODEEDIT-6 |89344       |              |This charge is inconsistent with this Financial Class for male patients.                                                                         |Inpatient   |
			|TEST CODEEDIT-6 |74260       |              |This charge is inconsistent with 'AETNA' financial class for this CPT.                                                                           |Inpatient   |
			|TEST CODEEDIT-6 |83986       |              |This charge is inconsistent with 'AETNA' financial class for 'CC - D1' department.                                                               |Inpatient   |
			|TEST CODEEDIT-6 |31830       |L90.5         |This charge is inconsistent with 'AETNA' financial class with this Dx: L90.5 OR L90.5                                                            |Inpatient   |
			|TEST CODEEDIT-6 |33976       |              |This charge is inconsistent with 'AETNA' financial class with this medical necessity.                                                            |Inpatient   |
			|TEST CODEEDIT-6 |23921       |T87.9;M62.9   |This charge is inconsistent with 'AETNA' financial class for this Dx combination.                                                                |Inpatient   |
			|TEST CODEEDIT-6 |44137       |              |This charge is inconsistent with 'AETNA' financial class with the specified Dx order,Dx Primary : H50.00 OR H50.00, Dx Secondary :K22.0 OR K22.0 |Inpatient   |
			|TEST CODEEDIT-6 |85246       |              |This charge is inconsistent with 'AETNA' financial class and requires the missing modifier: 57                                                   |Inpatient   |
			|TEST CODEEDIT-6 |85170-74    |              |This charge is inappropriate with 'AETNA' financial class and modifier 74.                                                                       |Inpatient   |
			|TEST CODEEDIT-6 |85210       |              |This CPT requires CPT: 85220 as an Add on Code for 'AETNA' financial class.                                                                      |Inpatient   |
			|TEST CODEEDIT-6 |92977;92975 |              |This charge is inconsistent with 'AETNA' financial class for this required quantity.Minimum required qty: 4                                      |Inpatient   |
			|TEST CODEEDIT-9 |88175       |              |This charge is inconsistent with 'AETNA' financial class for 'Outpatient' visit type.                                                            |Outpatient  |
			|TEST CODEEDIT-9 |67036       |              |This charge is inconsistent with 'AETNA' financial class for 'Outpatient' place of service.                                                      |Outpatient  |
			|TEST CODEEDIT-6 |95010       |              |If you are a 'USER' or 'REFERRING' provider you cannot charge to 'AETNA' financial class.                                                        |Inpatient   |

	Scenario Outline: Financial Class - Headers Excluded
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value           |
			|Bill Area    |CC - BillArea1  |
			|Svc Site     |<Site Detail>   |
			|Billing Prov |DEV0, PK        |
			|Injury Type  |MVA             |
		And I enter the CPT codes "<CPT>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image
		And I click the logout button

		Examples:
			|Patient         |CPT   |Message                                                                                                                                                                                                          |Site Detail |
			|TEST CODEEDIT-6 |72159 |This charge is inconsistent with 'AETNA' financial class with 'CC - BillArea1' Billing Area excluded header.                                                                                                     |Inpatient   |

	Scenario Outline: Financial Class - Headers Included
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |<Site Detail>          |
			|Billing Prov |CODEEDIT3, COMBINATION |
			|Injury Type  |MVA                    |
		And I enter the CPT codes "<CPT>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient         |CPT   |Message                                                                                                                               |Site Detail |
			|TEST CODEEDIT-6 |22552 |This charge is inconsistent with 'AETNA' financial class with included headers: Billing Provider(DEV1, PK) and 'Outpatient' svc site. |Inpatient   |

	Scenario Outline: Headers - CC-D1
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name           |Value                  |
			|Bill Area      |CC-D1                  |
			|Svc Site       |<Site Detail>          |
			|Billing Prov   |CODEEDIT3, COMBINATION |
			|Referring      |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "CloseMod" element if it exists
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT             |ICD           |Message                                                                                                                                                                                |Site Detail |
			|TEST CODEEDIT-14 |12036:1;12031:1 |              |This charge is inconsistent with the included header(Bill Area: CC - BillArea1, Billing Prov: DEV1, PK) with this Qty. Req Qty: 5                                                      |Outpatient  |
			|MOLLY DARR       |29581-T6        |              |This charge is inappropriate for these included headers (Referring: DEV0, PK OR Billing Prov: DEV1, PK) with this mod: T6                                                              |Inpatient   |
			|MOLLY DARR       |62141           |              |This charge is inappropriate for these included headers (Referring: DEV0, PK OR Billing Prov: DEV1, PK) with this missing mod: 90                                                      |Inpatient   |
			|MOLLY DARR       |47144           |K90.89;R18.8  |This charge is inappropriate for these included headers (Referring: DEV0, PK OR Billing Prov: DEV1, PK) with this Dx Order: Dx Primary :K90.89 OR  K90.9 , Dx Secondary :  R18.8 R18.8 |Inpatient   |
			|MOLLY DARR       |92570           |R47.89;R50.9  |This charge is inappropriate for these included headers (Referring: DEV0, PK OR Billing Prov: DEV1, PK) with this Dx Combination.                                                      |Inpatient   |
			|TEST CODEEDIT-14 |20220           |              |This charge is inconsistent with this included header for 'Inpatient' Place of service.                                                                                                |Inpatient   |

	Scenario Outline: Headers - CC-BillArea1
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name           |Value                  |
			|Bill Area      |CC - BillArea1         |
			|Svc Site       |Outpatient             |
			|Billing Prov   |CODEEDIT3, COMBINATION |
			|Referring      |DEV2, PK               |
		And I enter the CPT codes "<CPT>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT    |Message                                                                                                                                        |
			|TEST CODEEDIT-14 |70300  |This charge is inappropriate with the included headers (Referring: DEV0, PK OR Svc site: Inpatient) for this medical necessity: K03.6 OR K03.6 |
			|TEST CODEEDIT-14 |19271  |This charge is inconsistent with this included headers for this roles.                                                                         |

	Scenario: Headers - Included Dx alert
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "ROY BLAZER" is on the patient list
		When I select patient "ROY BLAZER" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name           |Value                  |
			|Bill Area      |CC-D1                  |
			|Svc Site       |Inpatient              |
			|Billing Prov   |CODEEDIT3, COMBINATION |
			|Referring      |DEV0, PK               |
		And I enter the CPT codes "77012"
		And I enter the ICD-10 codes "M20.5X9"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inappropriate with the included headers (Referring: DEV0, PK OR Svc site: Inpatient) for this primary DX: M20.5x9 M20.5X9" should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario: Headers - Department
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "TEST CODEEDIT-14" is on the patient list
		When I select patient "TEST CODEEDIT-14" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name           |Value                  |
			|Bill Area      |CC-D1                  |
			|Svc Site       |Outpatient             |
			|Billing Prov   |CODEEDIT3, COMBINATION |
			|Referring      |DEV2, PK               |
		And I enter the CPT codes "21013"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent with this included header for 'CC - D1' department." should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario Outline: Headers - Age
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name           |Value                  |
			|Bill Area      |CC-D1                  |
			|Svc Site       |<Site Detail>          |
			|Billing Prov   |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

			Examples:
			|Patient          |CPT   |Message                                                                                                                                                                                     |Site Detail |
			|TEST CODEEDIT-14 |27752 |This charge is inconsistent with the below mention Included and Excluded headers:Included Headers: Billarea(CC - BillArea1), Billing Prov(DEV0, PK). Excluded Headers: Svc Site(Outpatient) |Outpatient  |
			|MOLLY DARR       |19272 |This charge is inconsistent with this included header with this patients age range(0y to 90y).                                                                                              |Inpatient   |

	Scenario Outline: Headers - Included Gender/CPT
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name           |Value                  |
			|Bill Area      |CC - BillArea1         |
			|Svc Site       |<Site Details>         |
			|Billing Prov   |CODEEDIT3, COMBINATION |
			|Referring      |DEV1, PK               |
		And I enter the CPT codes "<CPT>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT   |Message                                                                   |Site Details |
			|ROY BLAZER       |19271 |This charge is inconsistent with this included header with male patients. |Inpatient    |
			|TEST CODEEDIT-14 |71101 |This charge is inconsistent with this included header for this CPT        |Outpatient   |

	Scenario: Headers - Included Financial Class
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "TEST CODEEDIT-6" is on the patient list
		When I select patient "TEST CODEEDIT-6" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name           |Value                  |
			|Bill Area      |CC - BillArea1         |
			|Svc Site       |Inpatient              |
			|Billing Prov   |CODEEDIT3, COMBINATION |
			|Referring      |DEV0, PK               |
		And I enter the CPT codes "71260"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent with this included headers for 'AETNA' financial class." should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario: Headers - Included PK Visit Type
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "ROY BLAZER" is on the patient list
		When I select patient "ROY BLAZER" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name           |Value                  |
			|Bill Area      |CC-D1                  |
			|Svc Site       |Inpatient              |
			|Billing Prov   |CODEEDIT3, COMBINATION |
			|Referring      |DEV3, PK               |
		And I enter the CPT codes "77261"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge requires 'Billing Prov(DEV1, PK)' , Bill Area(CC - BillArea1) to be included head for this inpatient visit." should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario Outline: Headers - Excluded DEV0
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value         |
			|Bill Area    |CC-D1         |
			|Svc Site     |<Site Detail> |
			|Billing Prov |DEV0, PK      |
			|Injury Type  |MVA           |
		And I enter the CPT codes "<CPT>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT         |ICD           |Message                                                                                                         |Site Detail |
			|ROY BLAZER       |01710       |              |This charge is inconsistent with this excluded header for this CPT.                                             |Inpatient   |
			|ROY BLAZER       |89261       |              |This charge is inconsistent with this excluded header for male patients.                                        |Inpatient   |
			|TEST CODEEDIT-9  |27250       |              |This charge is inconsistent with this excluded Header(Svc Site: Outpatient) for 'AETNA' financial class.        |Outpatient  |
			|TEST CODEEDIT-14 |01732       |              |This charge is inconsistent with this excluded header for 'Inpatient' OR 'Outpatient' Place of service.         |Outpatient  |
			|ROY BLAZER       |27703       |              |This charge is inconsistent with this excluded header for 'CC - D1' department                                  |Inpatient   |
			|ROY BLAZER       |28436       |S65.209A      |This charge is inappropriate with Billing Provider(DEV0, PK) excluded header for this Dx: S65.209A OR S65.209A. |Inpatient   |
			|TEST CODEEDIT-14 |30200       |Q16.9;H92.09  |This charge is inconsistent with Svc site(Outpatient) excluded header for this Dx combination.                  |Outpatient  |
			|TEST CODEEDIT-14 |47720       |K81.9;K82.9   |This charge is inconsistent with Svc site(Outpatient) excluded header for this Dx Order                         |Outpatient  |
			|ROY BLAZER       |01470;26145 |              |This charge is inconsistent with this excluded header for this required quantity.                               |Inpatient   |

	Scenario Outline: Headers - Excluded DEV1
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value          |
			|Bill Area    |CC - BillArea1 |
			|Svc Site     |Inpatient      |
			|Billing Prov |DEV1, PK       |
			|Referring    |DEV2, PK       |
			|Injury Type  |MVA            |
		And I enter the CPT codes "<CPT>"
		And I click the "CloseMod" element if it exists
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient    |CPT      |Message                                                                                                          |
			|MOLLY DARR |29075    |This charge is inconsistent with this excluded header with the patient's age range(0y to 90y)                    |
			|ROY BLAZER |73070    |This charge is inconsistent with this excluded header for 'Inpatient' visit type.                                |
			|ROY BLAZER |69550    |This charge is inappropriate for 'CC-BillArea1' excluded header for this medical necessity.                      |
			|ROY BLAZER |01472    |This charge is inconsistent with Bill Area(CC - BillArea1) excluded header for this missing modifier: 77         |
			|ROY BLAZER |29898-T4 |This charge is inconsistent with this excluded header for this modifier.                                         |

	Scenario: Headers - Excluded Include
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "TEST CODEEDIT-14" is on the patient list
		When I select patient "TEST CODEEDIT-14" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC - BillArea1         |
			|Svc Site     |Outpatient             |
			|Billing Prov |CODEEDIT3, COMBINATION |
			|Referring    |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "66682"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inappropriate with 'CC - BillArea1' excluded Billing area header for this included charge headers" should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario: Headers - Excluded Roles
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "ROY BLAZER" is on the patient list
		When I select patient "ROY BLAZER" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value     |
			|Bill Area    |CC-D1     |
			|Svc Site     |Inpatient |
			|Billing Prov |DEV1, PK  |
		And I enter the CPT codes "28445"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inappropriate with this excluded header for this role." should appear in the "Charge Entry" pane
		And I click the "Close" image
		And I click the logout button

	Scenario Outline: Medical Necessity
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |<Site Detail>          |
			|Billing Prov |CODEEDIT3, COMBINATION |
			|Injury Type  |MVA                    |
		And I enter the CPT codes "<CPT>"
		And I click the "CloseMod" element if it exists
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT         |Message                                                                                               |Site Detail |
			|TEST CODEEDIT-2  |90965       |This charge is inconsistent with the Dx Medical Necessity V61.03 OR Z63.5 for this Age                |Inpatient   |
			|MOLLY DARR       |53601       |This charge is inconsistent with the Dx Medical Necessity V61.04 OR Z63.8 for this Gender             |Inpatient   |
			|TEST CODEEDIT-6  |70300       |This charge is inconsistent with the Dx E873.6 OR Y63.6 for this Financial Class                      |Inpatient   |
			|TEST CODEEDIT-14 |97537       |This charge is inconsistent with the Dx V61.05 Z63.8 for this PK Visit Type                           |Outpatient  |
			|ROY BLAZER       |77399       |This charge is inconsistent with the Dx V61.07 OR Z63.4 for this Place of Service                     |Inpatient   |
			|ROY BLAZER       |97803       |This charge is inconsistent with the Dx 269.9 OR E63.9 for this Department                            |Inpatient   |
			|ROY BLAZER       |97750       |This charge is inconsistent with the Dx V62.81 OR Z65.8 for this Role                                 |Inpatient   |
			|ROY BLAZER       |00700       |This charge is inconsistent with the Medical Necessity E879.9 OR Y83.9 for this missing modifier      |Inpatient   |
			|ROY BLAZER       |99026-32    |This charge is inconsistent with the Medical Necessity 709.8 OR L98.8 for this inappropriate modifier |Inpatient   |
			|ROY BLAZER       |35860;35876 |This charge is inconsistent with the Dx 747.64 OR Q27.8 for this CPT Comparison Required Quantity     |Inpatient   |

	Scenario: Medical Necessity - Header Excluded
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "ROY BLAZER" is on the patient list
		When I select patient "ROY BLAZER" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value         |
			|Bill Area    |CC-D1         |
			|Svc Site     |Inpatient     |
			|Billing Prov |KADMIN, PERRY |
		And I enter the CPT codes "75801"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent with the Medical Necessity 903.9 OR S45.909A for this excluded Header" should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario: Medical Necessity - Header Included
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "ROY BLAZER" is on the patient list
		When I select patient "ROY BLAZER" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "95115"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent with the Dx 307.21 OR F95.0 for this included Header" should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario Outline: Validate Dx Combination (2 DX not allowed together)
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value         |
			|Bill Area    |CC-D1         |
			|Svc Site     |<Site Detail> |
			|Billing Prov |KADMIN, PERRY |
			|Referring    |DEV0, PK      |
		And I enter the CPT codes "<CPT>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT   |ICD           |Message                                                                                                                                            |Site Detail |
			|TEST CODEEDIT-1  |94011 |Z91.89;K90.89 |This charge is inconsistent with the Dx Combination of Dx Primary : Z91.89 OR Z91.89 and Dx Secondary : K90.89 OR K90.4 for this Age                |Inpatient   |
			|TEST CODEEDIT-1  |51040 |N32.89;N32.9  |This charge is inconsistent with the Dx Combination of Dx Primary : N32.89 OR N32.89 and Dx Secondary : N32.9 OR N32.9 for this Gender             |Inpatient   |
			|ROY BLAZER       |15150 |Q82.0;Q80.9   |This charge is inconsistent with the Dx Combination of Dx Primary : Q82.0 OR Q82.0 and Dx Secondary : Q80.9 OR Q80.9 for this CPT                  |Inpatient   |
			|TEST CODEEDIT-6  |70380 |H91.90;H90.6  |This charge is inconsistent with the Dx Combination of Dx Primary : H91.90 OR H91.92 and Dx Secondary : H90.6 OR H90.6 for this Financial Class    |Inpatient   |
			|TEST CODEEDIT-14 |99318 |Z72.811;Z71.9 |This charge is inconsistent with the Dx Combination of Dx Primary : V70.0 OR Z00.00 and Dx Secondary : Z71.9 OR Z71.9 for this PK Visit Type      |Outpatient  |
			|ROY BLAZER       |96040 |Z02.89;Z02.71 |This charge is inconsistent with the Dx Combination of Dx Primary : Z02.89 OR Z02.82 and Dx Secondary : Z02.71 Or Z02.71 for this Place of Service |Inpatient   |
			|ROY BLAZER       |4086F |Z78.9;Z98.810 |This charge is inconsistent with the Dx Combination of Dx Primary : Z78.9 OR Z78.9 and Dx Secondary : Z98.810 OR Z98.810 for this Department       |Inpatient   |
			|ROY BLAZER       |96153 |Y07.59;Z03.89 |This charge is inconsistent with the Dx Combination of Dx Primary : Y07.59 OR Y07.529 and Dx Secondary : Z03.89 OR Z03.89 for this Role            |Inpatient   |
			|TEST CODEEDIT-14 |4120F |Z09;Z79.2     |This charge is inconsistent with the Combination of Dx Primary : V67.9 OR Z09 and Dx Secondary : Z79.2 OR Z79.2 for this excluded Header          |Outpatient  |

	Scenario: Validate Dx Combination - Header Included
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "ROY BLAZER" is on the patient list
		When I select patient "ROY BLAZER" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
			|Referring    |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "3100F"
		And I enter the ICD-10 codes "Y93.81;Z02.89"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent with the Combination of Dx Primary : Y93.81 OR Y93.81 and Dx Secondary : Z02.89 OR Z02.89 for this included Header" should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario Outline: Validate Dx Order (one dx before another dx)
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value         |
			|Bill Area    |CC-D1         |
			|Svc Site     |<Site Detail> |
			|Billing Prov |KADMIN, PERRY |
		And I enter the CPT codes "<CPT>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT   |ICD             |Message                                                                                                                                       |Site Detail |
			|TEST CODEEDIT-2  |99241 |H04.129;H16.229 |This charge is inconsistent with the Dx order of Dx Primary : H04.129 OR H04.129 and Dx Secondary : H16.229 OR H16.229  for this Age            |Inpatient   |
			|TEST CODEEDIT-2  |89343 |R89.9;Z52.000   |This charge is inconsistent with the Dx order of Dx Primary : R86.9 OR R86.9 and Dx Secondary : V59.9 OR Z52.9 for this Gender                |Inpatient   |
			|ROY BLAZER       |30450 |N39.490;N39.43  |This charge is inconsistent with the Dx order of Dx Primary : 910.0 OR S00.31XA and Dx Secondary : 910.1 OR S00.31XA for this CPT             |Inpatient   |
			|TEST CODEEDIT-6  |47136 |K76.89;T86.40   |This charge is inconsistent with the Dx order of Dx Primary : K76.89 OR K76.89 and Dx Secondary : T86.40 OR T86.40 for this Financial Class    |Inpatient   |
#			|ROY BLAZER       |95929 |Z95.0;Z99.89    |This charge is inconsistent with the Dx order of Dx Primary : V49.4 OR R29.898 and Dx Secondary : V49.3 OR R29.818  for this PK Visit Type    |Inpatient   |
			|TEST CODEEDIT-14 |99253 |F10.231;F10.239 |This charge is inconsistent with the Dx order of Dx Primary : F10.231 OR F10.231 and Dx Secondary : F10.239 OR F10.239 for this Place of Service |Outpatient  |
			|ROY BLAZER       |0252T |D14.30;D38.1    |This charge is inconsistent with the Dx order of Dx Primary : D14.30 OR D14.30 and Dx Secondary : D38.1 OR D38.1 for this Department           |Inpatient   |
			|ROY BLAZER       |41000 |R68.89;M26.59   |This charge is inconsistent with the Dx order of Dx Primary : R68.89 OR R06.5 and Dx Secondary : M26.59 OR M26.59 for this Role               |Inpatient   |
			|ROY BLAZER       |32405 |J98.4;J64       |This charge is inconsistent with the Dx order of Dx Primary : J98.4 OR J98.4 and Dx Secondary : J64 OR J64 for this excluded header          |Inpatient   |
			|ROY BLAZER       |43855 |K30;R12         |This charge is inconsistent with the Dx order of Dx Primary : K30 OR K30 and Dx Secondary :R12 OR R12 for this included header            |Inpatient   |

	Scenario Outline: Roles CC-D1
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "CloseMod" element if it exists
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient         |CPT             |ICD            |Message                                                                                                                                                                |
			|MOLLY DARR      |17380           |               |This charge is inconsistent with 'USER' OR 'Referring' Provider role for the patients in the age range 0y to 90y.                                                      |
			|ROY BLAZER      |87220           |               |This charge is inconsistent with 'USER' OR 'PROVIDER' Role for male patients.                                                                                          |
			|ROY BLAZER      |26842           |               |This charge is inconsistent with 'Provider' OR 'Admin' Role with this CPT.                                                                                             |
			|TEST CODEEDIT-6 |72074           |               |This charge is inconsistent with 'USER' OR 'PROVIDER' Role for AETNA financial class.                                                                                  |
			|ROY BLAZER      |26755           |               |This charge is inconsistent with 'User' Provider Role for inpatient visit type.                                                                                        |
			|ROY BLAZER      |11443           |               |This charge is inconsistent with 'Provider' OR 'Referring' Role for 'Inpaient' OR 'Office' Place of Service.                                                           |
			|ROY BLAZER      |23930           |               |This charge is inconsistent with the specified roles(User OR Referring) for 'STOCK - Notewriter' department.                                                           |
			|ROY BLAZER      |24930           |S42.409A       |This charge is inconsistent with 'Referring' OR 'User' role for this Dx: S42.409A OR S42.409A.                                                                         |
			|ROY BLAZER      |75989           |               |This charge is inconsistent with 'USER' OR 'PROVIDER' roles for this medical necessity.                                                                                |
			|ROY BLAZER      |26991           |S60.417A;Q84.6 |This charge is inconsistent with 'USER' OR 'Referring' Roles for this Dx Combination.                                                                                  |
			|ROY BLAZER      |92571           |R47.89;I69.928 |This charge is inconsistent with 'User' OR 'Provider' roles with the specified Dx order                                                                                |
			|ROY BLAZER      |11441           |               |This charge is inconsistent with 'User' OR 'Provider' Role for this missing modifier: 32                                                                               |
			|ROY BLAZER      |26756-62        |               |This charge is inconsistent with 'User' OR 'Referring' Provider Role and with this modifier.                                                                           |
			|ROY BLAZER      |15946           |               |This charge is inconsistent with 'Referring' OR 'User' role for this Add on codes.                                                                                     |
			|ROY BLAZER      |26123:4;26125:4 |               |This charge is inconsistent with this 'Referring' OR 'User' role for this Reqiured Quantity.Min Required Qty: 5.                                                       |
			|ROY BLAZER      |01712;58150     |               |This charge is inconsistent with 'Referring' OR 'User' role for this global period.                                                                                    |

	Scenario Outline: Roles Header Excluded
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC - BillArea1         |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
			|Referring    |DEV2, PK               |
		And I enter the CPT codes "<CPT>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image
		And I click the logout button

		Examples:
			|Patient    |CPT     |Message                                                                                            |
			|ROY BLAZER |26145   |This charge is inconsistent with 'Referring Provider OR 'USER'' roles with these excluded headers. |

	Scenario: Roles Header Included
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "ROY BLAZER" is on the patient list
		When I select patient "ROY BLAZER" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Outpatient             |
			|Billing Prov |CODEEDIT3, COMBINATION |
			|Referring    |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "24640"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent with 'Referring' OR 'User' roles with this included headers." should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario Outline: Dx Alert(Notification)
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |<Site Detail>          |
			|Billing Prov |CODEEDIT3, COMBINATION |
			|Injury Type  |MVA                    |
		And I enter the CPT codes "<CPT>"
		And I click the "CloseMod" element if it exists
		And I enter the ICD-10 codes "<ICD>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT             |ICD      |Message                                                                                            |Site Detail |
			|TEST CODEEDIT-2  |40845           |H33.019  |This charge is inconsistent with the Dx H33.019 OR H33.019 for this Age                            |Inpatient   |
			|TEST CODEEDIT-2  |54670           |Q56.4    |This charge is inconsistent with the Dx Q56.4 OR Q55.0 for this Gender                             |Inpatient   |
			|ROY BLAZER       |0100T           |K11.5    |This charge is inconsistent with the Dx K11.5 OR K11.5 for this CPT                                |Inpatient   |
			|TEST CODEEDIT-6  |70300           |K03.6    |This charge is inconsistent with the Dx K03.6 OR K03.6 for this Financial Class                    |Inpatient   |
			|TEST CODEEDIT-14 |86000           |S32.409D |This charge is inconsistent with the Dx S32.409D OR S42.309D for this PK Visit Type                |Outpatient  |
			|ROY BLAZER       |90875           |Z63.8    |This charge is inconsistent with the Dx Z63.8 OR Z63.8 for this Place of Service                   |Inpatient   |
			|ROY BLAZER       |4090F           |Z78.9    |This charge is inconsistent with the Dx Z78.9 OR Z78.9 for this Department                         |Inpatient   |
			|ROY BLAZER       |1035F           |H54.7    |This charge is inconsistent with the Dx H54.7 OR Z73.82 for this Role                              |Inpatient   |
			|ROY BLAZER       |47900           |T14.90XA |This charge is inconsistent with the Dx T14.90 T14.90 for this excluded Header                     |Inpatient   |
			|ROY BLAZER       |62010           |X58.XXXA |This charge is inconsistent with the Dx X58.XXXA X58.XXXA for this excluded Header                 |Inpatient   |
			|ROY BLAZER       |90818           |F16.10   |This charge is inconsistent with the Dx F16.10 OR F16.90 for this missing modifier                 |Inpatient   |
			|ROY BLAZER       |99402-74        |Y63.5    |This charge is inconsistent with the Dx Y63.5 OR Y63.5 for this missing modifier                   |Inpatient   |
			|ROY BLAZER       |84490:1;78472:1 |D72.89   |This charge is inconsistent with the Dx D72.89 OR D72.89 for this CPT Comparison Required Quantity |Inpatient   |

	Scenario Outline: Add on codes
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		And I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |<Site Detail>          |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient           |CPT   |Message                                                                                    |Site Detail |
			|TEST CODEEDIT-6   |64483 |This charge is inconsistent with the Add on Codes 64483 and 64484 for this Financial Class |Inpatient   |
			|TEST CODEEDIT-14  |11200 |This charge is inconsistent with the Add on Codes 11200 and 11201 for this PK Visit Type   |Outpatient  |
			|MOLLY DARR        |76120 |This charge is inconsistent with the Add on Codes 76120 and 76125 for this Department      |Inpatient   |
			|MOLLY DARR        |88189 |This charge is inconsistent with the Add on Codes 88189 and 88185 for this Role            |Inpatient   |

	Scenario Outline: Place of Service
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |<Site Detail>          |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "CloseMod" element if it exists
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

	Examples:
			|Patient          |CPT             |ICD         |Message                                                                                                                                                              |Site Detail |
			|MOLLY DARR       |36430           |            |This charge is inconsistent with this place of service for this patient's age.                                                                                       |Inpatient   |
			|MOLLY DARR       |55650           |            |This charge is inconsistent with 'Inpatient' OR 'Outpatient' Place of Service for female patients.                                                                   |Inpatient   |
			|TEST CODEEDIT-12 |67113           |            |This charge is inconsistent with 'Office' OR 'Outpatient' Place of Service for this patient with this CPT.                                                           |Outpatient  |
			|ATENA* FINANCIAL |61140           |            |This charge is inconsistent with 'Inpatient' OR 'Outpatient' Place of Service for this Financial Class.                                                              |Inpatient   |
			|TEST CODEEDIT-12 |61154           |            |This charge is inconsistent with 'Office' OR 'Outpatient' Place of Service for this Outpatient Pk Visit Type.                                                        |Outpatient  |
			|TEST CODEEDIT-12 |21121           |            |This charge is inconsistent with 'Office' OR 'Outpatient' Place of Service for 'CC - D1' department.                                                                 |Outpatient  |
			|ROY BLAZER       |75978           |            |This charge is inconsistent with 'Inpatient' OR 'Other' Place of Service for this Provider                                                                           |Inpatient   |
			|ROY BLAZER       |83037           |R81         |This charge is inconsistent with 'Inpatient' OR 'Outpatient' Place of Service for this primary diagnosis.                                                            |Inpatient   |
			|ROY BLAZER       |86146           |            |This charge is inconsistent with 'Inpatient' OR 'Outpatient' Place of Service for this medical necessity.                                                            |Inpatient   |
			|ROY BLAZER       |59025           |R50.9;D70.9 |This charge is inconsistent with 'Inpatient' OR 'Outpatient' Place of service with this Dx combination.                                                              |Inpatient   |
			|TEST CODEEDIT-12 |43300           |C15.9;Q89.9 |This charge is inconsistent with 'Outpatient' OR 'Other' place of service with the specified Dx order,Dx Primary : C15.9 OR C15.9, Dx Secondary : Q89.9 OR O35.8XX0  |Outpatient  |
			|ROY BLAZER       |61875           |            |This charge is inconsistent with 'Inpatient' OR 'Other' Place of service with this missing modifer:                                                                  |Inpatient   |
			|ROY BLAZER       |99343-32        |            |This charge is inconsistent with 'Inpatient' OR 'Other' Place of service with this inappropriate modifier: 32.                                                       |Inpatient   |
			|ROY BLAZER       |83903:1;83904:1 |            |This charge is inconsistent with 'Inpatient' OR 'Other' Place of service with this required qty: 3.                                                                  |Inpatient   |

	Scenario: Place of Service - Headers Excluded
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "MOLLY DARR" is on the patient list
		When I select patient "MOLLY DARR" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value     |
			|Bill Area    |CC-D1     |
			|Svc Site     |Inpatient |
			|Billing Prov |DEV1, PK  |
		And I enter the CPT codes "82962"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent with 'Inpatient' OR 'Outpatient' Place of Service for this Billing Provider(DEV1, PK)" should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario: Place of Service - Headers included
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "MOLLY DARR" is on the patient list
		When I select patient "MOLLY DARR" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value     |
			|Bill Area    |CC-D1     |
			|Svc Site     |Inpatient |
			|Billing Prov |DEV0, PK  |
		And I enter the CPT codes "83036"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "This charge is inconsistent with 'Inpatient' OR 'Outpatient' Place of Service for this included header: Billing Provider(DEV1, PK)." should appear in the "Charge Entry" pane
		And I click the "Close" image

	Scenario: Place of Service - Validate Primary Dx
        And I select "My Patients" from the "Patient List" menu
		When "MOLLY DARR" is on the patient list
		And I select patient "MOLLY DARR" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "94640"
		And I enter the ICD-10 codes "J44.9"
		And I click the "Submit" button in the "Charge Entry" pane
		And I click the "Save As Is" button in the "Confirm" pane if it exists
		And "MOLLY DARR" is on the patient list
		And I select patient "MOLLY DARR" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "91065"
		And I enter the ICD-10 codes "J44.9"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "The diagnosis J44.9 has already been used as a primary diagnosis for this patient on this date by two providers within the same department for this place of service." should appear in the "Charge Entry" pane
		And I click the "Close" image
		And I click the logout button

	Scenario Outline: Validate Primary Dx
        And I select "My Patients" from the "Patient List" menu
		When "<Patient>" is on the patient list
		And I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
			|Referring    |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT1>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "Submit" button in the "Charge Entry" pane
		And I wait for loading to complete
		And I click the "Save As Is" button in the "Confirm" pane if it exists
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT2>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT1 |CPT2  |ICD    |Message                                                                                                                                                                                                               |
			|MOLLY DARR       |86619|86000 |B36.0  |The diagnosis 'B36.0' has already been used as a primary diagnosis for this patient on this date by two providers within the same department.                                                                         |
			|ROY BLAZER       |37210|58140 |H83.19 |The diagnosis 'H83.19' has already been used as a primary diagnosis for this 'male' patient on this date by two providers within the same department.                                                                 |
			|ATENA* FINANCIAL |21552|21558 |J86.9  |The diagnosis J86.9 OR J86.9 has already been used as a primary diagnosis for this patient on this date by two providers within the same department for this financial class.                                         |
			|ROY BLAZER       |31623|31624 |A15.0  |This diagnosis A15.0 has already been used as a primary diagnosis for this date within the same Department                                                                                                            |
			|ROY BLAZER       |31622|31627 |C33    |The diagnosis C33 has already been used as a primary diagnosis for this patient on this 'Inpatient' or 'Outpatient' Place of service on this date by two providers within the same department.                        |
			|ROY BLAZER       |31640|31641 |D38.1  |This diagnosis D38.1 has already been used as a primary diagnosis for this date within the same Department.                                                                                                           |
			|ROY BLAZER       |31645|31646 |J98.9  |This diagnosis J98.9 has already been used as a primary diagnosis for this date within the same Department                                                                                                            |
			|ROY BLAZER       |23410|90732 |Z98.890 |This charge is inconsistent with this Billing OR Referring Providers and the diagnosis Z98.89 has already been used as a primary diagnosis for this patient on this date by two providers within the same department. |

	Scenario Outline: Validate Primary - Headers Excluded
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "ROY BLAZER" is on the patient list
		When I select patient "ROY BLAZER" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
    		|Name		  |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |DEV0, PK               |
			|Referring    |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT1>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "Submit" button in the "Charge Entry" pane
		And I wait for loading to complete
		And I click the "Save As Is" button in the "Confirm" pane if it exists
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value     |
			|Bill Area    |CC-D1     |
			|Svc Site     |Inpatient |
			|Billing Prov |DEV0, PK  |
		And I enter the CPT codes "<CPT2>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|CPT1  |CPT2  |ICD    |Message                                                                                                                                                                                                                         |
			|32420 |32440 |J45.909 |The diagnosis J45.909 has already been used as a primary diagnosis for this patient on this date by two providers within the same department. This charge is inconsistent with this excluded header: Billing Provider(DEV0, PK). |

	Scenario Outline: Validate Primary DX All
        And I select "My Patients" from the "Patient List" menu
		When "<Patient>" is on the patient list
		When I select patient "<Patient>" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT1>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "Submit" button in the "Charge Entry" pane
		And I wait for loading to complete
		And I click the "Save As Is" button in the "Confirm" pane if it exists
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value                  |
			|Bill Area    |CC-D1                  |
			|Svc Site     |Inpatient              |
			|Billing Prov |CODEEDIT3, COMBINATION |
		And I enter the CPT codes "<CPT2>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|Patient          |CPT1  |CPT2  |ICD    |Message                                                                                                                                                                                        |
			|Test Codeedit-2 |69740 |69745 |R12    |This charge is inconsistent with this patients age and the diagnosis 69745 has already been used as a primary diagnosis for this patient on this date by two providers within the same department |
			|MOLLY DARR       |54550 |54560 |B36.0  |The diagnosis 'B36.0' has already been used as a primary diagnosis for this patient on this date by two providers within the same department.                                                  |
			|ATENA* FINANCIAL |15002 |15003 |N88.1  |This diagnosis N88.1 has already been used as a primary diagnosis for this date within the same Department                                                                                     |
			#|ROY BLAZER       |87481 |87482 |B37.9  |The diagnosis has already been used as a primary diagnosis for this patient on this date by two providers with 'User' OR ''Referring roles within the same department.                        |

	Scenario Outline: Department - Validate Primary
		Given I am on the "Patient List V2" tab
        And I select "My Patients" from the "Patient List" menu
		And "ROY BLAZER" is on the patient list
		When I select patient "ROY BLAZER" from the patient list
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value              |
			|Bill Area    |STOCK - NoteWriter |
			|Svc Site     |Inpatient          |
			|Billing Prov |DEV0, PK           |
		And I enter the CPT codes "<CPT1>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "Submit" button in the "Charge Entry" pane
		And I wait "6" seconds
		And I click the "Save As Is" button in the "Confirm" pane if it exists
		And I select "Add Charge" from the "Patient Header Actions" menu
		And I set the following charge headers
			|Name         |Value              |
			|Bill Area    |STOCK - NoteWriter |
			|Svc Site     |Inpatient          |
			|Billing Prov |DEV0, PK           |
		And I enter the CPT codes "<CPT2>"
		And I enter the ICD-10 codes "<ICD>"
		And I click the "Validate" button in the "Charge Entry" pane
		Then the text "<Message>" should appear in the "Charge Entry" pane
		And I click the "Close" image

		Examples:
			|CPT1  |CPT2  |ICD     |Message                                                                                                       |
			|32420 |32440 |Z45.018 |This diagnosis Z45.018 has already been used as a primary diagnosis for this date within the same Department. |

  #Moved to tearDown in CukeRunnerTEst.java
#	Scenario: Turn off all codeedits on user server
#		And I execute the "Disable All Code Edits" query